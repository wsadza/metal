#pragma once

#include <luisa/runtime/rhi/device_interface.h>
#include <luisa/core/logging.h>

namespace luisa::compute {

template<typename T>
class Buffer;
template<typename T>
class BufferView;

class Stream;

class DenoiserExt : public DeviceExtension {

protected:
    ~DenoiserExt() noexcept = default;

public:
    static constexpr luisa::string_view name = "DenoiserExt";
    enum class PrefilterMode : uint32_t {
        NONE,
        FAST,
        ACCURATE
    };
    enum class FilterQuality : uint32_t {
        DEFAULT,
        FAST,
        ACCURATE
    };
    enum class ImageFormat : uint32_t {
        FLOAT1,
        FLOAT2,
        FLOAT3,
        FLOAT4,
        HALF1,
        HALF2,
        HALF3,
        HALF4,
    };
    static constexpr size_t size(ImageFormat fmt) {
        switch (fmt) {
            case ImageFormat::FLOAT1:
                return 4;
            case ImageFormat::FLOAT2:
                return 8;
            case ImageFormat::FLOAT3:
                return 12;
            case ImageFormat::FLOAT4:
                return 16;
            case ImageFormat::HALF1:
                return 2;
            case ImageFormat::HALF2:
                return 4;
            case ImageFormat::HALF3:
                return 6;
            case ImageFormat::HALF4:
                return 8;
            default:
                return 0;
        }
    }
    enum class ImageColorSpace : uint32_t {
        HDR,
        LDR_LINEAR,
        LDR_SRGB
    };
    enum class ImageFeatureType: uint32_t {
        ALBEDO,
        NORMAL,
        FLOW,
        FLOWTRUST
    };
    enum class ImageAOVType: uint32_t {
        BEAUTY,
        DIFFUSE,
        SPECULAR,
        REFLECTION,
        REFRACTION
    };
    static ImageFeatureType get_feature_type(luisa::string_view s) noexcept {
        if (s == "albedo") return ImageFeatureType::ALBEDO;
        else if (s == "normal") return ImageFeatureType::NORMAL;
        else if (s == "flow") return ImageFeatureType::FLOW;
        else if (s == "flowtrust") return ImageFeatureType::FLOWTRUST;
        else LUISA_ERROR_WITH_LOCATION("Invalid feature type: {}.", s);
    }

    struct Image {
        ImageFormat format = ImageFormat::FLOAT4;
        uint64_t buffer_handle = -1;
        void *device_ptr = nullptr;
        size_t width{};
        size_t height{};
        size_t offset{};
        size_t pixel_stride{};
        size_t row_stride{};
        size_t size_bytes{};
        ImageColorSpace color_space = ImageColorSpace::HDR;
        float input_scale = 1.0f;   // for oidn
    };
    struct Feature {
        ImageFeatureType type;
        Image image;
    };
    struct Layer {
        Image input;
        Image output;
        ImageAOVType aov_type;
    };

    struct DenoiserInput {
        luisa::vector<Layer> layers;

        // if prefilter is enabled, the feature images might be prefiltered **in-place**
        luisa::vector<Feature> features;
        PrefilterMode prefilter_mode = PrefilterMode::NONE;
        FilterQuality filter_quality = FilterQuality::DEFAULT;  // for oidn
        bool noisy_features = false;
        bool upscale = false;       // upscale 2x for output, for optix
        bool temporal = false;      // temporal denoise mode, for optix
        bool alphamode = false;     // alpha channel denoiser mode, for optix
        uint32_t width = 0u;
        uint32_t height = 0u;
    private:
        template<class T>
        Image buffer_to_image(
            const BufferView<T> &buffer, uint32_t width, uint32_t height,
            ImageFormat format, ImageColorSpace cs, float input_scale
        ) noexcept {
            LUISA_ASSERT(size(format) <= sizeof(T), "Invalid format");
            LUISA_ASSERT(buffer.size() == width * height, "Buffer size mismatch.");
            return Image{
                format,
                buffer.handle(),
                buffer.native_handle(),
                width, height,
                buffer.offset_bytes(),
                buffer.stride(),
                buffer.stride() * width,
                buffer.size_bytes(),
                cs, input_scale};
        }
    public:
        DenoiserInput() noexcept = delete;
        DenoiserInput(uint32_t width, uint32_t height) noexcept: width{width}, height{height} {}
        template<class T, class U>
        void push_noisy_image(const BufferView<T> &input,
                              const BufferView<U> &output,
                              ImageFormat format,
                              ImageColorSpace cs = ImageColorSpace::HDR,
                              float input_scale = 1.0f,
                              ImageAOVType aov_type = ImageAOVType::BEAUTY) noexcept {
            uint32_t scale = upscale ? 2u : 1u;
            layers.emplace_back(
                buffer_to_image(input, width, height, format, cs, input_scale),
                buffer_to_image(output, width * scale, height * scale, format, cs, input_scale),
                aov_type
            );
        }
        template<class T>
        void push_feature_image(ImageFeatureType feature_type,
                                const BufferView<T> &feature,
                                ImageFormat format,
                                ImageColorSpace cs = ImageColorSpace::HDR,
                                float input_scale = 1.0f) noexcept {
            features.emplace_back(
                feature_type,
                buffer_to_image(feature, format, cs, input_scale)
            );
        }
    };
    
    class Denoiser;
    virtual luisa::shared_ptr<Denoiser> create(uint64_t stream) noexcept = 0;
    virtual luisa::shared_ptr<Denoiser> create(Stream &stream) noexcept = 0;
    class Denoiser : public luisa::enable_shared_from_this<Denoiser> {
    public:
        virtual void init(const DenoiserInput &input) noexcept = 0;
        virtual void execute(bool async) noexcept = 0;
        void execute() noexcept { execute(true); }
        virtual ~Denoiser() noexcept = default;
    };
};

}// namespace luisa::compute
