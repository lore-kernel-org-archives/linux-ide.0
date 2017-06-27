From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] ahci: Add Device ID for ASMedia 1061R and 1062R
Date: Tue, 27 Jun 2017 11:53:14 +0800
Message-ID: <1498535594-138680-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:34707 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdF0D4C (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jun 2017 23:56:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Adding ASMedia 1061R and 1062R platform device IDs for SATA.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1e1c355..5a5fd0b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -548,6 +548,8 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
 
 	/*
 	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
-- 
1.9.1


