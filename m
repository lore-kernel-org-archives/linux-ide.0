From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream 3/3 REGENERATED] libata: implement and use ata_port_desc() to report port configuration
Date: Sat, 18 Aug 2007 13:14:55 +0900
Message-ID: <20070818041455.GB8590@htj.dyndns.org>
References: <20070730052303.GH22374@htj.dyndns.org> <20070730052415.GI22374@htj.dyndns.org> <20070730052527.GJ22374@htj.dyndns.org> <46C2BDEE.7060705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:39184 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbXHREPG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 00:15:06 -0400
Received: by wa-out-1112.google.com with SMTP id j4so69526wah
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2007 21:15:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46C2BDEE.7060705@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Currently, port configuration reporting has the following problems.

* iomapped address is reported instead of raw address
* report contains irrelevant fields or lacks necessary fields for
  non-SFF controllers.
* host->irq/irq2 are there just for reporting and hacky.

This patch implements and uses ata_port_desc() and
ata_port_pbar_desc().  ata_port_desc() is almost identical to
ata_ehi_push_desc() except that it takes @ap instead of @ehi, has no
locking requirement, can only be used during host initialization and "
" is used as separator instead of ", ".  ata_port_pbar_desc() is a
helper to ease reporting of a PCI BAR or an offsetted address into it.

LLD pushes whatever description it wants using the above two
functions.  The accumulated description is printed on host
registration after "[S/P]ATA max MAX_XFERMODE ".

SFF init helpers and ata_host_activate() automatically add
descriptions for addresses and irq respectively, so only LLDs which
isn't standard SFF need to add custom descriptions.  In many cases,
such controllers need to report different things anyway.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Regenerated against the current #upstream (41b135c7).

 drivers/ata/ahci.c           |    4 ++
 drivers/ata/libata-core.c    |   27 +++++++----------
 drivers/ata/libata-eh.c      |   67 +++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-sff.c     |   23 +++++++++++---
 drivers/ata/pata_cs5520.c    |   23 +++++++++-----
 drivers/ata/pata_hpt3x3.c    |    6 +++
 drivers/ata/pata_icside.c    |   19 ++++++++++--
 drivers/ata/pata_isapnp.c    |    4 ++
 drivers/ata/pata_ixp4xx_cf.c |   13 +++++++-
 drivers/ata/pata_legacy.c    |    2 +
 drivers/ata/pata_mpc52xx.c   |    7 +++-
 drivers/ata/pata_mpiix.c     |   16 ++++++----
 drivers/ata/pata_pcmcia.c    |    2 +
 drivers/ata/pata_pdc2027x.c  |   17 +++++++---
 drivers/ata/pata_platform.c  |    4 ++
 drivers/ata/pata_qdi.c       |    5 ++-
 drivers/ata/pata_scc.c       |    3 +
 drivers/ata/pata_winbond.c   |    7 +++-
 drivers/ata/pdc_adma.c       |   13 ++++++--
 drivers/ata/sata_inic162x.c  |   14 +++++++-
 drivers/ata/sata_mv.c        |    8 ++++-
 drivers/ata/sata_promise.c   |   11 +++++--
 drivers/ata/sata_qstor.c     |   11 +++++--
 drivers/ata/sata_sil.c       |    6 +++
 drivers/ata/sata_sil24.c     |    7 +++-
 drivers/ata/sata_svw.c       |   12 +++++--
 drivers/ata/sata_sx4.c       |   19 +++++++-----
 drivers/ata/sata_uli.c       |   13 ++++++++
 drivers/ata/sata_via.c       |    3 +
 drivers/ata/sata_vsc.c       |   12 +++++--
 include/linux/libata.h       |   12 ++++++-
 31 files changed, 309 insertions(+), 81 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index fe9dfa3..cba6168 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1885,6 +1885,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		struct ata_port *ap = host->ports[i];
 		void __iomem *port_mmio = ahci_port_base(ap);
 
+		ata_port_pbar_desc(ap, AHCI_PCI_BAR, -1, "abar");
+		ata_port_pbar_desc(ap, AHCI_PCI_BAR,
+				   0x100 + ap->port_no * 0x80, "port");
+
 		/* standard SATA port setup */
 		if (hpriv->port_map & (1 << i))
 			ap->ioaddr.cmd_addr = port_mmio;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 735f74b..f3d1e0f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6510,7 +6510,6 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	/* set cable, sata_spd_limit and report */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-		int irq_line;
 		unsigned long xfer_mask;
 
 		/* set SATA cable type if still unset */
@@ -6520,24 +6519,16 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		/* init sata_spd_limit to the current value */
 		sata_link_init_spd(&ap->link);
 
-		/* report the secondary IRQ for second channel legacy */
-		irq_line = host->irq;
-		if (i == 1 && host->irq2)
-			irq_line = host->irq2;
-
+		/* print per-port info to dmesg */
 		xfer_mask = ata_pack_xfermask(ap->pio_mask, ap->mwdma_mask,
 					      ap->udma_mask);
 
-		/* print per-port info to dmesg */
 		if (!ata_port_is_dummy(ap))
-			ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%p "
-					"ctl 0x%p bmdma 0x%p irq %d\n",
+			ata_port_printk(ap, KERN_INFO,
+					"%cATA max %s %s\n",
 					(ap->flags & ATA_FLAG_SATA) ? 'S' : 'P',
 					ata_mode_string(xfer_mask),
-					ap->ioaddr.cmd_addr,
-					ap->ioaddr.ctl_addr,
-					ap->ioaddr.bmdma_addr,
-					irq_line);
+					ap->link.eh_info.desc);
 		else
 			ata_port_printk(ap, KERN_INFO, "DUMMY\n");
 	}
@@ -6621,7 +6612,7 @@ int ata_host_activate(struct ata_host *host, int irq,
 		      irq_handler_t irq_handler, unsigned long irq_flags,
 		      struct scsi_host_template *sht)
 {
-	int rc;
+	int i, rc;
 
 	rc = ata_host_start(host);
 	if (rc)
@@ -6632,8 +6623,8 @@ int ata_host_activate(struct ata_host *host, int irq,
 	if (rc)
 		return rc;
 
-	/* Used to print device info at probe */
-	host->irq = irq;
+	for (i = 0; i < host->n_ports; i++)
+		ata_port_desc(host->ports[i], "irq %d", irq);
 
 	rc = ata_host_register(host, sht);
 	/* if failed, just free the IRQ and leave ports alone */
@@ -7105,6 +7096,10 @@ EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
 EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
 EXPORT_SYMBOL_GPL(ata_ehi_clear_desc);
+EXPORT_SYMBOL_GPL(ata_port_desc);
+#ifdef CONFIG_PCI
+EXPORT_SYMBOL_GPL(ata_port_pbar_desc);
+#endif /* CONFIG_PCI */
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 EXPORT_SYMBOL_GPL(ata_link_abort);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2ddc2ed..8219e2d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -151,6 +151,73 @@ void ata_ehi_clear_desc(struct ata_eh_info *ehi)
 	ehi->desc_len = 0;
 }
 
+/**
+ *	ata_port_desc - append port description
+ *	@ap: target ATA port
+ *	@fmt: printf format string
+ *
+ *	Format string according to @fmt and append it to port
+ *	description.  If port description is not empty, " " is added
+ *	in-between.  This function is to be used while initializing
+ *	ata_host.  The description is printed on host registration.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_port_desc(struct ata_port *ap, const char *fmt, ...)
+{
+	va_list args;
+
+	WARN_ON(!(ap->pflags & ATA_PFLAG_INITIALIZING));
+
+	if (ap->link.eh_info.desc_len)
+		__ata_ehi_push_desc(&ap->link.eh_info, " ");
+
+	va_start(args, fmt);
+	__ata_ehi_pushv_desc(&ap->link.eh_info, fmt, args);
+	va_end(args);
+}
+
+#ifdef CONFIG_PCI
+
+/**
+ *	ata_port_pbar_desc - append PCI BAR description
+ *	@ap: target ATA port
+ *	@bar: target PCI BAR
+ *	@offset: offset into PCI BAR
+ *	@name: name of the area
+ *
+ *	If @offset is negative, this function formats a string which
+ *	contains the name, address, size and type of the BAR and
+ *	appends it to the port description.  If @offset is zero or
+ *	positive, only name and offsetted address is appended.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
+			const char *name)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	char *type = "";
+	unsigned long long start, len;
+
+	if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
+		type = "m";
+	else if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
+		type = "i";
+
+	start = (unsigned long long)pci_resource_start(pdev, bar);
+	len = (unsigned long long)pci_resource_len(pdev, bar);
+
+	if (offset < 0)
+		ata_port_desc(ap, "%s %s%llu@0x%llx", name, type, len, start);
+	else
+		ata_port_desc(ap, "%s 0x%llx", name, start + offset);
+}
+
+#endif /* CONFIG_PCI */
+
 static void ata_ering_record(struct ata_ering *ering, int is_io,
 			     unsigned int err_mask)
 {
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9828404..37f019c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -564,6 +564,9 @@ int ata_pci_init_bmdma(struct ata_host *host)
 		if ((!(ap->flags & ATA_FLAG_IGN_SIMPLEX)) &&
 		    (ioread8(bmdma + 2) & 0x80))
 			host->flags |= ATA_HOST_SIMPLEX;
+
+		ata_port_desc(ap, "bmdma 0x%llx",
+			(unsigned long long)pci_resource_start(pdev, 4) + 8 * i);
 	}
 
 	return 0;
@@ -631,6 +634,10 @@ int ata_pci_init_sff_host(struct ata_host *host)
 			((unsigned long)iomap[base + 1] | ATA_PCI_CTL_OFS);
 		ata_std_ports(&ap->ioaddr);
 
+		ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
+			(unsigned long long)pci_resource_start(pdev, base),
+			(unsigned long long)pci_resource_start(pdev, base + 1));
+
 		mask |= 1 << i;
 	}
 
@@ -801,24 +808,30 @@ int ata_pci_init_one(struct pci_dev *pdev,
 				      IRQF_SHARED, DRV_NAME, host);
 		if (rc)
 			goto err_out;
-		host->irq = pdev->irq;
+
+		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
+		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
 	} else {
 		if (!ata_port_is_dummy(host->ports[0])) {
-			host->irq = ATA_PRIMARY_IRQ(pdev);
-			rc = devm_request_irq(dev, host->irq,
+			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),
 					      pi->port_ops->irq_handler,
 					      IRQF_SHARED, DRV_NAME, host);
 			if (rc)
 				goto err_out;
+
+			ata_port_desc(host->ports[0], "irq %d",
+				      ATA_PRIMARY_IRQ(pdev));
 		}
 
 		if (!ata_port_is_dummy(host->ports[1])) {
-			host->irq2 = ATA_SECONDARY_IRQ(pdev);
-			rc = devm_request_irq(dev, host->irq2,
+			rc = devm_request_irq(dev, ATA_SECONDARY_IRQ(pdev),
 					      pi->port_ops->irq_handler,
 					      IRQF_SHARED, DRV_NAME, host);
 			if (rc)
 				goto err_out;
+
+			ata_port_desc(host->ports[1], "irq %d",
+				      ATA_SECONDARY_IRQ(pdev));
 		}
 	}
 
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 5f06fcd..0d24160 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -189,6 +189,8 @@ static struct ata_port_operations cs5520_port_ops = {
 
 static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	static const unsigned int cmd_port[] = { 0x1F0, 0x170 };
+	static const unsigned int ctl_port[] = { 0x3F6, 0x376 };
 	struct ata_port_info pi = {
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,
@@ -242,10 +244,10 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 	}
 
 	/* Map IO ports and initialize host accordingly */
-	iomap[0] = devm_ioport_map(&pdev->dev, 0x1F0, 8);
-	iomap[1] = devm_ioport_map(&pdev->dev, 0x3F6, 1);
-	iomap[2] = devm_ioport_map(&pdev->dev, 0x170, 8);
-	iomap[3] = devm_ioport_map(&pdev->dev, 0x376, 1);
+	iomap[0] = devm_ioport_map(&pdev->dev, cmd_port[0], 8);
+	iomap[1] = devm_ioport_map(&pdev->dev, ctl_port[0], 1);
+	iomap[2] = devm_ioport_map(&pdev->dev, cmd_port[1], 8);
+	iomap[3] = devm_ioport_map(&pdev->dev, ctl_port[1], 1);
 	iomap[4] = pcim_iomap(pdev, 2, 0);
 
 	if (!iomap[0] || !iomap[1] || !iomap[2] || !iomap[3] || !iomap[4])
@@ -258,6 +260,10 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 	ioaddr->bmdma_addr = iomap[4];
 	ata_std_ports(ioaddr);
 
+	ata_port_desc(host->ports[0],
+		      "cmd 0x%x ctl 0x%x", cmd_port[0], ctl_port[0]);
+	ata_port_pbar_desc(host->ports[0], 4, 0, "bmdma");
+
 	ioaddr = &host->ports[1]->ioaddr;
 	ioaddr->cmd_addr = iomap[2];
 	ioaddr->ctl_addr = iomap[3];
@@ -265,6 +271,10 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 	ioaddr->bmdma_addr = iomap[4] + 8;
 	ata_std_ports(ioaddr);
 
+	ata_port_desc(host->ports[1],
+		      "cmd 0x%x ctl 0x%x", cmd_port[1], ctl_port[1]);
+	ata_port_pbar_desc(host->ports[1], 4, 8, "bmdma");
+
 	/* activate the host */
 	pci_set_master(pdev);
 	rc = ata_host_start(host);
@@ -283,10 +293,7 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 		if (rc)
 			return rc;
 
-		if (i == 0)
-			host->irq = irq[0];
-		else
-			host->irq2 = irq[1];
+		ata_port_desc(ap, "irq %d", irq[i]);
 	}
 
 	return ata_host_register(host, &cs5520_sht);
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 752394b..873aa70 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -237,7 +237,8 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	base = host->iomap[4];	/* Bus mastering base */
 
 	for (i = 0; i < host->n_ports; i++) {
-		struct ata_ioports *ioaddr = &host->ports[i]->ioaddr;
+		struct ata_port *ap = host->ports[i];
+		struct ata_ioports *ioaddr = &ap->ioaddr;
 
 		ioaddr->cmd_addr = base + offset_cmd[i];
 		ioaddr->altstatus_addr =
@@ -245,6 +246,9 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ioaddr->scr_addr = NULL;
 		ata_std_ports(ioaddr);
 		ioaddr->bmdma_addr = base + 8 * i;
+
+		ata_port_pbar_desc(ap, 4, -1, "ioport");
+		ata_port_pbar_desc(ap, 4, offset_cmd[i], "cmd");
 	}
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 4a69328..be30923 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -70,6 +70,8 @@ struct pata_icside_info {
 	unsigned int		mwdma_mask;
 	unsigned int		nr_ports;
 	const struct portinfo	*port[2];
+	unsigned long		raw_base;
+	unsigned long		raw_ioc_base;
 };
 
 #define ICS_TYPE_A3IN	0
@@ -392,9 +394,10 @@ static struct ata_port_operations pata_icside_port_ops = {
 };
 
 static void __devinit
-pata_icside_setup_ioaddr(struct ata_ioports *ioaddr, void __iomem *base,
+pata_icside_setup_ioaddr(struct ata_port *ap, void __iomem *base,
 			 const struct portinfo *info)
 {
+	struct ata_ioports *ioaddr = &ap->ioaddr;
 	void __iomem *cmd = base + info->dataoffset;
 
 	ioaddr->cmd_addr	= cmd;
@@ -411,6 +414,13 @@ pata_icside_setup_ioaddr(struct ata_ioports *ioaddr, void __iomem *base,
 
 	ioaddr->ctl_addr	= base + info->ctrloffset;
 	ioaddr->altstatus_addr	= ioaddr->ctl_addr;
+
+	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
+		      info->raw_base + info->dataoffset,
+		      info->raw_base + info->ctrloffset);
+
+	if (info->raw_ioc_base)
+		ata_port_desc(ap, "iocbase 0x%lx", info->raw_ioc_base);
 }
 
 static int __devinit pata_icside_register_v5(struct pata_icside_info *info)
@@ -431,6 +441,8 @@ static int __devinit pata_icside_register_v5(struct pata_icside_info *info)
 	info->nr_ports = 1;
 	info->port[0] = &pata_icside_portinfo_v5;
 
+	info->raw_base = ecard_resource_start(ec, ECARD_RES_MEMC);
+
 	return 0;
 }
 
@@ -471,6 +483,9 @@ static int __devinit pata_icside_register_v6(struct pata_icside_info *info)
 	info->port[0] = &pata_icside_portinfo_v6_1;
 	info->port[1] = &pata_icside_portinfo_v6_2;
 
+	info->raw_base = ecard_resource_start(ec, ECARD_RES_EASI);
+	info->raw_ioc_base = ecard_resource_start(ec, ECARD_RES_IOCFAST);
+
 	return icside_dma_init(info);
 }
 
@@ -507,7 +522,7 @@ static int __devinit pata_icside_add_ports(struct pata_icside_info *info)
 		ap->flags |= ATA_FLAG_SLAVE_POSS;
 		ap->ops = &pata_icside_port_ops;
 
-		pata_icside_setup_ioaddr(&ap->ioaddr, info->base, info->port[i]);
+		pata_icside_setup_ioaddr(ap, info->base, info->port[i]);
 	}
 
 	return ata_host_activate(host, ec->irq, ata_interrupt, 0,
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 421e832..97bf45e 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -110,6 +110,10 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 
 	ata_std_ports(&ap->ioaddr);
 
+	ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
+		      (unsigned long long)pnp_port_start(idev, 0),
+		      (unsigned long long)pnp_port_start(idev, 1));
+
 	/* activate */
 	return ata_host_activate(host, pnp_irq(idev, 0), ata_interrupt, 0,
 				 &isapnp_sht);
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index fb53869..4c3a817 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -131,8 +131,12 @@ static struct ata_port_operations ixp4xx_port_ops = {
 };
 
 static void ixp4xx_setup_port(struct ata_ioports *ioaddr,
-				struct ixp4xx_pata_data *data)
+			      struct ixp4xx_pata_data *data,
+			      unsigned long raw_cs0, unsigned long raw_cs1)
 {
+	unsigned long raw_cmd = raw_cs0;
+	unsigned long raw_ctl = raw_cs1 + 0x06;
+
 	ioaddr->cmd_addr	= data->cs0;
 	ioaddr->altstatus_addr	= data->cs1 + 0x06;
 	ioaddr->ctl_addr	= data->cs1 + 0x06;
@@ -158,7 +162,12 @@ static void ixp4xx_setup_port(struct ata_ioports *ioaddr,
 	*(unsigned long *)&ioaddr->device_addr		^= 0x03;
 	*(unsigned long *)&ioaddr->status_addr		^= 0x03;
 	*(unsigned long *)&ioaddr->command_addr		^= 0x03;
+
+	raw_cmd ^= 0x03;
+	raw_ctl ^= 0x03;
 #endif
+
+	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", raw_cmd, raw_ctl);
 }
 
 static __devinit int ixp4xx_pata_probe(struct platform_device *pdev)
@@ -200,7 +209,7 @@ static __devinit int ixp4xx_pata_probe(struct platform_device *pdev)
 	ap->pio_mask = 0x1f; /* PIO4 */
 	ap->flags |= ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY | ATA_FLAG_NO_ATAPI;
 
-	ixp4xx_setup_port(&ap->ioaddr, data);
+	ixp4xx_setup_port(ap, data, cs0->start, cs1->start);
 
 	dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 6cae26f..7bed8d8 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -799,6 +799,8 @@ static __init int legacy_init_one(int port, unsigned long io, unsigned long ctrl
 	ata_std_ports(&ap->ioaddr);
 	ap->private_data = ld;
 
+	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", io, ctrl);
+
 	ret = ata_host_activate(host, irq, ata_interrupt, 0, &legacy_sht);
 	if (ret)
 		goto fail;
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 0c62200..cf65961 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -302,7 +302,8 @@ static struct ata_port_operations mpc52xx_ata_port_ops = {
 };
 
 static int __devinit
-mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv)
+mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv,
+		     unsigned long raw_ata_regs)
 {
 	struct ata_host *host;
 	struct ata_port *ap;
@@ -336,6 +337,8 @@ mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv)
 	aio->status_addr	= &priv->ata_regs->tf_command;
 	aio->command_addr	= &priv->ata_regs->tf_command;
 
+	ata_port_desc(ap, "ata_regs 0x%lx", raw_ata_regs);
+
 	/* activate host */
 	return ata_host_activate(host, priv->ata_irq, ata_interrupt, 0,
 				 &mpc52xx_ata_sht);
@@ -432,7 +435,7 @@ mpc52xx_ata_probe(struct of_device *op, const struct of_device_id *match)
 	}
 
 	/* Register ourselves to libata */
-	rv = mpc52xx_ata_init_one(&op->dev, priv);
+	rv = mpc52xx_ata_init_one(&op->dev, priv, res_mem.start);
 	if (rv) {
 		printk(KERN_ERR DRV_NAME ": "
 			"Error while registering to ATA layer\n");
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index b509109..a0a74bd 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -201,7 +201,7 @@ static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	struct ata_port *ap;
 	void __iomem *cmd_addr, *ctl_addr;
 	u16 idetim;
-	int irq;
+	int cmd, ctl, irq;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
@@ -209,6 +209,7 @@ static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	host = ata_host_alloc(&dev->dev, 1);
 	if (!host)
 		return -ENOMEM;
+	ap = host->ports[0];
 
 	/* MPIIX has many functions which can be turned on or off according
 	   to other devices present. Make sure IDE is enabled before we try
@@ -220,25 +221,28 @@ static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 	/* See if it's primary or secondary channel... */
 	if (!(idetim & SECONDARY)) {
+		cmd = 0x1F0;
+		ctl = 0x3F6;
 		irq = 14;
-		cmd_addr = devm_ioport_map(&dev->dev, 0x1F0, 8);
-		ctl_addr = devm_ioport_map(&dev->dev, 0x3F6, 1);
 	} else {
+		cmd = 0x170;
+		ctl = 0x376;
 		irq = 15;
-		cmd_addr = devm_ioport_map(&dev->dev, 0x170, 8);
-		ctl_addr = devm_ioport_map(&dev->dev, 0x376, 1);
 	}
 
+	cmd_addr = devm_ioport_map(&dev->dev, cmd, 8);
+	ctl_addr = devm_ioport_map(&dev->dev, ctl, 1);
 	if (!cmd_addr || !ctl_addr)
 		return -ENOMEM;
 
+	ata_port_desc(ap, "cmd 0x%x ctl 0x%x", cmd, ctl);
+
 	/* We do our own plumbing to avoid leaking special cases for whacko
 	   ancient hardware into the core code. There are two issues to
 	   worry about.  #1 The chip is a bridge so if in legacy mode and
 	   without BARs set fools the setup.  #2 If you pci_disable_device
 	   the MPIIX your box goes castors up */
 
-	ap = host->ports[0];
 	ap->ops = &mpiix_port_ops;
 	ap->pio_mask = 0x1F;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 5a13ae8..bfb042e 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -302,6 +302,8 @@ next_entry:
 	ap->ioaddr.ctl_addr = ctl_addr;
 	ata_std_ports(&ap->ioaddr);
 
+	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", io_base, ctl_base);
+
 	/* activate */
 	ret = ata_host_activate(host, pdev->irq.AssignedIRQ, ata_interrupt,
 				IRQF_SHARED, &pcmcia_sht);
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index b153ffe..ccc08c9 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -787,12 +787,14 @@ static void pdc_ata_setup_port(struct ata_ioports *port, void __iomem *base)
 static int __devinit pdc2027x_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
+	static const unsigned long cmd_offset[] = { 0x17c0, 0x15c0 };
+	static const unsigned long bmdma_offset[] = { 0x1000, 0x1008 };
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	const struct ata_port_info *ppi[] =
 		{ &pdc2027x_port_info[board_idx], NULL };
 	struct ata_host *host;
 	void __iomem *mmio_base;
-	int rc;
+	int i, rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -822,10 +824,15 @@ static int __devinit pdc2027x_init_one(struct pci_dev *pdev, const struct pci_de
 
 	mmio_base = host->iomap[PDC_MMIO_BAR];
 
-	pdc_ata_setup_port(&host->ports[0]->ioaddr, mmio_base + 0x17c0);
-	host->ports[0]->ioaddr.bmdma_addr = mmio_base + 0x1000;
-	pdc_ata_setup_port(&host->ports[1]->ioaddr, mmio_base + 0x15c0);
-	host->ports[1]->ioaddr.bmdma_addr = mmio_base + 0x1008;
+	for (i = 0; i < 2; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		pdc_ata_setup_port(&ap->ioaddr, mmio_base + cmd_offset[i]);
+		ap->ioaddr.bmdma_addr = mmio_base + bmdma_offset[i];
+
+		ata_port_pbar_desc(ap, PDC_MMIO_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, PDC_MMIO_BAR, cmd_offset[i], "cmd");
+	}
 
 	//pci_enable_intx(pdev);
 
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 80fdfe9..b9dac67 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -208,6 +208,10 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 	pp_info = pdev->dev.platform_data;
 	pata_platform_setup_port(&ap->ioaddr, pp_info);
 
+	ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
+		      (unsigned long long)io_res->start,
+		      (unsigned long long)ctl_res->start);
+
 	/* activate */
 	return ata_host_activate(host, platform_get_irq(pdev, 0),
 				 ata_interrupt, pp_info ? pp_info->irq_flags
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index da9ccd2..8598c05 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -234,6 +234,7 @@ static struct ata_port_operations qdi6580_port_ops = {
 
 static __init int qdi_init_one(unsigned long port, int type, unsigned long io, int irq, int fast)
 {
+	unsigned long ctl = io + 0x206;
 	struct platform_device *pdev;
 	struct ata_host *host;
 	struct ata_port *ap;
@@ -250,7 +251,7 @@ static __init int qdi_init_one(unsigned long port, int type, unsigned long io, i
 
 	ret = -ENOMEM;
 	io_addr = devm_ioport_map(&pdev->dev, io, 8);
-	ctl_addr = devm_ioport_map(&pdev->dev, io + 0x206, 1);
+	ctl_addr = devm_ioport_map(&pdev->dev, ctl, 1);
 	if (!io_addr || !ctl_addr)
 		goto fail;
 
@@ -275,6 +276,8 @@ static __init int qdi_init_one(unsigned long port, int type, unsigned long io, i
 	ap->ioaddr.ctl_addr = ctl_addr;
 	ata_std_ports(&ap->ioaddr);
 
+	ata_port_desc(ap, "cmd %lx ctl %lx", io, ctl);
+
 	/*
 	 *	Hook in a private data structure per channel
 	 */
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 59daf87..8e58bf9 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -1159,6 +1159,9 @@ static int scc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
 
+	ata_port_pbar_desc(host->ports[0], SCC_CTRL_BAR, -1, "ctrl");
+	ata_port_pbar_desc(host->ports[0], SCC_BMID_BAR, -1, "bmid");
+
 	rc = scc_host_init(host);
 	if (rc)
 		return rc;
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index d7555f7..7f8c72a 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -197,6 +197,7 @@ static __init int winbond_init_one(unsigned long port)
 
 	for (i = 0; i < 2 ; i ++) {
 		unsigned long cmd_port = 0x1F0 - (0x80 * i);
+		unsigned long ctl_port = cmd_port + 0x206;
 		struct ata_host *host;
 		struct ata_port *ap;
 		void __iomem *cmd_addr, *ctl_addr;
@@ -212,14 +213,16 @@ static __init int winbond_init_one(unsigned long port)
 		host = ata_host_alloc(&pdev->dev, 1);
 		if (!host)
 			goto err_unregister;
+		ap = host->ports[0];
 
 		rc = -ENOMEM;
 		cmd_addr = devm_ioport_map(&pdev->dev, cmd_port, 8);
-		ctl_addr = devm_ioport_map(&pdev->dev, cmd_port + 0x0206, 1);
+		ctl_addr = devm_ioport_map(&pdev->dev, ctl_port, 1);
 		if (!cmd_addr || !ctl_addr)
 			goto err_unregister;
 
-		ap = host->ports[0];
+		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", cmd_port, ctl_port);
+
 		ap->ops = &winbond_port_ops;
 		ap->pio_mask = 0x1F;
 		ap->flags |= ATA_FLAG_SLAVE_POSS;
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 1a88949..0bb0c93 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -704,9 +704,16 @@ static int adma_ata_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	for (port_no = 0; port_no < ADMA_PORTS; ++port_no)
-		adma_ata_setup_port(&host->ports[port_no]->ioaddr,
-				    ADMA_ATA_REGS(mmio_base, port_no));
+	for (port_no = 0; port_no < ADMA_PORTS; ++port_no) {
+		struct ata_port *ap = host->ports[port_no];
+		void __iomem *port_base = ADMA_ATA_REGS(mmio_base, port_no);
+		unsigned int offset = port_base - mmio_base;
+
+		adma_ata_setup_port(&ap->ioaddr, port_base);
+
+		ata_port_pbar_desc(ap, ADMA_MMIO_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, ADMA_MMIO_BAR, offset, "port");
+	}
 
 	/* initialize adapter */
 	adma_host_init(host, board_idx);
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 037a693..9261a30 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -693,16 +693,24 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	host->iomap = iomap = pcim_iomap_table(pdev);
 
 	for (i = 0; i < NR_PORTS; i++) {
-		struct ata_ioports *port = &host->ports[i]->ioaddr;
-		void __iomem *port_base = iomap[MMIO_BAR] + i * PORT_SIZE;
+		struct ata_port *ap = host->ports[i];
+		struct ata_ioports *port = &ap->ioaddr;
+		unsigned int offset = i * PORT_SIZE;
 
 		port->cmd_addr = iomap[2 * i];
 		port->altstatus_addr =
 		port->ctl_addr = (void __iomem *)
 			((unsigned long)iomap[2 * i + 1] | ATA_PCI_CTL_OFS);
-		port->scr_addr = port_base + PORT_SCR;
+		port->scr_addr = iomap[MMIO_BAR] + offset + PORT_SCR;
 
 		ata_std_ports(port);
+
+		ata_port_pbar_desc(ap, MMIO_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, MMIO_BAR, offset, "port");
+		ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
+		  (unsigned long long)pci_resource_start(pdev, 2 * i),
+		  (unsigned long long)pci_resource_start(pdev, (2 * i + 1)) |
+				      ATA_PCI_CTL_OFS);
 	}
 
 	hpriv->cached_hctl = readw(iomap[MMIO_BAR] + HOST_CTL);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 95d298b..a0a130f 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2560,8 +2560,14 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 	}
 
 	for (port = 0; port < host->n_ports; port++) {
+		struct ata_port *ap = host->ports[port];
 		void __iomem *port_mmio = mv_port_base(mmio, port);
-		mv_port_init(&host->ports[port]->ioaddr, port_mmio);
+		unsigned int offset = port_mmio - mmio;
+
+		mv_port_init(&ap->ioaddr, port_mmio);
+
+		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
 	}
 
 	for (hc = 0; hc < n_hc; hc++) {
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index fca60d4..abcf156 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -1003,10 +1003,15 @@ static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 
 	is_sataii_tx4 = pdc_is_sataii_tx4(pi->flags);
 	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
 		unsigned int ata_no = pdc_port_no_to_ata_no(i, is_sataii_tx4);
-		pdc_ata_setup_port(host->ports[i],
-				   base + 0x200 + ata_no * 0x80,
-				   base + 0x400 + ata_no * 0x100);
+		unsigned int port_offset = 0x200 + ata_no * 0x80;
+		unsigned int scr_offset = 0x400 + ata_no * 0x100;
+
+		pdc_ata_setup_port(ap, base + port_offset, base + scr_offset);
+
+		ata_port_pbar_desc(ap, PDC_MMIO_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, PDC_MMIO_BAR, port_offset, "port");
 	}
 
 	/* initialize adapter */
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 340d28e..634c870 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -635,9 +635,14 @@ static int qs_ata_init_one(struct pci_dev *pdev,
 		return rc;
 
 	for (port_no = 0; port_no < host->n_ports; ++port_no) {
-		void __iomem *chan =
-			host->iomap[QS_MMIO_BAR] + (port_no * 0x4000);
-		qs_ata_setup_port(&host->ports[port_no]->ioaddr, chan);
+		struct ata_port *ap = host->ports[port_no];
+		unsigned int offset = port_no * 0x4000;
+		void __iomem *chan = host->iomap[QS_MMIO_BAR] + offset;
+
+		qs_ata_setup_port(&ap->ioaddr, chan);
+
+		ata_port_pbar_desc(ap, QS_MMIO_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, QS_MMIO_BAR, offset, "port");
 	}
 
 	/* initialize adapter */
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 214e019..dea5d3f 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -687,7 +687,8 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	mmio_base = host->iomap[SIL_MMIO_BAR];
 
 	for (i = 0; i < host->n_ports; i++) {
-		struct ata_ioports *ioaddr = &host->ports[i]->ioaddr;
+		struct ata_port *ap = host->ports[i];
+		struct ata_ioports *ioaddr = &ap->ioaddr;
 
 		ioaddr->cmd_addr = mmio_base + sil_port[i].tf;
 		ioaddr->altstatus_addr =
@@ -695,6 +696,9 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		ioaddr->bmdma_addr = mmio_base + sil_port[i].bmdma;
 		ioaddr->scr_addr = mmio_base + sil_port[i].scr;
 		ata_std_ports(ioaddr);
+
+		ata_port_pbar_desc(ap, SIL_MMIO_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, SIL_MMIO_BAR, sil_port[i].tf, "tf");
 	}
 
 	/* initialize and activate */
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 42c8209..08ad478 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1111,12 +1111,15 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	host->iomap = iomap;
 
 	for (i = 0; i < host->n_ports; i++) {
-		void __iomem *port = iomap[SIL24_PORT_BAR] + i * PORT_REGS_SIZE;
+		struct ata_port *ap = host->ports[i];
+		size_t offset = ap->port_no * PORT_REGS_SIZE;
+		void __iomem *port = iomap[SIL24_PORT_BAR] + offset;
 
 		host->ports[i]->ioaddr.cmd_addr = port;
 		host->ports[i]->ioaddr.scr_addr = port + PORT_SCONTROL;
 
-		ata_std_ports(&host->ports[i]->ioaddr);
+		ata_port_pbar_desc(ap, SIL24_HOST_BAR, -1, "host");
+		ata_port_pbar_desc(ap, SIL24_PORT_BAR, offset, "port");
 	}
 
 	/* configure and activate the device */
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index b785db5..488d641 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -443,9 +443,15 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	/* different controllers have different number of ports - currently 4 or 8 */
 	/* All ports are on the same function. Multi-function device is no
 	 * longer available. This should not be seen in any system. */
-	for (i = 0; i < host->n_ports; i++)
-		k2_sata_setup_port(&host->ports[i]->ioaddr,
-				   mmio_base + i * K2_SATA_PORT_OFFSET);
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		unsigned int offset = i * K2_SATA_PORT_OFFSET;
+
+		k2_sata_setup_port(&ap->ioaddr, mmio_base + offset);
+
+		ata_port_pbar_desc(ap, 5, -1, "mmio");
+		ata_port_pbar_desc(ap, 5, offset, "port");
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 2c59ea5..692ab43 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1381,9 +1381,8 @@ static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *
 	const struct ata_port_info *ppi[] =
 		{ &pdc_port_info[ent->driver_data], NULL };
 	struct ata_host *host;
-	void __iomem *base;
 	struct pdc_host_priv *hpriv;
-	int rc;
+	int i, rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -1409,11 +1408,17 @@ static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
 
-	base = host->iomap[PDC_MMIO_BAR] + PDC_CHIP0_OFS;
-	pdc_sata_setup_port(&host->ports[0]->ioaddr, base + 0x200);
-	pdc_sata_setup_port(&host->ports[1]->ioaddr, base + 0x280);
-	pdc_sata_setup_port(&host->ports[2]->ioaddr, base + 0x300);
-	pdc_sata_setup_port(&host->ports[3]->ioaddr, base + 0x380);
+	for (i = 0; i < 4; i++) {
+		struct ata_port *ap = host->ports[i];
+		void __iomem *base = host->iomap[PDC_MMIO_BAR] + PDC_CHIP0_OFS;
+		unsigned int offset = 0x200 + i * 0x80;
+
+		pdc_sata_setup_port(&ap->ioaddr, base + offset);
+
+		ata_port_pbar_desc(ap, PDC_MMIO_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, PDC_DIMM_BAR, -1, "dimm");
+		ata_port_pbar_desc(ap, PDC_MMIO_BAR, offset, "port");
+	}
 
 	/* configure and activate */
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 604f2e0..59590b5 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -239,6 +239,12 @@ static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		hpriv->scr_cfg_addr[2] = ULI5287_BASE + ULI5287_OFFS*4;
 		ata_std_ports(ioaddr);
 
+		ata_port_desc(host->ports[2],
+			"cmd 0x%llx ctl 0x%llx bmdma 0x%llx",
+			(unsigned long long)pci_resource_start(pdev, 0) + 8,
+			((unsigned long long)pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS) + 4,
+			(unsigned long long)pci_resource_start(pdev, 4) + 16);
+
 		ioaddr = &host->ports[3]->ioaddr;
 		ioaddr->cmd_addr = iomap[2] + 8;
 		ioaddr->altstatus_addr =
@@ -247,6 +253,13 @@ static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		ioaddr->bmdma_addr = iomap[4] + 24;
 		hpriv->scr_cfg_addr[3] = ULI5287_BASE + ULI5287_OFFS*5;
 		ata_std_ports(ioaddr);
+
+		ata_port_desc(host->ports[2],
+			"cmd 0x%llx ctl 0x%llx bmdma 0x%llx",
+			(unsigned long long)pci_resource_start(pdev, 2) + 9,
+			((unsigned long long)pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS) + 4,
+			(unsigned long long)pci_resource_start(pdev, 4) + 24);
+
 		break;
 
 	case uli_5289:
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index fb97644..95162e3 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -399,6 +399,9 @@ static void vt6421_init_addrs(struct ata_port *ap)
 	ioaddr->scr_addr = vt6421_scr_addr(iomap[5], ap->port_no);
 
 	ata_std_ports(ioaddr);
+
+	ata_port_pbar_desc(ap, ap->port_no, -1, "port");
+	ata_port_pbar_desc(ap, 4, ap->port_no * 8, "bmdma");
 }
 
 static int vt6420_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 151a082..98a3153 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -406,9 +406,15 @@ static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_d
 
 	mmio_base = host->iomap[VSC_MMIO_BAR];
 
-	for (i = 0; i < host->n_ports; i++)
-		vsc_sata_setup_port(&host->ports[i]->ioaddr,
-				    mmio_base + (i + 1) * VSC_SATA_PORT_OFFSET);
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		unsigned int offset = (i + 1) * VSC_SATA_PORT_OFFSET;
+
+		vsc_sata_setup_port(&ap->ioaddr, mmio_base + offset);
+
+		ata_port_pbar_desc(ap, VSC_MMIO_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, VSC_MMIO_BAR, offset, "port");
+	}
 
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a9a4e43..0816441 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -367,8 +367,6 @@ struct ata_ioports {
 struct ata_host {
 	spinlock_t		lock;
 	struct device 		*dev;
-	unsigned long		irq;
-	unsigned long		irq2;
 	void __iomem * const	*iomap;
 	unsigned int		n_ports;
 	void			*private_data;
@@ -968,6 +966,16 @@ static inline void ata_ehi_hotplugged(struct ata_eh_info *ehi)
 }
 
 /*
+ * port description helpers
+ */
+extern void ata_port_desc(struct ata_port *ap, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+#ifdef CONFIG_PCI
+extern void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
+			       const char *name);
+#endif
+
+/*
  * qc helpers
  */
 static inline int
