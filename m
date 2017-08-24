From: Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] ata: add a blank line after declaration
Date: Fri, 25 Aug 2017 02:49:00 +0530
Message-ID: <1503609540-27217-1-git-send-email-himanshujha199640@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34418 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbdHXVTe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2017 17:19:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>

Added a blank line after declaration conforming to the coding style.
Issue found using checkpatch.pl

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/ata/acard-ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 940ddbc..a45886b 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -338,6 +338,7 @@ static int acard_ahci_port_start(struct ata_port *ap)
 	if ((hpriv->cap & HOST_CAP_FBS) && sata_pmp_supported(ap)) {
 		void __iomem *port_mmio = ahci_port_base(ap);
 		u32 cmd = readl(port_mmio + PORT_CMD);
+
 		if (cmd & PORT_CMD_FBSCP)
 			pp->fbs_supported = true;
 		else if (hpriv->flags & AHCI_HFLAG_YES_FBS) {
-- 
2.7.4

