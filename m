From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/20] libata: implement several LLD init helpers
Date: Tue, 19 Sep 2006 01:16:01 -0400
Message-ID: <450F7D11.7030007@pobox.com>
References: <11559779712708-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47518 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752062AbWISFQQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 01:16:16 -0400
In-Reply-To: <11559779712708-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> +struct ata_host *ata_host_alloc_pinfo(struct device *dev,
> +				      const struct ata_port_info *pinfo,
> +				      int n_ports)
> +{
> +	struct ata_host *host;
> +
> +	if (!n_ports)
> +		return NULL;
> +
> +	host = ata_host_alloc(dev, pinfo->sht, n_ports);
> +	if (host)
> +		__ata_host_init_pinfo(host, &pinfo, n_ports, 0);
> +	return host;
> +}
> +
> +/**
> + *	ata_host_alloc_pinfo_ar - alloc host and init with port_info ar
> + *	@dev: generic device this host is associated with
> + *	@pinfo_ar: array of ATA port_info to initialize host with
> + *	@n_ports: number of ATA ports attached to this host
> + *
> + *	Allocate ATA host and initialize with info from @pinfo_ar.
> + *
> + *	RETURNS:
> + *	Allocate ATA host on success, NULL on failure.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +struct ata_host *ata_host_alloc_pinfo_ar(struct device *dev,
> +					 const struct ata_port_info **pinfo_ar,
> +					 int n_ports)
> +{
> +	struct ata_host *host;
> +
> +	if (!n_ports)
> +		return NULL;
> +
> +	host = ata_host_alloc(dev, pinfo_ar[0]->sht, n_ports);
> +	if (host)
> +		__ata_host_init_pinfo(host, pinfo_ar, n_ports, 1);
> +	return host;
> +}
> +
> +/**
> + *	ata_host_add_ports_pinfo - add ports and init with port_info
> + *	@host: target ATA host
> + *	@pinfo: ATA port_info to initialize host with
> + *	@n_ports: number of ATA ports attached to this host
> + *
> + *	Add @n_ports ports to @host and initialize @host with
> + *	info from @pinfo.
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +int ata_host_add_ports_pinfo(struct ata_host *host,
> +			     const struct ata_port_info *pinfo, int n_ports)
> +{
> +	int rc;
> +
> +	rc = ata_host_add_ports(host, pinfo->sht, n_ports);
> +	if (rc == 0)
> +		__ata_host_init_pinfo(host, &pinfo, n_ports, 0);
> +	return rc;
> +}
> +
> +/**
> + *	ata_host_add_ports_pinfo_ar - add ports and init with port_info ar
> + *	@host: target ATA host
> + *	@pinfo_ar: array of ATA port_info to initialize host with
> + *	@n_ports: number of ATA ports attached to this host
> + *
> + *	Add @n_ports ports to @host and initialize @host with
> + *	info from @pinfo_ar.
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +int ata_host_add_ports_pinfo_ar(struct ata_host *host,
> +				const struct ata_port_info **pinfo_ar,
> +				int n_ports)
> +{
> +	int rc;
> +
> +	rc = ata_host_add_ports(host, pinfo_ar[0]->sht, n_ports);
> +	if (rc == 0)
> +		__ata_host_init_pinfo(host, pinfo_ar, n_ports, 1);
> +	return rc;
> +}

Just implement a single version for each case (array and non-array). 
The LLDD can pass in an indication of whether or not to copy the first 
element into succeeding elements.


> @@ -5494,6 +5643,7 @@ void ata_host_init(struct ata_host *host
>  	host->dev = dev;
>  	host->flags = flags;
>  	host->ops = ops;
> +	INIT_LIST_HEAD(&host->irq_list);
>  }
>  
>  /**
> @@ -5541,6 +5691,108 @@ int ata_host_start(struct ata_host *host
>  }
>  
>  /**
> + *	ata_host_request_irq_marker - request IRQ helper
> + *	@host: ATA host requesting IRQ for
> + *	@irq: IRQ to request
> + *	@handler: IRQ handler
> + *	@irq_flags: IRQ flags
> + *	@dev_id: IRQ dev_id
> + *	@marker: marker
> + *	@p_reason: out arg for error message (can be NULL)
> + *
> + *	Freeze all ports and request IRQ with given parameters.
> + *	devname for the IRQ will be the name of the associated LLD.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + *
> + *	RETURNS:
> + *	Return value of request_irq().
> + */
> +int ata_host_request_irq_marker(struct ata_host *host, unsigned int irq,
> +			irqreturn_t (*handler)(int, void *, struct pt_regs *),
> +			unsigned int irq_flags, void *dev_id, void *marker,
> +			const char **p_reason)
> +{
> +	struct ata_irq *airq = NULL;
> +	const char *reason;
> +	int i, rc;
> +
> +	/* make sure ports are started */
> +	rc = ata_host_start(host);
> +	if (rc) {
> +		reason = "failed to start host";
> +		goto err;
> +	}
> +
> +	/* freeze before requesting IRQ */
> +	for (i = 0; i < host->n_ports; i++) {
> +		struct ata_port *ap = host->ports[i];
> +
> +		if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
> +			ata_chk_status(ap);
> +			host->ops->irq_clear(ap);
> +			ata_eh_freeze_port(ap);
> +		}
> +	}
> +
> +	/* request irq */
> +	airq = kzalloc(sizeof(*airq), GFP_KERNEL);
> +	if (!airq) {
> +		reason = "failed to allocate ata_irq";
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	rc = request_irq(irq, handler, irq_flags, DRV_NAME, dev_id);
> +	if (rc) {
> +		reason = "failed to request IRQ";
> +		goto err;
> +	}
> +
> +	airq->irq = irq;
> +	airq->dev_id = dev_id;
> +	airq->marker = marker;
> +	list_add_tail(&airq->node, &host->irq_list);
> +
> +	return rc;
> +
> + err:
> +	kfree(airq);
> +	if (p_reason)
> +		*p_reason = reason;
> +	return rc;
> +}
> +
> +/**
> + *	ata_host_request_irq - request IRQ helper
> + *	@host: ATA host requesting IRQ for
> + *	@irq: IRQ to request
> + *	@handler: IRQ handler
> + *	@irq_flags: IRQ flags
> + *	@dev_id: IRQ dev_id
> + *	@p_reason: out arg for error message (can be NULL)
> + *
> + *	Freeze all ports and request IRQ with given parameters.
> + *	devname for the IRQ will be the name of the associated LLD.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + *
> + *	RETURNS:
> + *	Return value of request_irq().
> + */
> +int ata_host_request_irq(struct ata_host *host, unsigned int irq,
> +			 irqreturn_t (*handler)(int, void *, struct pt_regs *),
> +			 unsigned int irq_flags, void *dev_id,
> +			 const char **p_reason)
> +{
> +	return ata_host_request_irq_marker(host, irq, handler, irq_flags,
> +					   dev_id, ata_host_request_irq,
> +					   p_reason);
> +}
> +
> +/**
>   *	ata_host_attach - attach initialized ATA host
>   *	@host: ATA host to attach
>   *
> @@ -5886,6 +6138,48 @@ void ata_host_stop(struct ata_host *host
>  	}
>  }
>  
> +static void __ata_host_free_irqs(struct ata_host *host, void **markerp)
> +{
> +	struct ata_irq *airq, *tmp;
> +
> +	list_for_each_entry_safe(airq, tmp, &host->irq_list, node) {
> +		if (!markerp || airq->marker == *markerp) {
> +			list_del(&airq->node);
> +			free_irq(airq->irq, airq->dev_id);
> +			kfree(airq);
> +		}
> +	}
> +}

Ugh, I just don't like this at all.  I would much rather have a hook or 
entry point where the LLDD is given the capability to call request_irq() 
itself, in some exotic situations.  Then, helpers provided by libata can 
handle the common cases.  That's much more modular than the above.

	Jeff


