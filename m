From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
Date: Fri, 23 Oct 2015 10:44:16 +0900
Message-ID: <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33287 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbJWBp1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2015 21:45:27 -0400
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Add offsets for 40nm BMIPS based set-top box platforms.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 8cf6f7d4798f..59eb526cf4f6 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -50,7 +50,8 @@
   #define SATA_TOP_CTRL_2_SW_RST_RX			BIT(2)
   #define SATA_TOP_CTRL_2_SW_RST_TX			BIT(3)
   #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
- #define SATA_TOP_CTRL_PHY_OFFS				0x8
+ #define SATA_TOP_CTRL_28NM_PHY_OFFS			0x8
+ #define SATA_TOP_CTRL_40NM_PHY_OFFS			0x4
  #define SATA_TOP_MAX_PHYS				2
 #define SATA_TOP_CTRL_SATA_TP_OUT			0x1c
 #define SATA_TOP_CTRL_CLIENT_INIT_CTRL			0x20
@@ -237,7 +238,13 @@ static int brcm_ahci_resume(struct device *dev)
 
 static const struct of_device_id ahci_of_match[] = {
 	{.compatible = "brcm,bcm7445-ahci",
-			.data = (void *)SATA_TOP_CTRL_PHY_OFFS},
+			.data = (void *)SATA_TOP_CTRL_28NM_PHY_OFFS},
+	{.compatible = "brcm,bcm7346-ahci",
+			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
+	{.compatible = "brcm,bcm7360-ahci",
+			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
+	{.compatible = "brcm,bcm7362-ahci",
+			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
2.6.2

