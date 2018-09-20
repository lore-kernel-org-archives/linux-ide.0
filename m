From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/9] phy: brcm-sata: allow PHY_BRCM_SATA driver to be built for DSL SoCs
Date: Thu, 20 Sep 2018 12:16:36 -0700
Message-ID: <20180920191646.18198-3-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Al Cooper <alcooperx@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

Broadcom ARM-based DSL SoCs (BCM63xx product line) have the same
Broadcom SATA PHY that other SoCs are using, make it possible to select
that driver on these platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/phy/broadcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index 8786a9674471..aa917a61071d 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -60,7 +60,8 @@ config PHY_NS2_USB_DRD
 
 config PHY_BRCM_SATA
 	tristate "Broadcom SATA PHY driver"
-	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || \
+		   ARCH_BCM_63XX || COMPILE_TEST
 	depends on OF
 	select GENERIC_PHY
 	default ARCH_BCM_IPROC
-- 
2.17.1
