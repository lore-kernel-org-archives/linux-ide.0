From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: fix drive side 80c cable check, take 2
Date: Mon, 5 Feb 2007 13:28:49 +0000
Message-ID: <20070205132849.484e97a1@localhost.localdomain>
References: <20070205074713.GF1625@htj.dyndns.org>
	<20070205111837.1981bda2@localhost.localdomain>
	<20070205124713.GL1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54404 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932417AbXBENRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 08:17:10 -0500
In-Reply-To: <20070205124713.GL1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: bzolnier@gmail.com, stable@kernel.org, linux-ide@vger.kernel.org

On Mon, 5 Feb 2007 21:47:13 +0900
Tejun Heo <htejun@gmail.com> wrote:

> eighty_ninty_three() had word 93 validitity check but not the 80c bit
> test itself (bit 12).  This increases the chance of incorrect wire
> detection especially because host side cable detection is often
> unreliable and we sometimes soley depend on drive side cable
> detection.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Ah... thanks.  That explains the code much better.  Fixed accordingly.
> 
> diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> index badde63..6558055 100644
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -607,6 +607,8 @@ u8 eighty_ninty_three (ide_drive_t *drive)
>  	if(!(drive->id->hw_config & 0x4000))
>  		return 0;
>  #endif /* CONFIG_IDEDMA_IVB */
> +	if (!(drive->id->hw_config & 0x2000))
> +		return 0;
>  	return 1;

Acked-by: Alan Cox <alan@redhat.com>
