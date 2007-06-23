From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/6] ide: add ide_pci_device_t.host_flags
Date: Sat, 23 Jun 2007 23:19:13 +0400
Message-ID: <467D7231.7080701@ru.mvista.com>
References: <200706232005.50076.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15369 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752440AbXFWTRc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 15:17:32 -0400
In-Reply-To: <200706232005.50076.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> * Rename ide_pci_device_t.flags to ide_pci_device_t.host_flags
>   and IDEPCI_FLAG_ISA_PORTS flag to IDE_HFLAG_ISA_PORTS.

    Erm, do you intend also adding device_flags field? :-O ;-)

> * Add IDE_HFLAG_SINGLE flag for single channel devices.

> * Convert core code and all IDE PCI drivers to use IDE_HFLAG_SINGLE
>   and remove no longer needed ide_pci_device_t.channels field.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Sorry, NAK this one. ;-)

> Index: b/drivers/ide/pci/hpt366.c
> ===================================================================
> --- a/drivers/ide/pci/hpt366.c
> +++ b/drivers/ide/pci/hpt366.c
> @@ -1490,7 +1490,7 @@ static int __devinit init_setup_hpt366(s
>  		 * HPT36x chips are single channel and
>  		 * do not seem to have the channel enable bit...
>  		 */
> -		d->channels = 1;
> +		d->host_flags |= IDE_HFLAG_SINGLE;
>  		d->enablebits[0].reg = 0;

    Probablly worth submitting a patch to fix up the enablebit here...
Well, one we get Linas HPT366/Maxtor issue sorted out...

>  		d->udma_mask = HPT366_ALLOW_ATA66_3 ?
> Index: b/drivers/ide/pci/scc_pata.c
> ===================================================================
> --- a/drivers/ide/pci/scc_pata.c
> +++ b/drivers/ide/pci/scc_pata.c
> @@ -731,9 +731,9 @@ static void __devinit init_hwif_scc(ide_
>        .init_setup	= init_setup_scc,		\
>        .init_iops	= init_iops_scc,		\
>        .init_hwif	= init_hwif_scc,		\
> -      .channels	= 1,					\
>        .autodma	= AUTODMA,				\
>        .bootable	= ON_BOARD,				\
> +      .host_flags = IDE_HFLAG_SINGLE,			\

    Erm, why misaligned?

> Index: b/drivers/ide/pci/serverworks.c
> ===================================================================
> --- a/drivers/ide/pci/serverworks.c
> +++ b/drivers/ide/pci/serverworks.c
> @@ -448,9 +448,12 @@ static int __devinit init_setup_csb6 (st
>  			d->bootable = ON_BOARD;
>  	}
>  
> -	d->channels = ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
> -			dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
> -		       (!(PCI_FUNC(dev->devfn) & 1))) ? 1 : 2;
> +	if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
> +	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&

    I'd have left that aligning space alone. :-)

> +	    (!(PCI_FUNC(dev->devfn) & 1)))
> +		d->host_flags |= IDE_HFLAG_SINGLE;
> +	else
 > +		d->host_flags &= IDE_HFLAG_SINGLE;

    Here's the offending code! Should've been:

		d->host_flags &= ~IDE_HFLAG_SINGLE;

>  	return ide_setup_pci_device(dev, d);
>  }
> @@ -485,17 +485,17 @@ static ide_pci_device_t serverworks_chip
>  		.init_setup	= init_setup_csb6,
>  		.init_chipset	= init_chipset_svwks,
>  		.init_hwif	= init_hwif_svwks,
> -		.channels	= 1,	/* 2 */
>  		.autodma	= AUTODMA,
>  		.bootable	= ON_BOARD,
> +		.host_flags	= IDE_HFLAG_SINGLE,
>  	},{	/* 4 */
>  		.name		= "SvrWks HT1000",
>  		.init_setup	= init_setup_svwks,
>  		.init_chipset	= init_chipset_svwks,
>  		.init_hwif	= init_hwif_svwks,
> -		.channels	= 1,	/* 2 */
>  		.autodma	= AUTODMA,
>  		.bootable	= ON_BOARD,
> +		.host_flags	= IDE_HFLAG_SINGLE,
>  	}
>  };

MBR, Sergei
