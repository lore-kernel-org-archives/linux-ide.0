From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/17] libata: separate out ata_host_set_alloc() and ata_host_set_attach()
Date: Mon, 7 Aug 2006 12:04:00 +0900
Message-ID: <1154919840400-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:3655 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750946AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855317pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:07 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out ata_host_set_alloc(), ata_host_set_add_ports() and
ata_host_set_attach() from ata_device_add().  These functions will be
used by new LLD init model where LLD allocates host_set directly, then
intializes and attaches it instead of going through probe_ent.

This patch does not introduce behavior changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  420 +++++++++++++++++++++++++++-----------------
 include/linux/libata.h     |    6 +
 2 files changed, 266 insertions(+), 160 deletions(-)

b84483d8b22dbbf17fed447883e9e01aacf47171
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f8d6bc0..eccc6bc 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5200,25 +5200,36 @@ void ata_dev_init(struct ata_device *dev
 }
 
 /**
- *	ata_port_init - Initialize an ata_port structure
- *	@ap: Structure to initialize
- *	@host: associated SCSI mid-layer structure
- *	@host_set: Collection of hosts to which @ap belongs
- *	@ent: Probe information provided by low-level driver
- *	@port_no: Port number associated with this ata_port
+ *	ata_port_alloc - allocate and initialize basic ATA port resources
+ *	@host_set: ATA host_set this allocated port belongs to
+ *	@sht: template for SCSI host
  *
- *	Initialize a new ata_port structure, and its associated
- *	scsi_host.
+ *	Allocate and initialize basic ATA port resources.
+ *
+ *	RETURNS:
+ *	Allocate ATA port on success, NULL on failure.
  *
  *	LOCKING:
- *	Inherited from caller.
+ *	Inherited from calling layer (may sleep).
  */
-static void ata_port_init(struct ata_port *ap, struct Scsi_Host *host,
-			  struct ata_host_set *host_set,
-			  const struct ata_probe_ent *ent, unsigned int port_no)
+static struct ata_port *ata_port_alloc(struct ata_host_set *host_set,
+				       struct scsi_host_template *sht)
 {
-	unsigned int i;
+	struct Scsi_Host *host;
+	struct ata_port *ap;
+	int i;
+
+	DPRINTK("ENTER\n");
+
+	host = scsi_host_alloc(sht, sizeof(struct ata_port));
+	if (!host)
+		return NULL;
+
+	host->transportt = &ata_scsi_transport_template;
+
+	ap = ata_shost_to_port(host);
 
+	/* initialize basic fields */
 	host->max_id = 16;
 	host->max_lun = 1;
 	host->max_channel = 1;
@@ -5231,13 +5242,7 @@ static void ata_port_init(struct ata_por
 	ap->host = host;
 	ap->ctl = ATA_DEVCTL_OBS;
 	ap->host_set = host_set;
-	ap->dev = ent->dev;
-	ap->port_no = port_no;
-	ap->pio_mask = ent->pio_mask;
-	ap->mwdma_mask = ent->mwdma_mask;
-	ap->udma_mask = ent->udma_mask;
-	ap->flags |= ent->host_flags;
-	ap->ops = ent->port_ops;
+	ap->dev = host_set->dev;
 	ap->hw_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
@@ -5257,10 +5262,7 @@ #endif
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 
-	/* set cable type */
 	ap->cbl = ATA_CBL_NONE;
-	if (ap->flags & ATA_FLAG_SATA)
-		ap->cbl = ATA_CBL_SATA;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
@@ -5274,51 +5276,97 @@ #ifdef ATA_IRQ_TRAP
 	ap->stats.idle_irq = 1;
 #endif
 
-	memcpy(&ap->ioaddr, &ent->port[port_no], sizeof(struct ata_ioports));
+	return ap;
 }
 
 /**
- *	ata_port_add - Attach low-level ATA driver to system
- *	@ent: Information provided by low-level driver
- *	@host_set: Collections of ports to which we add
- *	@port_no: Port number associated with this host
+ *	ata_host_set_alloc - allocate and init basic ATA host_set resources
+ *	@dev: generic device this host_set is associated with
+ *	@sht: template for SCSI host
+ *	@n_ports: number of ATA ports associated with this host_set (can be 0)
  *
- *	Attach low-level ATA driver to system.
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
+ *	Allocate and initialize basic ATA host_set resources.  LLD
+ *	calls this function to allocate a host_set, initializes it
+ *	fully and attaches it using ata_host_set_attach().
  *
  *	RETURNS:
- *	New ata_port on success, for NULL on error.
+ *	Allocate ATA host_set on success, NULL on failure.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
  */
-
-static struct ata_port * ata_port_add(const struct ata_probe_ent *ent,
-				      struct ata_host_set *host_set,
-				      unsigned int port_no)
+struct ata_host_set *ata_host_set_alloc(struct device *dev,
+					struct scsi_host_template *sht,
+					int n_ports)
 {
-	struct Scsi_Host *host;
-	struct ata_port *ap;
+	struct ata_host_set *host_set;
+	size_t sz;
 
 	DPRINTK("ENTER\n");
 
-	if (!ent->port_ops->error_handler &&
-	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
-		printk(KERN_ERR "ata%u: no reset mechanism available\n",
-		       port_no);
-		return NULL;
-	}
+	/* alloc a container for our list of ATA ports (buses) */
+	sz = sizeof(struct ata_host_set) + n_ports * sizeof(void *);
+	if (n_ports == 0)
+		sz += ATA_MAX_PORTS * sizeof(void *);
 
-	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
-	if (!host)
+	host_set = kzalloc(sz, GFP_KERNEL);
+	if (!host_set)
 		return NULL;
 
-	host->transportt = &ata_scsi_transport_template;
+	spin_lock_init(&host_set->lock);
+	host_set->dev = dev;
 
-	ap = ata_shost_to_port(host);
+	if (ata_host_set_add_ports(host_set, sht, n_ports))
+		goto err_free;
 
-	ata_port_init(ap, host, host_set, ent, port_no);
+	return host_set;
 
-	return ap;
+ err_free:
+	ata_host_set_free(host_set);
+	return NULL;
+}
+
+/**
+ *	ata_host_set_add_ports - allocate ports to zero-port host_set
+ *	@host_set: target ATA host_set
+ *	@sht: template for SCSI host
+ *	@n_ports: number of ATA ports associated with this host_set
+ *
+ *	Allocate @n_ports ports and associate them with @host_set.
+ *	@n_ports must be less than or equal to ATA_MAX_PORTS and
+ *	@host_set must have been allocated with zero port.  This
+ *	function is used by LLDs which can't determine number of ports
+ *	at host_set allocation time.
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+int ata_host_set_add_ports(struct ata_host_set *host_set,
+			   struct scsi_host_template *sht, int n_ports)
+{
+	int i;
+
+	if (host_set->n_ports || n_ports > ATA_MAX_PORTS)
+		return -EINVAL;
+
+	/* allocate ports bound to this host_set */
+	for (i = 0; i < n_ports; i++) {
+		struct ata_port *ap;
+
+		ap = ata_port_alloc(host_set, sht);
+		if (!ap)
+			return -ENOMEM;
+
+		ap->port_no = i;
+		host_set->ports[i] = ap;
+	}
+
+	host_set->n_ports = n_ports;
+
+	return 0;
 }
 
 /**
@@ -5329,6 +5377,9 @@ static struct ata_port * ata_port_add(co
  *	ap->pflags, so this function can be called multiple times.
  *	Ports are guaranteed to get started only once.
  *
+ *	This function also initializes ap->cbl according to
+ *	ATA_FLAG_SATA if cable type isn't set yet.
+ *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  *
@@ -5343,6 +5394,11 @@ int ata_host_set_start(struct ata_host_s
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
+		/* set cable type */
+		if (ap->cbl == ATA_CBL_NONE && (ap->flags & ATA_FLAG_SATA))
+			ap->cbl = ATA_CBL_SATA;
+
+		/* start ports */
 		if (ap->pflags & ATA_PFLAG_STARTED)
 			continue;
 
@@ -5361,6 +5417,126 @@ int ata_host_set_start(struct ata_host_s
 }
 
 /**
+ *	ata_host_set_attach - attach initialized ATA host_set
+ *	@host_set: ATA host_set to attach
+ *
+ *	Attach initialized ATA host_set.  @host_set is allocated using
+ *	ata_host_set_alloc() and fully initialized by LLD.  This
+ *	function registers @host_set with ATA and SCSI layers and
+ *	probe attached devices.
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+int ata_host_set_attach(struct ata_host_set *host_set)
+{
+	int i, rc;
+
+	/* make sure ports are started */
+	rc = ata_host_set_start(host_set);
+	if (rc)
+		return rc;
+
+	/* perform each probe synchronously */
+	DPRINTK("probe begin\n");
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+		int irq_line = host_set->irq;
+		unsigned long xfer_mode_mask;
+		u32 scontrol;
+		int rc;
+
+		/* report the secondary IRQ for second channel legacy */
+		if (i == 1 && host_set->irq2)
+			irq_line = host_set->irq2;
+
+		xfer_mode_mask = (ap->udma_mask << ATA_SHIFT_UDMA) |
+				 (ap->mwdma_mask << ATA_SHIFT_MWDMA) |
+				 (ap->pio_mask << ATA_SHIFT_PIO);
+
+		/* print per-port info to dmesg */
+		if (ap->ops != &ata_dummy_port_ops)
+			ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lu "
+					"ctl 0x%lX bmdma 0x%lX irq %d\n",
+					ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
+					ata_mode_string(xfer_mode_mask),
+					ap->ioaddr.cmd_addr,
+					ap->ioaddr.ctl_addr,
+					ap->ioaddr.bmdma_addr, irq_line);
+		else
+			ata_port_printk(ap, KERN_INFO, "DUMMY port\n");
+
+		/* init sata_spd_limit to the current value */
+		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
+			int spd = (scontrol >> 4) & 0xf;
+			ap->hw_sata_spd_limit &= (1 << spd) - 1;
+		}
+		ap->sata_spd_limit = ap->hw_sata_spd_limit;
+
+		rc = scsi_add_host(ap->host, host_set->dev);
+		if (rc) {
+			ata_port_printk(ap, KERN_ERR, "scsi_add_host failed\n");
+			/* FIXME: do something useful here */
+			/* FIXME: handle unconditional calls to
+			 * scsi_scan_host and ata_host_remove, below,
+			 * at the very least
+			 */
+		}
+
+		if (ap->ops->error_handler) {
+			struct ata_eh_info *ehi = &ap->eh_info;
+			unsigned long flags;
+
+			ata_port_probe(ap);
+
+			/* kick EH for boot probing */
+			spin_lock_irqsave(ap->lock, flags);
+
+			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
+			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
+
+			ap->pflags |= ATA_PFLAG_LOADING;
+			ata_port_schedule_eh(ap);
+
+			spin_unlock_irqrestore(ap->lock, flags);
+
+			/* wait for EH to finish */
+			ata_port_wait_eh(ap);
+		} else {
+			DPRINTK("ata%u: bus probe begin\n", ap->id);
+			rc = ata_bus_probe(ap);
+			DPRINTK("ata%u: bus probe end\n", ap->id);
+
+			if (rc) {
+				/* FIXME: do something useful here?
+				 * Current libata behavior will
+				 * tear down everything when
+				 * the module is removed
+				 * or the h/w is unplugged.
+				 */
+			}
+		}
+	}
+
+	/* probes are done, now scan each port's disk(s) */
+	DPRINTK("host probe begin\n");
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		ata_scsi_scan_host(ap);
+	}
+
+	dev_set_drvdata(host_set->dev, host_set);
+
+	VPRINTK("EXIT, returning %u\n", host_set->n_ports);
+	return 0; /* success */
+}
+
+/**
  *	ata_device_add - Register hardware device with ATA and SCSI layers
  *	@ent: Probe information describing hardware device to be registered
  *
@@ -5386,15 +5562,19 @@ int ata_device_add(const struct ata_prob
 	int rc;
 
 	DPRINTK("ENTER\n");
-	/* alloc a container for our list of ATA ports (buses) */
-	host_set = kzalloc(sizeof(struct ata_host_set) +
-			   (ent->n_ports * sizeof(void *)), GFP_KERNEL);
+
+	if (!ent->port_ops->error_handler &&
+	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
+		dev_printk(KERN_ERR, dev, "no reset mechanism available\n");
+		return 0;
+	}
+
+	/* allocate host_set */
+	host_set = ata_host_set_alloc(dev, ent->sht, ent->n_ports);
 	if (!host_set)
 		return 0;
-	spin_lock_init(&host_set->lock);
 
-	host_set->dev = dev;
-	host_set->n_ports = ent->n_ports;
+	/* initialize host_set according to @ent */
 	host_set->irq = ent->irq;
 	host_set->irq2 = ent->irq2;
 	host_set->mmio_base = ent->mmio_base;
@@ -5402,48 +5582,29 @@ int ata_device_add(const struct ata_prob
 	host_set->ops = ent->port_ops;
 	host_set->flags = ent->host_set_flags;
 
-	/* register each port bound to this device */
 	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap;
-		unsigned long xfer_mode_mask;
-		int irq_line = ent->irq;
-
-		ap = ata_port_add(ent, host_set, i);
-		if (!ap)
-			goto err_out;
-
-		host_set->ports[i] = ap;
+		struct ata_port *ap = host_set->ports[i];
 
 		/* dummy? */
 		if (ent->dummy_port_mask & (1 << i)) {
-			ata_port_printk(ap, KERN_INFO, "DUMMY\n");
 			ap->ops = &ata_dummy_port_ops;
 			continue;
 		}
 
-		/* Report the secondary IRQ for second channel legacy */
-		if (i == 1 && ent->irq2)
-			irq_line = ent->irq2;
+		ap->pio_mask = ent->pio_mask;
+		ap->mwdma_mask = ent->mwdma_mask;
+		ap->udma_mask = ent->udma_mask;
+		ap->flags |= ent->host_flags;
+		ap->ops = ent->port_ops;
 
-		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
-				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
-				(ap->pio_mask << ATA_SHIFT_PIO);
-
-		/* print per-port info to dmesg */
-		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
-				"ctl 0x%lX bmdma 0x%lX irq %d\n",
-				ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
-				ata_mode_string(xfer_mode_mask),
-				ap->ioaddr.cmd_addr,
-				ap->ioaddr.ctl_addr,
-				ap->ioaddr.bmdma_addr,
-				irq_line);
+		memcpy(&ap->ioaddr, &ent->port[ap->port_no],
+		       sizeof(struct ata_ioports));
 	}
 
 	/* start ports */
 	rc = ata_host_set_start(host_set);
 	if (rc)
-		goto err_out;
+		goto err_free_host_set;
 
 	/* freeze */
 	for (i = 0; i < host_set->n_ports; i++) {
@@ -5460,7 +5621,7 @@ int ata_device_add(const struct ata_prob
 	if (rc) {
 		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
 			   ent->irq, rc);
-		goto err_out;
+		goto err_free_host_set;
 	}
 
 	/* do we have a second IRQ for the other channel, eg legacy mode */
@@ -5474,86 +5635,22 @@ int ata_device_add(const struct ata_prob
 		if (rc) {
 			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
 				   ent->irq2, rc);
-			goto err_out_free_irq;
+			goto err_free_irq;
 		}
 	}
 
-	/* perform each probe synchronously */
-	DPRINTK("probe begin\n");
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap = host_set->ports[i];
-		u32 scontrol;
-		int rc;
-
-		/* init sata_spd_limit to the current value */
-		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
-			int spd = (scontrol >> 4) & 0xf;
-			ap->hw_sata_spd_limit &= (1 << spd) - 1;
-		}
-		ap->sata_spd_limit = ap->hw_sata_spd_limit;
-
-		rc = scsi_add_host(ap->host, dev);
-		if (rc) {
-			ata_port_printk(ap, KERN_ERR, "scsi_add_host failed\n");
-			/* FIXME: do something useful here */
-			/* FIXME: handle unconditional calls to
-			 * scsi_scan_host and ata_host_remove, below,
-			 * at the very least
-			 */
-		}
-
-		if (ap->ops->error_handler) {
-			struct ata_eh_info *ehi = &ap->eh_info;
-			unsigned long flags;
-
-			ata_port_probe(ap);
-
-			/* kick EH for boot probing */
-			spin_lock_irqsave(ap->lock, flags);
-
-			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
-			ehi->action |= ATA_EH_SOFTRESET;
-			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
-
-			ap->pflags |= ATA_PFLAG_LOADING;
-			ata_port_schedule_eh(ap);
-
-			spin_unlock_irqrestore(ap->lock, flags);
-
-			/* wait for EH to finish */
-			ata_port_wait_eh(ap);
-		} else {
-			DPRINTK("ata%u: bus probe begin\n", ap->id);
-			rc = ata_bus_probe(ap);
-			DPRINTK("ata%u: bus probe end\n", ap->id);
-
-			if (rc) {
-				/* FIXME: do something useful here?
-				 * Current libata behavior will
-				 * tear down everything when
-				 * the module is removed
-				 * or the h/w is unplugged.
-				 */
-			}
-		}
-	}
-
-	/* probes are done, now scan each port's disk(s) */
-	DPRINTK("host probe begin\n");
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap = host_set->ports[i];
-
-		ata_scsi_scan_host(ap);
-	}
-
-	dev_set_drvdata(dev, host_set);
+	rc = ata_host_set_attach(host_set);
+	if (rc)
+		goto err_free_irq2;
 
-	VPRINTK("EXIT, returning %u\n", ent->n_ports);
-	return ent->n_ports; /* success */
+	return host_set->n_ports; /* success */
 
-err_out_free_irq:
+ err_free_irq2:
+	if (ent->irq2)
+		free_irq(ent->irq2, host_set);
+ err_free_irq:
 	free_irq(ent->irq, host_set);
-err_out:
+ err_free_host_set:
 	ata_host_set_free(host_set);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
@@ -6018,7 +6115,10 @@ EXPORT_SYMBOL_GPL(sata_deb_timing_long);
 EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
+EXPORT_SYMBOL_GPL(ata_host_set_alloc);
+EXPORT_SYMBOL_GPL(ata_host_set_add_ports);
 EXPORT_SYMBOL_GPL(ata_host_set_start);
+EXPORT_SYMBOL_GPL(ata_host_set_attach);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_detach);
 EXPORT_SYMBOL_GPL(ata_host_set_stop);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5436bd1..fed12ae 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -691,7 +691,13 @@ extern int ata_pci_device_suspend(struct
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
+extern struct ata_host_set *ata_host_set_alloc(struct device *dev,
+					       struct scsi_host_template *sht,
+					       int n_ports);
+extern int ata_host_set_add_ports(struct ata_host_set *host_set,
+				  struct scsi_host_template *sht, int n_ports);
 extern int ata_host_set_start(struct ata_host_set *host_set);
+extern int ata_host_set_attach(struct ata_host_set *host_set);
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_set_detach(struct ata_host_set *host_set);
 extern void ata_host_set_stop(struct ata_host_set *host_set);
-- 
1.3.2


