#pragma once

#include "../optix_api.h"
#include "../cuda_stream.h"
#include "../cuda_buffer.h"
#include "../cuda_device.h"
#include <luisa/backends/ext/denoiser_ext.h>
#include <luisa/core/platform.h>
#include <luisa/core/dll_export.h>
#include <luisa/core/stl/vector.h>

namespace luisa::compute::cuda {

class OptixDenoiser : public DenoiserExt::Denoiser {
protected:
    CUDADevice *_device;
    CUDAStream *_stream;

    optix::Denoiser _denoiser = nullptr;
    optix::DenoiserGuideLayer _guideLayer = {};
    luisa::vector<optix::DenoiserLayer> _layers;
    optix::DenoiserParams _params = {};
    bool _has_aov;
    bool _has_upscale;
    bool _has_temporal;

    uint32_t _scratch_size = 0;
    uint32_t _state_size = 0;
    uint32_t _overlap = 0u;
    CUdeviceptr _scratch = 0;
    CUdeviceptr _state = 0;
    
    optix::DenoiserModelKind get_model_kind() noexcept;
    optix::PixelFormat get_format(DenoiserExt::ImageFormat fmt) noexcept;
    optix::DenoiserAOVType get_aov_type(DenoiserExt::ImageAOVType type) noexcept;
    optix::Image2D build_Image2D(const DenoiserExt::Image &img) noexcept;
    optix::Image2D create_Image2D(const DenoiserExt::Image &img) noexcept;
    optix::Image2D create_internal(const DenoiserExt::Image &img, const optix::DenoiserSizes &denoiser_sizes) noexcept;
    void reset() noexcept;
    void execute_denoise() noexcept;
public:
    explicit OptixDenoiser(CUDADevice *device, CUDAStream *stream) noexcept;
    virtual void init(const DenoiserExt::DenoiserInput &input) noexcept override;
    ~OptixDenoiser() noexcept override;
};

}// namespace luisa::compute::cuda
