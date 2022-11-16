#
# Be sure to run `pod lib lint OneMapKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'OneMapKit'
    s.version          = '0.1.0'
    s.summary          = 'A short description of OneMapKit.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/linshaolong5240/OneMapKit'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'linshaolong5240' => '634205468@qq.com' }
    s.source           = { :git => 'https://github.com/linshaolong5240/OneMapKit.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '10.0'
    
    s.static_framework = true
    
    #    s.source_files = 'OneMapKit/Classes/**/*'
    
    s.resource_bundles = {
        #      'OneMapKit' => ['OneMapKit/Assets/*.png'],
        'OneMapKit' => ['OneMapKit/Assets/*.xcassets']
    }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
    
    s.default_subspec = 'One'
    
    s.subspec 'Core' do |core|
        core.source_files = 'OneMapKit/Classes/Core/**/*'
        core.private_header_files = 'OneMapKit/Classes/Core/**/*.h'
        s.dependency 'Masonry', '~> 1.1.0'
    end
    
    s.subspec 'AMap' do |amap|
        amap.source_files = 'OneMapKit/Classes/AMap/**/*'
        amap.private_header_files = 'OneMapKit/Classes/AMap/**/*.h'
        amap.dependency "OneMapKit/Core"
        amap.dependency 'AMap3DMap', '~> 9.5.0'
        amap.dependency 'AMapSearch', '~> 9.5.0'
    end

    s.subspec 'Baidu' do |baidu|
        baidu.source_files = 'OneMapKit/Classes/Baidu/**/*'
        baidu.private_header_files = 'OneMapKit/Classes/Baidu/**/*.h'
        baidu.dependency "OneMapKit/Core"
        baidu.dependency 'BMKLocationKit', '~> 2.0.5'
        baidu.dependency 'BaiduMapKit', '~> 6.5.4' # 默认集成全量包
    end
    
    s.subspec 'Tencent' do |tencent|
        tencent.source_files = 'OneMapKit/Classes/Tencent/**/*'
        tencent.private_header_files = 'OneMapKit/Classes/Tencent/**/*.h'
        tencent.dependency "OneMapKit/Core"
        tencent.dependency 'Tencent-MapSDK', '~> 4.5.10'    # 默认添加地图SDK所有子模块
    end
    
    s.subspec 'One' do |one|
        one.dependency "OneMapKit/Core"
        one.dependency "OneMapKit/AMap"
        one.dependency "OneMapKit/Baidu"
        one.dependency "OneMapKit/Tencent"
    end
    
    #百度地图
    # s.dependency 'BMKLocationKit', '~> 2.0.5'
    # s.dependency 'BaiduMapKit', '~> 6.5.4' # 默认集成全量包
    # 可选组件
    # pod 'BaiduMapKit/Map', '~> 6.5.4'    # 集成地图Map包
    # pod 'BaiduMapKit/Search', '~> 6.5.4' # 集成地图Search包
    # pod 'BaiduMapKit/Cloud', '~> 6.5.4'  # 集成地图Cloud包
    # pod 'BaiduMapKit/Utils', '~> 6.5.4'  # 集成地图Utils包
    
    #腾讯地图
    # s.dependency 'Tencent-MapSDK', '~> 4.5.10'    # 默认添加地图SDK所有子模块
    # 如果只需要添加SDK的指定子模块，请参考下面代码：
    # pod 'Tencent-MapSDK/QMapKit', '~> 4.5.10'               # 添加地图SDK模块
    # pod 'Tencent-MapSDK/QMapVisualPlugin', '~> 4.5.10'      # 添加地图可视化库模块
    # pod 'Tencent-MapSDK/QMapSDKUtils', '~> 4.5.10'          # 添加地图工具库模块
    # pod 'Tencent-MapSDK/QMapFoundation', '~> 4.5.10'        # 添加地图基础库模块，在4.5.6版本后需要添加
    
    #高德地图
    # s.dependency 'AMa p3DMap', '~> 9.5.0'
    # pod 'AMap2DMap', '~> 5.6.1'
    # s.dependency 'AMapSearch', '~> 9.5.0'
    # pod 'AMapLocation', '~> 2.9.0'
    # pod 'AMap2DMap-NO-IDFA', '~> 5.6.1'
    # pod 'AMapSearch-NO-IDFA', '~> 9.4.5'
    # pod 'AMapLocation-NO-IDFA', '~> 2.9.0'
    
end
