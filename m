From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4/7] libata: Drain data on errors
Date: Fri, 05 Dec 2008 19:43:13 +0000
Message-ID: <20081205194309.17133.50690.stgit@localhost.localdomain>
References: <20081205194231.17133.42760.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40164 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755748AbYLETnF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2008 14:43:05 -0500
In-Reply-To: <20081205194231.17133.42760.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kai@kaishome.de, linux-ide@vger.kernel.org, jeff@garzik.org

From: Alan Cox <alan@redhat.com>

If the device is signalling that there is data to drain after an error we
should read the bytes out and throw them away. Without this some devices
and controllers get wedged and don't recover.

Based on earlier work by Mark Lord

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/libata-sff.c  |   44 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/pata_pcmcia.c |   34 +++++++++++++++++++++++++++++++++-
 include/linux/libata.h    |    3 +++
 3 files changed, 79 insertions(+), 2 deletions(-)


diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9033d16..e74b3db 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -52,6 +52,7 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.softreset		= ata_sff_softreset,
 	.hardreset		= sata_sff_hardreset,
 	.postreset		= ata_sff_postreset,
+	.drain_fifo		= ata_sff_drain_fifo,
 	.error_handler		= ata_sff_error_handler,
 	.post_internal_cmd	= ata_sff_post_internal_cmd,
 
@@ -2082,6 +2083,38 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
 }
 
 /**
+ *	ata_sff_drain_fifo - Stock FIFO drain logic for SFF controllers
+ *	@qc: command
+ *
+ *	Drain the FIFO and device of any stuck data following a command
+ *	failing to complete. In some cases this is neccessary before a
+ *	reset will recover the device.
+ *
+ */
+
+void ata_sff_drain_fifo(struct ata_queued_cmd *qc)
+{
+	int count;
+	struct ata_port *ap;
+
+	/* We only need to flush incoming data when a command was running */
+	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
+		return;
+
+	ap = qc->ap;
+	/* Drain up to 64K of data before we give up this recovery method */
+	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
+						&& count < 32768; count++)
+		ioread16(ap->ioaddr.data_addr);
+
+	/* Can become DEBUG later */
+	if (count)
+		ata_port_printk(ap, KERN_WARNING,
+			"drained %d bytes to clear DRQ.\n", count);
+
+}
+
+/**
  *	ata_sff_error_handler - Stock error handler for BMDMA controller
  *	@ap: port to handle error for
  *
@@ -2122,7 +2155,8 @@ void ata_sff_error_handler(struct ata_port *ap)
 		 * really a timeout event, adjust error mask and
 		 * cancel frozen state.
 		 */
-		if (qc->err_mask == AC_ERR_TIMEOUT && (host_stat & ATA_DMA_ERR)) {
+		if (qc->err_mask == AC_ERR_TIMEOUT
+						&& (host_stat & ATA_DMA_ERR)) {
 			qc->err_mask = AC_ERR_HOST_BUS;
 			thaw = 1;
 		}
@@ -2133,6 +2167,13 @@ void ata_sff_error_handler(struct ata_port *ap)
 	ata_sff_sync(ap);		/* FIXME: We don't need this */
 	ap->ops->sff_check_status(ap);
 	ap->ops->sff_irq_clear(ap);
+	/* We *MUST* do FIFO draining before we issue a reset as several
+	 * devices helpfully clear their internal state and will lock solid
+	 * if we touch the data port post reset. Pass qc in case anyone wants
+	 *  to do different PIO/DMA recovery or has per command fixups
+	 */
+	if (ap->ops->drain_fifo)
+		ap->ops->drain_fifo(qc);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
@@ -2856,6 +2897,7 @@ EXPORT_SYMBOL_GPL(ata_sff_wait_after_reset);
 EXPORT_SYMBOL_GPL(ata_sff_softreset);
 EXPORT_SYMBOL_GPL(sata_sff_hardreset);
 EXPORT_SYMBOL_GPL(ata_sff_postreset);
+EXPORT_SYMBOL_GPL(ata_sff_drain_fifo);
 EXPORT_SYMBOL_GPL(ata_sff_error_handler);
 EXPORT_SYMBOL_GPL(ata_sff_post_internal_cmd);
 EXPORT_SYMBOL_GPL(ata_sff_port_start);
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 64b2e22..35de58e 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -42,7 +42,7 @@
 
 
 #define DRV_NAME "pata_pcmcia"
-#define DRV_VERSION "0.3.3"
+#define DRV_VERSION "0.3.5"
 
 /*
  *	Private data structure to glue stuff together
@@ -126,6 +126,37 @@ static unsigned int ata_data_xfer_8bit(struct ata_device *dev,
 	return buflen;
 }
 
+/**
+ *	pcmcia_8bit_drain_fifo - Stock FIFO drain logic for SFF controllers
+ *	@qc: command
+ *
+ *	Drain the FIFO and device of any stuck data following a command
+ *	failing to complete. In some cases this is neccessary before a
+ *	reset will recover the device.
+ *
+ */
+ 
+void pcmcia_8bit_drain_fifo(struct ata_queued_cmd *qc)
+{
+	int count;
+	struct ata_port *ap;
+
+	/* We only need to flush incoming data when a command was running */
+	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
+		return;
+
+	ap = qc->ap;
+
+	/* Drain up to 64K of data before we give up this recovery method */
+	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
+							&& count++ < 65536;)
+		ioread8(ap->ioaddr.data_addr);
+
+	/* Can become DEBUG later */
+	ata_port_printk(ap, KERN_WARNING, "drained %d bytes to clear DRQ.\n",
+								count);
+
+}
 
 static struct scsi_host_template pcmcia_sht = {
 	ATA_PIO_SHT(DRV_NAME),
@@ -143,6 +174,7 @@ static struct ata_port_operations pcmcia_8bit_port_ops = {
 	.sff_data_xfer	= ata_data_xfer_8bit,
 	.cable_detect	= ata_cable_40wire,
 	.set_mode	= pcmcia_set_mode_8bit,
+	.drain_fifo	= pcmcia_8bit_drain_fifo,
 };
 
 #define CS_CHECK(fn, ret) \
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ed3f26e..291ac55 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -825,6 +825,8 @@ struct ata_port_operations {
 	void (*bmdma_start)(struct ata_queued_cmd *qc);
 	void (*bmdma_stop)(struct ata_queued_cmd *qc);
 	u8   (*bmdma_status)(struct ata_port *ap);
+
+	void (*drain_fifo)(struct ata_queued_cmd *qc);
 #endif /* CONFIG_ATA_SFF */
 
 	ssize_t (*em_show)(struct ata_port *ap, char *buf);
@@ -1531,6 +1533,7 @@ extern int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 extern int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 			       unsigned long deadline);
 extern void ata_sff_postreset(struct ata_link *link, unsigned int *classes);
+extern void ata_sff_drain_fifo(struct ata_queued_cmd *qc);
 extern void ata_sff_error_handler(struct ata_port *ap);
 extern void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc);
 extern int ata_sff_port_start(struct ata_port *ap);

