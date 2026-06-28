;;; package --- Summary: Emacs config -*- lexical-binding: t; -*-
;;; Commentary:
;;; The initial config file that loads all config modules.
;;; Code:

;; Load configuration files
(load (expand-file-name "~/.emacs.d/packages.el"))
(load (expand-file-name "~/.emacs.d/config.el"))
(load (expand-file-name "~/.emacs.d/utils.el"))
(load (expand-file-name "~/.emacs.d/cmake_tasks.el"))


(add-hook 'emacs-startup-hook
	  (lambda () (eshell)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("83550d0386203f010fa42ad1af064a766cfec06fc2f42eb4f2d89ab646f3ac01"
     "7c3d62a64bafb2cc95cd2de70f7e4446de85e40098ad314ba2291fc07501b70c"
     "93011fe35859772a6766df8a4be817add8bfe105246173206478a0706f88b33d"
     "921f165deb8030167d44eaa82e85fcef0254b212439b550a9b6c924f281b5695"
     "a6920ee8b55c441ada9a19a44e9048be3bfb1338d06fc41bce3819ac22e4b5a1"
     "2f7fa7a92119d9ed63703d12723937e8ba87b6f3876c33d237619ccbd60c96b9"
     "3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b"
     "fffef514346b2a43900e1c7ea2bc7d84cbdd4aa66c1b51946aade4b8d343b55a"
     "be0d9f0e72a4ebc4a59c382168921b082b4dc15844bdaf1353c08157806b3321"
     "e622620e5f31216fd71e492fc1476e1fe7c21b8dc5811bf9e640c4b1fd6cfac1"
     "19d62171e83f2d4d6f7c31fc0a6f437e8cec4543234f0548bad5d49be8e344cd"
     "f6ea954a9544b0174a876d195387f444da441535ee88c7fb0fc346af08b0d228"
     "c9d837f562685309358d8dc7fccb371ed507c0ae19cf3c9ae67875db0c038632"
     "70c88c01b0b5fde9ecf3bb23d542acba45bb4c5ae0c1330b965def2b6ce6fac3"
     "dfb1c8b5bfa040b042b4ef660d0aab48ef2e89ee719a1f24a4629a0c5ed769e8"
     "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd"
     "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
     "7ec8fd456c0c117c99e3a3b16aaf09ed3fb91879f6601b1ea0eeaee9c6def5d9"
     "22a0d47fe2e6159e2f15449fcb90bbf2fe1940b185ff143995cc604ead1ea171"
     "456697e914823ee45365b843c89fbc79191fdbaff471b29aad9dcbe0ee1d5641"
     "7771c8496c10162220af0ca7b7e61459cb42d18c35ce272a63461c0fc1336015"
     "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0"
     "6963de2ec3f8313bb95505f96bf0cf2025e7b07cefdb93e3d2e348720d401425"
     "f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
     "02d422e5b99f54bd4516d4157060b874d14552fe613ea7047c4a5cfa1288cf4f"
     "166a2faa9dc5b5b3359f7a31a09127ebf7a7926562710367086fcc8fc72145da"
     "720838034f1dd3b3da66f6bd4d053ee67c93a747b219d1c546c41c4e425daf93"
     "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19"
     "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098"
     "c07f072a88bed384e51833e09948a8ab7ca88ad0e8b5352334de6d80e502da8c"
     "9b9d7a851a8e26f294e778e02c8df25c8a3b15170e6f9fd6965ac5f2544ef2a9"
     "7de64ff2bb2f94d7679a7e9019e23c3bf1a6a04ba54341c36e7cf2d2e56e2bcc"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
;;; init.el ends here
