From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/14] libata: ATA_FLAG_IN_EH is not used, kill it
Date: Sat, 1 Apr 2006 19:48:36 +0900
Message-ID: <11438885164168-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:54728 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751359AbWDAKsq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:46 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210246nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:45 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill unused flag ATA_FLAG_IN_EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   17 ++++-------------
 include/linux/libata.h     |    1 -
 2 files changed, 4 insertions(+), 14 deletions(-)

2b41377fa3c3134fdce3e2366f16c6df4e27d3df
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index c1a4b29..bcbf71e 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -779,20 +779,15 @@ enum scsi_eh_timer_return ata_scsi_timed
 
 int ata_scsi_error(struct Scsi_Host *host)
 {
-	struct ata_port *ap;
-	unsigned long flags;
+	struct ata_port *ap = (struct ata_port *)&host->hostdata[0];
 
 	DPRINTK("ENTER\n");
 
-	ap = (struct ata_port *) &host->hostdata[0];
+	/* synchronize with IRQ handler and port task */
+	spin_unlock_wait(&ap->host_set->lock);
+	ata_port_flush_task(ap);
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	WARN_ON(ap->flags & ATA_FLAG_IN_EH);
-	ap->flags |= ATA_FLAG_IN_EH;
 	WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	ata_port_flush_task(ap);
 
 	ap->ops->eng_timeout(ap);
 
@@ -800,10 +795,6 @@ int ata_scsi_error(struct Scsi_Host *hos
 
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->flags &= ~ATA_FLAG_IN_EH;
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
 	DPRINTK("EXIT\n");
 	return 0;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c246a15..036b737 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -152,7 +152,6 @@ enum {
 	ATA_FLAG_IRQ_MASK	= (1 << 14), /* Mask IRQ in PIO xfers */
 
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* Flush port task */
-	ATA_FLAG_IN_EH		= (1 << 16), /* EH in progress */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
-- 
1.2.4


