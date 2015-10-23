From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 04/10] phy: phy_brcmstb_sata: make the driver buildable on BMIPS_GENERIC
Date: Fri, 23 Oct 2015 10:44:17 +0900
Message-ID: <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36443 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbJWBpc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2015 21:45:32 -0400
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
SATA3 PHY.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 47da573d0bab..c83e48661fd7 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -364,11 +364,11 @@ config PHY_TUSB1210
 
 config PHY_BRCMSTB_SATA
 	tristate "Broadcom STB SATA PHY driver"
-	depends on ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
 	depends on OF
 	select GENERIC_PHY
 	help
-	  Enable this to support the SATA3 PHY on 28nm Broadcom STB SoCs.
+	  Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB SoCs.
 	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
 
 endmenu
-- 
2.6.2

