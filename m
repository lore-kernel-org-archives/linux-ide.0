From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/05] ahci: rewrite ahci_phy_reset
Date: Mon, 19 Dec 2005 22:38:35 +0900
Message-ID: <20051219133835.GE26769@htj.dyndns.org>
References: <20051219133502.GA26769@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:10026 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932341AbVLSNik (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 08:38:40 -0500
Received: by zproxy.gmail.com with SMTP id 14so1921909nzn
        for <linux-ide@vger.kernel.org>; Mon, 19 Dec 2005 05:38:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051219133502.GA26769@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Rewrite ahci_phy_reset such that engine is stopped while phy reset is
in progress as AHCI specification mandates.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 463456a..eece762 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -489,22 +489,72 @@ static unsigned int ahci_dev_classify(st
 	return ata_dev_classify(&tf);
 }
 
+static int ahci_wait_for_bit(void __iomem *reg, u32 mask, u32 val,
+			     unsigned long interval_msec,
+			     unsigned long timeout_msec)
+{
+	unsigned long timeout;
+	u32 tmp;
+
+	timeout = jiffies + (timeout_msec * HZ) / 1000;
+	do {
+		tmp = readl(reg);
+		if ((tmp & mask) != val)
+			return 0;
+		msleep(interval_msec);
+	} while (time_before(jiffies, timeout));
+
+	return -1;
+}
+
 static void ahci_phy_reset(struct ata_port *ap)
 {
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	struct ata_device *dev = &ap->device[0];
 	u32 new_tmp, tmp;
 
-	__sata_phy_reset(ap);
+	/* stop engine */
+	ahci_stop_engine(ap);
 
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+	/* Issue COMRESET.  On AHCI, DET bits are cleared by COMRESET
+	 * and it may take quite some millisecs before they are turned
+	 * on again.  Wait longer if device is present.
+	 */
+	tmp = readl(port_mmio + PORT_SCR_STAT);
+
+	writel(0x301, port_mmio + PORT_SCR_CTL);
+	readl(port_mmio + PORT_SCR_CTL); /* flush */
+	msleep(1);
+	writel(0x300, port_mmio + PORT_SCR_CTL);
+	readl(port_mmio + PORT_SCR_CTL); /* flush */
+
+	msleep(200);
+	if (tmp & 0xf)
+		ahci_wait_for_bit(port_mmio + PORT_SCR_STAT, 0xf, 0x0, 10, 5000);
+	ahci_wait_for_bit(port_mmio + PORT_SCR_STAT, 0xf, 0x1, 10, 5000);
+
+	/* clear SATA phy error, if any */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* re-start engine */
+	ahci_start_engine(ap);
+
+	/* print link status & classify */
+	ata_sata_print_link_status(ap);
+
+	if (!sata_dev_present(ap))
+		goto out_disable;
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT))
+		goto out_disable;
 
 	dev->class = ahci_dev_classify(ap);
-	if (!ata_dev_present(dev)) {
-		ata_port_disable(ap);
-		return;
-	}
+	if (!ata_dev_present(dev))
+		goto out_disable;
+
+	ata_port_probe(ap);
 
 	/* Make sure port's ATAPI bit is set appropriately */
 	new_tmp = tmp = readl(port_mmio + PORT_CMD);
@@ -516,6 +566,12 @@ static void ahci_phy_reset(struct ata_po
 		writel(new_tmp, port_mmio + PORT_CMD);
 		readl(port_mmio + PORT_CMD); /* flush */
 	}
+
+	ap->cbl = ATA_CBL_SATA;
+	return;
+
+ out_disable:
+	ata_port_disable(ap);
 }
 
 static u8 ahci_check_status(struct ata_port *ap)
