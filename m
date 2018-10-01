From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 4/4] ata: ahci_brcm: Allow using driver or DSL SoCs
Date: Mon,  1 Oct 2018 10:33:02 -0700
Message-ID: <20181001173302.25398-5-f.fainelli@gmail.com>
References: <20181001173302.25398-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001173302.25398-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

The Broadcom STB AHCI controller is the same as the one found on DSL
SoCs, so we will utilize the same driver on these systems as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 39b181d6bd0d..99698d7fe585 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -121,7 +121,8 @@ config SATA_AHCI_PLATFORM
 
 config AHCI_BRCM
 	tristate "Broadcom AHCI SATA support"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
+		   ARCH_BCM_63XX
 	help
 	  This option enables support for the AHCI SATA3 controller found on
 	  Broadcom SoC's.
-- 
2.17.1
