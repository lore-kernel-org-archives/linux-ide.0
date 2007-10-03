From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/15] ide: remove ->dma_master field from ide_hwif_t
Date: Wed, 03 Oct 2007 16:50:44 +0400
Message-ID: <47039024.3090705@ru.mvista.com>
References: <200710012339.39304.bzolnier@gmail.com> <200710020006.35156.bzolnier@gmail.com> <4701755C.4030906@garzik.org> <200710022324.01132.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.mvista.com ([63.81.120.155]:32248 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753232AbXJCMvF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 08:51:05 -0400
In-Reply-To: <200710022324.01132.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>>* Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
>>>>>  pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.

>>>>Before using pci_resource_start(), the code should check 
>>>>pci_resource_len() to ensure it is the appropriate size.

>>>>It would be very wise to ensure that pci_resource_flags()&IORESOURCE_IO 
>>>>is true, too.

>>>Sure but since the old code hasn't been doing these checks (old code
>>>just did pci_resource_start() -> hwif->dma_base -> hwif->dma_master)
>>>this is a separate issue from what the patch tries to achieve.

>>Nonetheless this is duplicating an existing bug $N times... not ideal :)

> The existing bug is that the methods converted to use pci_resource_start()
> may be set in hwif instance and used even if the BAR4 is invalid.  Therefore
> the above patch is correct and it isn't duplicating the existing bug. :)

> However I agree that all these pci_resource_start()s could be a bit confusing
> so here is 'take 2'.

    Yeah, they are.  Actually, I was thinking about such patch ~1.5 years ago 
*but* using a different approach -- namely, hwif->extra_base.

> [PATCH] ide: remove ->dma_master field from ide_hwif_t (take 2)

> * Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
>   pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.

> * Remove no longer needed ->dma_master field from ide_hwif_t.

> v2:
> * Use the more readable 'hwif->dma_base - (hwif->channel * 8)' instead of
>   pci_resource_start(hwif->pci_dev, 4).

    s/readable/clumsy/? ;-)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/ide-dma.c
> ===================================================================
> --- a/drivers/ide/ide-dma.c
> +++ b/drivers/ide/ide-dma.c
> @@ -1006,11 +1006,6 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
>  
>  	hwif->dma_base = base;
>  
> -	if (hwif->mate)
> -		hwif->dma_master = hwif->channel ? hwif->mate->dma_base : base;
> -	else
> -		hwif->dma_master = base;
> -
>  	if (!(hwif->dma_command))
>  		hwif->dma_command	= hwif->dma_base;
>  	if (!(hwif->dma_vendor1))

   Ugh, these extra parens... :-)

[...]
> Index: b/drivers/ide/pci/cmd64x.c
> ===================================================================
> --- a/drivers/ide/pci/cmd64x.c
> +++ b/drivers/ide/pci/cmd64x.c
> @@ -333,13 +333,14 @@ static void cmd64x_set_dma_mode(ide_driv
>  static int cmd648_ide_dma_end (ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
> +	unsigned long addr	= hwif->dma_base - (hwif->channel * 8) + 0x01;

    Dunno... pci_resource_start() looked better to my taste. Except I'd 
probably called the variable 'base' and wouldn't + 0x01 right away.

>  	int err			= __ide_dma_end(drive);
>  	u8  irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
>  						  MRDMODE_INTR_CH0;
> -	u8  mrdmode		= inb(hwif->dma_master + 0x01);
> +	u8  mrdmode		= inb(addr);
>  
>  	/* clear the interrupt bit */
> -	outb(mrdmode | irq_mask, hwif->dma_master + 0x01);
> +	outb(mrdmode | irq_mask, addr);
>  
>  	return err;
>  }
> @@ -364,10 +365,11 @@ static int cmd64x_ide_dma_end (ide_drive
>  static int cmd648_ide_dma_test_irq (ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
> +	unsigned long addr	= hwif->dma_base - (hwif->channel * 8) + 0x01;

    Same comment here...

>  	u8 irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
>  						  MRDMODE_INTR_CH0;
>  	u8 dma_stat		= inb(hwif->dma_status);
> -	u8 mrdmode		= inb(hwif->dma_master + 0x01);
> +	u8 mrdmode		= inb(addr);
>  
>  #ifdef DEBUG
>  	printk("%s: dma_stat: 0x%02x mrdmode: 0x%02x irq_mask: 0x%02x\n",
> Index: b/drivers/ide/pci/hpt366.c
> ===================================================================
> --- a/drivers/ide/pci/hpt366.c
> +++ b/drivers/ide/pci/hpt366.c
> @@ -845,32 +845,33 @@ static int hpt374_ide_dma_end(ide_drive_

    This just asks to be:

>  static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
>  {
	unsigned long base = hwif->extra_base;
	u8 scr2 = inb(base + 0x5b);

  	if ((scr2 & 0x7f) == mode)
  		return;

  	/* Tristate the bus */
	outb(0x80, base + 0x53);
	outb(0x80, base + 0x57);

  	/* Switch clock and reset channels */
	outb(mode, base + 0x5b);
	outb(0xc0, base + 0x59);

  	/*
  	 * Reset the state machines.
   	 * NOTE: avoid accidentally enabling the disabled channels.
  	 */
	outb(inb(base + 0x50) | 0x32, base + 0x50);
	outb(inb(base + 0x54) | 0x32, base + 0x54);

  	/* Complete reset */
	outb(0x00, base + 0x59);

	/* Reconnect channels to bus */
	outb(0x00, base + 0x53);
	outb(0x00, base + 0x57);
}

> Index: b/drivers/ide/pci/pdc202xx_old.c
> ===================================================================
> --- a/drivers/ide/pci/pdc202xx_old.c
> +++ b/drivers/ide/pci/pdc202xx_old.c
> @@ -162,7 +162,7 @@ static u8 pdc202xx_old_cable_detect (ide

    And this asks to be:

>   */
>  static void pdc_old_enable_66MHz_clock(ide_hwif_t *hwif)
>  {
> -	unsigned long clock_reg = hwif->dma_master + 0x11;
+	unsigned long clock_reg = hwif->extra_base + 0x01;

>  	u8 clock = inb(clock_reg);
>  
>  	outb(clock | (hwif->channel ? 0x08 : 0x02), clock_reg);
> @@ -170,7 +170,7 @@ static void pdc_old_enable_66MHz_clock(i
>  
>  static void pdc_old_disable_66MHz_clock(ide_hwif_t *hwif)
>  {
> -	unsigned long clock_reg = hwif->dma_master + 0x11;

+	unsigned long clock_reg = hwif->extra_base + 0x01;

>  	u8 clock = inb(clock_reg);
>  
>  	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
> @@ -193,7 +193,7 @@ static void pdc202xx_old_ide_dma_start(i
>  	if (drive->media != ide_disk || drive->addressing == 1) {
>  		struct request *rq	= HWGROUP(drive)->rq;
>  		ide_hwif_t *hwif	= HWIF(drive);
> -		unsigned long high_16   = hwif->dma_master;

+		unsigned long high_16	= hwif->extra_base;

>  		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
>  		u32 word_count	= 0;
>  		u8 clock = inb(high_16 + 0x11);
> @@ -212,7 +212,7 @@ static int pdc202xx_old_ide_dma_end(ide_
>  {
>  	if (drive->media != ide_disk || drive->addressing == 1) {
>  		ide_hwif_t *hwif	= HWIF(drive);
> -		unsigned long high_16	= hwif->dma_master;

+		unsigned long high_16	= hwif->extra_base;

>  		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
>  		u8 clock		= 0;
>  
> @@ -228,7 +228,7 @@ static int pdc202xx_old_ide_dma_end(ide_
>  static int pdc202xx_old_ide_dma_test_irq(ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
> -	unsigned long high_16	= hwif->dma_master;

+	unsigned long high_16	= hwif->extra_base;

>  	u8 dma_stat		= inb(hwif->dma_status);
>  	u8 sc1d			= inb(high_16 + 0x001d);
>  
> @@ -271,7 +271,7 @@ static void pdc202xx_dma_timeout(ide_dri
>  
>  static void pdc202xx_reset_host (ide_hwif_t *hwif)
>  {
> -	unsigned long high_16	= hwif->dma_master;
> +	unsigned long high_16	= hwif->dma_base - (hwif->channel * 8);

	unsigned long high_16	= hwif->extra_base;

>  	u8 udma_speed_flag	= inb(high_16 | 0x001f);

MBR, Sergei
