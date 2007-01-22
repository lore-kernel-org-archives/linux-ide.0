From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/15] ide: fix UDMA/MWDMA/SWDMA masks
Date: Mon, 22 Jan 2007 19:19:13 +0300
Message-ID: <45B4E401.6070208@ru.mvista.com>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain> <20070119003226.14846.87052.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:35409 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751936AbXAVQTP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Jan 2007 11:19:15 -0500
In-Reply-To: <20070119003226.14846.87052.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] ide: fix UDMA/MWDMA/SWDMA masks

> * use 0x00 instead of 0x80 to disable ->{ultra,mwdma,swdma}_mask
> * add udma_mask field to ide_pci_device_t and use it to initialize
>   ->ultra_mask in aec62xx, pdc202xx_new and pdc202xx_old drivers
> * fix UDMA masks to match with chipset specific *_ratemask()
>   (alim15x3, hpt366, serverworks and siimage drivers need UDMA mask
>    filtering method - done in the next patch)

    More nit picking (-:

> Index: b/drivers/ide/pci/cmd64x.c
> ===================================================================
> --- a/drivers/ide/pci/cmd64x.c
> +++ b/drivers/ide/pci/cmd64x.c
> @@ -695,9 +695,10 @@ static void __devinit init_hwif_cmd64x(i
>  	hwif->swdma_mask = 0x07;
>  
>  	if (dev->device == PCI_DEVICE_ID_CMD_643)
> -		hwif->ultra_mask = 0x80;
> +		hwif->ultra_mask = 0x00;
>  	if (dev->device == PCI_DEVICE_ID_CMD_646)
> -		hwif->ultra_mask = (class_rev > 0x04) ? 0x07 : 0x80;
> +		hwif->ultra_mask =
> +			(class_rev == 0x05 || class_rev == 0x07) ? 0x07 : 0x00;
>  	if (dev->device == PCI_DEVICE_ID_CMD_648)
>  		hwif->ultra_mask = 0x1f;

    Hm, well, this doesn't look consistent with the changes in other drivers.
This driver asks for explicit hwif->cds->ultra_mask initializers, IMO...
    You'd only have to check for PCI-646 revisions < 5 then...

> Index: b/drivers/ide/pci/piix.c
> ===================================================================
> --- a/drivers/ide/pci/piix.c
> +++ b/drivers/ide/pci/piix.c
> @@ -493,7 +493,7 @@ static void __devinit init_hwif_piix(ide
>  		case PCI_DEVICE_ID_INTEL_82371FB_0:
>  		case PCI_DEVICE_ID_INTEL_82371FB_1:
>  		case PCI_DEVICE_ID_INTEL_82371SB_1:
> -			hwif->ultra_mask = 0x80;
> +			hwif->ultra_mask = 0x00;
>  			break;
>  		case PCI_DEVICE_ID_INTEL_82371AB:
>  		case PCI_DEVICE_ID_INTEL_82443MX_1:
> @@ -501,6 +501,10 @@ static void __devinit init_hwif_piix(ide
>  		case PCI_DEVICE_ID_INTEL_82801AB_1:
>  			hwif->ultra_mask = 0x07;
>  			break;
> +		case PCI_DEVICE_ID_INTEL_82801AA_1:
> +		case PCI_DEVICE_ID_INTEL_82372FB_1:
> +			hwif->ultra_mask = 0x1f;
> +			break;

    Alas, I'm afraid this part is wrong!
    At least, the cable detection should work for 82801AA the same way as for 
the 82801Bx and newer chips, if Intel's datasheet is to be trusted... I think 
we should fall thru here.

>  		default:
>  			if (!hwif->udma_four)
>  				hwif->udma_four = piix_cable_detect(hwif);

    This one also certainly asks for explicit hwif->cds->ultra_mask 
initializers... Thus almost all of this switch statement could go away...

MBR, Sergei
