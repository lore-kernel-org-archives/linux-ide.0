From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata: rearrange dmesg info to add full ATA revision
Date: Wed, 31 Jan 2007 12:57:44 +0900
Message-ID: <45C013B8.8030600@gmail.com>
References: <20070131021051.GA3403@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10058 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846AbXAaD6L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 22:58:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so68437uga
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 19:58:10 -0800 (PST)
In-Reply-To: <20070131021051.GA3403@bounceswoosh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Hello, Eric.

Eric D. Mudama wrote:
> Per Jeff's suggestion, this patch rearranges the info printed for ATA
> drives into dmesg to add the full ATA firmware revision and model
> information, while keeping the output to 2 lines.
> 
> Signed-off-by: Eric D. Mudama <edmudama@gmail.com>

The patch is formatted and applies perfectly.  I'm glad to see this
change.  Just a few nits below.

>  	char revbuf[7];		/* XYZ-99\0 */
> +	char fwrevbuf[9];
> +	char modelbuf[41];

Please use ATA_ID_FW_REV_LEN + 1 and ATA_ID_PROD_LEN + 1.

> @@ -1680,13 +1692,18 @@ int ata_dev_configure(struct ata_device *dev)
>  			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
>  
>  			/* print device info to dmesg */
> -			if (ata_msg_drv(ap) && print_info)
> -				ata_dev_printk(dev, KERN_INFO, "%s, "
> -					"max %s, %Lu sectors: %s %s\n",
> +			if (ata_msg_drv(ap) && print_info) {
> +				ata_dev_printk(dev, KERN_INFO,
> +					"%s: %s, %s, max %s\n",
>  					revbuf,
> -					ata_mode_string(xfer_mask),
> +					modelbuf, fwrevbuf,

Please merge the above line with the line above it.

> +					ata_mode_string(xfer_mask));
> +				ata_dev_printk(dev, KERN_INFO,
> +					"%Lu sectors, multi %u: %s %s\n",
>  					(unsigned long long)dev->n_sectors,
> +					dev->multi_count,
>  					lba_desc, ncq_desc);

Ditto.

> +			}
>  		} else {
>  			/* CHS */
>  
> @@ -1703,22 +1720,19 @@ int ata_dev_configure(struct ata_device *dev)
>  			}
>  
>  			/* print device info to dmesg */
> -			if (ata_msg_drv(ap) && print_info)
> -				ata_dev_printk(dev, KERN_INFO, "%s, "
> -					"max %s, %Lu sectors: CHS %u/%u/%u\n",
> +			if (ata_msg_drv(ap) && print_info) {
> +				ata_dev_printk(dev, KERN_INFO,
> +					"%s: %s, %s, max %s\n",
>  					revbuf,
> -					ata_mode_string(xfer_mask),
> +					modelbuf, fwrevbuf,

Ditto.

> +					ata_mode_string(xfer_mask));
> +				ata_dev_printk(dev, KERN_INFO, 
> +					"%Lu sectors, multi %u, CHS %u/%u/%u\n",
>  					(unsigned long long)dev->n_sectors,
> +					dev->multi_count,
>  					dev->cylinders, dev->heads,
>  					dev->sectors);

I would prefer

dev->multi_count, dev->cylinders,
dev->heads, dev->sectors

Other than these,

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
