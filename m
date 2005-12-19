From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/05] ahci: separate out ahci_dev_classify
Date: Mon, 19 Dec 2005 22:37:17 +0900
Message-ID: <20051219133717.GD26769@htj.dyndns.org>
References: <20051219133502.GA26769@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:12833 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932341AbVLSNhV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 08:37:21 -0500
Received: by zproxy.gmail.com with SMTP id 14so1921599nzn
        for <linux-ide@vger.kernel.org>; Mon, 19 Dec 2005 05:37:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051219133502.GA26769@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Separate out ahci_dev_classify().

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 085d749..463456a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -474,10 +474,24 @@ static void ahci_start_engine(struct ata
 	readl(port_mmio + PORT_CMD); /* flush */
 }
 
-static void ahci_phy_reset(struct ata_port *ap)
+static unsigned int ahci_dev_classify(struct ata_port *ap)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	struct ata_taskfile tf;
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_SIG);
+	tf.lbah		= (tmp >> 24)	& 0xff;
+	tf.lbam		= (tmp >> 16)	& 0xff;
+	tf.lbal		= (tmp >> 8)	& 0xff;
+	tf.nsect	= (tmp)		& 0xff;
+
+	return ata_dev_classify(&tf);
+}
+
+static void ahci_phy_reset(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	struct ata_device *dev = &ap->device[0];
 	u32 new_tmp, tmp;
 
@@ -486,13 +500,7 @@ static void ahci_phy_reset(struct ata_po
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
 
-	tmp = readl(port_mmio + PORT_SIG);
-	tf.lbah		= (tmp >> 24)	& 0xff;
-	tf.lbam		= (tmp >> 16)	& 0xff;
-	tf.lbal		= (tmp >> 8)	& 0xff;
-	tf.nsect	= (tmp)		& 0xff;
-
-	dev->class = ata_dev_classify(&tf);
+	dev->class = ahci_dev_classify(ap);
 	if (!ata_dev_present(dev)) {
 		ata_port_disable(ap);
 		return;
