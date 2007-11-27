From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/8] libata: implement ATA_DFLAG_DUBIOUS_XFER
Date: Tue, 27 Nov 2007 19:28:58 +0900
Message-ID: <11961593404096-git-send-email-htejun@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:15466 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878AbXK0K3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:29:32 -0500
Received: by rv-out-0910.google.com with SMTP id k20so837301rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:29:31 -0800 (PST)
In-Reply-To: <11961593392491-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, Tejun Heo <htejun@gmail.com>

ATA_DFLAG_DUBIOUS_XFER is set whenever data transfer speed or method
changes and gets cleared when data transfer command succeeds in the
newly configured transfer mode.

This will be used to improve speed down logic.

Signed-off-by: Tejun Heo <htejun@gmail.com<
---
 drivers/ata/libata-core.c |   19 +++++++++++++++++++
 drivers/ata/libata-eh.c   |   33 +++++++++++++++++++++++++++++++--
 include/linux/libata.h    |    3 +++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 85053bf..fe453c7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5764,6 +5764,22 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
 	ap->ops->tf_read(ap, &qc->result_tf);
 }
 
+static void ata_verify_xfer(struct ata_queued_cmd *qc)
+{
+	struct ata_device *dev = qc->dev;
+
+	if (ata_tag_internal(qc->tag))
+		return;
+
+	if (ata_is_nodata(qc->tf.protocol))
+		return;
+
+	if ((dev->mwdma_mask || dev->udma_mask) && ata_is_pio(qc->tf.protocol))
+		return;
+
+	dev->flags &= ~ATA_DFLAG_DUBIOUS_XFER;
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -5835,6 +5851,9 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 			break;
 		}
 
+		if (unlikely(dev->flags & ATA_DFLAG_DUBIOUS_XFER))
+			ata_verify_xfer(qc);
+
 		__ata_qc_complete(qc);
 	} else {
 		if (qc->flags & ATA_QCFLAG_EH_SCHEDULED)
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index e479df2..2ba6f59 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -456,9 +456,20 @@ void ata_scsi_error(struct Scsi_Host *host)
 		spin_lock_irqsave(ap->lock, flags);
 
 		__ata_port_for_each_link(link, ap) {
+			struct ata_eh_context *ehc = &link->eh_context;
+			struct ata_device *dev;
+
 			memset(&link->eh_context, 0, sizeof(link->eh_context));
 			link->eh_context.i = link->eh_info;
 			memset(&link->eh_info, 0, sizeof(link->eh_info));
+
+			ata_link_for_each_dev(dev, link) {
+				int devno = dev->devno;
+
+				ehc->saved_xfer_mode[devno] = dev->xfer_mode;
+				if (ata_ncq_enabled(dev))
+					ehc->saved_ncq_enabled |= 1 << devno;
+			}
 		}
 
 		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
@@ -2344,11 +2355,27 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 {
 	struct ata_port *ap = link->ap;
+	struct ata_device *dev;
+	int rc;
 
 	/* has private set_mode? */
 	if (ap->ops->set_mode)
-		return ap->ops->set_mode(link, r_failed_dev);
-	return ata_do_set_mode(link, r_failed_dev);
+		rc = ap->ops->set_mode(link, r_failed_dev);
+	else
+		rc = ata_do_set_mode(link, r_failed_dev);
+
+	/* if transfer mode has changed, set DUBIOUS_XFER on device */
+	ata_link_for_each_dev(dev, link) {
+		struct ata_eh_context *ehc = &link->eh_context;
+		u8 saved_xfer_mode = ehc->saved_xfer_mode[dev->devno];
+		u8 saved_ncq = !!(ehc->saved_ncq_enabled & (1 << dev->devno));
+
+		if (dev->xfer_mode != saved_xfer_mode ||
+		    ata_ncq_enabled(dev) != saved_ncq)
+			dev->flags |= ATA_DFLAG_DUBIOUS_XFER;
+	}
+
+	return rc;
 }
 
 static int ata_link_nr_enabled(struct ata_link *link)
@@ -2409,6 +2436,8 @@ static int ata_eh_schedule_probe(struct ata_device *dev)
 	ata_dev_init(dev);
 	ehc->did_probe_mask |= (1 << dev->devno);
 	ehc->i.action |= ATA_EH_SOFTRESET;
+	ehc->saved_xfer_mode[dev->devno] = 0;
+	ehc->saved_ncq_enabled &= ~(1 << dev->devno);
 
 	return 1;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e9407f1..a1b47d8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -141,6 +141,7 @@ enum {
 	ATA_DFLAG_NCQ_OFF	= (1 << 13), /* device limited to non-NCQ mode */
 	ATA_DFLAG_SPUNDOWN	= (1 << 14), /* XXX: for spindown_compat */
 	ATA_DFLAG_SLEEPING	= (1 << 15), /* device is sleeping */
+	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
 	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 24),
@@ -557,6 +558,8 @@ struct ata_eh_context {
 	int			tries[ATA_MAX_DEVICES];
 	unsigned int		classes[ATA_MAX_DEVICES];
 	unsigned int		did_probe_mask;
+	unsigned int		saved_ncq_enabled;
+	u8			saved_xfer_mode[ATA_MAX_DEVICES];
 };
 
 struct ata_acpi_drive
-- 
1.5.2.4

