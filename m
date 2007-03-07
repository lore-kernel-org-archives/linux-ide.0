From: <gregkh@suse.de>
Subject: patch sata_sil-ignore-and-clear-spurious-irqs-while-executing-commands-by-polling.patch queued to -stable tree
Date: Tue, 06 Mar 2007 17:30:51 -0800
Message-ID: <20070307013224.77964C6C36B@imap.suse.de>
References: <20070224133036.GB20322@htj.dyndns.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:48467 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161131AbXCGBc1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 20:32:27 -0500
In-Reply-To: <20070224133036.GB20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, gregkh@suse.de, jeff@garzik.org, linux-ide@vger.kernel.org
Cc: stable@kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: sata_sil: ignore and clear spurious IRQs while executing commands by polling

to the 2.6.20-stable tree.  Its filename is

     sata_sil-ignore-and-clear-spurious-irqs-while-executing-commands-by-polling.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From stable-bounces@linux.kernel.org Sat Feb 24 05:32:07 2007
From: Tejun Heo <htejun@gmail.com>
Date: Sat, 24 Feb 2007 22:30:36 +0900
Subject: sata_sil: ignore and clear spurious IRQs while executing commands by polling
To: Jeff Garzik <jeff@garzik.org>, <linux-ide@vger.kernel.org>
Cc: stable@kernel.org
Message-ID: <20070224133036.GB20322@htj.dyndns.org>
Content-Disposition: inline


sata_sil used to trigger HSM error if IRQ occurs during polling
command.  This didn't matter because polling wasn't used in sata_sil.
However, as of 2.6.20, all IDENTIFYs are performed by polling and
device detection sometimes fails due to spurious IRQ.  This patch
makes sata_sil ignore and clear spurious IRQ while executing commands
by polling.

This fixes bug#7996 and IMHO should also be included in -stable.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -386,9 +386,15 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 		goto freeze;
 	}
 
-	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
+	if (unlikely(!qc))
 		goto freeze;
 
+	if (unlikely(qc->tf.flags & ATA_TFLAG_POLLING)) {
+		/* this sometimes happens, just clear IRQ */
+		ata_chk_status(ap);
+		return;
+	}
+
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable


Patches currently in stable-queue which might be from htejun@gmail.com are

