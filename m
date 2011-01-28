From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/4] sata_dwc_460ex: fix misuse of ata_get_cmd_descript()
Date: Fri, 28 Jan 2011 22:01:01 +0300
Message-ID: <201101282201.01793.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:59157 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755057Ab1A1TCX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2011 14:02:23 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

The driver erroneously uses ata_get_cmd_descript() not only for printing out
the ATA commands but also the protocol and DMA direction enums. Add functions
for properly printing those out...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/sata_dwc_460ex.c |   56 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/ata/sata_dwc_460ex.c
===================================================================
--- linux-2.6.orig/drivers/ata/sata_dwc_460ex.c
+++ linux-2.6/drivers/ata/sata_dwc_460ex.c
@@ -44,7 +44,7 @@
 #undef	DRV_NAME
 #undef	DRV_VERSION
 #define DRV_NAME        "sata-dwc"
-#define DRV_VERSION     "1.2"
+#define DRV_VERSION     "1.3"
 
 /* SATA DMA driver Globals */
 #define DMA_NUM_CHANS		1
@@ -336,11 +336,47 @@ static int dma_dwc_xfer_setup(struct sca
 			      void __iomem *addr, int dir);
 static void dma_dwc_xfer_start(int dma_ch);
 
+static const char *get_prot_descript(u8 protocol)
+{
+	switch ((enum ata_tf_protocols)protocol) {
+	case ATA_PROT_NODATA:
+		return "ATA no data";
+	case ATA_PROT_PIO:
+		return "ATA PIO";
+	case ATA_PROT_DMA:
+		return "ATA DMA";
+	case ATA_PROT_NCQ:
+		return "ATA NCQ";
+	case ATAPI_PROT_NODATA:
+		return "ATAPI no data";
+	case ATAPI_PROT_PIO:
+		return "ATAPI PIO";
+	case ATAPI_PROT_DMA:
+		return "ATAPI DMA";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *get_dma_dir_descript(int dma_dir)
+{
+	switch ((enum dma_data_direction)dma_dir) {
+	case DMA_BIDIRECTIONAL:
+		return "bidirectional";
+	case DMA_TO_DEVICE:
+		return "to device";
+	case DMA_FROM_DEVICE:
+		return "from device";
+	default:
+		return "none";
+	}
+}
+
 static void sata_dwc_tf_dump(struct ata_taskfile *tf)
 {
 	dev_vdbg(host_pvt.dwc_dev, "taskfile cmd: 0x%02x protocol: %s flags:"
-		"0x%lx device: %x\n", tf->command, ata_get_cmd_descript\
-		(tf->protocol), tf->flags, tf->device);
+		"0x%lx device: %x\n", tf->command,
+		get_prot_descript(tf->protocol), tf->flags, tf->device);
 	dev_vdbg(host_pvt.dwc_dev, "feature: 0x%02x nsect: 0x%x lbal: 0x%x "
 		"lbam: 0x%x lbah: 0x%x\n", tf->feature, tf->nsect, tf->lbal,
 		 tf->lbam, tf->lbah);
@@ -970,7 +1006,7 @@ static irqreturn_t sata_dwc_isr(int irq,
 		}
 
 		dev_dbg(ap->dev, "%s non-NCQ cmd interrupt, protocol: %s\n",
-			__func__, ata_get_cmd_descript(qc->tf.protocol));
+			__func__, get_prot_descript(qc->tf.protocol));
 DRVSTILLBUSY:
 		if (ata_is_dma(qc->tf.protocol)) {
 			/*
@@ -1060,7 +1096,7 @@ DRVSTILLBUSY:
 
 		/* Process completed command */
 		dev_dbg(ap->dev, "%s NCQ command, protocol: %s\n", __func__,
-			ata_get_cmd_descript(qc->tf.protocol));
+			get_prot_descript(qc->tf.protocol));
 		if (ata_is_dma(qc->tf.protocol)) {
 			host_pvt.dma_interrupt_count++;
 			if (hsdevp->dma_pending[tag] == \
@@ -1145,8 +1181,8 @@ static void sata_dwc_dma_xfer_complete(s
 	if (tag > 0) {
 		dev_info(ap->dev, "%s tag=%u cmd=0x%02x dma dir=%s proto=%s "
 			 "dmacr=0x%08x\n", __func__, qc->tag, qc->tf.command,
-			 ata_get_cmd_descript(qc->dma_dir),
-			 ata_get_cmd_descript(qc->tf.protocol),
+			 get_dma_dir_descript(qc->dma_dir),
+			 get_prot_descript(qc->tf.protocol),
 			 in_le32(&(hsdev->sata_dwc_regs->dmacr)));
 	}
 #endif
@@ -1416,7 +1452,7 @@ static void sata_dwc_bmdma_start_by_tag(
 
 	dev_dbg(ap->dev, "%s qc=%p tag: %x cmd: 0x%02x dma_dir: %s "
 		"start_dma? %x\n", __func__, qc, tag, qc->tf.command,
-		ata_get_cmd_descript(qc->dma_dir), start_dma);
+		get_dma_dir_descript(qc->dma_dir), start_dma);
 	sata_dwc_tf_dump(&(qc->tf));
 
 	if (start_dma) {
@@ -1467,7 +1503,7 @@ static void sata_dwc_qc_prep_by_tag(stru
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 
 	dev_dbg(ap->dev, "%s: port=%d dma dir=%s n_elem=%d\n",
-		__func__, ap->port_no, ata_get_cmd_descript(qc->dma_dir),
+		__func__, ap->port_no, get_dma_dir_descript(qc->dma_dir),
 		 qc->n_elem);
 
 	dma_chan = dma_dwc_xfer_setup(sg, qc->n_elem, hsdevp->llit[tag],
@@ -1494,7 +1530,7 @@ static unsigned int sata_dwc_qc_issue(st
 			 "prot=%s ap active_tag=0x%08x ap sactive=0x%08x\n",
 			 __func__, ap->print_id, qc->tf.command,
 			 ata_get_cmd_descript(qc->tf.command),
-			 qc->tag, ata_get_cmd_descript(qc->tf.protocol),
+			 qc->tag, get_prot_descript(qc->tf.protocol),
 			 ap->link.active_tag, ap->link.sactive);
 #endif
 
