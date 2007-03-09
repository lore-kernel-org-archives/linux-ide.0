From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/12] libata: separate out ata_host_alloc() and ata_host_attach()
Date: Fri, 9 Mar 2007 20:15:35 +0900
Message-ID: <11734389353424-git-send-email-htejun@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:50781 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767180AbXCILPg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:36 -0500
Received: by nz-out-0506.google.com with SMTP id s1so740598nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:36 -0800 (PST)
In-Reply-To: <1173438935540-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Reorganize ata_host_alloc() and its subroutines into the following
three functions.

* ata_host_alloc() : allocates host and its attached ports.  shost is
  not attached automatically.

* ata_scsi_add_hosts() : allocates and adds shosts associated with an
  ATA host.  Used by ata_host_attach().

* ata_host_attach() : takes a fully initialized ata_host structure and
  registers it to libata layer and probes it.

Only ata_host_alloc() and ata_host_attach() are exported.
ata_device_add() is rewritten using the above functions.  This patch
does not introduce any observable behavior change.  Things worth
mentioning.

* print_id is assigned at attach time and LLDs are allowed to
  overallocate ports and reduce host->n_ports during initialization.
  ata_host_attach() will throw away unused ports automatically.

* All SCSI host initialization stuff now resides in
  ata_scsi_add_hosts() in libata-scsi.c, where it should be.

* ipr is now the only user of ata_host_init().  Either kill it by
  converting ipr to use ata_host_alloc() and friends or rename and
  move it to libata-scsi.c

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |  469 +++++++++++++++++++++++++--------------------
 drivers/ata/libata-scsi.c |   68 ++++++--
 drivers/ata/libata.h      |    8 +-
 include/linux/libata.h    |    3 +
 4 files changed, 326 insertions(+), 222 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6a4e7a4..b95618d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -72,7 +72,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 
-static unsigned int ata_print_id = 1;
+unsigned int ata_print_id = 1;
 static struct workqueue_struct *ata_wq;
 
 struct workqueue_struct *ata_aux_wq;
@@ -5520,42 +5520,35 @@ void ata_dev_init(struct ata_device *dev)
 }
 
 /**
- *	ata_port_init - Initialize an ata_port structure
- *	@ap: Structure to initialize
- *	@host: Collection of hosts to which @ap belongs
- *	@ent: Probe information provided by low-level driver
- *	@port_no: Port number associated with this ata_port
+ *	ata_port_alloc - allocate and initialize basic ATA port resources
+ *	@host: ATA host this allocated port belongs to
  *
- *	Initialize a new ata_port structure.
+ *	Allocate and initialize basic ATA port resources.
+ *
+ *	RETURNS:
+ *	Allocate ATA port on success, NULL on failure.
  *
  *	LOCKING:
- *	Inherited from caller.
+ *	Inherited from calling layer (may sleep).
  */
-void ata_port_init(struct ata_port *ap, struct ata_host *host,
-		   const struct ata_probe_ent *ent, unsigned int port_no)
+struct ata_port *ata_port_alloc(struct ata_host *host)
 {
+	struct ata_port *ap;
 	unsigned int i;
 
+	DPRINTK("ENTER\n");
+
+	ap = kzalloc(sizeof(*ap), GFP_KERNEL);
+	if (!ap)
+		return NULL;
+
 	ap->lock = &host->lock;
 	ap->flags = ATA_FLAG_DISABLED;
-	ap->print_id = ata_print_id++;
+	ap->print_id = -1;
 	ap->ctl = ATA_DEVCTL_OBS;
 	ap->host = host;
-	ap->dev = ent->dev;
-	ap->port_no = port_no;
-	if (port_no == 1 && ent->pinfo2) {
-		ap->pio_mask = ent->pinfo2->pio_mask;
-		ap->mwdma_mask = ent->pinfo2->mwdma_mask;
-		ap->udma_mask = ent->pinfo2->udma_mask;
-		ap->flags |= ent->pinfo2->flags;
-		ap->ops = ent->pinfo2->port_ops;
-	} else {
-		ap->pio_mask = ent->pio_mask;
-		ap->mwdma_mask = ent->mwdma_mask;
-		ap->udma_mask = ent->udma_mask;
-		ap->flags |= ent->port_flags;
-		ap->ops = ent->port_ops;
-	}
+	ap->dev = host->dev;
+
 	ap->hw_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
@@ -5575,10 +5568,7 @@ void ata_port_init(struct ata_port *ap, struct ata_host *host,
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 
-	/* set cable type */
 	ap->cbl = ATA_CBL_NONE;
-	if (ap->flags & ATA_FLAG_SATA)
-		ap->cbl = ATA_CBL_SATA;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
@@ -5591,75 +5581,6 @@ void ata_port_init(struct ata_port *ap, struct ata_host *host,
 	ap->stats.unhandled_irq = 1;
 	ap->stats.idle_irq = 1;
 #endif
-
-	memcpy(&ap->ioaddr, &ent->port[port_no], sizeof(struct ata_ioports));
-}
-
-/**
- *	ata_port_init_shost - Initialize SCSI host associated with ATA port
- *	@ap: ATA port to initialize SCSI host for
- *	@shost: SCSI host associated with @ap
- *
- *	Initialize SCSI host @shost associated with ATA port @ap.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-static void ata_port_init_shost(struct ata_port *ap, struct Scsi_Host *shost)
-{
-	ap->scsi_host = shost;
-
-	shost->unique_id = ap->print_id;
-	shost->max_id = 16;
-	shost->max_lun = 1;
-	shost->max_channel = 1;
-	shost->max_cmd_len = 16;
-}
-
-/**
- *	ata_port_add - Attach low-level ATA driver to system
- *	@ent: Information provided by low-level driver
- *	@host: Collections of ports to which we add
- *	@port_no: Port number associated with this host
- *
- *	Attach low-level ATA driver to system.
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
- *
- *	RETURNS:
- *	New ata_port on success, for NULL on error.
- */
-static struct ata_port * ata_port_add(const struct ata_probe_ent *ent,
-				      struct ata_host *host,
-				      unsigned int port_no)
-{
-	struct Scsi_Host *shost;
-	struct ata_port *ap;
-
-	DPRINTK("ENTER\n");
-
-	if (!ent->port_ops->error_handler &&
-	    !(ent->port_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
-		printk(KERN_ERR "ata%u: no reset mechanism available\n",
-		       port_no);
-		return NULL;
-	}
-
-	ap = kzalloc(sizeof(struct ata_port), GFP_KERNEL);
-	if (!ap)
-		return NULL;
-
-	shost = scsi_host_alloc(ent->sht, sizeof(struct ata_port *));
-	if (!shost)
-		return NULL;
-
-	*(struct ata_port **)&shost->hostdata[0] = ap;
-	shost->transportt = &ata_scsi_transport_template;
-
-	ata_port_init(ap, host, ent, port_no);
-	ata_port_init_shost(ap, shost);
-
 	return ap;
 }
 
@@ -5698,13 +5619,79 @@ static void ata_host_release(struct device *gendev, void *res)
 }
 
 /**
+ *	ata_host_alloc - allocate and init basic ATA host resources
+ *	@dev: generic device this host is associated with
+ *	@max_ports: maximum number of ATA ports associated with this host
+ *
+ *	Allocate and initialize basic ATA host resources.  LLD calls
+ *	this function to allocate a host, initializes it fully and
+ *	attaches it using ata_host_attach().
+ *
+ *	@max_ports ports are allocated and host->n_ports is
+ *	initialized to @max_ports.  The caller is allowed to decrease
+ *	host->n_ports before calling ata_host_attach().  The unused
+ *	ports will be automatically freed on attach.
+ *
+ *	RETURNS:
+ *	Allocate ATA host on success, NULL on failure.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
+{
+	struct ata_host *host;
+	size_t sz;
+	int i;
+
+	DPRINTK("ENTER\n");
+
+	if (!devres_open_group(dev, NULL, GFP_KERNEL))
+		return NULL;
+
+	/* alloc a container for our list of ATA ports (buses) */
+	sz = sizeof(struct ata_host) + (max_ports + 1) * sizeof(void *);
+	/* alloc a container for our list of ATA ports (buses) */
+	host = devres_alloc(ata_host_release, sz, GFP_KERNEL);
+	if (!host)
+		goto err_out;
+
+	devres_add(dev, host);
+	dev_set_drvdata(dev, host);
+
+	spin_lock_init(&host->lock);
+	host->dev = dev;
+	host->n_ports = max_ports;
+
+	/* allocate ports bound to this host */
+	for (i = 0; i < max_ports; i++) {
+		struct ata_port *ap;
+
+		ap = ata_port_alloc(host);
+		if (!ap)
+			goto err_out;
+
+		ap->port_no = i;
+		host->ports[i] = ap;
+	}
+
+	devres_remove_group(dev, NULL);
+	return host;
+
+ err_out:
+	devres_release_group(dev, NULL);
+	return NULL;
+}
+
+/**
  *	ata_host_start - start and freeze ports of an ATA host
  *	@host: ATA host to start ports for
  *
  *	Start and then freeze ports of @host.  Started status is
  *	recorded in host->flags, so this function can be called
  *	multiple times.  Ports are guaranteed to get started only
- *	once.
+ *	once.  If host->ops isn't initialized yet, its set to the
+ *	first non-dummy port ops.
  *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
@@ -5722,6 +5709,9 @@ int ata_host_start(struct ata_host *host)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
+		if (!host->ops && !ata_port_is_dummy(ap))
+			host->ops = ap->ops;
+
 		if (ap->ops->port_start) {
 			rc = ap->ops->port_start(ap);
 			if (rc) {
@@ -5758,7 +5748,7 @@ int ata_host_start(struct ata_host *host)
  *	PCI/etc. bus probe sem.
  *
  */
-
+/* KILLME - the only user left is ipr */
 void ata_host_init(struct ata_host *host, struct device *dev,
 		   unsigned long flags, const struct ata_port_operations *ops)
 {
@@ -5769,6 +5759,143 @@ void ata_host_init(struct ata_host *host, struct device *dev,
 }
 
 /**
+ *	ata_host_attach - attach initialized ATA host
+ *	@host: ATA host to attach
+ *	@sht: template for SCSI host
+ *
+ *	Attach initialized ATA host.  @host is allocated using
+ *	ata_host_alloc() and fully initialized by LLD.  This function
+ *	starts ports, registers @host with ATA and SCSI layers and
+ *	probe attached devices.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_host_attach(struct ata_host *host, struct scsi_host_template *sht)
+{
+	int i, rc;
+
+	/* host must have been started */
+	if (!(host->flags & ATA_HOST_STARTED)) {
+		dev_printk(KERN_ERR, host->dev,
+			   "BUG: trying to attach unstarted host\n");
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	/* Blow away unused ports.  This happens when LLD can't
+	 * determine the exact number of ports to allocate at
+	 * allocation time.
+	 */
+	for (i = host->n_ports; host->ports[i]; i++)
+		kfree(host->ports[i]);
+
+	/* give ports names and add SCSI hosts */
+	for (i = 0; i < host->n_ports; i++)
+		host->ports[i]->print_id = ata_print_id++;
+
+	rc = ata_scsi_add_hosts(host, sht);
+	if (rc)
+		return rc;
+
+	/* set cable, sata_spd_limit and report */
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		int irq_line;
+		u32 scontrol;
+		unsigned long xfer_mask;
+
+		/* set SATA cable type if still unset */
+		if (ap->cbl == ATA_CBL_NONE && (ap->flags & ATA_FLAG_SATA))
+			ap->cbl = ATA_CBL_SATA;
+
+		/* init sata_spd_limit to the current value */
+		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
+			int spd = (scontrol >> 4) & 0xf;
+			ap->hw_sata_spd_limit &= (1 << spd) - 1;
+		}
+		ap->sata_spd_limit = ap->hw_sata_spd_limit;
+
+		/* report the secondary IRQ for second channel legacy */
+		irq_line = host->irq;
+		if (i == 1 && host->irq2)
+			irq_line = host->irq2;
+
+		xfer_mask = ata_pack_xfermask(ap->pio_mask, ap->mwdma_mask,
+					      ap->udma_mask);
+
+		/* print per-port info to dmesg */
+		if (!ata_port_is_dummy(ap))
+			ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%p "
+					"ctl 0x%p bmdma 0x%p irq %d\n",
+					ap->cbl == ATA_CBL_SATA ? 'S' : 'P',
+					ata_mode_string(xfer_mask),
+					ap->ioaddr.cmd_addr,
+					ap->ioaddr.ctl_addr,
+					ap->ioaddr.bmdma_addr,
+					irq_line);
+		else
+			ata_port_printk(ap, KERN_INFO, "DUMMY\n");
+	}
+
+	/* perform each probe synchronously */
+	DPRINTK("probe begin\n");
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		int rc;
+
+		/* probe */
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
+			DPRINTK("ata%u: bus probe begin\n", ap->print_id);
+			rc = ata_bus_probe(ap);
+			DPRINTK("ata%u: bus probe end\n", ap->print_id);
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
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		ata_scsi_scan_host(ap);
+	}
+
+	return 0;
+}
+
+/**
  *	ata_device_add - Register hardware device with ATA and SCSI layers
  *	@ent: Probe information describing hardware device to be registered
  *
@@ -5800,62 +5927,53 @@ int ata_device_add(const struct ata_probe_ent *ent)
 		return 0;
 	}
 
+	if (!ent->port_ops->error_handler &&
+	    !(ent->port_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
+		dev_printk(KERN_ERR, dev, "no reset mechanism available\n");
+		return 0;
+	}
+
 	if (!devres_open_group(dev, ata_device_add, GFP_KERNEL))
 		return 0;
 
-	/* alloc a container for our list of ATA ports (buses) */
-	host = devres_alloc(ata_host_release, sizeof(struct ata_host) +
-			    (ent->n_ports * sizeof(void *)), GFP_KERNEL);
-	if (!host)
-		goto err_out;
-	devres_add(dev, host);
-	dev_set_drvdata(dev, host);
+	/* allocate host */
+	host = ata_host_alloc(dev, ent->n_ports);
 
-	ata_host_init(host, dev, ent->_host_flags, ent->port_ops);
-	host->n_ports = ent->n_ports;
 	host->irq = ent->irq;
 	host->irq2 = ent->irq2;
 	host->iomap = ent->iomap;
 	host->private_data = ent->private_data;
+	host->ops = ent->port_ops;
+	host->flags = ent->_host_flags;
 
-	/* register each port bound to this device */
 	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap;
-		unsigned long xfer_mode_mask;
-		int irq_line = ent->irq;
-
-		ap = ata_port_add(ent, host, i);
-		host->ports[i] = ap;
-		if (!ap)
-			goto err_out;
+		struct ata_port *ap = host->ports[i];
 
 		/* dummy? */
 		if (ent->dummy_port_mask & (1 << i)) {
-			ata_port_printk(ap, KERN_INFO, "DUMMY\n");
 			ap->ops = &ata_dummy_port_ops;
 			continue;
 		}
 
-		/* Report the secondary IRQ for second channel legacy */
-		if (i == 1 && ent->irq2)
-			irq_line = ent->irq2;
-
-		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
-				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
-				(ap->pio_mask << ATA_SHIFT_PIO);
+		if (ap->port_no == 1 && ent->pinfo2) {
+			ap->pio_mask = ent->pinfo2->pio_mask;
+			ap->mwdma_mask = ent->pinfo2->mwdma_mask;
+			ap->udma_mask = ent->pinfo2->udma_mask;
+			ap->flags |= ent->pinfo2->flags;
+			ap->ops = ent->pinfo2->port_ops;
+		} else {
+			ap->pio_mask = ent->pio_mask;
+			ap->mwdma_mask = ent->mwdma_mask;
+			ap->udma_mask = ent->udma_mask;
+			ap->flags |= ent->port_flags;
+			ap->ops = ent->port_ops;
+		}
 
-		/* print per-port info to dmesg */
-		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%p "
-				"ctl 0x%p bmdma 0x%p irq %d\n",
-				ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
-				ata_mode_string(xfer_mode_mask),
-				ap->ioaddr.cmd_addr,
-				ap->ioaddr.ctl_addr,
-				ap->ioaddr.bmdma_addr,
-				irq_line);
+		memcpy(&ap->ioaddr, &ent->port[ap->port_no],
+		       sizeof(struct ata_ioports));
 	}
 
-	/* start ports */
+	/* start and freeze ports before requesting IRQ */
 	rc = ata_host_start(host);
 	if (rc)
 		goto err_out;
@@ -5888,80 +6006,17 @@ int ata_device_add(const struct ata_probe_ent *ent)
 	/* resource acquisition complete */
 	devres_remove_group(dev, ata_device_add);
 
-	/* perform each probe synchronously */
-	DPRINTK("probe begin\n");
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
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
-		rc = scsi_add_host(ap->scsi_host, dev);
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
-			DPRINTK("ata%u: bus probe begin\n", ap->print_id);
-			rc = ata_bus_probe(ap);
-			DPRINTK("ata%u: bus probe end\n", ap->print_id);
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
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		ata_scsi_scan_host(ap);
-	}
+	/* attach */
+	rc = ata_host_attach(host, ent->sht);
+	if (rc)
+		goto err_out;
 
-	VPRINTK("EXIT, returning %u\n", ent->n_ports);
-	return ent->n_ports; /* success */
+	VPRINTK("EXIT, returning %u\n", host->n_ports);
+	return host->n_ports; /* success */
 
  err_out:
 	devres_release_group(dev, ata_device_add);
-	VPRINTK("EXIT, returning %d\n", rc);
+	VPRINTK("EXIT, returning 0\n");
 	return 0;
 }
 
@@ -6414,7 +6469,9 @@ EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
+EXPORT_SYMBOL_GPL(ata_host_alloc);
 EXPORT_SYMBOL_GPL(ata_host_start);
+EXPORT_SYMBOL_GPL(ata_host_attach);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_sg_init);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 684528e..77e6124 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -104,7 +104,7 @@ static const u8 def_control_mpage[CONTROL_MPAGE_LEN] = {
  * libata transport template.  libata doesn't do real transport stuff.
  * It just needs the eh_timed_out hook.
  */
-struct scsi_transport_template ata_scsi_transport_template = {
+static struct scsi_transport_template ata_scsi_transport_template = {
 	.eh_strategy_handler	= ata_scsi_error,
 	.eh_timed_out		= ata_scsi_timed_out,
 	.user_scan		= ata_scsi_user_scan,
@@ -2949,6 +2949,48 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	}
 }
 
+int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
+{
+	int i, rc;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		struct Scsi_Host *shost;
+
+		rc = -ENOMEM;
+		shost = scsi_host_alloc(sht, sizeof(struct ata_port *));
+		if (!shost)
+			goto err_alloc;
+
+		*(struct ata_port **)&shost->hostdata[0] = ap;
+		ap->scsi_host = shost;
+
+		shost->transportt = &ata_scsi_transport_template;
+		shost->unique_id = ap->print_id;
+		shost->max_id = 16;
+		shost->max_lun = 1;
+		shost->max_channel = 1;
+		shost->max_cmd_len = 16;
+
+		rc = scsi_add_host(ap->scsi_host, ap->host->dev);
+		if (rc)
+			goto err_add;
+	}
+
+	return 0;
+
+ err_add:
+	scsi_host_put(host->ports[i]->scsi_host);
+ err_alloc:
+	while (--i >= 0) {
+		struct Scsi_Host *shost = host->ports[i]->scsi_host;
+
+		scsi_remove_host(shost);
+		scsi_host_put(shost);
+	}
+	return rc;
+}
+
 void ata_scsi_scan_host(struct ata_port *ap)
 {
 	unsigned int i;
@@ -3225,21 +3267,21 @@ struct ata_port *ata_sas_port_alloc(struct ata_host *host,
 				    struct ata_port_info *port_info,
 				    struct Scsi_Host *shost)
 {
-	struct ata_port *ap = kzalloc(sizeof(*ap), GFP_KERNEL);
-	struct ata_probe_ent *ent;
+	struct ata_port *ap;
 
+	ap = ata_port_alloc(host);
 	if (!ap)
 		return NULL;
 
-	ent = ata_probe_ent_alloc(host->dev, port_info);
-	if (!ent) {
-		kfree(ap);
-		return NULL;
-	}
-
-	ata_port_init(ap, host, ent, 0);
+	ap->port_no = 0;
 	ap->lock = shost->host_lock;
-	devm_kfree(host->dev, ent);
+	ap->pio_mask = port_info->pio_mask;
+	ap->mwdma_mask = port_info->mwdma_mask;
+	ap->udma_mask = port_info->udma_mask;
+	ap->flags |= port_info->flags;
+	ap->ops = port_info->port_ops;
+	ap->cbl = ATA_CBL_SATA;
+
 	return ap;
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
@@ -3295,8 +3337,10 @@ int ata_sas_port_init(struct ata_port *ap)
 {
 	int rc = ap->ops->port_start(ap);
 
-	if (!rc)
+	if (!rc) {
+		ap->print_id = ata_print_id++;
 		rc = ata_bus_probe(ap);
+	}
 
 	return rc;
 }
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index c426714..38949a2 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -52,6 +52,7 @@ enum {
 	ATA_DNXFER_QUIET	= (1 << 31),
 };
 
+extern unsigned int ata_print_id;
 extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
@@ -92,10 +93,9 @@ extern int ata_flush_cache(struct ata_device *dev);
 extern void ata_dev_init(struct ata_device *dev);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
-extern void ata_port_init(struct ata_port *ap, struct ata_host *host,
-			  const struct ata_probe_ent *ent, unsigned int port_no);
 extern struct ata_probe_ent *ata_probe_ent_alloc(struct device *dev,
 						 const struct ata_port_info *port);
+extern struct ata_port *ata_port_alloc(struct ata_host *host);
 
 /* libata-acpi.c */
 #ifdef CONFIG_SATA_ACPI
@@ -113,8 +113,8 @@ static inline int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
 #endif
 
 /* libata-scsi.c */
-extern struct scsi_transport_template ata_scsi_transport_template;
-
+extern int ata_scsi_add_hosts(struct ata_host *host,
+			      struct scsi_host_template *sht);
 extern void ata_scsi_scan_host(struct ata_port *ap);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 296c9ef..9edb7c7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -728,7 +728,10 @@ extern int ata_pci_device_resume(struct pci_dev *pdev);
 #endif
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
+extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
 extern int ata_host_start(struct ata_host *host);
+extern int ata_host_attach(struct ata_host *host,
+			   struct scsi_host_template *sht);
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
-- 
1.5.0.1


