From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/4] sata_dwc_460ex: fix compilation errors/warnings
Date: Fri, 28 Jan 2011 21:55:55 +0300
Message-ID: <201101282155.55438.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:33195 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751219Ab1A1S5R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2011 13:57:17 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Fix the following compilation errors/warnings:

drivers/ata/sata_dwc_460ex.c:43:1: warning: "DRV_NAME" redefined
In file included from drivers/ata/sata_dwc_460ex.c:38:
drivers/ata/libata.h:31:1: warning: this is the location of the previous
definition
drivers/ata/sata_dwc_460ex.c:44:1: warning: "DRV_VERSION" redefined
drivers/ata/libata.h:32:1: warning: this is the location of the previous
definition
drivers/ata/sata_dwc_460ex.c: In function `sata_dwc_exec_command_by_tag':
drivers/ata/sata_dwc_460ex.c:1356: warning: passing argument 1 of
`ata_get_cmd_descript' makes integer from pointer without a cast
drivers/ata/sata_dwc_460ex.c: In function `sata_dwc_qc_issue':
drivers/ata/sata_dwc_460ex.c:1476: warning: `err' is used uninitialized in this
function
drivers/ata/sata_dwc_460ex.c:1465: note: `err' was declared here
drivers/ata/sata_dwc_460ex.c: In function `sata_dwc_qc_issue':
drivers/ata/sata_dwc_460ex.c:1493: warning: passing argument 1 of
`ata_get_cmd_descript' makes integer from pointer without a cast
drivers/ata/sata_dwc_460ex.c: In function `sata_dwc_qc_prep':
drivers/ata/sata_dwc_460ex.c:1537: error: `tag' undeclared (first use in this
function)
drivers/ata/sata_dwc_460ex.c:1537: error: (Each undeclared identifier is
reported only once
drivers/ata/sata_dwc_460ex.c:1537: error: for each function it appears in.)

NB: error only happens if DEBUG_NCQ macro is defined...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/sata_dwc_460ex.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/ata/sata_dwc_460ex.c
===================================================================
--- linux-2.6.orig/drivers/ata/sata_dwc_460ex.c
+++ linux-2.6/drivers/ata/sata_dwc_460ex.c
@@ -40,8 +40,11 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 
+/* These two are defined in "libata.h" */
+#undef	DRV_NAME
+#undef	DRV_VERSION
 #define DRV_NAME        "sata-dwc"
-#define DRV_VERSION     "1.0"
+#define DRV_VERSION     "1.1"
 
 /* SATA DMA driver Globals */
 #define DMA_NUM_CHANS		1
@@ -1354,7 +1357,7 @@ static void sata_dwc_exec_command_by_tag
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 
 	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=%d\n", __func__, tf->command,
-		ata_get_cmd_descript(tf), tag);
+		ata_get_cmd_descript(tf->command), tag);
 
 	spin_lock_irqsave(&ap->host->lock, flags);
 	hsdevp->cmd_issued[tag] = cmd_issued;
@@ -1462,7 +1465,6 @@ static void sata_dwc_qc_prep_by_tag(stru
 	int dma_chan;
 	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
-	int err;
 
 	dev_dbg(ap->dev, "%s: port=%d dma dir=%s n_elem=%d\n",
 		__func__, ap->port_no, ata_get_cmd_descript(qc->dma_dir),
@@ -1474,7 +1476,7 @@ static void sata_dwc_qc_prep_by_tag(stru
 				      dmadr), qc->dma_dir);
 	if (dma_chan < 0) {
 		dev_err(ap->dev, "%s: dma_dwc_xfer_setup returns err %d\n",
-			__func__, err);
+			__func__, dma_chan);
 		return;
 	}
 	hsdevp->dma_chan[tag] = dma_chan;
@@ -1491,7 +1493,7 @@ static unsigned int sata_dwc_qc_issue(st
 		dev_info(ap->dev, "%s ap id=%d cmd(0x%02x)=%s qc tag=%d "
 			 "prot=%s ap active_tag=0x%08x ap sactive=0x%08x\n",
 			 __func__, ap->print_id, qc->tf.command,
-			 ata_get_cmd_descript(&qc->tf),
+			 ata_get_cmd_descript(qc->tf.command),
 			 qc->tag, ata_get_cmd_descript(qc->tf.protocol),
 			 ap->link.active_tag, ap->link.sactive);
 #endif
@@ -1533,7 +1535,7 @@ static void sata_dwc_qc_prep(struct ata_
 #ifdef DEBUG_NCQ
 	if (qc->tag > 0)
 		dev_info(qc->ap->dev, "%s: qc->tag=%d ap->active_tag=0x%08x\n",
-			 __func__, tag, qc->ap->link.active_tag);
+			 __func__, qc->tag, qc->ap->link.active_tag);
 
 	return ;
 #endif
