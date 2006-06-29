From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/9] libata-core.c conversion
Date: Fri, 30 Jun 2006 01:51:14 +0900
Message-ID: <44A40502.3040509@gmail.com>
References: <20060629161001.GE23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:1474 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750963AbWF2Qux (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:50:53 -0400
Received: by py-out-1112.google.com with SMTP id b36so324433pyb
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 09:50:52 -0700 (PDT)
In-Reply-To: <20060629161001.GE23122@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Borislav Petkov wrote:
> @@ -1341,20 +1341,18 @@ int ata_dev_configure(struct ata_device 
>  	unsigned int xfer_mask;
>  	int i, rc;
>  
> -	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
> -		ata_dev_printk(dev, KERN_INFO,
> +	if (!ata_dev_enabled(dev)) {
> +		ata_dev_printk(dev, ATA_MSG_INFO,
>  			       "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
>  			       __FUNCTION__, ap->id, dev->devno);
>  		return 0;

ATA_MSG_TRACE.

>  	}
>  
> -	if (ata_msg_probe(ap))
> -		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
> +	ata_dev_printk(dev, ATA_MSG_TRACE, "%s: ENTER, host %u, dev %u\n",
>  			       __FUNCTION__, ap->id, dev->devno);
>  
>  	/* print device capabilities */
> -	if (ata_msg_probe(ap))
> -		ata_dev_printk(dev, KERN_DEBUG,
> +	ata_dev_printk(dev, ATA_MSG_VDEBUG,
>  			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
>  			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
>  			       __FUNCTION__,

DEBUG

> @@ -1399,8 +1396,8 @@ int ata_dev_configure(struct ata_device 
>  			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
>  
>  			/* print device info to dmesg */
> -			if (ata_msg_info(ap))
> -				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
> +			if (print_info)
> +				ata_dev_printk(dev, ATA_MSG_DRV, "ATA-%d, "
>  					"max %s, %Lu sectors: %s %s\n",
>  					ata_id_major_version(id),
>  					ata_mode_string(xfer_mask),

Hmmm.. not INFO?

> @@ -2098,10 +2091,10 @@ static int ata_dev_set_mode(struct ata_d
>  	if (rc)
>  		return rc;
>  
> -	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
> +	ata_dev_printk(dev, ATA_MSG_CMD, "xfer_shift=%u, xfer_mode=0x%x\n",
>  		dev->xfer_shift, (int)dev->xfer_mode);

DEBUG.


> @@ -2339,7 +2332,7 @@ static unsigned int ata_bus_softreset(st
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
> +	ata_port_printk(ap, ATA_MSG_CMD, "ata%u: bus reset via SRST\n", ap->id);

DEBUG

>  
>  	/* software reset.  causes dev0 to be selected */
>  	if (ap->flags & ATA_FLAG_MMIO) {
> @@ -2686,10 +2680,11 @@ int ata_std_softreset(struct ata_port *a
>  	ap->ops->dev_select(ap, 0);
>  
>  	/* issue bus reset */
> -	DPRINTK("about to softreset, devmask=%x\n", devmask);
> +	ata_port_printk(ap, ATA_MSG_CMD, "%s: about to softreset, devmask=%x\n",
> +			__FUNCTION__, devmask);

DEBUG

>  	err_mask = ata_bus_softreset(ap, devmask);
>  	if (err_mask) {
> -		ata_port_printk(ap, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
> +		ata_port_printk(ap, ATA_MSG_ERR, "SRST failed (err_mask=0x%x)\n",
>  				err_mask);
>  		return -EIO;
>  	}
> @@ -3107,7 +3106,8 @@ static unsigned int ata_dev_set_xfermode
>  	unsigned int err_mask;
>  
>  	/* set up set-features taskfile */
> -	DPRINTK("set features - xfer mode\n");
> +	ata_dev_printk(dev, ATA_MSG_CMD, "%s: set features - xfer mode\n", 
> +			__FUNCTION__);

DEBUG

>  
>  	ata_tf_init(dev, &tf);
>  	tf.command = ATA_CMD_SET_FEATURES;
> @@ -3145,7 +3146,8 @@ static unsigned int ata_dev_init_params(
>  		return AC_ERR_INVALID;
>  
>  	/* set up init dev params taskfile */
> -	DPRINTK("init dev params \n");
> +	ata_dev_printk(dev, ATA_MSG_CMD, "%s: init dev params \n", 
> +			__FUNCTION__);

VDEBUG, I think.

>  
>  	ata_tf_init(dev, &tf);
>  	tf.command = ATA_CMD_INIT_DEV_PARAMS;
> @@ -3456,7 +3466,8 @@ static int ata_sg_setup(struct ata_queue
>  	struct scatterlist *lsg = &sg[qc->n_elem - 1];
>  	int n_elem, pre_n_elem, dir, trim_sg = 0;
>  
> -	VPRINTK("ENTER, ata%u\n", ap->id);
> +	ata_port_printk(ap, ATA_MSG_SG, "%s: ENTER, ata%u\n", 
> +			__FUNCTION__, ap->id);

TRACE???  Not sure.

>  	WARN_ON(!(qc->flags & ATA_QCFLAG_SG));
>  
>  	/* we must lengthen transfers to end on a 32-bit boundary */
> @@ -3681,7 +3695,9 @@ static void ata_pio_sector(struct ata_qu
>  	page = nth_page(page, (offset >> PAGE_SHIFT));
>  	offset %= PAGE_SIZE;
>  
> -	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> +	ata_port_printk(ap, ATA_MSG_CMD, "%s: data %s\n", 
> +			__FUNCTION__,
> +			qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");

Yeap, this is CMD.  :-)

> @@ -5106,7 +5136,8 @@ int ata_port_start (struct ata_port *ap)
>  		return rc;
>  	}
>  
> -	DPRINTK("prd alloc, virt %p, dma %llx\n", ap->prd, (unsigned long long) ap->prd_dma);
> +	ata_port_printk(ap, ATA_MSG_VDEBUG, "%s: prd alloc, virt %p, dma %llx\n",
> +			__FUNCTION__, ap->prd, (unsigned long long) ap->prd_dma);

DEBUG.

>  
>  	return 0;
>  }
> @@ -5241,7 +5272,7 @@ static void ata_host_init(struct ata_por
>  	/* turn on all debugging levels */
>  	ap->msg_enable = 0x00FF;
>  #elif defined(ATA_DEBUG)
> -	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
> +	ap->msg_enable = ATA_MSG_VDEBUG | ATA_MSG_INFO | ATA_MSG_DRV | ATA_MSG_WARN | ATA_MSG_ERR;

I think it should be ATA_MSG_DEBUG | ATA_MSG_DRV | ATA_MSG_INFO | 
ATA_MSG_WARN | ATA_MSG_ERR.

>  #else
>  	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;

ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_WARN | ATA_MSG_ERR

>  	/* perform each probe synchronously */
> -	DPRINTK("probe begin\n");
> +	ata_port_printk(ap, ATA_MSG_VDEBUG, "%s: probe begin\n", __FUNCTION__);

DEBUG

>  	for (i = 0; i < count; i++) {
>  		struct ata_port *ap;
>  		u32 scontrol;
> @@ -5453,9 +5484,15 @@ int ata_device_add(const struct ata_prob
>  			/* wait for EH to finish */
>  			ata_port_wait_eh(ap);
>  		} else {
> -			DPRINTK("ata%u: bus probe begin\n", ap->id);
> +			ata_port_printk(ap, ATA_MSG_VDEBUG, 
> +					"%s: ata%u: bus probe begin\n", 
> +					__FUNCTION__, ap->id);

DEBUG

> +
>  			rc = ata_bus_probe(ap);
> -			DPRINTK("ata%u: bus probe end\n", ap->id);
> +
> +			ata_port_printk(ap, ATA_MSG_VDEBUG, 
> +					"%s: ata%u: bus probe end\n", 
> +					__FUNCTION__, ap->id);

DEBUG

>  
>  			if (rc) {
>  				/* FIXME: do something useful here?
> @@ -5469,7 +5506,8 @@ int ata_device_add(const struct ata_prob
>  	}
>  
>  	/* probes are done, now scan each port's disk(s) */
> -	DPRINTK("host probe begin\n");
> +	ata_port_printk(ap, ATA_MSG_VDEBUG, "%s: host probe begin\n",
> +			__FUNCTION__);

DEBUG

>  	for (i = 0; i < count; i++) {
>  		struct ata_port *ap = host_set->ports[i];
>  

-- 
tejun
