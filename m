From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/10 UPDATED] sata_inic162x: update TF read handling
Date: Thu, 01 May 2008 23:55:58 +0900
Message-ID: <4819D9FE.9000909@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com> <1209540918399-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.180]:27120 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbYEAO4H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2008 10:56:07 -0400
Received: by el-out-1112.google.com with SMTP id n30so402618elf.21
        for <linux-ide@vger.kernel.org>; Thu, 01 May 2008 07:56:05 -0700 (PDT)
In-Reply-To: <1209540918399-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

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

* use inic_tf_read() for classification.

This is not perfect but it fixes hotplug detection failure and at
least makes the driver report 0's instead of random garbages while
reporting valid status and error for device errors.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Hotplug misdetection wasn't caused by wrongly reported signature.  It
was caused by bogus not-ready TF status value.  This patch is updated
accordingly and the whole patchset should be applied on top of the
following patch.

  http://article.gmane.org/gmane.linux.ide/31188

All other patches can be applied w/o change.  The git tree is updated.

  http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=inic162x
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git inic162x

Thanks.

 drivers/ata/sata_inic162x.c |   47 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

Index: work/drivers/ata/sata_inic162x.c
===================================================================
--- work.orig/drivers/ata/sata_inic162x.c
+++ work/drivers/ata/sata_inic162x.c
@@ -410,6 +410,41 @@ static unsigned int inic_qc_issue(struct
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
@@ -430,6 +465,13 @@ static void inic_thaw(struct ata_port *a
 	__inic_set_pirq_mask(ap, PIRQ_MASK_OTHER);
 }
 
+static int inic_check_ready(struct ata_link *link)
+{
+	void __iomem *port_base = inic_port_base(link->ap);
+
+	return ata_check_ready(readb(port_base + PORT_TF_COMMAND));
+}
+
 /*
  * SRST and SControl hardreset don't give valid signature on this
  * controller.  Only controller specific hardreset mechanism works.
@@ -465,7 +507,7 @@ static int inic_hardreset(struct ata_lin
 		struct ata_taskfile tf;
 
 		/* wait for link to become ready */
-		rc = ata_sff_wait_after_reset(link, 1, deadline);
+		rc = ata_wait_after_reset(link, deadline, inic_check_ready);
 		/* link occupied, -ENODEV too is an error */
 		if (rc) {
 			ata_link_printk(link, KERN_WARNING, "device not ready "
@@ -473,7 +515,7 @@ static int inic_hardreset(struct ata_lin
 			return rc;
 		}
 
-		ata_sff_tf_read(ap, &tf);
+		inic_tf_read(ap, &tf);
 		*class = ata_dev_classify(&tf);
 	}
 
@@ -569,6 +611,7 @@ static struct ata_port_operations inic_p
 	.bmdma_stop		= inic_bmdma_stop,
 	.bmdma_status		= inic_bmdma_status,
 	.qc_issue		= inic_qc_issue,
+	.qc_fill_rtf		= inic_qc_fill_rtf,
 
 	.freeze			= inic_freeze,
 	.thaw			= inic_thaw,
