//
// Created by Hercier on 2023/4/6.
//

#include <cuda.h>
#include <luisa/runtime/stream.h>
#include "../cuda_buffer.h"
#include "../cuda_stream.h"
#include "cuda_denoiser.h"

#if LUISA_BACKEND_ENABLE_OIDN

#include "../../common/oidn_denoiser.h"
namespace luisa::compute::cuda {

class CUDAOidnDenoiser : public OidnDenoiser {
public:
    using OidnDenoiser::OidnDenoiser;
    void execute(bool async) noexcept override {
        auto lock = luisa::make_unique<std::shared_lock<std::shared_mutex>>(_mutex);
        exec_filters();
        if (!async) {
            _oidn_device.sync();
        } else {
            auto cmd_list = CommandList{};
            cmd_list.add_callback([lock_ = std::move(lock), this]() mutable {
                LUISA_ASSERT(lock_, "Callback called twice.");
                lock_.reset();
            });
            _device->dispatch(_stream, std::move(cmd_list));
        }
    }
};

luisa::shared_ptr<DenoiserExt::Denoiser> CUDADenoiserExt::create(uint64_t stream) noexcept {
    auto oidn_device = oidn::newCUDADevice(
        static_cast<int>(_device->handle().index()),
        reinterpret_cast<CUDAStream *>(stream)->handle());
    return luisa::make_shared<CUDAOidnDenoiser>(_device, std::move(oidn_device), stream);
}

} // namespace luisa::compute::cuda

#else

#include "cuda_optix_denoiser.h"
namespace luisa::compute::cuda {

class CUDAOptixDenoiser : public OptixDenoiser {
public:
    using OptixDenoiser::OptixDenoiser;
    void init(const DenoiserExt::DenoiserInput &input) noexcept override{
        _device->with_handle([&] { OptixDenoiser::init(input); });
    }
    void execute(bool async) noexcept override {
        _device->with_handle([&] { OptixDenoiser::execute_denoise(); });
        if (!async) { _stream->synchronize(); }
    }
};

luisa::shared_ptr<DenoiserExt::Denoiser> CUDADenoiserExt::create(uint64_t stream) noexcept {
    return luisa::make_shared<CUDAOptixDenoiser>(_device, reinterpret_cast<CUDAStream *>(stream));
}

} // namespace luisa::compute::cuda

#endif