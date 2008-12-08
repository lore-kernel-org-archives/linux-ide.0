From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC PATCH] pata_hpt366: fix mode configuration
Date: Mon, 08 Dec 2008 13:40:40 +0300
Message-ID: <493CF9A8.301@ru.mvista.com>
References: <493CC897.9080406@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:31014 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751396AbYLHKkr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2008 05:40:47 -0500
In-Reply-To: <493CC897.9080406@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Hello.

Tejun Heo wrote:

> There have been reports of pata_hpt366 locking up the whole machine
> and as Mark kindly sent me his hpt366 about a year ago, I played with
> it a bit today.
>   

> The controller worked perfectly fine with the IDE driver but with
> pata_hpt366, PIO works but DMA mode locks up the machine solidly.
> After comparing the sources and lspci outputs, I found the following
> differences.
>
> 1. The case values for PCI clock speed selection seems wrong.  IDE
>    hpt366 uses 9 for 40Mhz and 5 for 25 not the other way around.
>   

   Yes, but that only concerns original HPT36x and should hardly matter 
as the BIOS seems to setup the timing registers only for 33 MHz PCI, and 
these 2 shouldn't even be eached.

> 2. IDE hpt366 uses different mask values for PIO, MWDMA and UDMA when
>    combining the old and new timing values but libata uses one value
>    for all.
>   

   Yes, I've fixed that stupidity. UltraDMA modes shouldn't force PIO4 
timings. However, the PIO and DMA masks were different from the start 
(though incorrect for HPT37x, IIRC)...

> 3. IDe hpt366 always turns off 0xC0000000 in the timing value but
>    pata_hpt366 doesn't.
>   

   Hm, that's strange... PIO_MST *must* be cleared and it's set in the 
timing tables.

> Removing the above three differences from pata_hpt366 makes it work
> happily, but I don't know anything about this controller so no
> sign-off yet.
>
> Alan, Mark, does this change look sane to you?
>
> Alan, it definitely seems we got something about the cable detection
> wrong.  libata can't see my 80c cable but IDE can.
>
> Thanks.
>
> RFC PATCH.  PLEASE DONT APPLY YET.
>   
Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
> index f2b83ea..64b3107 100644
> --- a/drivers/ata/pata_hpt366.c
> +++ b/drivers/ata/pata_hpt366.c
> @@ -188,25 +188,41 @@ static unsigned long hpt366_filter(struct ata_device *adev, unsigned long mask)
>  }
>  
>  /**
> - *	hpt36x_find_mode	-	reset the hpt36x bus
> + *	hpt36x_calc_timing	-	calculate timing value for transfer mode
>   *	@ap: ATA port
> - *	@speed: transfer mode
> + *	@cur_timing: current timing value
> + *	@speed: target transfer mode
>   *
>   *	Return the 32bit register programming information for this channel
>   *	that matches the speed provided.
>   */
>  
> -static u32 hpt36x_find_mode(struct ata_port *ap, int speed)
> +static u32 hpt36x_calc_timing(struct ata_port *ap, u32 cur_timing, int speed)
>  {
>  	struct hpt_clock *clocks = ap->host->private_data;
> +	u32 mask;
>  
> -	while(clocks->xfer_speed) {
> +	if (speed < XFER_MW_DMA_0)
> +		mask = 0xc1f8ffff;
> +	else if (speed < XFER_UDMA_0)
> +		mask = 0x303800ff;
> +	else
> +		mask = 0x30070000;
> +
> +	while (clocks->xfer_speed) {
>  		if (clocks->xfer_speed == speed)
> -			return clocks->timing;
> +			break;
>  		clocks++;
>  	}
>   

   Should really have been a *for* loop...

> @@ -247,11 +262,8 @@ static void hpt366_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	}
>  
>  	pci_read_config_dword(pdev, addr1, &reg);
> -	mode = hpt36x_find_mode(ap, adev->pio_mode);
> -	mode &= ~0x8000000;	/* No FIFO in PIO */
> -	mode &= ~0x30070000;	/* Leave config bits alone */
>   

   These are DMA enable bits and UDMA timings...

> @ -267,8 +279,7 @@ static void hpt366_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	u32 addr1, addr2;
> -	u32 reg;
> -	u32 mode;
> +	u32 reg, timing;
>  	u8 fast;
>  
>  	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
> @@ -282,11 +293,8 @@ static void hpt366_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  	}
>  
>  	pci_read_config_dword(pdev, addr1, &reg);
> -	mode = hpt36x_find_mode(ap, adev->dma_mode);
> -	mode |= 0x8000000;	/* FIFO in MWDMA or UDMA */
>   

   FIFO bit doesn't affect DMA modes.

> -	mode &= ~0xC0000000;	/* Leave config bits alone */
>   

  Oh, it's cleared right afterwards...
   Looks like with you change the set_dmamode() and set_piomode() 
methods are becoming sompletely similar, so it's probably worth to merge 
them...

MBR, Sergei


