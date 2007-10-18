From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/15] ide: remove ->dma_master field from ide_hwif_t
Date: Thu, 18 Oct 2007 21:08:25 +0400
Message-ID: <47179309.1090906@ru.mvista.com>
References: <200710012339.39304.bzolnier@gmail.com> <47039024.3090705@ru.mvista.com> <4704EA51.3040707@ru.mvista.com> <200710082303.58761.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:44457 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764416AbXJRRIO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 13:08:14 -0400
In-Reply-To: <200710082303.58761.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>Index: b/drivers/ide/pci/hpt366.c
>>>>===================================================================
>>>>--- a/drivers/ide/pci/hpt366.c
>>>>+++ b/drivers/ide/pci/hpt366.c
>>>>@@ -845,32 +845,33 @@ static int hpt374_ide_dma_end(ide_drive_

>>>   This just asks to be:

>>    No, it doesn't cause that way one would only break it.

>>>> static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
>>>> {

>>>    unsigned long base = hwif->extra_base;

>>    Sorry for a thinko. All offsets below shoud be really 0x6x, not 0x5x...

> Here we go again... :)

> [PATCH] ide: remove ->dma_master field from ide_hwif_t (take 4)

> * Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
>   pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.

> * Remove no longer needed ->dma_master field from ide_hwif_t.

> v2:
> * Use the more readable 'hwif->dma_base - (hwif->channel * 8)' instead of
>   pci_resource_start(hwif->pci_dev, 4).

> v3:
> * Use hwif->extra_base in hpt366/pdc20xx_old + some cosmetic fixups over v2
>   (suggested by Sergei).

    Huh? I don't see where you're using extra_base in hpt366.c

> v4:
> * Correct offsets in hpt3xxn_set_clock().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Unfortunately, I have to NAK the patch... :-/

> Index: b/drivers/ide/pci/hpt366.c
> ===================================================================
> --- a/drivers/ide/pci/hpt366.c
> +++ b/drivers/ide/pci/hpt366.c
> @@ -845,32 +845,33 @@ static int hpt374_ide_dma_end(ide_drive_
>  
>  static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
>  {
> -	u8 scr2 = inb(hwif->dma_master + 0x7b);
> +	unsigned long base = hwif->dma_base - (hwif->channel * 8);

    Should be hwif->extra_base - 0x10 or else the following code will touch 
all the wrong/reserved registers; one also can use hwif->extra_base ISO 'base' 
and change all the offsets to 0x6x...

> +	u8 scr2 = inb(base + 0x6b);
>  
>  	if ((scr2 & 0x7f) == mode)
>  		return;
>  
>  	/* Tristate the bus */
> -	outb(0x80, hwif->dma_master + 0x73);
> -	outb(0x80, hwif->dma_master + 0x77);
> +	outb(0x80, base + 0x63);
> +	outb(0x80, base + 0x67);

>  	/* Switch clock and reset channels */
> -	outb(mode, hwif->dma_master + 0x7b);
> -	outb(0xc0, hwif->dma_master + 0x79);
> +	outb(mode, base + 0x6b);
> +	outb(0xc0, base + 0x69);
>  
>  	/*
>  	 * Reset the state machines.
>  	 * NOTE: avoid accidentally enabling the disabled channels.
>  	 */
> -	outb(inb(hwif->dma_master + 0x70) | 0x32, hwif->dma_master + 0x70);
> -	outb(inb(hwif->dma_master + 0x74) | 0x32, hwif->dma_master + 0x74);
> +	outb(inb(base + 0x60) | 0x32, base + 0x60);
> +	outb(inb(base + 0x64) | 0x32, base + 0x64);
>  
>  	/* Complete reset */
> -	outb(0x00, hwif->dma_master + 0x79);
> +	outb(0x00, base + 0x69);
>  
>  	/* Reconnect channels to bus */
> -	outb(0x00, hwif->dma_master + 0x73);
> -	outb(0x00, hwif->dma_master + 0x77);
> +	outb(0x00, base + 0x63);
> +	outb(0x00, base + 0x67);
>  }

    Huh? That's wrong -- if you're setting base to the value of the former 
value of hwof->dma_master, the register offsets shouldn't change!

> Index: b/drivers/ide/pci/pdc202xx_old.c
> ===================================================================
> --- a/drivers/ide/pci/pdc202xx_old.c
> +++ b/drivers/ide/pci/pdc202xx_old.c
> @@ -193,7 +193,7 @@ static void pdc202xx_old_ide_dma_start(i
>  	if (drive->media != ide_disk || drive->addressing == 1) {
>  		struct request *rq	= HWGROUP(drive)->rq;
>  		ide_hwif_t *hwif	= HWIF(drive);
> -		unsigned long high_16   = hwif->dma_master;
> +		unsigned long high_16	= hwif->extra_base - 16;
>  		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);

    That 'high_16' is *not* a good name in this case -- it would've been if we 
didn't subtract 16. So, I'd wrote:

  		unsigned long atapi_reg	= hwif->extra_base +
					 (hwif->channel ? 0x14 : 0x10);

> @@ -212,7 +212,7 @@ static int pdc202xx_old_ide_dma_end(ide_
>  {
>  	if (drive->media != ide_disk || drive->addressing == 1) {
>  		ide_hwif_t *hwif	= HWIF(drive);
> -		unsigned long high_16	= hwif->dma_master;
> +		unsigned long high_16	= hwif->extra_base - 16;
>  		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
>  		u8 clock		= 0;

    Same here...

> @@ -228,7 +228,7 @@ static int pdc202xx_old_ide_dma_end(ide_
>  static int pdc202xx_old_ide_dma_test_irq(ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
> -	unsigned long high_16	= hwif->dma_master;
> +	unsigned long high_16	= hwif->extra_base - 16;
>  	u8 dma_stat		= inb(hwif->dma_status);
>  	u8 sc1d			= inb(high_16 + 0x001d);

    ... and here...

> @@ -271,7 +271,7 @@ static void pdc202xx_dma_timeout(ide_dri
>  
>  static void pdc202xx_reset_host (ide_hwif_t *hwif)
>  {
> -	unsigned long high_16	= hwif->dma_master;
> +	unsigned long high_16	= hwif->extra_base - 16;
>  	u8 udma_speed_flag	= inb(high_16 | 0x001f);

    ... and here too.

>  	outb(udma_speed_flag | 0x10, high_16 | 0x001f);

MBR, Sergei
