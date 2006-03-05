From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: rename ATA_FLAG_FLUSH_PIO_TASK to ATA_FLAG_FLUSH_PORT_TASK
Date: Sun, 5 Mar 2006 15:29:09 +0900
Message-ID: <1141540149927-git-send-email-htejun@gmail.com>
References: <1141540149886-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:17136 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751898AbWCEG3P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 01:29:15 -0500
Received: by pproxy.gmail.com with SMTP id i75so538843pye
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 22:29:13 -0800 (PST)
In-Reply-To: <1141540149886-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Rename ATA_FLAG_FLUSH_PIO_TASK to ATA_FLAG_FLUSH_PORT_TASK.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 +++---
 include/linux/libata.h     |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

4347020e90c1e2ae5d8d48b27e9d52f7143730e1
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 657b196..6a06c47 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -742,7 +742,7 @@ void ata_port_queue_task(struct ata_port
 {
 	int rc;
 
-	if (ap->flags & ATA_FLAG_FLUSH_PIO_TASK)
+	if (ap->flags & ATA_FLAG_FLUSH_PORT_TASK)
 		return;
 
 	PREPARE_WORK(&ap->port_task, fn, data);
@@ -773,7 +773,7 @@ void ata_port_flush_task(struct ata_port
 	DPRINTK("ENTER\n");
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->flags |= ATA_FLAG_FLUSH_PIO_TASK;
+	ap->flags |= ATA_FLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	DPRINTK("flush #1\n");
@@ -790,7 +790,7 @@ void ata_port_flush_task(struct ata_port
 	}
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->flags &= ~ATA_FLAG_FLUSH_PIO_TASK;
+	ap->flags &= ~ATA_FLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	DPRINTK("EXIT\n");
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d856660..034f515 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -151,7 +151,7 @@ enum {
 	ATA_FLAG_PIO_LBA48	= (1 << 13), /* Host DMA engine is LBA28 only */
 	ATA_FLAG_IRQ_MASK	= (1 << 14), /* Mask IRQ in PIO xfers */
 
-	ATA_FLAG_FLUSH_PIO_TASK	= (1 << 15), /* Flush PIO task */
+	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* Flush port task */
 	ATA_FLAG_IN_EH		= (1 << 16), /* EH in progress */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
-- 
1.2.1


