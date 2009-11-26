From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 36/86] pata_it8213: add UDMA100 and UDMA133 support
Date: Thu, 26 Nov 2009 18:05:12 +0300
Message-ID: <4B0E9928.2020809@ru.mvista.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125170637.5446.77089.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:60919 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1760574AbZKZPET (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 10:04:19 -0500
In-Reply-To: <20091125170637.5446.77089.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> There shouldn't be any problems with it as IDE it8213 host driver
> has been supporting UDMA100 and UDMA133 for years.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ata/pata_it8213.c
> ===================================================================
> --- a/drivers/ata/pata_it8213.c
> +++ b/drivers/ata/pata_it8213.c
> @@ -164,7 +164,7 @@ static void it8213_set_dmamode (struct a
>  
>  		/* Clocks follow the PIIX style */
>  		u_speed = min(2 - (udma & 1), udma);
> -		if (udma == 5)
> +		if (udma > 4)
>  			u_clock = 0x1000;	/* 100Mhz */
>  		else if (udma > 2)
>  			u_clock = 1;		/* 66Mhz */
> @@ -264,7 +264,7 @@ static int it8213_init_one (struct pci_d
>  		.flags		= ATA_FLAG_SLAVE_POSS,
>  		.pio_mask	= ATA_PIO4,
>  		.mwdma_mask	= ATA_MWDMA2,
> -		.udma_mask 	= ATA_UDMA4, /* FIXME: want UDMA 100? */
> +		.udma_mask 	= ATA_UDMA6,
>  		.port_ops	= &it8213_ops,
>  	};
>  	/* Current IT8213 stuff is single port */

    Well, at 100 MHz it's probably not really UDMA6 but UDMA5 in disguise... 
though u_speed would be 2 instead of 1 which should correspond to either 3 
clocks or 1 clock according to Intel's documentation (different Intel docs 
give different figures and even ICH PRM gives *both* clocks).
    IOW, I doubt that 'it8213' is correct. Anybody has the datasheet?

MBR, Sergei
