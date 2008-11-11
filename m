From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_pcmcia: another memory card support
Date: Tue, 11 Nov 2008 03:02:23 -0500
Message-ID: <49193C0F.5000908@garzik.org>
References: <200811061144.35556.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32915 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294AbYKKIC3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 03:02:29 -0500
In-Reply-To: <200811061144.35556.marc.pignat@hevs.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Pignat <marc.pignat@hevs.ch>
Cc: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org

Marc Pignat wrote:
> Support for Apacer photo steno pro card.
> 
> Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
> ---
> 
> Hi all!
> 
> Here is a new ID for ide-cs and pata_pcmcia. I tried all the card
> I can find in the labs, only this one was unknown.
> 
> Best regards
> 
> Marc
> 
> 
> 
> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
> index 271cb64..64b2e22 100644
> --- a/drivers/ata/pata_pcmcia.c
> +++ b/drivers/ata/pata_pcmcia.c
> @@ -416,6 +416,7 @@ static struct pcmcia_device_id pcmcia_devices[] = {
>  	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
>  	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
>  	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
> +	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
>  	PCMCIA_DEVICE_NULL,
>  };
>  
> diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
> index cb199c8..f50210f 100644
> --- a/drivers/ide/ide-cs.c
> +++ b/drivers/ide/ide-cs.c
> @@ -444,6 +444,7 @@ static struct pcmcia_device_id ide_ids[] = {
>  	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
>  	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
>  	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
> +	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
>  	PCMCIA_DEVICE_NULL,
>  };
>  MODULE_DEVICE_TABLE(pcmcia, ide_ids);
> --

applied pata_pcmcia bit


