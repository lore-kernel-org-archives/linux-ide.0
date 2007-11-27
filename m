From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 16/21] ide: add ide_init_port_hw() helper
Date: Tue, 27 Nov 2007 16:21:26 +0300
Message-ID: <474C19D6.7090108@ru.mvista.com>
References: <200711182328.15772.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42193 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756112AbXK0NVO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 08:21:14 -0500
In-Reply-To: <200711182328.15772.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Anton Vorontsov <avorontsov@ru.mvista.com>, Jeremy Higdon <jeremy@sgi.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Bartlomiej Zolnierkiewicz wrote:

> * Add ide_init_port_hw() helper.

> * rapide.c: convert rapide_locate_hwif() to rapide_setup_ports()
>   and use ide_init_port_hw().

> * ide_platform.c: convert plat_ide_locate_hwif() to plat_ide_setup_ports()
>   and use ide_init_port_hw().

> * sgiioc4.c: use ide_init_port_hw().

> * pmac.c: add 'hw_regs_t *hw' argument to pmac_ide_setup_device(),
>   setup 'hw' in pmac_ide_{macio,pci}_attach() and use ide_init_port_hw()
>   in pmac_ide_setup_device().

> This patch is a preparation for the future changes in the IDE probing code.

> There should be no functionality changes caused by this patch.

> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
> Cc: Jeremy Higdon <jeremy@sgi.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> @@ -1223,7 +1220,12 @@ pmac_ide_macio_attach(struct macio_dev *
>  #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
>  	dev_set_drvdata(&mdev->ofdev.dev, hwif);
>  
> -	rc = pmac_ide_setup_device(pmif, hwif);
> +	memset(&hw, 0, sizeof(hw));
> +	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, NULL);
> +	hw.irq = irq;
> +	hw.dev = &mdev->ofdev.dev;
> +
> +	rc = pmac_ide_setup_device(pmif, hwif, &hw);
>  	if (rc != 0) {
>  		/* The inteface is released to the common IDE layer */
>  		dev_set_drvdata(&mdev->ofdev.dev, NULL);
> @@ -1282,6 +1284,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
>  	void __iomem *base;
>  	unsigned long rbase, rlen;
>  	int i, rc;
> +	hw_regs_t hw;
>  
>  	np = pci_device_to_OF_node(pdev);
>  	if (np == NULL) {
> @@ -1315,7 +1318,6 @@ pmac_ide_pci_attach(struct pci_dev *pdev
>  	}
>  
>  	hwif->pci_dev = pdev;
> -	hwif->gendev.parent = &pdev->dev;
>  	pmif->mdev = NULL;
>  	pmif->node = np;
>  
> @@ -1332,7 +1334,12 @@ pmac_ide_pci_attach(struct pci_dev *pdev
>  
>  	pci_set_drvdata(pdev, hwif);
>  
> -	rc = pmac_ide_setup_device(pmif, hwif);
> +	memset(&hw, 0, sizeof(hw));
> +	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, NULL);

    It seems that the last argument to that function can be dropped now as the 
new code doesn't pass anything but NULL.

MBR, Sergei
