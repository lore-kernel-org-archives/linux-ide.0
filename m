From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Tue, 06 Jan 2009 01:41:25 +0300
Message-ID: <49628C95.7080507@ru.mvista.com>
References: <49615667.9020408@iwl.com> <4961F824.1090406@ru.mvista.com> <200901051736.18026.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:65473 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751323AbZAEWlc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2009 17:41:32 -0500
In-Reply-To: <200901051736.18026.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>> 2. The cs5535 ide driver doesn't seem to be able to recognize the
>>> newer CS5536 controller for IDE.
>>>       
>>    No wonder, it's even impossible to determine CS5536 IDE controller's 
>> device ID from the datasheet; include/linux/pci_ids.h tells me that the 
>> device ID is 0x209A, so adding another ID to the 'cs5535' driver's ID 
>> table shouldn't be an issue -- if they are indeed compatible. Looking at 
>> the datasheets, they are not -- bad luck, we need a new driver... BTW, 
>> libata seems to already have support for this chipset.
>>     
>
> Indeed...
>
> Karl, care to give a try to the following patch (it is completely untested
> so please backup your data first if necessary)?
>
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: add CS5536 host driver
>
> This is a port of libata's pata_cs5536.c (written by Martin K. Petersen)
> to IDE subsystem.
>
> Changes done while at it:
>
> * Reprogram PIO/MWDMA timings if needed before and after DMA transfer
>   (chipset uses shared PIO/MWDMA timings).
>   
> * Fix cable detection to report 80-wires cable if BIOS set it for any
>   device on a port (IDE core will do drive-side cable detection later).
>   

   The original pata_cs5536 cable detection is indeed somewhat bogus...

> * CS5536 is used mostly for driving CF cards and this allows use of
>   

   I woulnd't be so sure -- but anyway, I mostly see the development 
boards... :-)

> Cc: Martin K. Petersen <mkp@mkp.net>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Cc: Karl Auerbach <karl@iwl.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

   Looks good but needs some polishing...

> Index: b/drivers/ide/Kconfig
> ===================================================================
> --- a/drivers/ide/Kconfig
> +++ b/drivers/ide/Kconfig
> @@ -465,6 +465,16 @@ config BLK_DEV_CS5535
>  
>  	  It is safe to say Y to this question.
>  
> +config BLK_DEV_CS5536
> +	tristate "CS5536 chipset support"
> +	depends on X86 && !X86_64
>   

   Why not just depend on X86_32?

> Index: b/drivers/ide/cs5536.c
> ===================================================================
> --- /dev/null
> +++ b/drivers/ide/cs5536.c
> @@ -0,0 +1,303 @@
>   
[...]
> + * The IDE timing registers for the CS5536 live in the Geode Machine
> + * Specific Register file and not PCI config space.  Most BIOSes
> + * virtualize the PCI registers so the chip looks like a standard IDE
> + * controller.  Unfortunately not all implementations get this right.
> + * In particular some have problems with unaligned accesses to the
>   

   I'd say that people doing unaligned accesses are just looking for 
trouble... :-)

> +enum {
> +	MSR_IDE_CFG		= 0x51300010,
> +	PCI_IDE_CFG		= 0x40,
> +
> +	CFG			= 0,
> +	DTC			= 2,
> +	CAST			= 3,
> +	ETC			= 4,
> +
> +	IDE_CFG_CHANEN		= (1 << 1),
> +	IDE_CFG_CABLE		= (1 << 17) | (1 << 16),
> +
> +	IDE_D0_SHIFT		= 24,
> +	IDE_D1_SHIFT		= 16,
> +	IDE_DRV_MASK		= 0xff,
> +
> +	IDE_CAST_D0_SHIFT	= 6,
> +	IDE_CAST_D1_SHIFT	= 4,
> +	IDE_CAST_DRV_MASK	= 0x3,
> +
> +	IDE_CAST_CMD_SHIFT	= 24,
> +	IDE_CAST_CMD_MASK	= 0xff,
> +};
>   

   Declaring a lot of semi-related constants is not what enum was 
intended for I think...

> +static void cs5536_program_dtc(ide_drive_t *drive, u8 tim)
> +{
> +	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
> +	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
>   

   Masking with 1 is pointless (though harmless) for this single-channel 
controller.

> +/**
> + *	cs5536_set_pio_mode		-	PIO timing setup
> + *	@drive: ATA device
> + *	@pio: PIO mode number
> + */
> +
> +static void cs5536_set_pio_mode(ide_drive_t *drive, const u8 pio)
> +{
> +	static const u8 drv_timings[5] = {
> +		0x98, 0x55, 0x32, 0x21, 0x20,
> +	};
> +
> +	static const u8 addr_timings[5] = {
> +		0x2, 0x1, 0x0, 0x0, 0x0,
> +	};
> +
> +	static const u8 cmd_timings[5] = {
> +		0x99, 0x92, 0x90, 0x22, 0x20,
> +	};
> +
> +	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
> +	ide_drive_t *pair = ide_get_pair_dev(drive);
> +	int cshift = (drive->dn & 1) ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
>   

   Same comment...

> +	u32 cast;
> +	u8 cmd_pio = pio;
> +
> +	if (pair)
> +		cmd_pio = min(pio, ide_get_best_pio_mode(pair, 255, 4));
> +
> +	drive->drive_data &= 0xff00;

   IDE_DRV_MASK << 8?

> +/**
> + *	cs5536_set_dma_mode		-	DMA timing setup
> + *	@drive: ATA device
> + *	@mode: DMA mode
> + */
> +
> +static void cs5536_set_dma_mode(ide_drive_t *drive, const u8 mode)
> +{
> +	static const u8 udma_timings[6] = {
> +		0xc2, 0xc1, 0xc0, 0xc4, 0xc5, 0xc6,
> +	};
> +
> +	static const u8 mwdma_timings[3] = {
> +		0x67, 0x21, 0x20,
> +	};
> +
> +	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
> +	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
> +	u32 etc;
> +
> +	if (mode >= XFER_UDMA_0) {
> +		cs5536_read(pdev, ETC, &etc);
> +
> +		etc &= ~(IDE_DRV_MASK << dshift);
> +		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
> +
> +		cs5536_write(pdev, ETC, etc);
> +	} else { /* MWDMA */
> +		drive->drive_data &= 0xff;
>   

   IDE_DRV_MASK?

> +		drive->drive_data |= mwdma_timings[mode - XFER_MW_DMA_0] << 8;
>   

   How about disabling UltraDMA mode? While not an issue in the original 
driver with the set_{dma|pio}mode() method call order strictly 
determined and the latter method disabling UltraDMA, here this becames 
an issue...

> +static void cs5536_dma_start(ide_drive_t *drive)
> +{
> +	if (drive->current_speed < XFER_UDMA_0)
> +		cs5536_program_dtc(drive, drive->drive_data >> 8);
>   

   Worth comparing the values as PIO4 and MWDMA2 timings exactly 
correspond. Hm, PIO3 and MWDMA1 too...

> +/**
> + *	cs5536_init_one
> + *	@dev: PCI device
> + *	@id: Entry in match table
> + */
> +
> +static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
> +{
> +	u32 cfg;
> +
> +	if (use_msr)
> +		printk(KERN_ERR DRV_NAME ": Using MSR regs instead of PCI\n");
>   

   Why KERN_ERR? :-O

> +	cs5536_read(dev, CFG, &cfg);
> +
> +	if ((cfg & IDE_CFG_CHANEN) == 0) {
> +		printk(KERN_ERR DRV_NAME ": disabled by BIOS\n");
> +		return -ENODEV;
>   

   Eh, why not do it via the usual .enablebits mechanism?

MBR, Sergei


