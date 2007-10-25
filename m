From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] [IDE] Add helper __ide_setup_pci_device()
Date: Thu, 25 Oct 2007 21:33:20 +0200
Message-ID: <200710252133.20992.bzolnier@gmail.com>
References: <09821349085390234lkjasdflkjasflkdj24746@havoc.gtf.org> <20071024234820.D91351F81A1@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:46373 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbXJYUGs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 16:06:48 -0400
Received: by ug-out-1314.google.com with SMTP id z38so572967ugc
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 13:06:46 -0700 (PDT)
In-Reply-To: <20071024234820.D91351F81A1@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@linux-foundation.org


[ The last few days were extra busy with pushing previously queued
  IDE bits upstream but I'm back to reviewing the new stuff. ]

Thanks for splitting your patch on smaller chunks.

On Thursday 25 October 2007, Jeff Garzik wrote:
> Like ide_setup_pci_device(), except with additional array argument
> 'u8 *idx' that permits low-level driver to become aware of its assigned
> hwifs.

I would prefer to avoid exporting this information to host drivers
if possible (they shouldn't need to know about higher-layer decisions,
plus this change opens the door for various "creative" abuses).

In case of sc1200 host driver fixes (patches #2-3/3) it should be
possible to remove the need for the below patch and at the same time
simplify sc1200 code further (more details in review of patch #2/2).

> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
> ---
>  drivers/ide/setup-pci.c |   17 ++++++++++++-----
>  include/linux/ide.h     |    1 +
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
> index 02d14bf..4960b9f 100644
> --- a/drivers/ide/setup-pci.c
> +++ b/drivers/ide/setup-pci.c
> @@ -666,12 +666,10 @@ out:
>  	return ret;
>  }
>  
> -int ide_setup_pci_device(struct pci_dev *dev, const struct ide_port_info *d)
> +int __ide_setup_pci_device(struct pci_dev *dev, const struct ide_port_info *d,
> +			   u8 *idx)
>  {
> -	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
> -	int ret;
> -
> -	ret = do_ide_setup_pci_device(dev, d, &idx[0], 1);
> +	int ret = do_ide_setup_pci_device(dev, d, idx, 1);
>  
>  	if (ret >= 0)
>  		ide_device_add(idx);
> @@ -679,6 +677,15 @@ int ide_setup_pci_device(struct pci_dev *dev, const struct ide_port_info *d)
>  	return ret;
>  }
>  
> +EXPORT_SYMBOL_GPL(__ide_setup_pci_device);
> +
> +int ide_setup_pci_device(struct pci_dev *dev, const struct ide_port_info *d)
> +{
> +	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
> +
> +	return __ide_setup_pci_device(dev, d, &idx[0]);
> +}
> +
>  EXPORT_SYMBOL_GPL(ide_setup_pci_device);
>  
>  int ide_setup_pci_devices(struct pci_dev *dev1, struct pci_dev *dev2,
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index 4ed4777..3404fb9 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -1244,6 +1244,7 @@ struct ide_port_info {
>  	u8			udma_mask;
>  };
>  
> +int __ide_setup_pci_device(struct pci_dev *, const struct ide_port_info *, u8 *);
>  int ide_setup_pci_device(struct pci_dev *, const struct ide_port_info *);
>  int ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, const struct ide_port_info *);

