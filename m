From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH, RFC] pdc_adma: convert to new EH
Date: Sat, 17 Jun 2006 20:21:07 +0900
Message-ID: <20060617112107.GB11755@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:44880 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751360AbWFQLVO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 07:21:14 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1327677nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Jun 2006 04:21:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Convert pdc_adma to new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Hello,

This driver looked very similar to sata_qstor and thus converted in
similar way.  Again, all I can say is that it compiles.  :-p

* Am I using reinit_engine() correctly?

* ATA_NIEN good enough for freeze?

* freeze on healthy paranoia?

Thanks.

--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -129,14 +129,14 @@ static irqreturn_t adma_intr (int irq, v
 static int adma_port_start(struct ata_port *ap);
 static void adma_host_stop(struct ata_host_set *host_set);
 static void adma_port_stop(struct ata_port *ap);
-static void adma_phy_reset(struct ata_port *ap);
 static void adma_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int adma_qc_issue(struct ata_queued_cmd *qc);
 static int adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void adma_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 adma_bmdma_status(struct ata_port *ap);
 static void adma_irq_clear(struct ata_port *ap);
-static void adma_eng_timeout(struct ata_port *ap);
+static void adma_error_handler(struct ata_port *ap);
+static void adma_post_internal_cmd(struct ata_queued_cmd *qc);
 
 static struct scsi_host_template adma_ata_sht = {
 	.module			= THIS_MODULE,
@@ -164,10 +164,12 @@ static const struct ata_port_operations 
 	.check_atapi_dma	= adma_check_atapi_dma,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= adma_phy_reset,
 	.qc_prep		= adma_qc_prep,
 	.qc_issue		= adma_qc_issue,
-	.eng_timeout		= adma_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= adma_error_handler,
+	.post_internal_cmd	= adma_post_internal_cmd,
 	.data_xfer		= ata_mmio_data_xfer,
 	.irq_handler		= adma_intr,
 	.irq_clear		= adma_irq_clear,
@@ -182,8 +184,8 @@ static struct ata_port_info adma_port_in
 	/* board_1841_idx */
 	{
 		.sht		= &adma_ata_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x1f, /* udma0-4 */
 		.port_ops	= &adma_ata_ops,
@@ -270,24 +272,51 @@ static inline void adma_enter_reg_mode(s
 	readb(chan + ADMA_STATUS);	/* flush */
 }
 
-static void adma_phy_reset(struct ata_port *ap)
+static int adma_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct adma_port_priv *pp = ap->private_data;
 
 	pp->state = adma_state_idle;
 	adma_reinit_engine(ap);
-	ata_port_probe(ap);
-	ata_bus_reset(ap);
+
+	return ata_std_softreset(ap, class);
+}
+
+static int adma_hardreset(struct ata_port *ap, unsigned int *class)
+{
+	struct adma_port_priv *pp = ap->private_data;
+
+	pp->state = adma_state_idle;
+	adma_reinit_engine(ap);
+
+	return sata_std_hardreset(ap, class);
 }
 
-static void adma_eng_timeout(struct ata_port *ap)
+static void adma_error_handler(struct ata_port *ap)
 {
 	struct adma_port_priv *pp = ap->private_data;
 
 	if (pp->state != adma_state_idle) /* healthy paranoia */
 		pp->state = adma_state_mmio;
-	adma_reinit_engine(ap);
-	ata_eng_timeout(ap);
+
+	if (!(ap->flags & ATA_FLAG_FROZEN)) {
+		pp->state = adma_state_idle;
+		adma_reinit_engine(ap);
+	}
+
+	ata_do_eh(ap, ata_std_prereset, adma_softreset, adma_hardreset,
+		  ata_std_postreset);
+}
+
+static void adma_post_internal_cmd(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct adma_port_priv *pp = ap->private_data;
+
+	if (qc->err_mask) {
+		pp->state = adma_state_idle;
+		adma_reinit_engine(ap);
+	}
 }
 
 static int adma_fill_sg(struct ata_queued_cmd *qc)
