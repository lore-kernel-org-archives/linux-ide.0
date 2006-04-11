From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/15] libata-hp: implement ata_eh_detach_dev()
Date: Tue, 11 Apr 2006 23:14:07 +0900
Message-ID: <11447648473889-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:16055 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751287AbWDKOOJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:09 -0400
Received: by pproxy.gmail.com with SMTP id i49so1396236pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:08 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This function is to be called from EH to disable a device and mark it
for detach.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   20 ++++++++++++++++++++
 include/linux/libata.h     |    1 +
 3 files changed, 22 insertions(+), 0 deletions(-)

7e411eeec0a5d02daa41a48debc6a73ad970921d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 610f963..8f50a99 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5483,6 +5483,7 @@ EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_eh_schedule_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
+EXPORT_SYMBOL_GPL(ata_eh_detach_dev);
 EXPORT_SYMBOL_GPL(ata_eh_determine_qc);
 EXPORT_SYMBOL_GPL(ata_eh_autopsy);
 EXPORT_SYMBOL_GPL(ata_eh_report);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 1a87bce..1f55cc9 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -560,6 +560,26 @@ static unsigned int atapi_eh_request_sen
 }
 
 /**
+ *	ata_eh_detach_dev - EH helper to disable device and schedule detach
+ *	@ap: port on which device to be detached resides
+ *	@dev: device to be detached
+ *
+ *	Disable @dev and schedule it to be detached.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_eh_detach_dev(struct ata_port *ap, struct ata_device *dev)
+{
+	unsigned long flags;
+
+	ata_dev_disable(ap, dev);
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	dev->flags |= ATA_DFLAG_DETACH_ATA | ATA_DFLAG_DETACH_SCSI;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
+/**
  *	ata_read_log_page - read a specific log page
  *	@ap: port on which device we wish to probe resides
  *	@dev: target device
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5f8faca..ee86a87 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -719,6 +719,7 @@ extern void ata_eng_timeout(struct ata_p
 extern void ata_eh_schedule_port(struct ata_port *ap, unsigned int flags);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
+extern void ata_eh_detach_dev(struct ata_port *ap, struct ata_device *dev);
 extern struct ata_queued_cmd * ata_eh_determine_qc(struct ata_port *ap,
 						   int use_log_10h,
 						   struct ata_taskfile *tf);
-- 
1.2.4


