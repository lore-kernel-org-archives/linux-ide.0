From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: [PATCH] pata_pcmcia: another memory card support
Date: Thu, 6 Nov 2008 20:55:22 +0900
Message-ID: <20081106205522.1c86a44b.komurojun-mbn@nifty.com>
References: <200811061144.35556.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <200811061144.35556.marc.pignat@hevs.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Marc Pignat <marc.pignat@hevs.ch>
Cc: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi,

Could you post the output of lspcmcia -vv?

I think it is better to use "PCMCIA_DEVICE_PROD_ID12"
instead of "PCMCIA_DEVICE_PROD_ID2"

> +	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),


Best Regards
Komuro


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
> 
> _______________________________________________
> Linux PCMCIA reimplementation list
> http://lists.infradead.org/mailman/listinfo/linux-pcmcia


-- 
Komuro <komurojun-mbn@nifty.com>
