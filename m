From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 05/10] phy: phy_brcmstb_sata: remove duplicate definitions
Date: Fri, 30 Oct 2015 23:01:19 +0900
Message-ID: <1446213684-2625-6-git-send-email-jaedon.shin@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33196 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031325AbbJ3OBw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 10:01:52 -0400
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Remove duplicate definitions.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/phy/phy-brcmstb-sata.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 8a2cb16a1937..0be55dafe9ea 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -26,8 +26,6 @@
 
 #define SATA_MDIO_BANK_OFFSET				0x23c
 #define SATA_MDIO_REG_OFFSET(ofs)			((ofs) * 4)
-#define SATA_MDIO_REG_SPACE_SIZE			0x1000
-#define SATA_MDIO_REG_LENGTH				0x1f00
 
 #define MAX_PORTS					2
 
-- 
2.6.2

