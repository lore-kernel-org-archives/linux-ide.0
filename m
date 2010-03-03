From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 06/11] ahci: Factor out PCI specifics from
 ahci_init_controller()
Date: Wed, 3 Mar 2010 20:17:42 +0300
Message-ID: <20100303171742.GF12362@oksana.dev.rtsoft.ru>
References: <20100303171713.GA6322@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:37343 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754742Ab0CCRRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 12:17:43 -0500
Content-Disposition: inline
In-Reply-To: <20100303171713.GA6322@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Move PCI stuff into ahci_pci_init_controller().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ata/ahci.c |   45 +++++++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b646364..439ff90 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1668,11 +1668,34 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 static void ahci_init_controller(struct ata_host *host)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
 	void __iomem *mmio = hpriv->mmio;
 	int i;
 	void __iomem *port_mmio;
 	u32 tmp;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		port_mmio = ahci_port_base(ap);
+		if (ata_port_is_dummy(ap))
+			continue;
+
+		ahci_port_init(host->dev, ap, i, mmio, port_mmio);
+	}
+
+	tmp = readl(mmio + HOST_CTL);
+	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
+	tmp = readl(mmio + HOST_CTL);
+	VPRINTK("HOST_CTL 0x%x\n", tmp);
+}
+
+static void ahci_pci_init_controller(struct ata_host *host)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	void __iomem *port_mmio;
+	u32 tmp;
 	int mv;
 
 	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
@@ -1691,21 +1714,7 @@ static void ahci_init_controller(struct ata_host *host)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 	}
 
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		port_mmio = ahci_port_base(ap);
-		if (ata_port_is_dummy(ap))
-			continue;
-
-		ahci_port_init(host->dev, ap, i, mmio, port_mmio);
-	}
-
-	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
-	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
-	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	ahci_init_controller(host);
 }
 
 static void ahci_dev_config(struct ata_device *dev)
@@ -2682,7 +2691,7 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 		if (rc)
 			return rc;
 
-		ahci_init_controller(host);
+		ahci_pci_init_controller(host);
 	}
 
 	ata_host_resume(host);
@@ -3410,7 +3419,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	ahci_init_controller(host);
+	ahci_pci_init_controller(host);
 	ahci_print_info(host);
 
 	pci_set_master(pdev);
-- 
1.7.0

