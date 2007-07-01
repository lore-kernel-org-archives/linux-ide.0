From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/15] ahci: separate out ahci_kick_engine()
Date: Sun, 1 Jul 2007 19:54:16 +0900
Message-ID: <11832872563253-git-send-email-htejun@gmail.com>
References: <1183287253677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:54750 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756986AbXGAKyZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:54:25 -0400
Received: by py-out-1112.google.com with SMTP id u77so2090571pyb
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:54:25 -0700 (PDT)
In-Reply-To: <1183287253677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Separate out stop_engine - CLO - start_engine sequence from
ahci_softreset() and ahci_clo() into ahci_reset_engine() and use it in
ahci_softreset() and ahci_post_internal_cmd().  The function will also
be used to prepare for and clean up after PMP register access
commands.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   69 +++++++++++++++++++++++++++-------------------------
 1 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9af91ac..9d24dad 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -923,25 +923,49 @@ static void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
 	pp->cmd_slot[tag].tbl_addr_hi = cpu_to_le32((cmd_tbl_dma >> 16) >> 16);
 }
 
-static int ahci_clo(struct ata_port *ap)
+static int ahci_kick_engine(struct ata_port *ap, int force_restart)
 {
 	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u32 tmp;
+	int busy, rc;
 
-	if (!(hpriv->cap & HOST_CAP_CLO))
-		return -EOPNOTSUPP;
+	/* do we need to kick the port? */
+	busy = ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ);
+	if (!busy && !force_restart)
+		return 0;
+
+	/* stop engine */
+	rc = ahci_stop_engine(ap);
+	if (rc)
+		goto out_restart;
+
+	/* need to do CLO? */
+	if (!busy) {
+		rc = 0;
+		goto out_restart;
+	}
+
+	if (!(hpriv->cap & HOST_CAP_CLO)) {
+		rc = -EOPNOTSUPP;
+		goto out_restart;
+	}
 
+	/* perform CLO */
 	tmp = readl(port_mmio + PORT_CMD);
 	tmp |= PORT_CMD_CLO;
 	writel(tmp, port_mmio + PORT_CMD);
 
+	rc = 0;
 	tmp = ata_wait_register(port_mmio + PORT_CMD,
 				PORT_CMD_CLO, PORT_CMD_CLO, 1, 500);
 	if (tmp & PORT_CMD_CLO)
-		return -EIO;
+		rc = -EIO;
 
-	return 0;
+	/* restart engine */
+ out_restart:
+	ahci_start_engine(ap);
+	return rc;
 }
 
 static int ahci_softreset(struct ata_link *link, unsigned int *class,
@@ -967,27 +991,10 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 	}
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
-	rc = ahci_stop_engine(ap);
-	if (rc) {
-		reason = "failed to stop engine";
-		goto fail_restart;
-	}
-
-	/* check BUSY/DRQ, perform Command List Override if necessary */
-	if (ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)) {
-		rc = ahci_clo(ap);
-
-		if (rc == -EOPNOTSUPP) {
-			reason = "port busy but CLO unavailable";
-			goto fail_restart;
-		} else if (rc) {
-			reason = "port busy but CLO failed";
-			goto fail_restart;
-		}
-	}
-
-	/* restart engine */
-	ahci_start_engine(ap);
+	rc = ahci_kick_engine(ap, 1);
+	if (rc)
+		ata_link_printk(link, KERN_WARNING,
+				"failed to reset engine (errno=%d)", rc);
 
 	ata_tf_init(link->device, &tf);
 	fis = pp->cmd_tbl;
@@ -1046,8 +1053,6 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
- fail_restart:
-	ahci_start_engine(ap);
  fail:
 	ata_link_printk(link, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
@@ -1497,11 +1502,9 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
-	if (qc->flags & ATA_QCFLAG_FAILED) {
-		/* make DMA engine forget about the failed command */
-		ahci_stop_engine(ap);
-		ahci_start_engine(ap);
-	}
+	/* make DMA engine forget about the failed command */
+	if (qc->flags & ATA_QCFLAG_FAILED)
+		ahci_kick_engine(ap, 1);
 }
 
 #ifdef CONFIG_PM
-- 
1.5.0.3


