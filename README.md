# WACommonOrientationController


A common orientation controller object that can manage dynamically two differents portrait/landscape controllers and XIB (could easily be adapted with storyboards).

The base classe is the CommonOrientationController one and you can inherit from this class for each portrait/landscape specific controller/xib you want. It will automatically instantiate and present the right one appending the name of your controller/xib (baseName) followed by CommonOrientationController. In the project example you will sea that you can mix up in a navigation controller some CommonOrientationController and classic one (for example, the first controller which is pushed hasn't any landscape specific controller/xib).
