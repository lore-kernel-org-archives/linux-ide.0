From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Can't disable IDE DMA on 2.6.0-test9 (patch)
Date: Mon, 8 Dec 2003 02:39:58 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200312080239.58602.bzolnier@elka.pw.edu.pl>
References: <16317.18623.912339.111750@wombat.disy.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45758 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265273AbTLHBiA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Dec 2003 20:38:00 -0500
In-Reply-To: <16317.18623.912339.111750@wombat.disy.cse.unsw.edu.au>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Friday 21 of November 2003 00:05, Peter Chubb wrote:
> Hi Folks,

Hi,

>    If you try to disable IDE DMA from Kconfig, you'll end up with an
> undefined symbol, ide_hwif_setup_dma().
>
> The attached rather ugly patch fixes the problem by defining a dummy
> function.

Not exactly.  Disable IDE DMA and enable support for every PCI chipset.
Now try to compile... welcome to compile time hell :-).

To do this properly you have to fix almost every PCI chipset driver
(by adding many CONFIG_BLK_DEV_IDEDMA_PCI #ifdefs).

--bart

> ===== setup-pci.c 1.19 vs edited =====
> --- 1.19/drivers/ide/setup-pci.c	Sat Oct 18 01:22:22 2003
> +++ edited/setup-pci.c	Wed Nov 19 13:52:25 2003
> @@ -474,6 +474,11 @@
>   *	state
>   */
>
> +#ifndef CONFIG_BLK_DEV_IDEDMA_PCI
> +static void ide_hwif_setup_dma(struct pci_dev *dev, ide_pci_device_t *d,
> ide_hwif_t *hwif) +{
> +}
> +#else
>  static void ide_hwif_setup_dma(struct pci_dev *dev, ide_pci_device_t *d,
> ide_hwif_t *hwif) {
>  	u16 pcicmd;
> @@ -516,6 +521,7 @@
>  		}
>  	}
>  }
> +#endif /* CONFIG_BLK_DEV_IDEDMA_PCI*/
>
>  /**
>   *	ide_setup_pci_controller	-	set up IDE PCI

