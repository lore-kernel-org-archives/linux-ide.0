From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: 2.6.33-rc2 pata_macio fails to detect PMac G3 CD-drive
Date: Wed, 13 Jan 2010 14:15:01 +0100
Message-ID: <19277.51029.197524.477689@pilspetsen.it.uu.se>
References: <19254.17766.674348.933702@pilspetsen.it.uu.se>
	<1263186759.724.132.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:40466 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705Ab0AMNPJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Jan 2010 08:15:09 -0500
In-Reply-To: <1263186759.724.132.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

Benjamin Herrenschmidt writes:
 > Mikael: Can you try commenting out the code in pata_macio_reset_hw()
 > that calles ppc_mc.feature_call(PMAC_FTR_IDE_RESET,...) ? Keep the
 > ENABLE calls but comment out the reset ones, and let us know if that
 > makes a difference. These calls basically toggle the HW reset line of
 > the drive.

Made no difference (2.6.33-rc4 + patch appended below):

pata-macio 0.00020000:ide: Activating pata-macio chipset Heathrow ATA, Apple bus ID 0
scsi1 : pata_macio
ata1: PATA max MWDMA2 irq 30
irq 30: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[ef075c40] [c00094a0] show_stack+0x74/0x1a8 (unreliable)
[ef075c70] [c00604f0] __report_bad_irq+0x40/0xd4
[ef075c90] [c006077c] note_interrupt+0x1f8/0x254
[ef075cc0] [c0061198] handle_edge_irq+0xe4/0x1ac
[ef075ce0] [c0007004] do_IRQ+0xa8/0xcc
[ef075d00] [c00142cc] ret_from_except+0x0/0x14
--- Exception: 501 at ata_eh_freeze_port+0x34/0x48
    LR = ata_eh_freeze_port+0x30/0x48
[ef075dd0] [c01af1ec] ata_eh_reset+0x370/0xd90
[ef075e50] [c01b0eb4] ata_eh_recover+0x300/0x115c
[ef075ee0] [c01b1f18] ata_do_eh+0x54/0xc8
[ef075f10] [c01b3f68] ata_sff_error_handler+0x144/0x228
[ef075f30] [c01b28a4] ata_scsi_error+0x320/0x548
[ef075f60] [c017e970] scsi_error_handler+0x174/0x444
[ef075fc0] [c0046bc4] kthread+0x80/0x84
[ef075ff0] [c0013a44] kernel_thread+0x4c/0x68
handlers:
[<c01b5f20>] (ata_sff_interrupt+0x0/0x12c)
Disabling IRQ #30
ata1.00: ATAPI: MATSHITA CR-585, ZS20, max MWDMA1
ata1.00: configured for MWDMA1
pata-macio 0.00021000:ide: Activating pata-macio chipset Heathrow ATA, Apple bus ID 1
scsi2 : pata_macio
ata2: PATA max MWDMA2 irq 34
...
ata1.00: qc timeout (cmd 0xa0)
ata1.00: TEST_UNIT_READY failed (err_mask=0x5)
ata1.00: configured for MWDMA1
ata1.00: qc timeout (cmd 0xa0)
ata1.00: TEST_UNIT_READY failed (err_mask=0x5)
ata1.00: limiting speed to MWDMA1:PIO2
ata1.00: configured for MWDMA1
ata1.00: qc timeout (cmd 0xa0)
ata1.00: TEST_UNIT_READY failed (err_mask=0x5)
ata1.00: disabled
ata1: soft resetting link
ata1: EH complete

--- linux-2.6.33-rc4/drivers/ata/pata_macio.c.~1~	2010-01-13 12:49:00.000000000 +0100
+++ linux-2.6.33-rc4/drivers/ata/pata_macio.c	2010-01-13 13:26:01.000000000 +0100
@@ -749,15 +749,21 @@ static void pata_macio_reset_hw(struct p
 		int rc;
 
  		/* Reset and enable controller */
+#if 0
 		rc = ppc_md.feature_call(PMAC_FTR_IDE_RESET,
 					 priv->node, priv->aapl_bus_id, 1);
+#else
+		rc = 0;
+#endif
 		ppc_md.feature_call(PMAC_FTR_IDE_ENABLE,
 				    priv->node, priv->aapl_bus_id, 1);
 		msleep(10);
 		/* Only bother waiting if there's a reset control */
 		if (rc == 0) {
+#if 0
 			ppc_md.feature_call(PMAC_FTR_IDE_RESET,
 					    priv->node, priv->aapl_bus_id, 0);
+#endif
 			msleep(IDE_WAKEUP_DELAY_MS);
 		}
 	}

Seems to me the "irq 30: nobody cared" and "Disabling IRQ #30"
are the real problems. Is the pata_macio irq handler registered
too late, or does it ignore the interrupt?
