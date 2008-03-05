From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 3/3] pata: "I do not think it means, what you think it means."
Date: Wed, 5 Mar 2008 02:34:40 +0100
Message-ID: <200803050234.40594.bzolnier@gmail.com>
References: <200803042316.m24NGI7k002489@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:49334 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935155AbYCEBVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 20:21:47 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3004124ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 04 Mar 2008 17:21:46 -0800 (PST)
In-Reply-To: <200803042316.m24NGI7k002489@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, linux-kernel@vger.kernel.org


Jeff,

Could we get this merged ASAP (it was first posted on 26th February)?

This patch fixes data corruption for libata PATA ServerWorks and HPT drivers.

[ IDE users are already leaving happy life since they are not affected
  (modes masking has always worked correctly in the original drivers)...

  Can we make life happy also for libata PATA users? :) ]

On Wednesday 05 March 2008, akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> When masking mask out the modes that are unsupported not the ones that are
> supported.  This makes life happier.
> 
> [akpm@linux-foundation.org: coding-style fixes]
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_hpt366.c      |    6 +++---
>  drivers/ata/pata_hpt37x.c      |    6 +++---
>  drivers/ata/pata_serverworks.c |    2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff -puN drivers/ata/pata_hpt366.c~pata-i-do-not-think-it-means-what-you-think-it-means drivers/ata/pata_hpt366.c
> --- a/drivers/ata/pata_hpt366.c~pata-i-do-not-think-it-means-what-you-think-it-means
> +++ a/drivers/ata/pata_hpt366.c
> @@ -27,7 +27,7 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME	"pata_hpt366"
> -#define DRV_VERSION	"0.6.1"
> +#define DRV_VERSION	"0.6.2"
>  
>  struct hpt_clock {
>  	u8	xfer_speed;
> @@ -180,9 +180,9 @@ static unsigned long hpt366_filter(struc
>  		if (hpt_dma_blacklisted(adev, "UDMA",  bad_ata33))
>  			mask &= ~ATA_MASK_UDMA;
>  		if (hpt_dma_blacklisted(adev, "UDMA3", bad_ata66_3))
> -			mask &= ~(0x07 << ATA_SHIFT_UDMA);
> +			mask &= ~(0xF8 << ATA_SHIFT_UDMA);
>  		if (hpt_dma_blacklisted(adev, "UDMA4", bad_ata66_4))
> -			mask &= ~(0x0F << ATA_SHIFT_UDMA);
> +			mask &= ~(0xF0 << ATA_SHIFT_UDMA);
>  	}
>  	return ata_pci_default_filter(adev, mask);
>  }
> diff -puN drivers/ata/pata_hpt37x.c~pata-i-do-not-think-it-means-what-you-think-it-means drivers/ata/pata_hpt37x.c
> --- a/drivers/ata/pata_hpt37x.c~pata-i-do-not-think-it-means-what-you-think-it-means
> +++ a/drivers/ata/pata_hpt37x.c
> @@ -24,7 +24,7 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME	"pata_hpt37x"
> -#define DRV_VERSION	"0.6.9"
> +#define DRV_VERSION	"0.6.11"
>  
>  struct hpt_clock {
>  	u8	xfer_speed;
> @@ -281,7 +281,7 @@ static unsigned long hpt370_filter(struc
>  		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
>  			mask &= ~ATA_MASK_UDMA;
>  		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
> -			mask &= ~(0x1F << ATA_SHIFT_UDMA);
> +			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
>  	}
>  	return ata_pci_default_filter(adev, mask);
>  }
> @@ -297,7 +297,7 @@ static unsigned long hpt370a_filter(stru
>  {
>  	if (adev->class == ATA_DEV_ATA) {
>  		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
> -			mask &= ~ (0x1F << ATA_SHIFT_UDMA);
> +			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
>  	}
>  	return ata_pci_default_filter(adev, mask);
>  }
> diff -puN drivers/ata/pata_serverworks.c~pata-i-do-not-think-it-means-what-you-think-it-means drivers/ata/pata_serverworks.c
> --- a/drivers/ata/pata_serverworks.c~pata-i-do-not-think-it-means-what-you-think-it-means
> +++ a/drivers/ata/pata_serverworks.c
> @@ -226,7 +226,7 @@ static unsigned long serverworks_csb_fil
>  
>  	for (i = 0; (p = csb_bad_ata100[i]) != NULL; i++) {
>  		if (!strcmp(p, model_num))
> -			mask &= ~(0x1F << ATA_SHIFT_UDMA);
> +			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
>  	}
>  	return ata_pci_default_filter(adev, mask);
>  }
