From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/4] ide: add ide_dev_is_sata() helper
Date: Fri, 24 Aug 2007 22:49:14 +0400
Message-ID: <46CF282A.9020601@ru.mvista.com>
References: <200708192259.08171.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:44679 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763030AbXHXSqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2007 14:46:38 -0400
In-Reply-To: <200708192259.08171.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

> Make the SATA drive detection code from eighty_ninty_three() into inline
> ide_dev_is_sata() helper fixing it along the way to be more strict while
> checking word 80 for the reserved values...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

[...]
> Index: linux-2.6/drivers/ide/ide-iops.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide-iops.c
> +++ linux-2.6/drivers/ide/ide-iops.c
> @@ -580,8 +580,7 @@ u8 eighty_ninty_three (ide_drive_t *driv
>  	if (hwif->cbl != ATA_CBL_PATA80)
>  		goto no_80w;
>  
> -	/* Check for SATA but only if we are ATA5 or higher */
> -	if (id->hw_config == 0 && (id->major_rev_num & 0x7FE0))
> +	if (ide_dev_is_sata(id))
>  		return 1;
>  
>  	/*
> Index: linux-2.6/include/linux/ide.h
> ===================================================================
> --- linux-2.6.orig/include/linux/ide.h
> +++ linux-2.6/include/linux/ide.h
> @@ -1380,6 +1380,19 @@ static inline int ide_dev_has_iordy(stru
>  	return ((id->field_valid & 2) && (id->capability & 8)) ? 1 : 0;
>  }
>  
> +static inline int ide_dev_is_sata(struct hd_driveid *id)
> +{
> +	/*
> +	 * See if word 93 is 0 AND drive is at least ATA-5 compatible
> +	 * making sure that word 80 is valid by flipping its MSB --
> +	 * this trick allows us to filter out reserved values of 0
> +	 * and 0xffff along with the earlier ATA revisions.
> +	 */
> +	if (id->hw_config == 0 && (id->major_rev_num ^ 0x8000) >= 0x8020)
> +		return 1;
> +	return 0;
> +}
> +

    The same could have been achieved more simply:

	if (id->hw_config == 0 && (short}id->major_rev_num >= 0x0020

    so I'll probably recast...

MBR, Sergei
