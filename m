From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-core.c: restore configuration boot messages in
 ata_dev_configure()
Date: Tue, 27 Jun 2006 21:25:26 +0900
Message-ID: <44A123B6.20000@gmail.com>
References: <20060627073335.GA6237@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:51732 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932124AbWF0MZJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jun 2006 08:25:09 -0400
Received: by nz-out-0102.google.com with SMTP id z31so1622374nzd
        for <linux-ide@vger.kernel.org>; Tue, 27 Jun 2006 05:25:09 -0700 (PDT)
In-Reply-To: <20060627073335.GA6237@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux IDE ML <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Borislav Petkov wrote:
> Hi Tejun, Jeff,
>    is this one like what you had in mind? I left out the ENTER/EXIT printk's
>    since they are debug level. By the way, should I convert the dbg message
>    levels to the scheme you both proposed now while not everything is converted
>    or wait first. However, i'd rather do it now since it is less work than
>    later :)?

IMHO, this should be done in the following steps.

* define ATA_MSG_* and ata_msg_* macros which map 1:1 to the current 
message levels.

* make ata_*_prink()s use ATA_MSG_* instead of KERN_* and embed 
ata_msg_enable() into ata_*_printk()s.  Convert ALL ata_*_printk()s and 
convertible DEBUG/VDEBUG()s in single sweep - it doesn't have to be a 
single patch but post them together.  These conversions touch a lot of 
places and other patches have to be regenerated afterward.

* define more ATA_MSG_* and convert.

> This restores the default libata configuration messages printed during booting.
> 
> Signed-off-by: <petkov@math.uni-muenster.de>
> 
> 
> --- libata-dev/drivers/scsi/libata-core.c.orig2	2006-06-27 09:21:44.000000000 +0200
> +++ libata-dev/drivers/scsi/libata-core.c	2006-06-27 09:23:54.000000000 +0200
> @@ -1359,11 +1359,10 @@ int ata_dev_configure(struct ata_device 
>  			       __FUNCTION__, ap->id, dev->devno);
>  
>  	/* print device capabilities */
> -	if (ata_msg_probe(ap))
> -		ata_dev_printk(dev, KERN_DEBUG,
> -			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
> +	if (ata_msg_drv(ap))
> +		ata_dev_printk(dev, KERN_INFO,
> +			       "cfg 49:%04x 82:%04x 83:%04x 84:%04x "
>  			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
> -			       __FUNCTION__,
>  			       id[49], id[82], id[83], id[84],
>  			       id[85], id[86], id[87], id[88]);

This is a debug message and shouldn't be printed by default.

> @@ -1405,7 +1404,7 @@ int ata_dev_configure(struct ata_device 
>  			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
>  
>  			/* print device info to dmesg */
> -			if (ata_msg_info(ap))
> +			if (ata_msg_drv(ap))
>  				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
>  					"max %s, %Lu sectors: %s %s\n",
>  					ata_id_major_version(id),

This should be printed by default but only when @print_info is non-zero.

> @@ -1428,7 +1427,7 @@ int ata_dev_configure(struct ata_device 
>  			}
>  
>  			/* print device info to dmesg */
> -			if (ata_msg_info(ap))
> +			if (ata_msg_drv(ap))
>  				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
>  					"max %s, %Lu sectors: CHS %u/%u/%u\n",
>  					ata_id_major_version(id),

Ditto.

> @@ -1440,7 +1439,7 @@ int ata_dev_configure(struct ata_device 
>  
>  		if (dev->id[59] & 0x100) {
>  			dev->multi_count = dev->id[59] & 0xff;
> -			if (ata_msg_info(ap))
> +			if (ata_msg_drv(ap))
>  				ata_dev_printk(dev, KERN_INFO,
>  					"ata%u: dev %u multi count %u\n",
>  					ap->id, dev->devno, dev->multi_count);

Ditto.

> @@ -1469,7 +1468,7 @@ int ata_dev_configure(struct ata_device 
>  		}
>  
>  		/* print device info to dmesg */
> -		if (ata_msg_info(ap))
> +		if (ata_msg_drv(ap))
>  			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
>  				       ata_mode_string(xfer_mask),
>  				       cdb_intr_string);

Ditto.

> @@ -1483,7 +1482,7 @@ int ata_dev_configure(struct ata_device 
>  
>  	/* limit bridge transfers to udma5, 200 sectors */
>  	if (ata_dev_knobble(dev)) {
> -		if (ata_msg_info(ap))
> +		if (ata_msg_drv(ap))
>  			ata_dev_printk(dev, KERN_INFO,
>  				       "applying bridge limits\n");
>  		dev->udma_mask &= ATA_UDMA5;

Ditto.

And, now we're using ata_msg_drv() which is reserved for driver loading 
messages for info messages.  See how the scheme is broken?  :-p

Thanks.

-- 
tejun
