From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/10] sata_inic162x: update TF read handling
Date: Wed, 30 Apr 2008 16:35:10 +0900
Message-ID: <1209540918399-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.245]:29897 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755399AbYD3HfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:25 -0400
Received: by rv-out-0506.google.com with SMTP id k29so211406rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:24 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

inic162x can't reliably read back TF or at least we don't know how to
do it yet.  The only values which seem reliable are status and error.
This patch updates access to TF.

* implement inic_tf_read() which reads the TF area in mmio area

* implement custom inic_qc_fill_rtf() which only returns true if
  status indicates device error.  it'll be returning bogus addresses
  for device errors but it'll be able to report why it failed at
  least.

* implement custom inic_check_ready() and use ata_wait_after_reset()
  instead of the SFF version.

* use inic_tf_read() for classification && assume ATA if class is
  invalid when link is online.

This is not perfect but it fixes hotplug detection failure and at
least makes the driver report 0's instead of random garbages while
reporting valid status and error for device errors.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |   53 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 1b10455..db669f2 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -410,6 +410,41 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
 	return ata_sff_qc_issue(qc);
 }
 
+static void inic_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	void __iomem *port_base = inic_port_base(ap);
+
+	tf->feature	= readb(port_base + PORT_TF_FEATURE);
+	tf->nsect	= readb(port_base + PORT_TF_NSECT);
+	tf->lbal	= readb(port_base + PORT_TF_LBAL);
+	tf->lbam	= readb(port_base + PORT_TF_LBAM);
+	tf->lbah	= readb(port_base + PORT_TF_LBAH);
+	tf->device	= readb(port_base + PORT_TF_DEVICE);
+	tf->command	= readb(port_base + PORT_TF_COMMAND);
+}
+
+static bool inic_qc_fill_rtf(struct ata_queued_cmd *qc)
+{
+	struct ata_taskfile *rtf = &qc->result_tf;
+	struct ata_taskfile tf;
+
+	/* FIXME: Except for status and error, result TF access
+	 * doesn't work.  I tried reading from BAR0/2, CPB and BAR5.
+	 * None works regardless of which command interface is used.
+	 * For now return true iff status indicates device error.
+	 * This means that we're reporting bogus sector for RW
+	 * failures.  Eeekk....
+	 */
+	inic_tf_read(qc->ap, &tf);
+
+	if (!(tf.command & ATA_ERR))
+		return false;
+
+	rtf->command = tf.command;
+	rtf->feature = tf.feature;
+	return true;
+}
+
 static void inic_freeze(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
@@ -430,6 +465,13 @@ static void inic_thaw(struct ata_port *ap)
 	__inic_set_pirq_mask(ap, PIRQ_MASK_OTHER);
 }
 
+static int inic_check_ready(struct ata_link *link)
+{
+	void __iomem *port_base = inic_port_base(link->ap);
+
+	return !(readb(port_base + PORT_TF_COMMAND) & ATA_BUSY);
+}
+
 /*
  * SRST and SControl hardreset don't give valid signature on this
  * controller.  Only controller specific hardreset mechanism works.
@@ -465,7 +507,7 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 		struct ata_taskfile tf;
 
 		/* wait for link to become ready */
-		rc = ata_sff_wait_after_reset(link, 1, deadline);
+		rc = ata_wait_after_reset(link, deadline, inic_check_ready);
 		/* link occupied, -ENODEV too is an error */
 		if (rc) {
 			ata_link_printk(link, KERN_WARNING, "device not ready "
@@ -473,8 +515,14 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 			return rc;
 		}
 
-		ata_sff_tf_read(ap, &tf);
+		inic_tf_read(ap, &tf);
 		*class = ata_dev_classify(&tf);
+
+		/* Signature sometimes isn't reliable after hotplug,
+		 * assume ATA if signature is invalid.
+		 */
+		if (!ata_class_enabled(*class))
+			*class = ATA_DEV_ATA;
 	}
 
 	return 0;
@@ -569,6 +617,7 @@ static struct ata_port_operations inic_port_ops = {
 	.bmdma_stop		= inic_bmdma_stop,
 	.bmdma_status		= inic_bmdma_status,
 	.qc_issue		= inic_qc_issue,
+	.qc_fill_rtf		= inic_qc_fill_rtf,
 
 	.freeze			= inic_freeze,
 	.thaw			= inic_thaw,
-- 
1.5.2.4

