From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: Use ATA_FLAG_PIO_POLLING for pdc_adma
Date: Wed, 09 Aug 2006 08:59:49 -0400
Message-ID: <44D9DC45.9090703@rtr.ca>
References: <44D9BAA6.2050005@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:14990 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750747AbWHIM7v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 08:59:51 -0400
In-Reply-To: <44D9BAA6.2050005@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Albert Lee wrote:
> pdc_adma was overlooked and broken by the irq-pio patch:
> Only HSM_ST_LAST interrupts should be delivered to this LLDD.
> 
> Adding ATA_FLAG_PIO_POLLING to pdc_adma fixes the problem (temporarily),
> before we convert the irq handler of pdc_adma to handle all interrupts.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Signed-off-by: Mark Lord <mlord@pobox.com>

Looks good.  Note also that sata_qstor.c uses the same code structure,
and already does the same thing.

> ---
> Patch against 2.6.18-rc4 and tested ok by Tejun.
> 
> --- linux-2.6.18-rc4/drivers/scsi/pdc_adma.c	2006-08-08 14:03:21.000000000 +0800
> +++ linux-2.6.18-rc4-adma-poll/drivers/scsi/pdc_adma.c	2006-08-08 14:05:13.000000000 +0800
> @@ -183,7 +183,8 @@ static struct ata_port_info adma_port_in
>  	{
>  		.sht		= &adma_ata_sht,
>  		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
> -				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO,
> +				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
> +				  ATA_FLAG_PIO_POLLING,
>  		.pio_mask	= 0x10, /* pio4 */
>  		.udma_mask	= 0x1f, /* udma0-4 */
>  		.port_ops	= &adma_ata_ops,
> 

