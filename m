From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 04/10] ata: ahci_brcmstb: remove unused definitions
Date: Tue, 27 Oct 2015 15:48:05 +0900
Message-ID: <1445928491-7320-5-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35361 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbbJ0Gst (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2015 02:48:49 -0400
In-Reply-To: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <robh+dt@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Remove unused definitions.

The MIPS-based 40nm chipsets has different offset. The
SATA_TOP_CTRL_SATA_TP_OUT offset is 0x18 and the
SATA_TOP_CTRL_CLIENT_INIT_CTRL is not exist. So, To remove do to avoid
confusion.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index c61303f7c7dc..2d25a28f4f64 100644
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
2.6.2

