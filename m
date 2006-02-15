From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: add softreset
Date: Wed, 15 Feb 2006 15:36:59 +0900
Message-ID: <20060215063659.GB9621@htj.dyndns.org>
References: <11396427632078-git-send-email-htejun@gmail.com> <43EE72D5.1050005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:16473 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751034AbWBOGhH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 01:37:07 -0500
Received: by wproxy.gmail.com with SMTP id 55so49796wri
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 22:37:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <43EE72D5.1050005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Now that libata is smart enought to handle both soft and hard resets,
add softreset method.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, as I didn't get reply about the whether waiting is necessary or
not, I've just fixed the first part.

Thanks.

 ahci.c |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1c2ab3d..6b36345 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -513,6 +513,138 @@ static void ahci_fill_cmd_slot(struct ah
 	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
 }
 
+static int ahci_poll_register(void __iomem *reg, u32 mask, u32 val,
+			      unsigned long interval_msec,
+			      unsigned long timeout_msec)
+{
+	unsigned long timeout;
+	u32 tmp;
+
+	timeout = jiffies + (timeout_msec * HZ) / 1000;
+	do {
+		tmp = readl(reg);
+		if ((tmp & mask) == val)
+			return 0;
+		msleep(interval_msec);
+	} while (time_before(jiffies, timeout));
+
+	return -1;
+}
+
+static int ahci_softreset(struct ata_port *ap, int verbose, unsigned int *class)
+{
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	const u32 cmd_fis_len = 5; /* five dwords */
+	const char *reason = NULL;
+	struct ata_taskfile tf;
+	u8 *fis;
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* prepare for SRST (AHCI-1.1 10.4.1) */
+	rc = ahci_stop_engine(ap);
+	if (rc) {
+		reason = "failed to stop engine";
+		goto fail_restart;
+	}
+
+	/* check BUSY/DRQ, perform Command List Override if necessary */
+	ahci_tf_read(ap, &tf);
+	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
+		u32 tmp;
+
+		if (!(hpriv->cap & HOST_CAP_CLO)) {
+			rc = -EIO;
+			reason = "port busy but no CLO";
+			goto fail_restart;
+		}
+
+		tmp = readl(port_mmio + PORT_CMD);
+		tmp |= PORT_CMD_CLO;
+		writel(tmp, port_mmio + PORT_CMD);
+		readl(port_mmio + PORT_CMD); /* flush */
+
+		if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0,
+				       1, 500)) {
+			rc = -EIO;
+			reason = "CLO failed";
+			goto fail_restart;
+		}
+	}
+
+	/* restart engine */
+	ahci_start_engine(ap);
+
+	ata_tf_init(ap, &tf, 0);
+	fis = pp->cmd_tbl;
+
+	/* issue the first D2H Register FIS */
+	ahci_fill_cmd_slot(pp, cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
+
+	tf.ctl |= ATA_SRST;
+	ata_tf_to_fis(&tf, fis, 0);
+	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+
+	if (ahci_poll_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x0, 1, 500)) {
+		rc = -EIO;
+		reason = "1st FIS failed";
+		goto fail;
+	}
+
+	/* spec says at least 5us, but be generous and sleep for 1ms */
+	msleep(1);
+
+	/* issue the second D2H Register FIS */
+	ahci_fill_cmd_slot(pp, cmd_fis_len);
+
+	tf.ctl &= ~ATA_SRST;
+	ata_tf_to_fis(&tf, fis, 0);
+	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+
+	/* spec mandates ">= 2ms" before checking status.
+	 * We wait 150ms, because that was the magic delay used for
+	 * ATAPI devices in Hale Landis's ATADRVR, for the period of time
+	 * between when the ATA command register is written, and then
+	 * status is checked.  Because waiting for "a while" before
+	 * checking status is fine, post SRST, we perform this magic
+	 * delay here as well.
+	 */
+	msleep(150);
+
+	*class = ATA_DEV_NONE;
+	if (sata_dev_present(ap)) {
+		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+			rc = -EIO;
+			reason = "device not ready";
+			goto fail;
+		}
+		*class = ahci_dev_classify(ap);
+	}
+
+	DPRINTK("EXIT, class=%u\n", *class);
+	return 0;
+
+ fail_restart:
+	ahci_start_engine(ap);
+ fail:
+	if (verbose)
+		printk(KERN_ERR "ata%u: softreset failed (%s)\n",
+		       ap->id, reason);
+	else
+		DPRINTK("EXIT, rc=%d reason=\"%s\"\n", rc, reason);
+	return rc;
+}
+
 static int ahci_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
 {
 	int rc;
@@ -553,7 +685,8 @@ static void ahci_postreset(struct ata_po
 
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
-	return ata_drive_probe_reset(ap, NULL, NULL, ahci_hardreset,
+	return ata_drive_probe_reset(ap, ata_std_probeinit,
+				     ahci_softreset, ahci_hardreset,
 				     ahci_postreset, classes);
 }
 
