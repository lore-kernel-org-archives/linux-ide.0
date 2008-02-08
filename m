From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: problems using it as a platform_driver
Date: Thu, 07 Feb 2008 23:42:38 -0500
Message-ID: <47ABDDBE.4060607@rtr.ca>
References: <alpine.DEB.1.00.0802080113560.16853@git.byronbradley.co.uk> <alpine.DEB.1.00.0802080217070.16853@git.byronbradley.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1892 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760215AbYBHEmk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Feb 2008 23:42:40 -0500
In-Reply-To: <alpine.DEB.1.00.0802080217070.16853@git.byronbradley.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Byron Bradley <byron.bbradley@gmail.com>, saeed@marvell.com
Cc: linux-ide@vger.kernel.org, mlord@pobox.com, jeff@garzik.org, linux-arm-kernel@lists.arm.linux.org.uk

Byron Bradley wrote:
> On Fri, 8 Feb 2008, Byron Bradley wrote:
> 
>> I'm having problems getting the sata_mv driver working as a platform
>> driver on the QNAP TS-209 and the Linkstation/Kurobox (both are Marvell
>> Orion 88f5182 based devices). First of all it would oops in
>> mv_port_start() while calling dma_pool_alloc(), the patch to fix this is
>> at the end of this email.
>>
>> In mv_platform_probe() host->iomap is set to NULL but it is dereferenced
>> in mv_start_dma(), I'm not sure what the fix for this is. This is based on
>> the latest 2.6-git and a merge with the for-rmk branch of the orion git.
> 
> The following patch makes this driver work although I have no idea if this
> is the correct thing to do. Will this be OK for other devices using this
> driver? The pointer only works because it is dereferenced as
> iomap[MV_PRIMARY_BAR] and MV_PRIMARY_BAR = 0, will another offset ever be
> used in the future?
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 04b5717..b538ccc 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2950,8 +2950,8 @@ static int mv_platform_probe(struct platform_device *pdev)
>  	host->private_data = hpriv;
>  	hpriv->n_ports = n_ports;
> 
> -	host->iomap = NULL;
>  	hpriv->base = ioremap(res->start, res->end - res->start + 1);
> +	host->iomap = &hpriv->base;
>  	hpriv->base -= MV_SATAHC0_REG_BASE;
> 
>  	rc = mv_create_dma_pools(hpriv, &pdev->dev);
..

Well, that's definitely one way to attack it.

The original problem being, for a non-PCI device, there is no iomap[] table.
sata_mv only ever uses iomap[MV_PRIMARY_BAR=0], so the above patch should
work around it just fine.

Dunno how that maps to Jeff's taste in code, though.  :)
How do other platform drivers deal with this?

Saeed -- homework for you.

Cheers
