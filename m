From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/14] ahci: separate out ahci_stop/start_engine()
Date: Sun, 18 Dec 2005 22:48:22 +0900
Message-ID: <20051218134822.GK31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:31465 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965115AbVLRNs1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:48:27 -0500
Received: by zproxy.gmail.com with SMTP id 14so1716120nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:48:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Separate out ahci_stop/start_engine() from ahci_restart_port().  This
is preparation for conversion to new reset mechanism.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-12-18 16:32:04.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-12-18 19:54:50.000000000 +0900
@@ -437,6 +437,43 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
+static int ahci_stop_engine(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	int work;
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp &= ~PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/* wait for engine to stop.  TODO: this could be
+	 * as long as 500 msec
+	 */
+	work = 1000;
+	while (work-- > 0) {
+		tmp = readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_LIST_ON) == 0)
+			return 0;
+		udelay(10);
+	}
+
+	return -EIO;
+}
+
+static void ahci_start_engine(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+}
+
 static void ahci_phy_reset(struct ata_port *ap)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
@@ -563,7 +600,6 @@ static void ahci_restart_port(struct ata
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
-	int work;
 
 	if ((ap->device[0].class != ATA_DEV_ATAPI) ||
 	    ((irq_stat & PORT_IRQ_TF_ERR) == 0))
@@ -579,20 +615,7 @@ static void ahci_restart_port(struct ata
 			readl(port_mmio + PORT_SCR_ERR));
 
 	/* stop DMA */
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= ~PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-
-	/* wait for engine to stop.  TODO: this could be
-	 * as long as 500 msec
-	 */
-	work = 1000;
-	while (work-- > 0) {
-		tmp = readl(port_mmio + PORT_CMD);
-		if ((tmp & PORT_CMD_LIST_ON) == 0)
-			break;
-		udelay(10);
-	}
+	ahci_stop_engine(ap);
 
 	/* clear SATA phy error, if any */
 	tmp = readl(port_mmio + PORT_SCR_ERR);
@@ -611,10 +634,7 @@ static void ahci_restart_port(struct ata
 	}
 
 	/* re-start DMA */
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
+	ahci_start_engine(ap);
 }
 
 static void ahci_eng_timeout(struct ata_port *ap)
