From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: separate port number determination from host initialization
Date: Fri, 9 Mar 2007 19:47:09 +0900
Message-ID: <20070309104709.GF32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:24212 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767159AbXCIKrK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 05:47:10 -0500
Received: by py-out-1112.google.com with SMTP id a29so280896pyi
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 02:47:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

ahci used to reset controller then fetch cap value to be used for
configuration.  On some controller this misses some cap bits and ahci
got modified to maintain cap and ports_impl values over reset, so
there is no reason to reset the controller before fetching those
register values.

Separate out ahci_determine_nr_ports() from ahci_host_init() and it
before starting to initialize probe_ent.  This makes ahci's init_one
more consistent to other drivers and eases conversion to new init
model.

Also, the initialization is more robust as it doesn't depend on
ports_impl being writeable when HONOR_PI is set but the register
itself is zero.

Tested on ICH7 (no ports_impl) and 8 AHCI (w/ ports_impl).

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |  100 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 43cc43d..4242c70 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -672,11 +672,6 @@ static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev)
 	 * Restore BIOS values... which we HOPE were present before
 	 * reset.
 	 */
-	if (!impl_save) {
-		impl_save = (1 << ahci_nr_ports(cap_save)) - 1;
-		dev_printk(KERN_WARNING, &pdev->dev,
-			   "PORTS_IMPL is zero, forcing 0x%x\n", impl_save);
-	}
 	writel(cap_save, mmio + HOST_CAP);
 	writel(impl_save, mmio + HOST_PORTS_IMPL);
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
@@ -1517,49 +1512,60 @@ static void ahci_setup_port(struct ata_ioports *port, void __iomem *base,
 	VPRINTK("EXIT\n");
 }
 
+static int ahci_determine_nr_ports(struct pci_dev *pdev,
+				   struct ata_port_info *pi,
+				   struct ahci_host_priv *hpriv,
+				   unsigned int *dummy_mask)
+{
+	u32 port_map;
+	int cap_n_ports, n_ports, max_port, i;
+
+	cap_n_ports = ahci_nr_ports(hpriv->cap);
+
+	VPRINTK("cap 0x%x  port_map 0x%x  cap_n_ports %d\n",
+		hpriv->cap, hpriv->port_map, cap_n_ports);
+
+	if (!(pi->flags & AHCI_FLAG_HONOR_PI))
+		return cap_n_ports;
+
+	if (!hpriv->port_map) {
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "HONOR_PI set but port map is zero, ignoring\n");
+		pi->flags &= ~AHCI_FLAG_HONOR_PI;
+		return cap_n_ports;
+	}
+
+	port_map = hpriv->port_map;
+	n_ports = cap_n_ports;
+	for (i = 0, max_port = 0; i < AHCI_MAX_PORTS && n_ports; i++) {
+		if (port_map & (1 << i)) {
+			n_ports--;
+			port_map &= ~(1 << i);
+			max_port = i;
+		} else
+			*dummy_mask |= 1 << i;
+	}
+
+	if (n_ports || port_map)
+		dev_printk(KERN_WARNING, &pdev->dev, "nr_ports (%u) and "
+			   "implemented port map (0x%x) don't match\n",
+			   cap_n_ports, hpriv->port_map);
+
+	return max_port + 1;
+}
+
 static int ahci_host_init(struct ata_probe_ent *probe_ent)
 {
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void __iomem *mmio = probe_ent->iomap[AHCI_PCI_BAR];
-	unsigned int i, cap_n_ports, using_dac;
+	unsigned int i, using_dac;
 	int rc;
 
 	rc = ahci_reset_controller(mmio, pdev);
 	if (rc)
 		return rc;
 
-	hpriv->cap = readl(mmio + HOST_CAP);
-	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
-	cap_n_ports = ahci_nr_ports(hpriv->cap);
-
-	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
-		hpriv->cap, hpriv->port_map, cap_n_ports);
-
-	if (probe_ent->port_flags & AHCI_FLAG_HONOR_PI) {
-		unsigned int n_ports = cap_n_ports;
-		u32 port_map = hpriv->port_map;
-		int max_port = 0;
-
-		for (i = 0; i < AHCI_MAX_PORTS && n_ports; i++) {
-			if (port_map & (1 << i)) {
-				n_ports--;
-				port_map &= ~(1 << i);
-				max_port = i;
-			} else
-				probe_ent->dummy_port_mask |= 1 << i;
-		}
-
-		if (n_ports || port_map)
-			dev_printk(KERN_WARNING, &pdev->dev,
-				   "nr_ports (%u) and implemented port map "
-				   "(0x%x) don't match\n",
-				   cap_n_ports, hpriv->port_map);
-
-		probe_ent->n_ports = max_port + 1;
-	} else
-		probe_ent->n_ports = cap_n_ports;
-
 	using_dac = hpriv->cap & HOST_CAP_64;
 	if (using_dac &&
 	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
@@ -1673,7 +1679,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	struct ata_port_info pi = ahci_port_info[board_idx];
 	struct device *dev = &pdev->dev;
+	void __iomem *mmio;
 	struct ata_probe_ent *probe_ent;
 	struct ahci_host_priv *hpriv;
 	int rc;
@@ -1694,6 +1702,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
+	mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
 
 	if (pci_enable_msi(pdev))
 		pci_intx(pdev, 1);
@@ -1709,11 +1718,18 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!hpriv)
 		return -ENOMEM;
 
-	probe_ent->sht		= ahci_port_info[board_idx].sht;
-	probe_ent->port_flags	= ahci_port_info[board_idx].flags;
-	probe_ent->pio_mask	= ahci_port_info[board_idx].pio_mask;
-	probe_ent->udma_mask	= ahci_port_info[board_idx].udma_mask;
-	probe_ent->port_ops	= ahci_port_info[board_idx].port_ops;
+	/* determine number of ports and fill probe_ent */
+	hpriv->cap = readl(mmio + HOST_CAP);
+	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
+
+	probe_ent->n_ports = ahci_determine_nr_ports(pdev, &pi, hpriv,
+						&probe_ent->dummy_port_mask);
+
+	probe_ent->sht		= pi.sht;
+	probe_ent->port_flags	= pi.flags;
+	probe_ent->pio_mask	= pi.pio_mask;
+	probe_ent->udma_mask	= pi.udma_mask;
+	probe_ent->port_ops	= pi.port_ops;
 
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = IRQF_SHARED;
-- 
1.5.0.1

