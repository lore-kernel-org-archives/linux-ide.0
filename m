From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/8] libata: implement ATA_DFLAG_DUBIOUS_XFER
Date: Fri,  2 Nov 2007 00:51:43 +0900
Message-ID: <11939323061665-git-send-email-htejun@gmail.com>
References: <11939323042554-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:20834 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754359AbXKAPvt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 11:51:49 -0400
In-Reply-To: <11939323042554-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ATA_DFLAG_DUBIOUS_XFER is set whenever data transfer speed or method
changes and gets cleared when data transfer command succeeds in the
newly configured transfer mode.

This will be used to improve speed down logic.

Signed-off-by: Tejun Heo <htejun@gmail.com<
---
 drivers/ata/libata-core.c |   20 ++++++++++++++++++++
 drivers/ata/libata-eh.c   |   33 +++++++++++++++++++++++++++++++--
 include/linux/libata.h    |    3 +++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ec2cb60..0527b1e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5590,6 +5590,23 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
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
+	if ((dev->mwdma_mask || dev->udma_mask) &&
+	    ata_is_pio_data(qc->tf.protocol))
+		return;
+
+	dev->flags &= ~ATA_DFLAG_DUBIOUS_XFER;
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -5661,6 +5678,9 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 			break;
 		}
 
+		if (unlikely(dev->flags & ATA_DFLAG_DUBIOUS_XFER))
+			ata_verify_xfer(qc);
+
 		__ata_qc_complete(qc);
 	} else {
 		if (qc->flags & ATA_QCFLAG_EH_SCHEDULED)
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b5c5388..e635100 100644
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
@@ -2419,11 +2430,27 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
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
@@ -2484,6 +2511,8 @@ static int ata_eh_schedule_probe(struct ata_device *dev)
 	ata_dev_init(dev);
 	ehc->did_probe_mask |= (1 << dev->devno);
 	ehc->i.action |= ATA_EH_SOFTRESET;
+	ehc->saved_xfer_mode[dev->devno] = 0;
+	ehc->saved_ncq_enabled &= ~(1 << dev->devno);
 
 	return 1;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2e4648b..6ac3710 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -139,6 +139,7 @@ enum {
 	ATA_DFLAG_NCQ_OFF	= (1 << 13), /* device limited to non-NCQ mode */
 	ATA_DFLAG_SPUNDOWN	= (1 << 14), /* XXX: for spindown_compat */
 	ATA_DFLAG_SLEEPING	= (1 << 15), /* device is sleeping */
+	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
 	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 24),
@@ -537,6 +538,8 @@ struct ata_eh_context {
 	int			tries[ATA_MAX_DEVICES];
 	unsigned int		classes[ATA_MAX_DEVICES];
 	unsigned int		did_probe_mask;
+	unsigned int		saved_ncq_enabled;
+	u8			saved_xfer_mode[ATA_MAX_DEVICES];
 };
 
 struct ata_acpi_drive
-- 
1.5.2.4

