From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: cosmetic change in ata_bus_softreset()
Date: Fri, 24 Mar 2006 09:33:27 -0500
Message-ID: <44240337.8030509@pobox.com>
References: <20060324034556.GF25706@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14313 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751211AbWCXOdb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 09:33:31 -0500
In-Reply-To: <20060324034556.GF25706@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_bus_softreset() should return AC_ERR_* on failure not arbitrary
> positive number.  While at it, kill trailing indentations and reformat
> comment.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index f3c115b..200198c 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -1999,13 +1999,12 @@ static unsigned int ata_bus_softreset(st
>  	 */
>  	msleep(150);
>  
> -	
> -	/* Before we perform post reset processing we want to see if 
> -	   the bus shows 0xFF because the odd clown forgets the D7 pulldown
> -	   resistor */
> -	
> +	/* Before we perform post reset processing we want to see if
> +	 * the bus shows 0xFF because the odd clown forgets the D7
> +	 * pulldown resistor
> +	 */
>  	if (ata_check_status(ap) == 0xFF)
> -		return 1;	/* Positive is failure for some reason */
> +		return AC_ERR_OTHER;

agreed and will apply, though note:

The reason Alan did this is most likely because the only other function 
that produces a non-zero return code is ata_bus_edd->ata_busy_sleep, 
which returns 1.

Though really, we should rip out E.D.D. anyway....

	Jeff


