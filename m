From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_inic162x: disable LBA48 devices
Date: Mon, 02 Jul 2007 10:14:35 -0400
Message-ID: <4689084B.1050004@garzik.org>
References: <46846F64.7000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51881 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbXGBOOh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 10:14:37 -0400
In-Reply-To: <46846F64.7000201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>, greg.freemyer@gmail.com

Tejun Heo wrote:
> sata_inic162x can't do LBA48 properly yet and is likely to corrupt
> data on drives larger than LBA28 limit.  Disable LBA48 devices during
> device configuration.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/sata_inic162x.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> Index: work/drivers/ata/sata_inic162x.c
> ===================================================================
> --- work.orig/drivers/ata/sata_inic162x.c
> +++ work/drivers/ata/sata_inic162x.c
> @@ -496,6 +496,13 @@ static void inic_dev_config(struct ata_d
>  	/* inic can only handle upto LBA28 max sectors */
>  	if (dev->max_sectors > ATA_MAX_SECTORS)
>  		dev->max_sectors = ATA_MAX_SECTORS;
> +
> +	if (dev->n_sectors >= 1 << 28) {
> +		ata_dev_printk(dev, KERN_ERR,
> +	"ERROR: This driver doesn't support LBA48 yet and may cause\n"
> +	"                data corruption on such devices.  Disabling.\n");
> +		ata_dev_disable(dev);
> +	}

applied


