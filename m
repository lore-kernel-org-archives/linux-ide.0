From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 01/10] ata: ahci_brcmstb: add support MIPS-based platforms
Date: Fri, 30 Oct 2015 23:01:15 +0900
Message-ID: <1446213684-2625-2-git-send-email-jaedon.shin@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34762 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031343AbbJ3OBi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 10:01:38 -0400
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

The BCM7xxx ARM-based and MIPS-based platforms share a similar hardware
block for AHCI SATA3.

The BCM7425 is main chipset of MIPS-based 40nm class. The others have
same AHCI block. The compatible string may be use brcm,bcm7425-ahci.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
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
index 15e40ee62a94..8f535a88a0c7 100644
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
2.6.2

