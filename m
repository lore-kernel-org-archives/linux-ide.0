From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/20] libata: separate out ata_host_alloc() and ata_host_attach()
Date: Tue, 19 Sep 2006 01:08:20 -0400
Message-ID: <450F7B44.4010300@pobox.com>
References: <1155977971798-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:28318 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752061AbWISFI4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 01:08:56 -0400
In-Reply-To: <1155977971798-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out ata_host_alloc(), ata_host_add_ports() and
> ata_host_attach() from ata_device_add().  These functions will be used
> by new LLD init model where LLD allocates host directly, then
> intializes and attaches it instead of going through probe_ent.
> 
> ata_host_alloc() can be called with NULL @sht which indicates that
> Scsi_Host association is handled by the caller.  This will be used by
> SAS.
> 
> This patch does not introduce behavior changes.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK in general, but minor nits are found in comments below.

Also, to make reviewing and git bisect easier, it would be nice to split 
ata_host_attach() separation into another patch.


> ---
>  drivers/ata/libata-core.c |  451 ++++++++++++++++++++++++++++++---------------
>  include/linux/libata.h    |    7 +
>  2 files changed, 312 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d7bf4a1..eeb9dc6 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5243,11 +5243,15 @@ void ata_dev_init(struct ata_device *dev
>   *	ata_port_init - Initialize an ata_port structure
>   *	@ap: Structure to initialize
>   *	@host: Collection of hosts to which @ap belongs
> - *	@ent: Probe information provided by low-level driver
> - *	@port_no: Port number associated with this ata_port
> + *	@ent: Probe information provided by low-level driver (optional)
> + *	@port_no: Port number associated with this ata_port (optional)

I would perhaps note that port_no is require iff ent != NULL


>   *	Initialize a new ata_port structure.
>   *
> + *	@ent and @port_no are to support sas interface.  These will be
> + *	removed once sas is converted to use new alloc/init/attach
> + *	interface.
> + *
>   *	LOCKING:
>   *	Inherited from caller.
>   */
> @@ -5261,13 +5265,17 @@ void ata_port_init(struct ata_port *ap, 
>  	ap->id = ata_unique_id++;
>  	ap->ctl = ATA_DEVCTL_OBS;
>  	ap->host = host;
> -	ap->dev = ent->dev;
> -	ap->port_no = port_no;
> -	ap->pio_mask = ent->pio_mask;
> -	ap->mwdma_mask = ent->mwdma_mask;
> -	ap->udma_mask = ent->udma_mask;
> -	ap->flags |= ent->port_flags;
> -	ap->ops = ent->port_ops;
> +	ap->dev = host->dev;
> +
> +	if (ent) {
> +		ap->port_no = port_no;
> +		ap->pio_mask = ent->pio_mask;
> +		ap->mwdma_mask = ent->mwdma_mask;
> +		ap->udma_mask = ent->udma_mask;
> +		ap->flags |= ent->port_flags;
> +		ap->ops = ent->port_ops;
> +	}
> +
>  	ap->hw_sata_spd_limit = UINT_MAX;
>  	ap->active_tag = ATA_TAG_POISON;
>  	ap->last_ctl = 0xFF;
> @@ -5287,10 +5295,7 @@ #endif
>  	INIT_LIST_HEAD(&ap->eh_done_q);
>  	init_waitqueue_head(&ap->eh_wait_q);
>  
> -	/* set cable type */
>  	ap->cbl = ATA_CBL_NONE;
> -	if (ap->flags & ATA_FLAG_SATA)
> -		ap->cbl = ATA_CBL_SATA;
>  
>  	for (i = 0; i < ATA_MAX_DEVICES; i++) {
>  		struct ata_device *dev = &ap->device[i];
> @@ -5304,7 +5309,12 @@ #ifdef ATA_IRQ_TRAP
>  	ap->stats.idle_irq = 1;
>  #endif
>  
> -	memcpy(&ap->ioaddr, &ent->port[port_no], sizeof(struct ata_ioports));
> +	if (ent) {
> +		if (ap->flags & ATA_FLAG_SATA)
> +			ap->cbl = ATA_CBL_SATA;
> +		memcpy(&ap->ioaddr, &ent->port[port_no],
> +		       sizeof(struct ata_ioports));
> +	}
>  }
>  
>  /**
> @@ -5329,47 +5339,140 @@ static void ata_port_init_shost(struct a
>  }
>  
>  /**
> - *	ata_port_add - Attach low-level ATA driver to system
> - *	@ent: Information provided by low-level driver
> - *	@host: Collections of ports to which we add
> - *	@port_no: Port number associated with this host
> + *	ata_port_alloc - allocate and initialize basic ATA port resources
> + *	@host: ATA host this allocated port belongs to
> + *	@sht: template for SCSI host (can be NULL)
>   *
> - *	Attach low-level ATA driver to system.
> + *	Allocate and initialize basic ATA port resources.
>   *
> - *	LOCKING:
> - *	PCI/etc. bus probe sem.
> + *	If @sht is NULL, SCSI host is not allocated nor freed later
> + *	with the port.  The caller is responsible for associating SCSI
> + *	host.  This is for SAS.
>   *
>   *	RETURNS:
> - *	New ata_port on success, for NULL on error.
> + *	Allocate ATA port on success, NULL on failure.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
>   */
> -static struct ata_port * ata_port_add(const struct ata_probe_ent *ent,
> -				      struct ata_host *host,
> -				      unsigned int port_no)
> +static struct ata_port *ata_port_alloc(struct ata_host *host,
> +				       struct scsi_host_template *sht)
>  {
> -	struct Scsi_Host *shost;
>  	struct ata_port *ap;
>  
>  	DPRINTK("ENTER\n");
>  
> -	if (!ent->port_ops->error_handler &&
> -	    !(ent->port_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
> -		printk(KERN_ERR "ata%u: no reset mechanism available\n",
> -		       port_no);
> -		return NULL;
> +	if (sht) {
> +		struct Scsi_Host *shost;
> +
> +		shost = scsi_host_alloc(sht, sizeof(struct ata_port));
> +		if (!shost)
> +			return NULL;
> +
> +		shost->transportt = &ata_scsi_transport_template;
> +
> +		ap = ata_shost_to_port(shost);
> +		ata_port_init_shost(ap, shost);
> +
> +		ap->pflags |= ATA_PFLAG_SHOST_OWNER;
> +	} else {
> +		ap = kzalloc(sizeof(*ap), GFP_KERNEL);
> +		if (!ap)
> +			return NULL;
>  	}
>  
> -	shost = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
> -	if (!shost)
> +	ata_port_init(ap, host, NULL, 0);
> +
> +	return ap;
> +}
> +
> +/**
> + *	ata_host_alloc - allocate and init basic ATA host resources
> + *	@dev: generic device this host is associated with
> + *	@sht: template for SCSI host
> + *	@n_ports: number of ATA ports associated with this host (can be 0)
> + *
> + *	Allocate and initialize basic ATA host resources.  LLD calls
> + *	this function to allocate a host, initializes it fully and
> + *	attaches it using ata_host_attach().
> + *
> + *	RETURNS:
> + *	Allocate ATA host on success, NULL on failure.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +struct ata_host *ata_host_alloc(struct device *dev,
> +				struct scsi_host_template *sht, int n_ports)
> +{
> +	struct ata_host *host;
> +	size_t sz;
> +
> +	DPRINTK("ENTER\n");
> +
> +	/* alloc a container for our list of ATA ports (buses) */
> +	sz = sizeof(struct ata_host) + n_ports * sizeof(void *);
> +	if (n_ports == 0)
> +		sz += ATA_MAX_PORTS * sizeof(void *);
> +
> +	host = kzalloc(sz, GFP_KERNEL);
> +	if (!host)
>  		return NULL;
>  
> -	shost->transportt = &ata_scsi_transport_template;
> +	spin_lock_init(&host->lock);
> +	host->dev = dev;
>  
> -	ap = ata_shost_to_port(shost);
> +	if (ata_host_add_ports(host, sht, n_ports))
> +		goto err_free;
>  
> -	ata_port_init(ap, host, ent, port_no);
> -	ata_port_init_shost(ap, shost);
> +	return host;
>  
> -	return ap;
> + err_free:
> +	ata_host_free(host);
> +	return NULL;
> +}
> +
> +/**
> + *	ata_host_add_ports - allocate ports to zero-port host
> + *	@host: target ATA host
> + *	@sht: template for SCSI host
> + *	@n_ports: number of ATA ports associated with this host
> + *
> + *	Allocate @n_ports ports and associate them with @host.
> + *	@n_ports must be less than or equal to ATA_MAX_PORTS and @host
> + *	must have been allocated with zero port.  This function is
> + *	used by LLDs which can't determine number of ports at host
> + *	allocation time.
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +int ata_host_add_ports(struct ata_host *host,
> +		       struct scsi_host_template *sht, int n_ports)
> +{
> +	int i;
> +
> +	if (host->n_ports || n_ports > ATA_MAX_PORTS)
> +		return -EINVAL;

For what code path would host->n_ports be non-zero?


> +	/* allocate ports bound to this host */
> +	for (i = 0; i < n_ports; i++) {
> +		struct ata_port *ap;
> +
> +		ap = ata_port_alloc(host, sht);
> +		if (!ap)
> +			return -ENOMEM;
> +
> +		ap->port_no = i;
> +		host->ports[i] = ap;
> +	}
> +
> +	host->n_ports = n_ports;
> +
> +	return 0;
>  }
>  
>  /**
> @@ -5401,6 +5504,9 @@ void ata_host_init(struct ata_host *host
>   *	ap->pflags, so this function can be called multiple times.
>   *	Ports are guaranteed to get started only once.
>   *
> + *	This function also initializes ap->cbl according to
> + *	ATA_FLAG_SATA if cable type isn't set yet.
> + *
>   *	LOCKING:
>   *	Inherited from calling layer (may sleep).
>   *
> @@ -5414,6 +5520,11 @@ int ata_host_start(struct ata_host *host
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
>  
> +		/* set cable type */
> +		if (ap->cbl == ATA_CBL_NONE && (ap->flags & ATA_FLAG_SATA))
> +			ap->cbl = ATA_CBL_SATA;
> +
> +		/* start ports */
>  		if (ap->pflags & ATA_PFLAG_STARTED)
>  			continue;
>  
> @@ -5430,6 +5541,126 @@ int ata_host_start(struct ata_host *host
>  }
>  
>  /**
> + *	ata_host_attach - attach initialized ATA host
> + *	@host: ATA host to attach
> + *
> + *	Attach initialized ATA host.  @host is allocated using
> + *	ata_host_alloc() and fully initialized by LLD.  This function
> + *	registers @host with ATA and SCSI layers and probe attached
> + *	devices.
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +int ata_host_attach(struct ata_host *host)
> +{
> +	int i, rc;
> +
> +	/* make sure ports are started */
> +	rc = ata_host_start(host);
> +	if (rc)
> +		return rc;
> +
> +	/* perform each probe synchronously */
> +	DPRINTK("probe begin\n");
> +	for (i = 0; i < host->n_ports; i++) {
> +		struct ata_port *ap = host->ports[i];
> +		int irq_line = host->irq;
> +		unsigned long xfer_mode_mask;
> +		u32 scontrol;
> +		int rc;
> +
> +		/* report the secondary IRQ for second channel legacy */
> +		if (i == 1 && host->irq2)
> +			irq_line = host->irq2;
> +
> +		xfer_mode_mask = (ap->udma_mask << ATA_SHIFT_UDMA) |
> +				 (ap->mwdma_mask << ATA_SHIFT_MWDMA) |
> +				 (ap->pio_mask << ATA_SHIFT_PIO);
> +
> +		/* print per-port info to dmesg */
> +		if (ap->ops != &ata_dummy_port_ops)
> +			ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lu "
> +					"ctl 0x%lX bmdma 0x%lX irq %d\n",
> +					ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
> +					ata_mode_string(xfer_mode_mask),
> +					ap->ioaddr.cmd_addr,
> +					ap->ioaddr.ctl_addr,
> +					ap->ioaddr.bmdma_addr, irq_line);
> +		else
> +			ata_port_printk(ap, KERN_INFO, "DUMMY port\n");
> +
> +		/* init sata_spd_limit to the current value */
> +		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
> +			int spd = (scontrol >> 4) & 0xf;
> +			ap->hw_sata_spd_limit &= (1 << spd) - 1;
> +		}
> +		ap->sata_spd_limit = ap->hw_sata_spd_limit;
> +
> +		rc = scsi_add_host(ap->scsi_host, host->dev);
> +		if (rc) {
> +			ata_port_printk(ap, KERN_ERR, "scsi_add_host failed\n");
> +			/* FIXME: do something useful here */
> +			/* FIXME: handle unconditional calls to
> +			 * scsi_scan_host and ata_host_remove, below,
> +			 * at the very least
> +			 */
> +		}
> +
> +		if (ap->ops->error_handler) {
> +			struct ata_eh_info *ehi = &ap->eh_info;
> +			unsigned long flags;
> +
> +			ata_port_probe(ap);
> +
> +			/* kick EH for boot probing */
> +			spin_lock_irqsave(ap->lock, flags);
> +
> +			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
> +			ehi->action |= ATA_EH_SOFTRESET;
> +			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
> +
> +			ap->pflags |= ATA_PFLAG_LOADING;
> +			ata_port_schedule_eh(ap);
> +
> +			spin_unlock_irqrestore(ap->lock, flags);
> +
> +			/* wait for EH to finish */
> +			ata_port_wait_eh(ap);
> +		} else {
> +			DPRINTK("ata%u: bus probe begin\n", ap->id);
> +			rc = ata_bus_probe(ap);
> +			DPRINTK("ata%u: bus probe end\n", ap->id);
> +
> +			if (rc) {
> +				/* FIXME: do something useful here?
> +				 * Current libata behavior will
> +				 * tear down everything when
> +				 * the module is removed
> +				 * or the h/w is unplugged.
> +				 */
> +			}
> +		}
> +	}
> +
> +	/* probes are done, now scan each port's disk(s) */
> +	DPRINTK("host probe begin\n");
> +	for (i = 0; i < host->n_ports; i++) {
> +		struct ata_port *ap = host->ports[i];
> +
> +		ata_scsi_scan_host(ap);
> +	}
> +
> +	dev_set_drvdata(host->dev, host);
> +
> +	return 0;
> +}
> +
> +
> +/**
>   *	ata_device_add - Register hardware device with ATA and SCSI layers
>   *	@ent: Probe information describing hardware device to be registered
>   *
> @@ -5455,61 +5686,48 @@ int ata_device_add(const struct ata_prob
>  	int rc;
>  
>  	DPRINTK("ENTER\n");
> -	/* alloc a container for our list of ATA ports (buses) */
> -	host = kzalloc(sizeof(struct ata_host) +
> -		       (ent->n_ports * sizeof(void *)), GFP_KERNEL);
> +
> +	if (!ent->port_ops->error_handler &&
> +	    !(ent->port_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
> +		dev_printk(KERN_ERR, dev, "no reset mechanism available\n");
> +		return 0;
> +	}
> +
> +	/* allocate host */
> +	host = ata_host_alloc(dev, ent->sht, ent->n_ports);
>  	if (!host)
>  		return 0;
>  
> -	ata_host_init(host, dev, ent->_host_flags, ent->port_ops);
> -	host->n_ports = ent->n_ports;
>  	host->irq = ent->irq;
>  	host->irq2 = ent->irq2;
>  	host->mmio_base = ent->mmio_base;
>  	host->private_data = ent->private_data;
> +	host->ops = ent->port_ops;
> +	host->flags = ent->_host_flags;
>  
> -	/* register each port bound to this device */
>  	for (i = 0; i < host->n_ports; i++) {
> -		struct ata_port *ap;
> -		unsigned long xfer_mode_mask;
> -		int irq_line = ent->irq;
> -
> -		ap = ata_port_add(ent, host, i);
> -		if (!ap)
> -			goto err_out;
> -
> -		host->ports[i] = ap;
> +		struct ata_port *ap = host->ports[i];
>  
>  		/* dummy? */
>  		if (ent->dummy_port_mask & (1 << i)) {
> -			ata_port_printk(ap, KERN_INFO, "DUMMY\n");
>  			ap->ops = &ata_dummy_port_ops;
>  			continue;
>  		}
>  
> -		/* Report the secondary IRQ for second channel legacy */
> -		if (i == 1 && ent->irq2)
> -			irq_line = ent->irq2;
> -
> -		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
> -				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
> -				(ap->pio_mask << ATA_SHIFT_PIO);
> +		ap->pio_mask = ent->pio_mask;
> +		ap->mwdma_mask = ent->mwdma_mask;
> +		ap->udma_mask = ent->udma_mask;
> +		ap->flags |= ent->port_flags;
> +		ap->ops = ent->port_ops;
>  
> -		/* print per-port info to dmesg */
> -		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
> -				"ctl 0x%lX bmdma 0x%lX irq %d\n",
> -				ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
> -				ata_mode_string(xfer_mode_mask),
> -				ap->ioaddr.cmd_addr,
> -				ap->ioaddr.ctl_addr,
> -				ap->ioaddr.bmdma_addr,
> -				irq_line);
> +		memcpy(&ap->ioaddr, &ent->port[ap->port_no],
> +		       sizeof(struct ata_ioports));
>  	}
>  
>  	/* start ports */
>  	rc = ata_host_start(host);
>  	if (rc)
> -		goto err_out;
> +		goto err_free_host;
>  
>  	/* freeze */
>  	for (i = 0; i < host->n_ports; i++) {
> @@ -5526,7 +5744,7 @@ int ata_device_add(const struct ata_prob
>  	if (rc) {
>  		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
>  			   ent->irq, rc);
> -		goto err_out;
> +		goto err_free_host;
>  	}
>  
>  	/* do we have a second IRQ for the other channel, eg legacy mode */
> @@ -5540,86 +5758,22 @@ int ata_device_add(const struct ata_prob
>  		if (rc) {
>  			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
>  				   ent->irq2, rc);
> -			goto err_out_free_irq;
> +			goto err_free_irq;
>  		}
>  	}
>  
> -	/* perform each probe synchronously */
> -	DPRINTK("probe begin\n");
> -	for (i = 0; i < host->n_ports; i++) {
> -		struct ata_port *ap = host->ports[i];
> -		u32 scontrol;
> -		int rc;
> -
> -		/* init sata_spd_limit to the current value */
> -		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
> -			int spd = (scontrol >> 4) & 0xf;
> -			ap->hw_sata_spd_limit &= (1 << spd) - 1;
> -		}
> -		ap->sata_spd_limit = ap->hw_sata_spd_limit;
> -
> -		rc = scsi_add_host(ap->scsi_host, dev);
> -		if (rc) {
> -			ata_port_printk(ap, KERN_ERR, "scsi_add_host failed\n");
> -			/* FIXME: do something useful here */
> -			/* FIXME: handle unconditional calls to
> -			 * scsi_scan_host and ata_host_remove, below,
> -			 * at the very least
> -			 */
> -		}
> -
> -		if (ap->ops->error_handler) {
> -			struct ata_eh_info *ehi = &ap->eh_info;
> -			unsigned long flags;
> -
> -			ata_port_probe(ap);
> -
> -			/* kick EH for boot probing */
> -			spin_lock_irqsave(ap->lock, flags);
> -
> -			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
> -			ehi->action |= ATA_EH_SOFTRESET;
> -			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
> -
> -			ap->pflags |= ATA_PFLAG_LOADING;
> -			ata_port_schedule_eh(ap);
> -
> -			spin_unlock_irqrestore(ap->lock, flags);
> -
> -			/* wait for EH to finish */
> -			ata_port_wait_eh(ap);
> -		} else {
> -			DPRINTK("ata%u: bus probe begin\n", ap->id);
> -			rc = ata_bus_probe(ap);
> -			DPRINTK("ata%u: bus probe end\n", ap->id);
> -
> -			if (rc) {
> -				/* FIXME: do something useful here?
> -				 * Current libata behavior will
> -				 * tear down everything when
> -				 * the module is removed
> -				 * or the h/w is unplugged.
> -				 */
> -			}
> -		}
> -	}
> -
> -	/* probes are done, now scan each port's disk(s) */
> -	DPRINTK("host probe begin\n");
> -	for (i = 0; i < host->n_ports; i++) {
> -		struct ata_port *ap = host->ports[i];
> -
> -		ata_scsi_scan_host(ap);
> -	}
> -
> -	dev_set_drvdata(dev, host);
> +	rc = ata_host_attach(host);
> +	if (rc)
> +		goto err_free_irq2;
>  
> -	VPRINTK("EXIT, returning %u\n", ent->n_ports);
> -	return ent->n_ports; /* success */
> +	return host->n_ports; /* success */
>  
> -err_out_free_irq:
> + err_free_irq2:
> +	if (ent->irq2)
> +		free_irq(ent->irq2, host);
> + err_free_irq:
>  	free_irq(ent->irq, host);
> -err_out:
> + err_free_host:
>  	ata_host_stop(host);
>  	ata_host_free(host);
>  	VPRINTK("EXIT, returning 0\n");
> @@ -5755,8 +5909,10 @@ void ata_host_free(struct ata_host *host
>  	/* free */
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
> -		if (ap)
> +		if (ap->pflags & ATA_PFLAG_SHOST_OWNER)
>  			scsi_host_put(ap->scsi_host);
> +		else
> +			kfree(ap);

Do we ever have a reason to care about ap->scsi_host in the SAS case?

It seems like we could kill ATA_PFLAG_SHOST_OWNER, and just test 
scsi_host for NULL.

