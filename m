From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/15] libata: ATA_FLAG_IN_EH is not used, kill it
Date: Sun, 2 Apr 2006 18:51:52 +0900
Message-ID: <11439715122600-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:48058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932278AbWDBJv6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:51:58 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447005nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:51:58 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
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

ba36d3e3f4b1dba269a1c09f48f3131d287181ca
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
index a4a1e63..e20b0bf 100644
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


