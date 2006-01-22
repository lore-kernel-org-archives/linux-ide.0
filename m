From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] libata: implement ATA_FLAG_IN_EH port flag
Date: Sun, 22 Jan 2006 16:58:31 +0900
Message-ID: <11379167111012-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.194]:32683 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751257AbWAVH6j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:39 -0500
Received: by xproxy.gmail.com with SMTP id s14so513086wxc
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:39 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

ATA_FLAG_IN_EH flag is set on entry to EH and cleared on completion.
This patch just sets and clears the flag.  Following patches will
build normal qc execution / EH synchronization aroung this flag.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |    6 ++++++
 include/linux/libata.h     |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

cdc39a8dc6c08611e6317f4dcad2abaa5e027525
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index accb63a..cf54536 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -738,6 +738,8 @@ int ata_scsi_error(struct Scsi_Host *hos
 	DPRINTK("ENTER\n");
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
+	assert(!(ap->flags & ATA_FLAG_IN_EH));
+	ap->flags |= ATA_FLAG_IN_EH;
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
@@ -778,6 +780,10 @@ int ata_scsi_error(struct Scsi_Host *hos
 
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags &= ~ATA_FLAG_IN_EH;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	DPRINTK("EXIT\n");
 	return 0;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 576788d..063221d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -162,6 +162,8 @@ enum {
 	ATA_FLAG_PIO_LBA48	= (1 << 13), /* Host DMA engine is LBA28 only */
 	ATA_FLAG_IRQ_MASK	= (1 << 14), /* Mask IRQ in PIO xfers */
 
+	ATA_FLAG_IN_EH		= (1 << 15), /* EH in progress */
+
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
-- 
1.0.8


