From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: fix drive side 80c cable check
Date: Mon, 5 Feb 2007 11:18:37 +0000
Message-ID: <20070205111837.1981bda2@localhost.localdomain>
References: <20070205074713.GF1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33073 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751453AbXBELG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 06:06:57 -0500
In-Reply-To: <20070205074713.GF1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, bzolnier@gmail.com, stable@kernel.org, linux-ide@vger.kernel.org

On Mon, 5 Feb 2007 16:47:13 +0900
Tejun Heo <htejun@gmail.com> wrote:

> The 80c wire bit is bit 13, not 14.  This increases the chance of
> incorrect wire detection especially because host side cable detection
> is often unreliable and we sometimes soley depend on drive side cable
> detection.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Please consider for -stable.
> 
>  drivers/ide/ide-iops.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: work/drivers/ide/ide-iops.c
> ===================================================================
> --- work.orig/drivers/ide/ide-iops.c
> +++ work/drivers/ide/ide-iops.c
> @@ -604,7 +604,7 @@ u8 eighty_ninty_three (ide_drive_t *driv
>  	if (!(drive->id->hw_config & 0x6000))
>  		return 0;
>  #ifndef CONFIG_IDEDMA_IVB
> -	if(!(drive->id->hw_config & 0x4000))
> +	if (!(drive->id->hw_config & 0x2000))
>  		return 0;
>  #endif /* CONFIG_IDEDMA_IVB */

NAK

While the old code is a mess, your changes don't fix it. The code above
is correct before you touch it as far as I can tell. Incomplete but
correct as far as it went.

The logic in the function as far as it goes is correct

If neither valid bit nor 80pin bit set -> 40pin		[00]
If checking valid bit && valid bit clear -> 40pin	[0x]

The 0x2000 test is needed as an additional test (as per the
ide_ata66_check function directly below)		[10] v [11]

Without this an id value of 0x2000 will trigger 80pin but is not valid.

(the IDEDMA_IVB check is more relaxted to handle some confused ATA4
drives, and is probably something we don't want in libata anyway, or
should blacklist the afflicted for this)

Alan
