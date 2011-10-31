From: <r66093@freescale.com>
Subject: [PATCH] libata-pmp: add schedule timeout to support some PMP cards
Date: Mon, 31 Oct 2011 11:57:20 +0800
Message-ID: <1320033440-1106-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:54222
	"EHLO AM1EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752060Ab1JaFJ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2011 01:09:27 -0400
Received: from mail65-am1 (localhost.localdomain [127.0.0.1])	by
 mail65-am1-R.bigfish.com (Postfix) with ESMTP id EFA6B738139	for
 <linux-ide@vger.kernel.org>; Mon, 31 Oct 2011 05:09:20 +0000 (UTC)
Received: from AM1EHSMHS014.bigfish.com (unknown [10.3.201.254])	by
 mail65-am1.bigfish.com (Postfix) with ESMTP id A6296440050	for
 <linux-ide@vger.kernel.org>; Mon, 31 Oct 2011 05:09:20 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jerry Huang <r66093@freescale.com>

From: Jerry Huang <r66093freescale.com>

With Freescale SATA controller, some PMP cards(e.g JMB393 PMP card)
can't work on some platforms (e.g mpc837x, p1022):
During PMP initialize, when reading the PMP SCR, we will observe the TIMEOUT
error because PMP card SCR is not ready.
Therefore, we need enough time to wait for the PMP card ready for SCR read:
1. read the SCR after 1ms sleep,
2. if failed, looping until read success or timeout (count = 0)

below is the error log:
fsl-sata e0018000.sata: Sata FSL Platform/CSB Driver init
scsi0 : sata_fsl
ata1: SATA max UDMA/133 irq 44
ata1: Signature Update detected @ 504 msecs
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 15 ports, feat 0x5/0xf
ata2.00: hard resetting link
ata2.15: qc timeout (cmd 0xe4)
ata2.00: failed to read SCR 0 (Emask=0x4)
ata2.00: failed to read SCR 0 (Emask=0x40)
ata2.00: failed to read SCR 0 (Emask=0x40)
ata2: ATA_SRST issue failed
ata2.00: failed to read SCR 0 (Emask=0x40)
ata2.00: reset failed, giving up
ata2.15: hard resetting link
ata2: Hardreset failed, not off-lined 0
ata2: No Signature Update
ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: hard resetting link
ata2.15: qc timeout (cmd 0xe4)
ata2.00: failed to read SCR 0 (Emask=0x4)
ata2.00: failed to read SCR 0 (Emask=0x40)
ata2.00: failed to read SCR 0 (Emask=0x40)
ata2: ATA_SRST issue failed
ata2.00: failed to read SCR 0 (Emask=0x40)
ata2.00: reset failed, giving up
ata2.15: hard resetting link
ata2: Hardreset failed, not off-lined 0
ata2: No Signature Update
ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: hard resetting link
ata2.15: qc timeout (cmd 0xe4)
ata2.00: failed to read SCR 0 (Emask=0x4)
ata2.00: failed to read SCR 0 (Emask=0x40)
ata2.00: failed to read SCR 0 (Emask=0x40)
ata2: ATA_SRST issue failed
ata2.00: failed to read SCR 0 (Emask=0x40)
ata2.00: reset failed, giving up
ata2.00: failed to recover link after 3 tries, disabling
ata2.15: hard resetting link
ata2: Hardreset failed, not off-lined 0
ata2: No Signature Update
ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.15: qc timeout (cmd 0xe4)
ata2.00: failed to read SCR 0 (Emask=0x4)
ata2.00: failed to write SCR 1 (Emask=0x40)
ata2.00: failed to clear SError.N (errno=-5)
ata2.15: hard resetting link
ata2: Hardreset failed, not off-lined 0
ata2: No Signature Update
ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.01: hard resetting link
ata2.01: failed to resume link (SControl 0)
ata2.01: SATA link down (SStatus 0 SControl 0)
ata2.02: hard resetting link
ata2.02: failed to resume link (SControl 0)
ata2.02: SATA link down (SStatus 0 SControl 0)
......
ata2.14: hard resetting link
ata2.14: failed to resume link (SControl 0)
ata2.14: SATA link down (SStatus 0 SControl 0)
ata2: EH complete

Signed-off-by: Jerry Huang <r66093@freescale.com>
---
 drivers/ata/libata-pmp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 224faab..18d5f8e 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -140,11 +140,19 @@ int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
 int sata_pmp_scr_read(struct ata_link *link, int reg, u32 *r_val)
 {
 	unsigned int err_mask;
+	int count = 20;	/* try 20 times */
 
 	if (reg > SATA_PMP_PSCR_CONTROL)
 		return -EINVAL;
 
-	err_mask = sata_pmp_read(link, reg, r_val);
+	do {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1 * HZ / 1000); /* sleep 1 msecond */
+		set_current_state(TASK_RUNNING);
+
+		err_mask = sata_pmp_read(link, reg, r_val);
+	} while ((count--) && err_mask);
+
 	if (err_mask) {
 		ata_link_printk(link, KERN_WARNING, "failed to read SCR %d "
 				"(Emask=0x%x)\n", reg, err_mask);
-- 
1.7.4.1


