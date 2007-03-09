From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_hpt37x: Updates from drivers/ide work
Date: Fri, 09 Mar 2007 18:03:58 +0300
Message-ID: <45F1775E.5050703@ru.mvista.com>
References: <20070308232852.37b0ed54@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:43053 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932715AbXCIPEL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 10:04:11 -0500
In-Reply-To: <20070308232852.37b0ed54@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Alan Cox wrote:
> Drag pata_hpt37x kicking and screaming in the direction of
> drivers/ide/pci/hpt366.c and all the work that Sergei has been doing
> there. Plenty left to be done but this is a good snapshot for folks to
> work on and to review

> Signed-off-by: Alan Cox <alan@redhat.com>

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt37x.c linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt37x.c
> --- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt37x.c	2007-03-08 16:01:10.000000000 +0000
> +++ linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt37x.c	2007-03-08 17:08:53.000000000 +0000
> @@ -8,6 +8,7 @@
>   * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
>   * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
>   * Portions Copyright (C) 2003		Red Hat Inc
> + * Portions Copyright (C) 2005-2006	MontaVista Software, Inc.
>   *
>   * TODO
>   *	PLL mode
> @@ -25,7 +26,7 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME	"pata_hpt37x"
> -#define DRV_VERSION	"0.6.0"
> +#define DRV_VERSION	"0.6.4"
>  
>  struct hpt_clock {
>  	u8	xfer_speed;
> @@ -61,201 +62,75 @@
>   * 31     FIFO enable.
>   */
>  
> -/* from highpoint documentation. these are old values */
> -static const struct hpt_clock hpt370_timings_33[] = {
> -/*	{	XFER_UDMA_5,	0x1A85F442,	0x16454e31	}, */
> -	{	XFER_UDMA_5,	0x16454e31	},
> -	{	XFER_UDMA_4,	0x16454e31	},
> -	{	XFER_UDMA_3,	0x166d4e31	},
> -	{	XFER_UDMA_2,	0x16494e31	},
> -	{	XFER_UDMA_1,	0x164d4e31	},
> -	{	XFER_UDMA_0,	0x16514e31	},
> -
> -	{	XFER_MW_DMA_2,	0x26514e21	},
> -	{	XFER_MW_DMA_1,	0x26514e33	},
> -	{	XFER_MW_DMA_0,	0x26514e97	},
> -
> -	{	XFER_PIO_4,	0x06514e21	},
> -	{	XFER_PIO_3,	0x06514e22	},
> -	{	XFER_PIO_2,	0x06514e33	},
> -	{	XFER_PIO_1,	0x06914e43	},
> -	{	XFER_PIO_0,	0x06914e57	},
> -	{	0,		0x06514e57	}
> -};
> -
> -static const struct hpt_clock hpt370_timings_66[] = {
> -	{	XFER_UDMA_5,	0x14846231	},
> -	{	XFER_UDMA_4,	0x14886231	},
> -	{	XFER_UDMA_3,	0x148c6231	},
> -	{	XFER_UDMA_2,	0x148c6231	},
> -	{	XFER_UDMA_1,	0x14906231	},
> -	{	XFER_UDMA_0,	0x14986231	},
> -
> -	{	XFER_MW_DMA_2,	0x26514e21	},
> -	{	XFER_MW_DMA_1,	0x26514e33	},
> -	{	XFER_MW_DMA_0,	0x26514e97	},
> -
> -	{	XFER_PIO_4,	0x06514e21	},
> -	{	XFER_PIO_3,	0x06514e22	},
> -	{	XFER_PIO_2,	0x06514e33	},
> -	{	XFER_PIO_1,	0x06914e43	},
> -	{	XFER_PIO_0,	0x06914e57	},
> -	{	0,		0x06514e57	}
> -};
> -
> -/* these are the current (4 sep 2001) timings from highpoint */
> -static const struct hpt_clock hpt370a_timings_33[] = {
> -	{	XFER_UDMA_5,	0x12446231	},
> -	{	XFER_UDMA_4,	0x12446231	},
> -	{	XFER_UDMA_3,	0x126c6231	},
> -	{	XFER_UDMA_2,	0x12486231	},
> -	{	XFER_UDMA_1,	0x124c6233	},
> -	{	XFER_UDMA_0,	0x12506297	},
> -
> -	{	XFER_MW_DMA_2,	0x22406c31	},
> -	{	XFER_MW_DMA_1,	0x22406c33	},
> -	{	XFER_MW_DMA_0,	0x22406c97	},
> -
> -	{	XFER_PIO_4,	0x06414e31	},
> -	{	XFER_PIO_3,	0x06414e42	},
> -	{	XFER_PIO_2,	0x06414e53	},
> -	{	XFER_PIO_1,	0x06814e93	},
> -	{	XFER_PIO_0,	0x06814ea7	},
> -	{	0,		0x06814ea7	}
> -};
> -
> -/* 2x 33MHz timings */
> -static const struct hpt_clock hpt370a_timings_66[] = {
> -	{	XFER_UDMA_5,	0x1488e673	},
> -	{	XFER_UDMA_4,	0x1488e673	},
> -	{	XFER_UDMA_3,	0x1498e673	},
> -	{	XFER_UDMA_2,	0x1490e673	},
> -	{	XFER_UDMA_1,	0x1498e677	},
> -	{	XFER_UDMA_0,	0x14a0e73f	},
> -
> -	{	XFER_MW_DMA_2,	0x2480fa73	},
> -	{	XFER_MW_DMA_1,	0x2480fa77	},
> -	{	XFER_MW_DMA_0,	0x2480fb3f	},
> -
> -	{	XFER_PIO_4,	0x0c82be73	},
> -	{	XFER_PIO_3,	0x0c82be95	},
> -	{	XFER_PIO_2,	0x0c82beb7	},
> -	{	XFER_PIO_1,	0x0d02bf37	},
> -	{	XFER_PIO_0,	0x0d02bf5f	},
> -	{	0,		0x0d02bf5f	}
> -};
> -
> -static const struct hpt_clock hpt370a_timings_50[] = {
> -	{	XFER_UDMA_5,	0x12848242	},
> -	{	XFER_UDMA_4,	0x12ac8242	},
> -	{	XFER_UDMA_3,	0x128c8242	},
> -	{	XFER_UDMA_2,	0x120c8242	},
> -	{	XFER_UDMA_1,	0x12148254	},
> -	{	XFER_UDMA_0,	0x121882ea	},
> -
> -	{	XFER_MW_DMA_2,	0x22808242	},
> -	{	XFER_MW_DMA_1,	0x22808254	},
> -	{	XFER_MW_DMA_0,	0x228082ea	},
> -
> -	{	XFER_PIO_4,	0x0a81f442	},
> -	{	XFER_PIO_3,	0x0a81f443	},
> -	{	XFER_PIO_2,	0x0a81f454	},
> -	{	XFER_PIO_1,	0x0ac1f465	},
> -	{	XFER_PIO_0,	0x0ac1f48a	},
> -	{	0,		0x0ac1f48a	}
> -};
> -
> -static const struct hpt_clock hpt372_timings_33[] = {
> -	{	XFER_UDMA_6,	0x1c81dc62	},
> -	{	XFER_UDMA_5,	0x1c6ddc62	},
> -	{	XFER_UDMA_4,	0x1c8ddc62	},
> -	{	XFER_UDMA_3,	0x1c8edc62	},	/* checkme */
> -	{	XFER_UDMA_2,	0x1c91dc62	},
> -	{	XFER_UDMA_1,	0x1c9adc62	},	/* checkme */
> -	{	XFER_UDMA_0,	0x1c82dc62	},	/* checkme */
> -
> -	{	XFER_MW_DMA_2,	0x2c829262	},
> -	{	XFER_MW_DMA_1,	0x2c829266	},	/* checkme */
> -	{	XFER_MW_DMA_0,	0x2c82922e	},	/* checkme */
> -
> -	{	XFER_PIO_4,	0x0c829c62	},
> -	{	XFER_PIO_3,	0x0c829c84	},
> -	{	XFER_PIO_2,	0x0c829ca6	},
> -	{	XFER_PIO_1,	0x0d029d26	},
> -	{	XFER_PIO_0,	0x0d029d5e	},
> -	{	0,		0x0d029d5e	}
> -};
> -
> -static const struct hpt_clock hpt372_timings_50[] = {
> -	{	XFER_UDMA_5,	0x12848242	},
> -	{	XFER_UDMA_4,	0x12ac8242	},
> -	{	XFER_UDMA_3,	0x128c8242	},
> -	{	XFER_UDMA_2,	0x120c8242	},
> -	{	XFER_UDMA_1,	0x12148254	},
> -	{	XFER_UDMA_0,	0x121882ea	},
> -
> -	{	XFER_MW_DMA_2,	0x22808242	},
> -	{	XFER_MW_DMA_1,	0x22808254	},
> -	{	XFER_MW_DMA_0,	0x228082ea	},
> -
> -	{	XFER_PIO_4,	0x0a81f442	},
> -	{	XFER_PIO_3,	0x0a81f443	},
> -	{	XFER_PIO_2,	0x0a81f454	},
> -	{	XFER_PIO_1,	0x0ac1f465	},
> -	{	XFER_PIO_0,	0x0ac1f48a	},
> -	{	0,		0x0a81f443	}
> -};
> -
> -static const struct hpt_clock hpt372_timings_66[] = {
> -	{	XFER_UDMA_6,	0x1c869c62	},
> -	{	XFER_UDMA_5,	0x1cae9c62	},
> -	{	XFER_UDMA_4,	0x1c8a9c62	},
> -	{	XFER_UDMA_3,	0x1c8e9c62	},
> -	{	XFER_UDMA_2,	0x1c929c62	},
> -	{	XFER_UDMA_1,	0x1c9a9c62	},
> -	{	XFER_UDMA_0,	0x1c829c62	},
> -
> -	{	XFER_MW_DMA_2,	0x2c829c62	},
> -	{	XFER_MW_DMA_1,	0x2c829c66	},
> -	{	XFER_MW_DMA_0,	0x2c829d2e	},
> -
> -	{	XFER_PIO_4,	0x0c829c62	},
> -	{	XFER_PIO_3,	0x0c829c84	},
> -	{	XFER_PIO_2,	0x0c829ca6	},
> -	{	XFER_PIO_1,	0x0d029d26	},
> -	{	XFER_PIO_0,	0x0d029d5e	},
> -	{	0,		0x0d029d26	}
> -};
> -
> -static const struct hpt_clock hpt374_timings_33[] = {
> -	{	XFER_UDMA_6,	0x12808242	},
> -	{	XFER_UDMA_5,	0x12848242	},
> -	{	XFER_UDMA_4,	0x12ac8242	},
> -	{	XFER_UDMA_3,	0x128c8242	},
> -	{	XFER_UDMA_2,	0x120c8242	},
> -	{	XFER_UDMA_1,	0x12148254	},
> -	{	XFER_UDMA_0,	0x121882ea	},
> -
> -	{	XFER_MW_DMA_2,	0x22808242	},
> -	{	XFER_MW_DMA_1,	0x22808254	},
> -	{	XFER_MW_DMA_0,	0x228082ea	},
> -
> -	{	XFER_PIO_4,	0x0a81f442	},
> -	{	XFER_PIO_3,	0x0a81f443	},
> -	{	XFER_PIO_2,	0x0a81f454	},
> -	{	XFER_PIO_1,	0x0ac1f465	},
> -	{	XFER_PIO_0,	0x0ac1f48a	},
> -	{	0,		0x06814e93	}
> +static struct hpt_clock hpt37x_timings_33[] = {
> +	{ XFER_UDMA_6,		0x12446231 },	/* 0x12646231 ?? */
> +	{ XFER_UDMA_5,		0x12446231 },
> +	{ XFER_UDMA_4,		0x12446231 },
> +	{ XFER_UDMA_3,		0x126c6231 },
> +	{ XFER_UDMA_2,		0x12486231 },
> +	{ XFER_UDMA_1,		0x124c6233 },
> +	{ XFER_UDMA_0,		0x12506297 },
> +
> +	{ XFER_MW_DMA_2,	0x22406c31 },
> +	{ XFER_MW_DMA_1,	0x22406c33 },
> +	{ XFER_MW_DMA_0,	0x22406c97 },
> +
> +	{ XFER_PIO_4,		0x06414e31 },
> +	{ XFER_PIO_3,		0x06414e42 },
> +	{ XFER_PIO_2,		0x06414e53 },
> +	{ XFER_PIO_1,		0x06814e93 },
> +	{ XFER_PIO_0,		0x06814ea7 }
> +};
> +
> +static struct hpt_clock hpt37x_timings_50[] = {
> +	{ XFER_UDMA_6,		0x12848242 },
> +	{ XFER_UDMA_5,		0x12848242 },
> +	{ XFER_UDMA_4,		0x12ac8242 },
> +	{ XFER_UDMA_3,		0x128c8242 },
> +	{ XFER_UDMA_2,		0x120c8242 },
> +	{ XFER_UDMA_1,		0x12148254 },
> +	{ XFER_UDMA_0,		0x121882ea },
> +
> +	{ XFER_MW_DMA_2,	0x22808242 },
> +	{ XFER_MW_DMA_1,	0x22808254 },
> +	{ XFER_MW_DMA_0,	0x228082ea },
> +
> +	{ XFER_PIO_4,		0x0a81f442 },
> +	{ XFER_PIO_3,		0x0a81f443 },
> +	{ XFER_PIO_2,		0x0a81f454 },
> +	{ XFER_PIO_1,		0x0ac1f465 },
> +	{ XFER_PIO_0,		0x0ac1f48a }
> +};
> +
> +static struct hpt_clock hpt37x_timings_66[] = {
> +	{ XFER_UDMA_6,		0x1c869c62 },
> +	{ XFER_UDMA_5,		0x1cae9c62 },	/* 0x1c8a9c62 */
> +	{ XFER_UDMA_4,		0x1c8a9c62 },
> +	{ XFER_UDMA_3,		0x1c8e9c62 },
> +	{ XFER_UDMA_2,		0x1c929c62 },
> +	{ XFER_UDMA_1,		0x1c9a9c62 },
> +	{ XFER_UDMA_0,		0x1c829c62 },
> +
> +	{ XFER_MW_DMA_2,	0x2c829c62 },
> +	{ XFER_MW_DMA_1,	0x2c829c66 },
> +	{ XFER_MW_DMA_0,	0x2c829d2e },
> +
> +	{ XFER_PIO_4,		0x0c829c62 },
> +	{ XFER_PIO_3,		0x0c829c84 },
> +	{ XFER_PIO_2,		0x0c829ca6 },
> +	{ XFER_PIO_1,		0x0d029d26 },
> +	{ XFER_PIO_0,		0x0d029d5e }
>  };

    Yeah, I was going to cook a patch to remove broken tables for starters...

> +
>  static const struct hpt_chip hpt370 = {
>  	"HPT370",
>  	48,
>  	{
> -		hpt370_timings_33,
> +		hpt37x_timings_33,
>  		NULL,
>  		NULL,
> -		hpt370_timings_66
> +		hpt37x_timings_66
>  	}
>  };
>  
> @@ -263,10 +138,10 @@
>  	"HPT370A",
>  	48,
>  	{
> -		hpt370a_timings_33,
> +		hpt37x_timings_33,
>  		NULL,
> -		hpt370a_timings_50,
> -		hpt370a_timings_66
> +		hpt37x_timings_50,
> +		hpt37x_timings_66
>  	}
>  };

    HPT370 chips aren't clockable to 66MHz -- they neither support Ultra133 
nor are PCI66 capable.

> @@ -274,10 +149,10 @@
>  	"HPT372",
>  	55,
>  	{
> -		hpt372_timings_33,
> +		hpt37x_timings_33,
>  		NULL,
> -		hpt372_timings_50,
> -		hpt372_timings_66
> +		hpt37x_timings_50,
> +		hpt37x_timings_66
>  	}
>  };
>  
> @@ -285,10 +160,10 @@
>  	"HPT302",
>  	66,
>  	{
> -		hpt372_timings_33,
> +		hpt37x_timings_33,
>  		NULL,
> -		hpt372_timings_50,
> -		hpt372_timings_66
> +		hpt37x_timings_50,
> +		hpt37x_timings_66
>  	}
>  };
>  
> @@ -296,10 +171,10 @@
>  	"HPT371",
>  	66,
>  	{
> -		hpt372_timings_33,
> +		hpt37x_timings_33,
>  		NULL,
> -		hpt372_timings_50,
> -		hpt372_timings_66
> +		hpt37x_timings_50,
> +		hpt37x_timings_66
>  	}
>  };
>  
> @@ -307,10 +182,10 @@
>  	"HPT372A",
>  	66,
>  	{
> -		hpt372_timings_33,
> +		hpt37x_timings_33,
>  		NULL,
> -		hpt372_timings_50,
> -		hpt372_timings_66
> +		hpt37x_timings_50,
> +		hpt37x_timings_66
>  	}
>  };
>  
> @@ -318,7 +193,7 @@
>  	"HPT374",
>  	48,
>  	{
> -		hpt374_timings_33,
> +		hpt37x_timings_33,
>  		NULL,
>  		NULL,
>  		NULL

    But HPT374 is DPLL-clockable to 50 MHz!
    That effectivy means that we don't need the separate clock tables for each 
chip anymore -- they should be all the same, with only 66 MHz capability 
disabled for earlier chips (by other means)...

> @@ -463,8 +336,7 @@
>  		ap->cbl = ATA_CBL_PATA80;

    Erm, no cable_detect() here?

>  	/* Reset the state machine */
> -	pci_write_config_byte(pdev, 0x50, 0x37);
> -	pci_write_config_byte(pdev, 0x54, 0x37);
> +	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
>  	udelay(100);
>  
>  	return ata_std_prereset(ap, deadline);
> @@ -514,8 +386,7 @@
>  		ap->cbl = ATA_CBL_PATA80;
>  
>  	/* Reset the state machine */
> -	pci_write_config_byte(pdev, 0x50, 0x37);
> -	pci_write_config_byte(pdev, 0x54, 0x37);
> +	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
>  	udelay(100);
>  
>  	return ata_std_prereset(ap, deadline);
> @@ -1033,6 +904,24 @@
>  		.udma_mask = 0x3f,
>  		.port_ops = &hpt370a_port_ops
>  	};
> +	/* HPT370 - UDMA100 */
> +	static struct ata_port_info info_hpt370_33 = {
> +		.sht = &hpt37x_sht,
> +		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
> +		.pio_mask = 0x1f,
> +		.mwdma_mask = 0x07,
> +		.udma_mask = 0x0f,
> +		.port_ops = &hpt370_port_ops
> +	};
> +	/* HPT370A - UDMA100 */
> +	static struct ata_port_info info_hpt370a_33 = {
> +		.sht = &hpt37x_sht,
> +		.flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST,
> +		.pio_mask = 0x1f,
> +		.mwdma_mask = 0x07,
> +		.udma_mask = 0x0f,
> +		.port_ops = &hpt370a_port_ops
> +	};

    Well, these are clockable to Ultra/100 but my experiments have shown that 
it's slower than Ultra/66 (!).  And they needed a clock trunaround at this 
speed, according to 2.4.18 driver...
    Wait, wait, wait... why limit them to Ultra/44 on 33 MHz?! I certainly 
didn't do (or intend) anything alike... :-O

> @@ -1068,7 +957,11 @@
>  
>  	u8 irqmask;
>  	u32 class_rev;
> +	u8 mcr1;
>  	u32 freq;
> +	int prefer_dpll = 1;
> +	
> +	unsigned long iobase = pci_resource_start(dev, 4);
>  
>  	const struct hpt_chip *chip_table;
>  	int clock_slot;
> @@ -1089,10 +982,12 @@
>  			case 3:
>  				port = &info_hpt370;
>  				chip_table = &hpt370;
> +				prefer_dpll = 0;
>  				break;
>  			case 4:
>  				port = &info_hpt370a;
>  				chip_table = &hpt370a;
> +				prefer_dpll = 0;
>  				break;
>  			case 5:
>  				port = &info_hpt372;
> @@ -1120,8 +1015,16 @@
>  				chip_table = &hpt302;
>  				break;
>  			case PCI_DEVICE_ID_TTI_HPT371:
> +				if (class_rev > 1)
> +					return -ENODEV;
>  				port = &info_hpt372;
>  				chip_table = &hpt371;
> +				/* Single channel device, paster is not present
> +				   but the NIOS (or us for non x86) must mark it

    Earlier NIOSes (sic? :-) didn't do that either...

> +				   absent */
> +				pci_read_config_byte(dev, 0x50, &mcr1);
> +				mcr1 &= ~0x04;
> +				pci_write_config_byte(dev, 0x50, mcr1);
>  				break;
>  			case PCI_DEVICE_ID_TTI_HPT374:
>  				chip_table = &hpt374;
> @@ -1151,8 +1054,18 @@
>  	 */
>  
>  	pci_write_config_byte(dev, 0x5b, 0x23);
> +	
> +	/*
> +	 * HighPoint does this for HPT372A.
> +	 * NOTE: This register is only writeable via I/O space.
> +	 */
> +	if (chip_table == &hpt372a)
> +		outb(0x0e, iobase + 0x9c);
>  
> -	pci_read_config_dword(dev, 0x70, &freq);
> +	/* Some devices do not let this value be accessed via PCI space
> +	   according to the old driver */
> +
> +	freq = inl(iobase + 0x90);

    I wonder if any chips do let it... :-)

> @@ -1174,15 +1087,27 @@
>  	 *	Turn the frequency check into a band and then find a timing
>  	 *	table to match it.
>  	 */
> -
> +	 
>  	clock_slot = hpt37x_clock_slot(freq, chip_table->base);
> -	if (chip_table->clocks[clock_slot] == NULL) {
> +	if (chip_table->clocks[clock_slot] == NULL || prefer_dpll) {
>  		/*
>  		 *	We need to try PLL mode instead
> +		 *
> +		 *	For non UDMA133 capable devices we should
> +		 *	use a 50MHz DPLL by choice
>  		 */
> -		unsigned int f_low = (MHz[clock_slot] * chip_table->base) / 192;
> -		unsigned int f_high = f_low + 2;
> +		unsigned int f_low, f_high;
>  		int adjust;
> +		
> +		clock_slot = 2;
> +		if (port->udma_mask & 0xE0)
> +			clock_slot = 3;
> +		
> +		f_low = (MHz[clock_slot] * chip_table->base) / 192;
> +		f_high = f_low + 2;
> +
> +		/* Select the DPLL clock. */
> +		pci_write_config_byte(dev, 0x5b, 0x21);
>  
>  		for(adjust = 0; adjust < 8; adjust++) {
>  			if (hpt37x_calibrate_dpll(dev))
> @@ -1198,15 +1123,17 @@
>  			printk(KERN_WARNING "hpt37x: DPLL did not stabilize.\n");
>  			return -ENODEV;
>  		}
> -		/* Check if this works for all cases */
> -		port->private_data = (void *)hpt370_timings_66;
> +		if (clock_slot == 3)
> +			port->private_data = (void *)hpt37x_timings_66;
> +		else
> +			port->private_data = (void *)hpt37x_timings_50;
>  
>  		printk(KERN_INFO "hpt37x: Bus clock %dMHz, using DPLL.\n", MHz[clock_slot]);
>  	} else {
>  		port->private_data = (void *)chip_table->clocks[clock_slot];
>  		/*
>  		 *	Perform a final fixup. The 371 and 372 clock determines
> -		 *	if UDMA133 is available.
> +		 *	if UDMA133 is available. (FIXME: should we use DPLL then ?)
>  		 */
>  
>  		if (clock_slot == 2 && chip_table == &hpt372) {	/* 50Mhz */

    This else block won't be reachable with prefer_dpll == 1 anyway...

> @@ -1215,8 +1142,13 @@
>  				port = &info_hpt372_50;
>  			else BUG();
>  		}
> +		if (clock_slot < 2 && port == &info_hpt370)
> +			port = &info_hpt370_33;
> +		if (clock_slot < 2 && port == &info_hpt370a)
> +			port = &info_hpt370a_33;

    I didn't get this change at all... Ultra/66 is perfectly reachable at 33 
MHz PCI.

MBR, Sergei
