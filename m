From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH, RFC] sata_qstor: convert to new EH
Date: Sat, 17 Jun 2006 20:07:17 +0900
Message-ID: <20060617110717.GA11755@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:64729 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751592AbWFQLHW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 07:07:22 -0400
Received: by py-out-1112.google.com with SMTP id i49so845692pye
        for <linux-ide@vger.kernel.org>; Sat, 17 Jun 2006 04:07:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org

Convert sata_qstor to new EH.

---

Hello, Mark.

Does this conversion make sense?  I don't have access to qstor
controller or the doc, so this is done mostly by guessing.  I'm
curious about...

* qs_reset_channel_logic() resets the silicon but nothing else.  ie.
  it makes the controller forget about previous state and ready for
  new command but doesn't reset ATA bus, right?  If so, I think it
  would be better to move pp->state = qs_state_idle into that
  function.

* Is there better way to implement freeze/thaw other than the standard
  BMDMA way (ATA_NIEN)?

* Would ata_std_softreset() work on this controller?

* What do you think about freezing the port if pp->state != idle on
  entry to EH instead of forcing it to mmio?  Doing so would keep EH
  from mangling with the controller until the controller is reset,
  which will restore pp->state to idle.

Thanks.

diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 98ddc25..aafabd1 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -118,14 +118,14 @@ static irqreturn_t qs_intr (int irq, voi
 static int qs_port_start(struct ata_port *ap);
 static void qs_host_stop(struct ata_host_set *host_set);
 static void qs_port_stop(struct ata_port *ap);
-static void qs_phy_reset(struct ata_port *ap);
 static void qs_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int qs_qc_issue(struct ata_queued_cmd *qc);
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc);
 static void qs_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 qs_bmdma_status(struct ata_port *ap);
 static void qs_irq_clear(struct ata_port *ap);
-static void qs_eng_timeout(struct ata_port *ap);
+static void qs_error_handler(struct ata_port *ap);
+static void qs_post_internal_cmd(struct ata_queued_cmd *qc);
 
 static struct scsi_host_template qs_ata_sht = {
 	.module			= THIS_MODULE,
@@ -154,11 +154,13 @@ static const struct ata_port_operations 
 	.check_atapi_dma	= qs_check_atapi_dma,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= qs_phy_reset,
 	.qc_prep		= qs_qc_prep,
 	.qc_issue		= qs_qc_issue,
 	.data_xfer		= ata_mmio_data_xfer,
-	.eng_timeout		= qs_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= qs_error_handler,
+	.post_internal_cmd	= qs_post_internal_cmd,
 	.irq_handler		= qs_intr,
 	.irq_clear		= qs_irq_clear,
 	.scr_read		= qs_scr_read,
@@ -175,8 +177,6 @@ static const struct ata_port_info qs_por
 	{
 		.sht		= &qs_ata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET |
-				  //FIXME ATA_FLAG_SRST |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x7f, /* udma0-6 */
@@ -235,23 +235,51 @@ static inline void qs_reset_channel_logi
 	qs_enter_reg_mode(ap);
 }
 
-static void qs_phy_reset(struct ata_port *ap)
+static int qs_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct qs_port_priv *pp = ap->private_data;
 
 	pp->state = qs_state_idle;
 	qs_reset_channel_logic(ap);
-	sata_phy_reset(ap);
+
+	return ata_std_softreset(ap, class);
+}
+
+static int qs_hardreset(struct ata_port *ap, unsigned int *class)
+{
+	struct qs_port_priv *pp = ap->private_data;
+
+	pp->state = qs_state_idle;
+	qs_reset_channel_logic(ap);
+
+	return sata_std_hardreset(ap, class);
 }
 
-static void qs_eng_timeout(struct ata_port *ap)
+static void qs_error_handler(struct ata_port *ap)
 {
 	struct qs_port_priv *pp = ap->private_data;
 
 	if (pp->state != qs_state_idle) /* healthy paranoia */
 		pp->state = qs_state_mmio;
-	qs_reset_channel_logic(ap);
-	ata_eng_timeout(ap);
+
+	if (!(ap->flags & ATA_FLAG_FROZEN)) {
+		pp->state = qs_state_idle;
+		qs_reset_channel_logic(ap);
+	}
+
+	ata_do_eh(ap, ata_std_prereset, qs_softreset, qs_hardreset,
+		  ata_std_postreset);
+}
+
+static void qs_post_internal_cmd(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct qs_port_priv *pp = ap->private_data;
+
+	if (qc->err_mask) {
+		pp->state = qs_state_idle;
+		qs_reset_channel_logic(ap);
+	}
 }
 
 static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg)
