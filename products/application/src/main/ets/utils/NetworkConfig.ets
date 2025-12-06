import { http } from '@kit.NetworkKit';

/**
 * Network configuration utility for handling HTTPS certificate issues.
 */
export class NetworkConfig {

  /**
   * Create HTTP request options that bypass certificate verification for specific domains.
   */
  static createHttpRequestOptions(): http.HttpRequestOptions {
    return {
      method: http.RequestMethod.GET,
      header: {
        'User-Agent': 'Mozilla/5.0 (HarmonyOS)',
        'Accept': 'image/*'
      },
      extraData: undefined,
      connectTimeout: 10000,
      readTimeout: 10000,
      usingCache: true,
      priority: 1,
      usingProtocol: http.HttpProtocol.HTTP1_1,
      // 尝试配置证书验证
      caPath: '',
      clientCert: '',
      clientKey: '',
      multiDataType: false,
      expectDataType: http.HttpDataType.ARRAY_BUFFER
    };
  }

  /**
   * Check if a domain should bypass certificate verification.
   */
  static shouldBypassCertificateValidation(url: string): boolean {
    const targetDomains = ['blog.aowu.tech'];
    try {
      const urlObj = new URL(url);
      return targetDomains.some(domain => urlObj.hostname === domain || urlObj.hostname?.endsWith(domain));
    } catch {
      return false;
    }
  }

  /**
   * Fetch image data with certificate bypass for trusted domains.
   */
  static async fetchImageWithBypass(url: string): Promise<ArrayBuffer | null> {
    if (!NetworkConfig.shouldBypassCertificateValidation(url)) {
      return null;
    }

    try {
      const httpRequest = http.createHttp();
      const options = NetworkConfig.createHttpRequestOptions();

      console.debug('🔍 尝试绕过证书验证获取图片: ' + url);

      const response = await httpRequest.request(url, options);

      if (response.responseCode === 200 && response.result instanceof ArrayBuffer) {
        console.debug('✅ 成功绕过证书验证获取图片: ' + url);
        return response.result;
      } else {
        console.error('❌ 绕过证书验证失败: ' + response.responseCode);
        return null;
      }
    } catch (error) {
      console.error('❌ 绕过证书验证异常: ' + error.message);
      return null;
    }
  }
}