From: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 0/2] Add support for MediaTek AHCI SATA
Date: Fri, 18 Aug 2017 09:13:06 +0800
Message-ID: <cover.1503018631.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Long Cheng <long.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi,

This patch series add support for AHCI compatible SATA controller, and it is
compliant with the ahci 1.3 and sata 3.0 specification. This driver is slightly
different than ahci_platform.c (e.g., reset control, subsystem setting).

changes since v4:
- update binding text: Instead of "soc-model", pick something checkpatch.pl understands

changes since v3:
- update binding text: fix a typo and modify compatible strings.

changes since v2:
- according to Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting reset lines").
  replace devm_reset_control_get_optional() by devm_reset_control_get_optional_exclusive().

changes since v1:
- update binding text: add missing "specifier pairs" descriptions.
- fix kbuild test warning: fix the error handling.

Ryder Lee (2):
  ata: mediatek: add support for MediaTek SATA controller
  dt-bindings: ata: add DT bindings for MediaTek SATA controller

 Documentation/devicetree/bindings/ata/ahci-mtk.txt |  51 ++++++
 drivers/ata/Kconfig                                |  10 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_mtk.c                             | 196 +++++++++++++++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
 create mode 100644 drivers/ata/ahci_mtk.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
