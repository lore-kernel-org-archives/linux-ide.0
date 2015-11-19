From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v5 1/7] ata: ahci_brcmstb: add support MIPS-based platforms
Date: Thu, 19 Nov 2015 11:41:13 +0900
Message-ID: <1447900879-1549-2-git-send-email-jaedon.shin@gmail.com>
References: <1447900879-1549-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33444 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125AbbKSCmD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2015 21:42:03 -0500
Received: by pabfh17 with SMTP id fh17so66755760pab.0
        for <linux-ide@vger.kernel.org>; Wed, 18 Nov 2015 18:42:03 -0800 (PST)
In-Reply-To: <1447900879-1549-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>

The BCM7xxx ARM-based and MIPS-based platforms share a similar hardware
block for AHCI SATA3.

The BCM7425 is main chipset of MIPS-based 40nm class. The others have
same AHCI block. The compatible string may be use brcm,bcm7425-ahci.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt | 4 +++-
 drivers/ata/Kconfig                                         | 2 +-
 drivers/ata/ahci_brcmstb.c                                  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
index 20ac9bbfa1fd..60872838f1ad 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
@@ -4,7 +4,9 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
 Required properties:
-- compatible         : compatible list, may contain "brcm,bcm7445-ahci" and/or
+- compatible         : should be one or more of
+                       "brcm,bcm7425-ahci"
+                       "brcm,bcm7445-ahci"
                        "brcm,sata3-ahci"
 - reg                : register mappings for AHCI and SATA_TOP_CTRL
 - reg-names          : "ahci" and "top-ctrl"
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 6aaa3f81755b..861643ea91b5 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -100,7 +100,7 @@ config SATA_AHCI_PLATFORM
 
 config AHCI_BRCMSTB
 	tristate "Broadcom STB AHCI SATA support"
-	depends on ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  This option enables support for the AHCI SATA3 controller found on
 	  STB SoC's.
diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 14b7305d2ba0..73e3b0b2a3c2 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -300,6 +300,7 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ahci_of_match[] = {
+	{.compatible = "brcm,bcm7425-ahci"},
 	{.compatible = "brcm,bcm7445-ahci"},
 	{},
 };
-- 
2.6.3

