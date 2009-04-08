From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] libata: add CFA specific identify data words
Date: Wed, 08 Apr 2009 15:46:59 +0400
Message-ID: <49DC8EB3.4040404@ru.mvista.com>
References: <200903032029.29073.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56454 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932929AbZDHLqU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 07:46:20 -0400
In-Reply-To: <200903032029.29073.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:

> Declare and use constants for CFA specific identify data words 162 and 163.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Jeff, have you forgotten about this one too?

> Index: linux-2.6/drivers/ata/libata-core.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/libata-core.c
> +++ linux-2.6/drivers/ata/libata-core.c
> @@ -1650,8 +1650,8 @@ unsigned long ata_id_xfermask(const u16 
>  		/*
>  		 *	Process compact flash extended modes
>  		 */
> -		int pio = id[163] & 0x7;
> -		int dma = (id[163] >> 3) & 7;
> +		int pio = (id[ATA_ID_CFA_MODES] >> 0) & 0x7;
> +		int dma = (id[ATA_ID_CFA_MODES] >> 3) & 0x7;
>  
>  		if (pio)
>  			pio_mask |= (1 << 5);
> @@ -2408,7 +2408,8 @@ int ata_dev_configure(struct ata_device 
>  	/* ATA-specific feature tests */
>  	if (dev->class == ATA_DEV_ATA) {
>  		if (ata_id_is_cfa(id)) {
> -			if (id[162] & 1) /* CPRM may make this media unusable */
> +			/* CPRM may make this media unusable */
> +			if (id[ATA_ID_CFA_KEY_MGMT] & 1)
>  				ata_dev_printk(dev, KERN_WARNING,
>  					       "supports DRM functions and may "
>  					       "not be fully accessable.\n");

MBR, Sergei
