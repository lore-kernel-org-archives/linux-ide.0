From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 02/15] libata: zero xfer length on ATAPI data xfer IRQ
 is HSM violation
Date: Thu, 06 Dec 2007 14:44:23 +0800
Message-ID: <47579A47.9090908@tw.ibm.com>
References: <11968405951262-git-send-email-htejun@gmail.com> <11968405953773-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:58592 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbXLFGou (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2007 01:44:50 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB65h33F012141
	for <linux-ide@vger.kernel.org>; Thu, 6 Dec 2007 00:43:03 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id lB66iaMu112298
	for <linux-ide@vger.kernel.org>; Wed, 5 Dec 2007 23:44:36 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lB66iZOW009653
	for <linux-ide@vger.kernel.org>; Wed, 5 Dec 2007 23:44:36 -0700
In-Reply-To: <11968405953773-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> From: Albert Lee <albertcc@tw.ibm.com>
> 
> Treat zero xfer length as HSM violation.  While at it, add
> unlikely()'s to ATAPI ireason and transfer length checks.
> 
> tj: Formatted patch and added unlikely()'s.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 597e07c..88f7637 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5280,12 +5280,15 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
>  	bytes = (bc_hi << 8) | bc_lo;
>  
>  	/* shall be cleared to zero, indicating xfer of data */
> -	if (ireason & (1 << 0))
> +	if (unlikely(ireason & (1 << 0)))
>  		goto err_out;
>  
>  	/* make sure transfer direction matches expected */
>  	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
> -	if (do_write != i_write)
> +	if (unlikely(do_write != i_write))
> +		goto err_out;
> +
> +	if (unlikely(!bytes))
>  		goto err_out;
>  
>  	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);


Looks good.

Acked-by: Albert Lee <albertcc@tw.ibm.com>

