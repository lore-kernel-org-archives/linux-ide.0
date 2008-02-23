From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 08/10] IDE: Coding Style fixes to
	drivers/ide/pci/generic.c
Date: Sat, 23 Feb 2008 17:29:09 +0300
Message-ID: <20080223142909.GD6747@cvg>
References: <20080223150547.5256e734@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:24732 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbYBWO3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 09:29:40 -0500
Received: by wx-out-0506.google.com with SMTP id h31so731792wxd.4
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 06:29:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080223150547.5256e734@paolo-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

[Paolo Ciarrocchi - Sat, Feb 23, 2008 at 03:05:47PM +0100]
| File is now error free.
| Compile tested.
| 
| 
| Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
| ---
|  drivers/ide/pci/generic.c |   50 ++++++++++++++++++++++----------------------
|  1 files changed, 25 insertions(+), 25 deletions(-)
| 
| diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
| index f83afa1..f9a5879 100644
| --- a/drivers/ide/pci/generic.c
| +++ b/drivers/ide/pci/generic.c
| @@ -49,21 +49,21 @@ static const struct ide_port_info generic_chipsets[] __devinitdata = {
|  
|  	{	/* 1 */
|  		.name		= "NS87410",
| -		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
| +		.enablebits	= { {0x43, 0x08, 0x08}, {0x47, 0x08, 0x08} },
|  		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
|  		.swdma_mask	= ATA_SWDMA2,
|  		.mwdma_mask	= ATA_MWDMA2,
|  		.udma_mask	= ATA_UDMA6,
|  	},
|  
| -	/*  2 */ DECLARE_GENERIC_PCI_DEV("SAMURAI",	0),
| -	/*  3 */ DECLARE_GENERIC_PCI_DEV("HT6565",	0),
| -	/*  4 */ DECLARE_GENERIC_PCI_DEV("UM8673F",	IDE_HFLAGS_UMC),
| -	/*  5 */ DECLARE_GENERIC_PCI_DEV("UM8886A",	IDE_HFLAGS_UMC),
| -	/*  6 */ DECLARE_GENERIC_PCI_DEV("UM8886BF",	IDE_HFLAGS_UMC),
| -	/*  7 */ DECLARE_GENERIC_PCI_DEV("HINT_IDE",	0),
| -	/*  8 */ DECLARE_GENERIC_PCI_DEV("VIA_IDE",	IDE_HFLAG_NO_AUTODMA),
| -	/*  9 */ DECLARE_GENERIC_PCI_DEV("OPTI621V",	IDE_HFLAG_NO_AUTODMA),
| +	/*  2 */ DECLARE_GENERIC_PCI_DEV("SAMURAI", 0),
| +	/*  3 */ DECLARE_GENERIC_PCI_DEV("HT6565", 0),
| +	/*  4 */ DECLARE_GENERIC_PCI_DEV("UM8673F", IDE_HFLAGS_UMC),
| +	/*  5 */ DECLARE_GENERIC_PCI_DEV("UM8886A", IDE_HFLAGS_UMC),
| +	/*  6 */ DECLARE_GENERIC_PCI_DEV("UM8886BF", IDE_HFLAGS_UMC),
| +	/*  7 */ DECLARE_GENERIC_PCI_DEV("HINT_IDE", 0),
| +	/*  8 */ DECLARE_GENERIC_PCI_DEV("VIA_IDE", IDE_HFLAG_NO_AUTODMA),
| +	/*  9 */ DECLARE_GENERIC_PCI_DEV("OPTI621V", IDE_HFLAG_NO_AUTODMA),
|  
|  	{	/* 10 */
|  		.name		= "VIA8237SATA",
| @@ -89,7 +89,7 @@ static const struct ide_port_info generic_chipsets[] __devinitdata = {
|  	}
|  };
|  
| -/**
| +/*
^^^^^^^

Hi Paolo, it seems you just broke kdoc structure

|   *	generic_init_one	-	called when a PIIX is found
|   *	@dev: the generic device
|   *	@id: the matching pci id
| @@ -97,7 +97,7 @@ static const struct ide_port_info generic_chipsets[] __devinitdata = {
|   *	Called when the PCI registration layer (or the IDE initialization)
|   *	finds a device matching our IDE device tables.
|   */
| - 
| +
|  static int __devinit generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
|  {
|  	const struct ide_port_info *d = &generic_chipsets[id->driver_data];
| @@ -145,22 +145,22 @@ out:
|  }
|  
|  static const struct pci_device_id generic_pci_tbl[] = {
| -	{ PCI_VDEVICE(NS,	PCI_DEVICE_ID_NS_87410),		 1 },
| -	{ PCI_VDEVICE(PCTECH,	PCI_DEVICE_ID_PCTECH_SAMURAI_IDE),	 2 },
| -	{ PCI_VDEVICE(HOLTEK,	PCI_DEVICE_ID_HOLTEK_6565),		 3 },
| -	{ PCI_VDEVICE(UMC,	PCI_DEVICE_ID_UMC_UM8673F),		 4 },
| -	{ PCI_VDEVICE(UMC,	PCI_DEVICE_ID_UMC_UM8886A),		 5 },
| -	{ PCI_VDEVICE(UMC,	PCI_DEVICE_ID_UMC_UM8886BF),		 6 },
| -	{ PCI_VDEVICE(HINT,	PCI_DEVICE_ID_HINT_VXPROII_IDE),	 7 },
| -	{ PCI_VDEVICE(VIA,	PCI_DEVICE_ID_VIA_82C561),		 8 },
| -	{ PCI_VDEVICE(OPTI,	PCI_DEVICE_ID_OPTI_82C558),		 9 },
| +	{ PCI_VDEVICE(NS,	PCI_DEVICE_ID_NS_87410), 1 },
| +	{ PCI_VDEVICE(PCTECH,	PCI_DEVICE_ID_PCTECH_SAMURAI_IDE), 2 },
| +	{ PCI_VDEVICE(HOLTEK,	PCI_DEVICE_ID_HOLTEK_6565), 3 },
| +	{ PCI_VDEVICE(UMC,	PCI_DEVICE_ID_UMC_UM8673F), 4 },
| +	{ PCI_VDEVICE(UMC,	PCI_DEVICE_ID_UMC_UM8886A), 5 },
| +	{ PCI_VDEVICE(UMC,	PCI_DEVICE_ID_UMC_UM8886BF), 6 },
| +	{ PCI_VDEVICE(HINT,	PCI_DEVICE_ID_HINT_VXPROII_IDE), 7 },
| +	{ PCI_VDEVICE(VIA,	PCI_DEVICE_ID_VIA_82C561), 8 },
| +	{ PCI_VDEVICE(OPTI,	PCI_DEVICE_ID_OPTI_82C558), 9 },
|  #ifdef CONFIG_BLK_DEV_IDE_SATA
| -	{ PCI_VDEVICE(VIA,	PCI_DEVICE_ID_VIA_8237_SATA),		10 },
| +	{ PCI_VDEVICE(VIA,	PCI_DEVICE_ID_VIA_8237_SATA), 10 },
|  #endif
| -	{ PCI_VDEVICE(TOSHIBA,	PCI_DEVICE_ID_TOSHIBA_PICCOLO),		11 },
| -	{ PCI_VDEVICE(TOSHIBA,	PCI_DEVICE_ID_TOSHIBA_PICCOLO_1),	12 },
| -	{ PCI_VDEVICE(TOSHIBA,	PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),	13 },
| -	{ PCI_VDEVICE(NETCELL,	PCI_DEVICE_ID_REVOLUTION),		14 },
| +	{ PCI_VDEVICE(TOSHIBA,	PCI_DEVICE_ID_TOSHIBA_PICCOLO),	11 },
| +	{ PCI_VDEVICE(TOSHIBA,	PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), 12 },
| +	{ PCI_VDEVICE(TOSHIBA,	PCI_DEVICE_ID_TOSHIBA_PICCOLO_2), 13 },
| +	{ PCI_VDEVICE(NETCELL,	PCI_DEVICE_ID_REVOLUTION), 14 },
|  	/*
|  	 * Must come last.  If you add entries adjust
|  	 * this table and generic_chipsets[] appropriately.
| -- 
| 1.5.4.2.316.gf7a7
| 
		- Cyrill -
