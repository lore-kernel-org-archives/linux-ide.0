From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 7/9] sata_promise.c conversion
Date: Fri, 30 Jun 2006 08:50:29 +0200
Message-ID: <20060630065029.GA17760@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp104.plus.mail.re2.yahoo.com ([206.190.53.29]:31673 "HELO
	smtp104.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751212AbWF3Gud (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 02:50:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Convert the sata-promise.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index b2b6ed5..eda0ef5 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -408,9 +408,10 @@ static void pdc_sata_scr_write (struct a
 static void pdc_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct pdc_port_priv *pp = qc->ap->private_data;
+	struct ata_port *ap = qc->ap;
 	unsigned int i;
 
-	VPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -441,7 +442,7 @@ static void pdc_eng_timeout(struct ata_p
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
@@ -450,7 +451,7 @@ static void pdc_eng_timeout(struct ata_p
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
-		ata_port_printk(ap, KERN_ERR, "command timeout\n");
+		ata_port_printk(ap, ATA_MSG_ERR, "command timeout\n");
 		drv_stat = ata_wait_idle(ap);
 		qc->err_mask |= __ac_err_mask(drv_stat);
 		break;
@@ -458,7 +459,7 @@ static void pdc_eng_timeout(struct ata_p
 	default:
 		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-		ata_port_printk(ap, KERN_ERR,
+		ata_port_printk(ap, ATA_MSG_ERR,
 				"unknown timeout, cmd 0x%x stat 0x%x\n",
 				qc->tf.command, drv_stat);
 
@@ -468,7 +469,7 @@ static void pdc_eng_timeout(struct ata_p
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 	ata_eh_qc_complete(qc);
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
@@ -539,14 +540,15 @@ static irqreturn_t pdc_interrupt (int ir
 	mask &= 0xffff;		/* only 16 tags possible */
 	if (!mask) {
 		VPRINTK("QUICK EXIT 3\n");
+		return IRQ_NONE;
 		goto done_irq;
 	}
 
 	writel(mask, mmio_base + PDC_INT_SEQMASK);
 
 	for (i = 0; i < host_set->n_ports; i++) {
-		VPRINTK("port %u\n", i);
 		ap = host_set->ports[i];
+		ata_port_printk(ap, ATA_MSG_CMD, "port %u\n", i);
 		tmp = mask & (1 << (i + 1));
 		if (tmp && ap &&
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
@@ -572,7 +574,8 @@ static inline void pdc_packet_start(stru
 	unsigned int port_no = ap->port_no;
 	u8 seq = (u8) (port_no + 1);
 
-	VPRINTK("ENTER, ap %p\n", ap);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER, ap %p\n", 
+			__FUNCTION__, ap);
 
 	writel(0x00000001, ap->host_set->mmio_base + (seq * 4));
 	readl(ap->host_set->mmio_base + (seq * 4));	/* flush */

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

