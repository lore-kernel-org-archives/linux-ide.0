From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/21] ahci: separate out ahci_kick_engine()
Date: Mon, 16 Jul 2007 14:29:39 +0900
Message-ID: <11845637793363-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:11877 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479AbXGPF3q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:46 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736627nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:45 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
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
index 0451600..1be238d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -948,25 +948,49 @@ static void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
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
 
 static int ahci_softreset(struct ata_port *ap, unsigned int *class,
@@ -991,27 +1015,10 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
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
+		ata_port_printk(ap, KERN_WARNING,
+				"failed to reset engine (errno=%d)", rc);
 
 	ata_tf_init(ap->device, &tf);
 	fis = pp->cmd_tbl;
@@ -1070,8 +1077,6 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
- fail_restart:
-	ahci_start_engine(ap);
  fail:
 	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
@@ -1516,11 +1521,9 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
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
 
 static int ahci_port_resume(struct ata_port *ap)
-- 
1.5.0.3


