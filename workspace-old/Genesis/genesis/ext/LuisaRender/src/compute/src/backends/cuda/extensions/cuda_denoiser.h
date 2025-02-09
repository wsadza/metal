//
// Created by Hercier on 2023/4/6.
//
#pragma once
#include <luisa/core/logging.h>
#include <luisa/backends/ext/denoiser_ext.h>
#include <luisa/runtime/image.h>
#include <luisa/runtime/buffer.h>
#include <luisa/runtime/stream.h>
#include "../cuda_device.h"

namespace luisa::compute::cuda {
class CUDADenoiserExt final : public DenoiserExt {
private:
    CUDADevice *_device;
public:
    explicit CUDADenoiserExt(CUDADevice *device) noexcept : _device{device} {}
    luisa::shared_ptr<Denoiser> create(uint64_t stream) noexcept override;
    luisa::shared_ptr<Denoiser> create(Stream &stream) noexcept override {
        return create(stream.handle());
    }
};

}   // namespace luisa::compute::cuda
