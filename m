From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: implement ATA_FLAG_IN_EH port flag
Date: Thu, 2 Feb 2006 00:56:10 +0900
Message-ID: <11388093701287-git-send-email-htejun@gmail.com>
References: <11388093703495-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:34000 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161104AbWBAP4Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2006 10:56:16 -0500
Received: by zproxy.gmail.com with SMTP id 14so166954nzn
        for <linux-ide@vger.kernel.org>; Wed, 01 Feb 2006 07:56:16 -0800 (PST)
In-Reply-To: <11388093703495-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

ATA_FLAG_IN_EH flag is set on entry to EH and cleared on completion.
This patch just sets and clears the flag.  Following patches will
build normal qc execution / EH synchronization aroung this flag.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |    9 +++++++++
 include/linux/libata.h     |    2 ++
 2 files changed, 11 insertions(+), 0 deletions(-)

402b1d5c510fe7f9ad0457bcedb3a4742e79d649
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 6df8293..0e14259 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -735,6 +735,11 @@ int ata_scsi_error(struct Scsi_Host *hos
 
 	DPRINTK("ENTER\n");
 
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	assert(!(ap->flags & ATA_FLAG_IN_EH));
+	ap->flags |= ATA_FLAG_IN_EH;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	ap = (struct ata_port *) &host->hostdata[0];
 	ap->ops->eng_timeout(ap);
 
@@ -742,6 +747,10 @@ int ata_scsi_error(struct Scsi_Host *hos
 
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags &= ~ATA_FLAG_IN_EH;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	DPRINTK("EXIT\n");
 	return 0;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 474cdfa..55176df 100644
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
1.1.3


