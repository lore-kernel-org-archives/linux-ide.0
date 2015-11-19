From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v5 4/7] ata: ahci_brcmstb: remove unused definitions
Date: Thu, 19 Nov 2015 11:41:16 +0900
Message-ID: <1447900879-1549-5-git-send-email-jaedon.shin@gmail.com>
References: <1447900879-1549-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33931 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbbKSCmN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2015 21:42:13 -0500
Received: by padhx2 with SMTP id hx2so64606687pad.1
        for <linux-ide@vger.kernel.org>; Wed, 18 Nov 2015 18:42:12 -0800 (PST)
In-Reply-To: <1447900879-1549-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>

Remove unused definitions, and this is to avoid confusion with MIPS-based
chipsets.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index b7cdfc8fabb7..0af6d6dd6a36 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -52,8 +52,6 @@
   #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
  #define SATA_TOP_CTRL_PHY_OFFS				0x8
  #define SATA_TOP_MAX_PHYS				2
-#define SATA_TOP_CTRL_SATA_TP_OUT			0x1c
-#define SATA_TOP_CTRL_CLIENT_INIT_CTRL			0x20
 
 /* On big-endian MIPS, buses are reversed to big endian, so switch them back */
 #if defined(CONFIG_MIPS) && defined(__BIG_ENDIAN)
-- 
2.6.3

