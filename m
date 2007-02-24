From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil: ignore and clear spurious IRQs while executing commands by polling
Date: Sat, 24 Feb 2007 22:30:36 +0900
Message-ID: <20070224133036.GB20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:45480 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763AbXBXNaj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 08:30:39 -0500
Received: by nz-out-0506.google.com with SMTP id s1so751975nze
        for <linux-ide@vger.kernel.org>; Sat, 24 Feb 2007 05:30:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: stable@kernel.org

sata_sil used to trigger HSM error if IRQ occurs during polling
command.  This didn't matter because polling wasn't used in sata_sil.
However, as of 2.6.20, all IDENTIFYs are performed by polling and
device detection sometimes fails due to spurious IRQ.  This patch
makes sata_sil ignore and clear spurious IRQ while executing commands
by polling.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This fixes bug#7996 and IMHO should also be included in -stable.
Thanks.

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 1487255..aaff357 100644
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
