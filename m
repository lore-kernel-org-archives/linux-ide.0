From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] remove PCI dependence from libata
Date: Fri, 12 Nov 2004 19:10:16 -0500
Message-ID: <419550E8.5080404@pobox.com>
References: <006e01c4c069$dea08f60$4205040a@internal.synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090802070108080604060102"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20925 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262772AbUKMAKc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Nov 2004 19:10:32 -0500
In-Reply-To: <006e01c4c069$dea08f60$4205040a@internal.synopsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mat.Loikkanen@synopsys.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090802070108080604060102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Here's what I just checked in, to libata-2.6, libata-2.4, and 
libata-upstream-2.4 queues.



--------------090802070108080604060102
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

#
# ChangeSet
#   2004/11/12 19:01:32-05:00 jgarzik@pobox.com 
#   [libata] remove dependence on PCI
#   
#   Most of this work was done by "Mat Loikkanen" <Mat.Loikkanen@synopsys.com>.
#   
#   * use struct device rather than struct pci_dev
#   * use generic DMA routines (dma_xxx) and generic struct device
#     routines (dev_xxx)
#   * isolate PCI-specific helpers inside CONFIG_PCI
# 
diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/ahci.c	2004-11-12 19:08:53 -05:00
@@ -270,7 +270,7 @@
 
 static int ahci_port_start(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
 	struct ahci_port_priv *pp;
 	int rc;
@@ -289,7 +289,7 @@
 	}
 	memset(pp, 0, sizeof(*pp));
 
-	mem = pci_alloc_consistent(pdev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma);
+	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
 	if (!mem) {
 		rc = -ENOMEM;
 		goto err_out_kfree;
@@ -353,7 +353,7 @@
 
 static void ahci_port_stop(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct ahci_port_priv *pp = ap->private_data;
 	void *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
@@ -370,8 +370,8 @@
 	msleep(500);
 
 	ap->private_data = NULL;
-	pci_free_consistent(pdev, AHCI_PORT_PRIV_DMA_SZ,
-			    pp->cmd_slot, pp->cmd_slot_dma);
+	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
+			  pp->cmd_slot, pp->cmd_slot_dma);
 	kfree(pp);
 	ata_port_stop(ap);
 }
@@ -703,7 +703,7 @@
 static int ahci_host_init(struct ata_probe_ent *probe_ent)
 {
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
-	struct pci_dev *pdev = probe_ent->pdev;
+	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void __iomem *mmio = probe_ent->mmio_base;
 	u32 tmp, cap_save;
 	u16 tmp16;
@@ -861,7 +861,7 @@
 static void ahci_print_info(struct ata_probe_ent *probe_ent)
 {
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
-	struct pci_dev *pdev = probe_ent->pdev;
+	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void *mmio = probe_ent->mmio_base;
 	u32 vers, cap, impl, speed;
 	const char *speed_s;
@@ -965,7 +965,7 @@
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	mmio_base = ioremap(pci_resource_start(pdev, AHCI_PCI_BAR),
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/ata_piix.c	2004-11-12 19:08:53 -05:00
@@ -260,7 +260,7 @@
  */
 static void piix_pata_cbl_detect(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u8 tmp, mask;
 
 	/* no 80c support in host controller? */
@@ -293,8 +293,9 @@
 
 static void piix_pata_phy_reset(struct ata_port *ap)
 {
-	if (!pci_test_config_bits(ap->host_set->pdev,
-				  &piix_enable_bits[ap->hard_port_no])) {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+
+	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return;
@@ -322,7 +323,7 @@
  */
 static int piix_sata_probe (struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	int combined = (ap->flags & ATA_FLAG_SLAVE_POSS);
 	int orig_mask, mask, i;
 	u8 pcs;
@@ -392,7 +393,7 @@
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
-	struct pci_dev *dev	= ap->host_set->pdev;
+	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
 	unsigned int is_slave	= (adev->devno != 0);
 	unsigned int master_port= ap->hard_port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
@@ -444,7 +445,7 @@
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int udma	= adev->dma_mode; /* FIXME: MWDMA too */
-	struct pci_dev *dev	= ap->host_set->pdev;
+	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
 	u8 maslave		= ap->hard_port_no ? 0x42 : 0x40;
 	u8 speed		= udma;
 	unsigned int drive_dn	= (ap->hard_port_no ? 2 : 0) + adev->devno;
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/libata-core.c	2004-11-12 19:08:53 -05:00
@@ -1017,7 +1017,7 @@
 	BUG_ON(qc == NULL);
 
 	ata_sg_init_one(qc, dev->id, sizeof(dev->id));
-	qc->pci_dma_dir = PCI_DMA_FROMDEVICE;
+	qc->dma_dir = DMA_FROM_DEVICE;
 	qc->tf.protocol = ATA_PROT_PIO;
 	qc->nsect = 1;
 
@@ -1849,7 +1849,7 @@
 {
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg = qc->sg;
-	int dir = qc->pci_dma_dir;
+	int dir = qc->dma_dir;
 
 	assert(qc->flags & ATA_QCFLAG_DMAMAP);
 	assert(sg != NULL);
@@ -1860,9 +1860,9 @@
 	DPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
 	if (qc->flags & ATA_QCFLAG_SG)
-		pci_unmap_sg(ap->host_set->pdev, sg, qc->n_elem, dir);
+		dma_unmap_sg(ap->host_set->dev, sg, qc->n_elem, dir);
 	else
-		pci_unmap_single(ap->host_set->pdev, sg_dma_address(&sg[0]),
+		dma_unmap_single(ap->host_set->dev, sg_dma_address(&sg[0]),
 				 sg_dma_len(&sg[0]), dir);
 
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
@@ -1973,13 +1973,13 @@
 static int ata_sg_setup_one(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	int dir = qc->pci_dma_dir;
+	int dir = qc->dma_dir;
 	struct scatterlist *sg = qc->sg;
 	dma_addr_t dma_address;
 
-	dma_address = pci_map_single(ap->host_set->pdev, qc->buf_virt,
+	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
 				     sg_dma_len(sg), dir);
-	if (pci_dma_mapping_error(dma_address))
+	if (dma_mapping_error(dma_address))
 		return -1;
 
 	sg_dma_address(sg) = dma_address;
@@ -2010,8 +2010,8 @@
 	VPRINTK("ENTER, ata%u\n", ap->id);
 	assert(qc->flags & ATA_QCFLAG_SG);
 
-	dir = qc->pci_dma_dir;
-	n_elem = pci_map_sg(ap->host_set->pdev, sg, qc->n_elem, dir);
+	dir = qc->dma_dir;
+	n_elem = dma_map_sg(ap->host_set->dev, sg, qc->n_elem, dir);
 	if (n_elem < 1)
 		return -1;
 
@@ -2416,7 +2416,7 @@
 	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
 
 	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
-	qc->pci_dma_dir = PCI_DMA_FROMDEVICE;
+	qc->dma_dir = DMA_FROM_DEVICE;
 
 	memset(&qc->cdb, 0, sizeof(ap->cdb_len));
 	qc->cdb[0] = REQUEST_SENSE;
@@ -3104,9 +3104,9 @@
 
 int ata_port_start (struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 
-	ap->prd = pci_alloc_consistent(pdev, ATA_PRD_TBL_SZ, &ap->prd_dma);
+	ap->prd = dma_alloc_coherent(dev, ATA_PRD_TBL_SZ, &ap->prd_dma, GFP_KERNEL);
 	if (!ap->prd)
 		return -ENOMEM;
 
@@ -3117,9 +3117,9 @@
 
 void ata_port_stop (struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 
-	pci_free_consistent(pdev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
+	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 }
 
 /**
@@ -3165,7 +3165,7 @@
 	host->max_channel = 1;
 	host->unique_id = ata_unique_id++;
 	host->max_cmd_len = 12;
-	scsi_set_device(host, &ent->pdev->dev);
+	scsi_set_device(host, ent->dev);
 	scsi_assign_lock(host, &host_set->lock);
 
 	ap->flags = ATA_FLAG_PORT_DISABLED;
@@ -3252,7 +3252,7 @@
 int ata_device_add(struct ata_probe_ent *ent)
 {
 	unsigned int count = 0, i;
-	struct pci_dev *pdev = ent->pdev;
+	struct device *dev = ent->dev;
 	struct ata_host_set *host_set;
 
 	DPRINTK("ENTER\n");
@@ -3264,7 +3264,7 @@
 	memset(host_set, 0, sizeof(struct ata_host_set) + (ent->n_ports * sizeof(void *)));
 	spin_lock_init(&host_set->lock);
 
-	host_set->pdev = pdev;
+	host_set->dev = dev;
 	host_set->n_ports = ent->n_ports;
 	host_set->irq = ent->irq;
 	host_set->mmio_base = ent->mmio_base;
@@ -3332,7 +3332,7 @@
 			 */
 		}
 
-		rc = scsi_add_host(ap->host, &pdev->dev);
+		rc = scsi_add_host(ap->host, dev);
 		if (rc) {
 			printk(KERN_ERR "ata%u: scsi_add_host failed\n",
 			       ap->id);
@@ -3352,7 +3352,7 @@
 		scsi_scan_host(ap->host);
 	}
 
-	pci_set_drvdata(pdev, host_set);
+	dev_set_drvdata(dev, host_set);
 
 	VPRINTK("EXIT, returning %u\n", ent->n_ports);
 	return ent->n_ports; /* success */
@@ -3413,7 +3413,7 @@
 }
 
 static struct ata_probe_ent *
-ata_probe_ent_alloc(int n, struct pci_dev *pdev, struct ata_port_info **port)
+ata_probe_ent_alloc(int n, struct device *dev, struct ata_port_info **port)
 {
 	struct ata_probe_ent *probe_ent;
 	int i;
@@ -3421,7 +3421,7 @@
 	probe_ent = kmalloc(sizeof(*probe_ent) * n, GFP_KERNEL);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
-		       pci_name(pdev));
+		       kobject_name(&(dev->kobj)));
 		return NULL;
 	}
 
@@ -3429,7 +3429,7 @@
 
 	for (i = 0; i < n; i++) {
 		INIT_LIST_HEAD(&probe_ent[i].node);
-		probe_ent[i].pdev = pdev;
+		probe_ent[i].dev = dev;
 
 		probe_ent[i].sht = port[i]->sht;
 		probe_ent[i].host_flags = port[i]->host_flags;
@@ -3443,10 +3443,12 @@
 	return probe_ent;
 }
 
+#ifdef CONFIG_PCI
 struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port)
 {
-	struct ata_probe_ent *probe_ent = ata_probe_ent_alloc(1, pdev, port);
+	struct ata_probe_ent *probe_ent =
+		ata_probe_ent_alloc(1, pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
 		return NULL;
 
@@ -3475,7 +3477,8 @@
 struct ata_probe_ent *
 ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port)
 {
-	struct ata_probe_ent *probe_ent = ata_probe_ent_alloc(2, pdev, port);
+	struct ata_probe_ent *probe_ent =
+		ata_probe_ent_alloc(2, pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
 		return NULL;
 
@@ -3651,7 +3654,8 @@
 
 void ata_pci_remove_one (struct pci_dev *pdev)
 {
-	struct ata_host_set *host_set = pci_get_drvdata(pdev);
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
 	struct ata_port *ap;
 	unsigned int i;
 
@@ -3692,7 +3696,7 @@
 
 	kfree(host_set);
 	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
+	dev_set_drvdata(dev, NULL);
 }
 
 /* move to PCI subsystem */
@@ -3728,6 +3732,7 @@
 
 	return (tmp == bits->val) ? 1 : 0;
 }
+#endif /* CONFIG_PCI */
 
 
 /**
@@ -3764,7 +3769,6 @@
  * Do not depend on ABI/API stability.
  */
 
-EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
@@ -3779,8 +3783,6 @@
 EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
-EXPORT_SYMBOL_GPL(ata_pci_init_legacy_mode);
-EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
@@ -3795,8 +3797,6 @@
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
-EXPORT_SYMBOL_GPL(ata_pci_init_one);
-EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
@@ -3806,3 +3806,11 @@
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
+
+#ifdef CONFIG_PCI
+EXPORT_SYMBOL_GPL(pci_test_config_bits);
+EXPORT_SYMBOL_GPL(ata_pci_init_legacy_mode);
+EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
+EXPORT_SYMBOL_GPL(ata_pci_init_one);
+EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+#endif /* CONFIG_PCI */
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/libata-scsi.c	2004-11-12 19:08:53 -05:00
@@ -678,7 +678,7 @@
 			ata_sg_init_one(qc, cmd->request_buffer,
 					cmd->request_bufflen);
 
-		qc->pci_dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+		qc->dma_dir = cmd->sc_data_direction;
 	}
 
 	qc->complete_fn = ata_scsi_qc_complete;
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/sata_nv.c	2004-11-12 19:08:53 -05:00
@@ -454,12 +454,13 @@
 
 static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent)
 {
+	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	u8 intr_mask;
 	u8 regval;
 
-	pci_read_config_byte(probe_ent->pdev, NV_MCP_SATA_CFG_20, &regval);
+	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
 	regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(probe_ent->pdev, NV_MCP_SATA_CFG_20, regval);
+	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
 
 	writeb(NV_INT_STATUS_HOTPLUG, probe_ent->mmio_base + NV_INT_STATUS_CK804);
 
@@ -471,6 +472,7 @@
 
 static void nv_disable_hotplug_ck804(struct ata_host_set *host_set)
 {
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 	u8 intr_mask;
 	u8 regval;
 
@@ -480,9 +482,9 @@
 
 	writeb(intr_mask, host_set->mmio_base + NV_INT_ENABLE_CK804);
 
-	pci_read_config_byte(host_set->pdev, NV_MCP_SATA_CFG_20, &regval);
+	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
 	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(host_set->pdev, NV_MCP_SATA_CFG_20, regval);
+	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
 }
 
 static void nv_check_hotplug_ck804(struct ata_host_set *host_set)
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/sata_promise.c	2004-11-12 19:08:53 -05:00
@@ -174,7 +174,7 @@
 
 static int pdc_port_start(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct pdc_port_priv *pp;
 	int rc;
 
@@ -189,7 +189,7 @@
 	}
 	memset(pp, 0, sizeof(*pp));
 
-	pp->pkt = pci_alloc_consistent(pdev, 128, &pp->pkt_dma);
+	pp->pkt = dma_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
 	if (!pp->pkt) {
 		rc = -ENOMEM;
 		goto err_out_kfree;
@@ -209,11 +209,11 @@
 
 static void pdc_port_stop(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct pdc_port_priv *pp = ap->private_data;
 
 	ap->private_data = NULL;
-	pci_free_consistent(pdev, 128, pp->pkt, pp->pkt_dma);
+	dma_free_coherent(dev, 128, pp->pkt, pp->pkt_dma);
 	kfree(pp);
 	ata_port_stop(ap);
 }
@@ -577,7 +577,7 @@
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	mmio_base = ioremap(pci_resource_start(pdev, 3),
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/sata_sil.c	2004-11-12 19:08:53 -05:00
@@ -363,7 +363,7 @@
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	INIT_LIST_HEAD(&probe_ent->node);
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	probe_ent->port_ops = sil_port_info[ent->driver_data].port_ops;
 	probe_ent->sht = sil_port_info[ent->driver_data].sht;
 	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2;
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/sata_sis.c	2004-11-12 19:08:53 -05:00
@@ -140,22 +140,24 @@
 
 static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg);
 	u32 val;
 
 	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
 		return 0xffffffff;
-	pci_read_config_dword(ap->host_set->pdev, cfg_addr, &val);
+	pci_read_config_dword(pdev, cfg_addr, &val);
 	return val;
 }
 
 static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr);
 
 	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
 		return;
-	pci_write_config_dword(ap->host_set->pdev, cfg_addr, val);
+	pci_write_config_dword(pdev, cfg_addr, val);
 }
 
 static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/sata_svw.c	2004-11-12 19:08:53 -05:00
@@ -376,7 +376,7 @@
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	mmio_base = ioremap(pci_resource_start(pdev, 5),
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/sata_sx4.c	2004-11-12 19:08:53 -05:00
@@ -248,7 +248,7 @@
 
 static int pdc_port_start(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct pdc_port_priv *pp;
 	int rc;
 
@@ -263,7 +263,7 @@
 	}
 	memset(pp, 0, sizeof(*pp));
 
-	pp->pkt = pci_alloc_consistent(pdev, 128, &pp->pkt_dma);
+	pp->pkt = dma_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
 	if (!pp->pkt) {
 		rc = -ENOMEM;
 		goto err_out_kfree;
@@ -283,11 +283,11 @@
 
 static void pdc_port_stop(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct pdc_port_priv *pp = ap->private_data;
 
 	ap->private_data = NULL;
-	pci_free_consistent(pdev, 128, pp->pkt, pp->pkt_dma);
+	dma_free_coherent(dev, 128, pp->pkt, pp->pkt_dma);
 	kfree(pp);
 	ata_port_stop(ap);
 }
@@ -1397,7 +1397,7 @@
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	mmio_base = ioremap(pci_resource_start(pdev, 3),
diff -Nru a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/sata_uli.c	2004-11-12 19:08:53 -05:00
@@ -149,18 +149,20 @@
 
 static u32 uli_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg);
 	u32 val;
 
-	pci_read_config_dword(ap->host_set->pdev, cfg_addr, &val);
+	pci_read_config_dword(pdev, cfg_addr, &val);
 	return val;
 }
 
 static void uli_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr);
 
-	pci_write_config_dword(ap->host_set->pdev, cfg_addr, val);
+	pci_write_config_dword(pdev, cfg_addr, val);
 }
 
 static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg)
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-11-12 19:08:53 -05:00
+++ b/drivers/scsi/sata_vsc.c	2004-11-12 19:08:53 -05:00
@@ -293,7 +293,7 @@
 		goto err_out_regions;
 	}
 	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	mmio_base = ioremap(pci_resource_start(pdev, 0),
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-11-12 19:08:53 -05:00
+++ b/include/linux/libata.h	2004-11-12 19:08:53 -05:00
@@ -25,6 +25,7 @@
 
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/pci.h>
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
@@ -68,6 +69,12 @@
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
+/* move to PCI layer? */
+static inline struct device *pci_dev_to_dev(struct pci_dev *pdev)
+{
+	return &pdev->dev;
+}
+
 enum {
 	/* various global constants */
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
@@ -184,7 +191,7 @@
 
 struct ata_probe_ent {
 	struct list_head	node;
-	struct pci_dev		*pdev;
+	struct device 		*dev;
 	struct ata_port_operations	*port_ops;
 	Scsi_Host_Template	*sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
@@ -203,7 +210,7 @@
 
 struct ata_host_set {
 	spinlock_t		lock;
-	struct pci_dev		*pdev;
+	struct device 		*dev;
 	unsigned long		irq;
 	void __iomem		*mmio_base;
 	unsigned int		n_ports;
@@ -226,7 +233,7 @@
 	unsigned int		tag;
 	unsigned int		n_elem;
 
-	int			pci_dma_dir;
+	int			dma_dir;
 
 	unsigned int		nsect;
 	unsigned int		cursect;
@@ -361,12 +368,6 @@
 	struct ata_port_operations	*port_ops;
 };
 
-struct pci_bits {
-	unsigned int		reg;	/* PCI config register to read */
-	unsigned int		width;	/* 1 (8 bit), 2 (16 bit), 4 (32 bit) */
-	unsigned long		mask;
-	unsigned long		val;
-};
 
 extern void ata_port_probe(struct ata_port *);
 extern void __sata_phy_reset(struct ata_port *ap);
@@ -374,9 +375,11 @@
 extern void ata_bus_reset(struct ata_port *ap);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
+#ifdef CONFIG_PCI
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
+#endif /* CONFIG_PCI */
 extern int ata_device_add(struct ata_probe_ent *ent);
 extern int ata_scsi_detect(Scsi_Host_Template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
@@ -398,10 +401,6 @@
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
-extern struct ata_probe_ent *
-ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port);
-extern struct ata_probe_ent *
-ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 extern void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf,
@@ -414,7 +413,6 @@
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
@@ -423,6 +421,24 @@
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+
+
+#ifdef CONFIG_PCI
+struct pci_bits {
+	unsigned int		reg;	/* PCI config register to read */
+	unsigned int		width;	/* 1 (8 bit), 2 (16 bit), 4 (32 bit) */
+	unsigned long		mask;
+	unsigned long		val;
+};
+
+extern struct ata_probe_ent *
+ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port);
+extern struct ata_probe_ent *
+ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port);
+extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
+
+#endif /* CONFIG_PCI */
+
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {

--------------090802070108080604060102--
