From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 04/18] ide: remove ide_setup_dma()
Date: Sat, 21 Jun 2008 02:03:16 +0400
Message-ID: <485C2924.7040905@ru.mvista.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <20080620213350.13202.73557.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58555 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753145AbYFTWD0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jun 2008 18:03:26 -0400
In-Reply-To: <20080620213350.13202.73557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> Export sff_dma_ops and then remove ide_setup_dma().
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
>   
[...]
> Index: b/drivers/ide/arm/palm_bk3710.c
> ===================================================================
> --- a/drivers/ide/arm/palm_bk3710.c
> +++ b/drivers/ide/arm/palm_bk3710.c
> @@ -318,15 +318,14 @@ static u8 __devinit palm_bk3710_cable_de
>  static int __devinit palm_bk3710_init_dma(ide_hwif_t *hwif,
>  					  const struct ide_port_info *d)
>  {
> -	unsigned long base =
> -		hwif->io_ports.data_addr - IDE_PALM_ATA_PRI_REG_OFFSET;
> -
>  	printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
>  
>  	if (ide_allocate_dma_engine(hwif))
>  		return -1;
>  
> -	ide_setup_dma(hwif, base);
> +	hwif->dma_base = hwif->io_ports.data_addr - IDE_PALM_ATA_PRI_REG_OFFSET;
>   

   That's er... too complex. Actually, 'base' has the value for 
'dma_base' at that moment...

WBR, Sergei


