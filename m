From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc5] libata: be less verbose about hpa
Date: Wed, 27 Jun 2007 02:45:23 -0400
Message-ID: <46820783.2030501@garzik.org>
References: <467FAAF2.9080104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37964 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760103AbXF0GpZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 02:45:25 -0400
In-Reply-To: <467FAAF2.9080104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> There's no reason to print out hpa related messages when HPA is not
> active.  Kill the unconditional message and add a warning message
> which is printed if HPA size is smaller than the current size.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index adfae9d..deda684 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -983,11 +983,6 @@ static u64 ata_hpa_resize(struct ata_device *dev)
>  	else
>  		hpa_sectors = ata_read_native_max_address(dev);
>  
> -	/* if no hpa, both should be equal */
> -	ata_dev_printk(dev, KERN_INFO, "%s 1: sectors = %lld, "
> -				"hpa_sectors = %lld\n",
> -		__FUNCTION__, (long long)sectors, (long long)hpa_sectors);
> -
>  	if (hpa_sectors > sectors) {
>  		ata_dev_printk(dev, KERN_INFO,
>  			"Host Protected Area detected:\n"
> @@ -1009,7 +1004,11 @@ static u64 ata_hpa_resize(struct ata_device *dev)
>  				return hpa_sectors;
>  			}
>  		}
> -	}
> +	} else if (hpa_sectors < sectors)
> +		ata_dev_printk(dev, KERN_WARNING, "%s 1: hpa sectors (%lld) "
> +			       "is smaller than sectors (%lld)\n", __FUNCTION__,
> +			       (long long)hpa_sectors, (long long)sectors);
> +

applied


