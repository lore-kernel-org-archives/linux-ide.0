From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: New IDE driver for review
Date: Mon, 20 Jun 2005 21:15:26 +0200
Message-ID: <58cb370e050620121547d21e80@mail.gmail.com>
References: <BFECAF9E178F144FAEF2BF4CE739C668030176E7@exmail1.se.axis.com>
	 <BFECAF9E178F144FAEF2BF4CE739C668030B4C92@exmail1.se.axis.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:52342 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261481AbVFTTPa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jun 2005 15:15:30 -0400
Received: by wproxy.gmail.com with SMTP id 37so887351wra
        for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2005 12:15:26 -0700 (PDT)
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668030B4C92@exmail1.se.axis.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: Mikael Starvik <starvik@axis.com>, linux-ide@vger.kernel.org

On 6/17/05, Mikael Starvik <mikael.starvik@axis.com> wrote:
> Hi,

Hi,

> I have created a merged driver for CRIS v10 and v32. Do you think this
> approach is better? In that case you'll also need a Makefile patch as
> follows below.

Looks much better.  Thanks for doing this.

Few comments:

> void
> cris_ide_outw(unsigned short data, unsigned long reg) {
> 	int timeleft;
> 
> 	LOWDB(printk("ow: data 0x%x, reg 0x%x\n", data, reg));
> 
> 	/* note the lack of handling any timeouts. we stop waiting, but we don't
> 	 * really notify anybody.
> 	 */
> 
> 	timeleft = IDE_REGISTER_TIMEOUT;
> 	/* wait for busy flag */
> 	do {
> 		timeleft--;
> 	} while(timeleft && cris_ide_busy());
> 
> 	/*
> 	 * Fall through at a timeout, so the ongoing command will be
> 	 * aborted by the write below, which is expected to be a dummy
> 	 * command to the command register.  This happens when a faulty
> 	 * drive times out on a command.  See comment on timeout in
> 	 * INB.
> 	 */
> 	if(!timeleft)
> 		printk("ATA timeout reg 0x%lx := 0x%x\n", reg, data);
> 
> 	cris_ide_write_command(reg|data); /* write data to the drive's register */
> 
> 	timeleft = IDE_REGISTER_TIMEOUT;
> 	/* wait for transmitter ready */
> 	do {
> 		timeleft--;
> 	} while(timeleft && cris_ide_busy());

previously it was:

	while(timeleft && !(*R_ATA_STATUS_DATA &
			    IO_MASK(R_ATA_STATUS_DATA, tr_rdy)))
		timeleft--;

for v10, is it OK to use busy instead of tr_rdy?

> }

> unsigned short
> cris_ide_inw(unsigned long reg) {
> 	int timeleft;
> 	unsigned short val;
> 
> 	timeleft = IDE_REGISTER_TIMEOUT;
> 	/* wait for busy flag */
> 	do {
> 		timeleft--;
> 	} while(timeleft && cris_ide_busy());
> 
> 	if(!timeleft)
> 		return 0;

previously there was a special case for IDE_STATUS_OFFSET here,
is it not needed any longer?
 
> 	cris_ide_write_command(reg | cris_pio_read);
> 
> 	timeleft = IDE_REGISTER_TIMEOUT;
> 	/* wait for available */
> 	do {
> 		timeleft--;
> 	} while(timeleft && !cris_ide_data_available(&val));
> 
> 	if(!timeleft)
> 		return 0;
> 
> 	LOWDB(printk("inb: 0x%x from reg 0x%x\n", val & 0xff, reg));
> 
> 	return val;
> }

> static void
> cris_atapi_output_bytes (ide_drive_t *drive, void *buffer, unsigned int bytecount)
> {
> 	D(printk("atapi_output_bytes, dreg 0x%x, buffer 0x%x, count %d\n",
> 	         0, buffer, bytecount));

dreg?

> 	if(bytecount & 1) {
> 		printk("odd bytecount %d in atapi_out_bytes!\n", bytecount);
> 		bytecount++;
> 	}
> 
> 	cris_ide_fill_descriptor(&mydescr, buffer, bytecount, 1);
> 	cris_ide_start_dma(drive, &mydescr, 0, TYPE_PIO, bytecount);
> 
> 	/* wait for completion */
> 
> 	LED_DISK_WRITE(1);
> 	LED_DISK_READ(1);
> 	cris_ide_wait_dma(1);

cris_ide_wait_dma(0) ?

> 	LED_DISK_WRITE(0);
> }

> static int config_drive_for_dma (ide_drive_t *drive)
> {
> 	struct hd_driveid *id = drive->id;
> 
> 	if (id && (id->capability & 1)) {
> 		/* Enable DMA on any drive that supports mword2 DMA */
> 		if ((id->field_valid & 2) &&
> 		    ((id->dma_mword & 0xff00) || (id->dma_ultra & 0xff00))) {

no checking of (id->field_valid & 4)

DMA will be used only if drive has it already enabled

> 			drive->using_dma = 1;

drive->using_dma shouldn't be touched at this layer

> 			return 0;               /* DMA enabled */
> 		}
> 	}
> 	drive->using_dma = 0;
> 	return 0;       /* DMA not enabled */

DMA whitelist/blacklist checking is missing

> }

should look more like:

static int cris_config_drive_for_dma(ide_drive_t *drive)
{
	u8 speed = ide_dma_speed(drive, 0); /* no UDMA for now */

	if (!speed)
		return 0;

	speed_cris_ide(drive, speed);
	ide_config_drive_speed(drive, speed);

	return ide_dma_enable(drive);
}

>  * For ATAPI devices, we just prepare for DMA and return. The caller should
>  * then issue the packet command to the drive and call us again with
>  * ide_dma_begin afterwards.

this comment got re-introduced
s/ide_dma_begin/->dma_start()/

> static int cris_dma_check(ide_drive_t *drive)
> {
> 	int speed = ide_dma_speed(drive, 0); /* No UDMA for now */

No UDMA?

> 	speed_cris_ide(drive, speed);
> 	ide_config_drive_speed(drive, speed);
> 	return config_drive_for_dma (drive);
> }

should look more like:

static int cris_dma_check(ide_drive_t *drive)
{
	ide_hwif_t *hwif = drive->hwif;
	struct hd_driveid *id = drive->id;

	if (id && (id->capability & 1)) {
		if (ide_use_dma(drive) {
			if (cris_config_drive_for_dma(drive))
				return hwif->ide_dma_on(drive);
		}
	}

	return hwif->ide_dma_off_quietly(drive);
}

> static int cris_prepare_dma(ide_drive_t *drive, int atapi, int reading)

atapi and reading arguments are unused

> {
> 	struct request *rq = drive->hwif->hwgroup->rq;
> 	if (cris_ide_build_dmatable (drive)) {
> 		ide_map_sg(drive, rq);
> 		return 1;
> 	}
> 
> 	return 0;
> }
> 
> static int cris_dma_setup(ide_drive_t *drive)
> {
> 	struct request *rq = drive->hwif->hwgroup->rq;
> 	int ret;
> 	if (rq_data_dir(rq))
> 		ret = cris_prepare_dma(drive, 0, 0);
>         else
> 		ret = cris_prepare_dma(drive, 0, 1);
> 	if (ret)
> 		return ret;
> 	drive->waiting_for_dma = 1;
> 	return 0;
> }

should look more like:

static int cris_dma_setup(ide_drive_t *drive)
{
	struct request *rq = drive->hwif->hwgroup->rq;

	if (cris_ide_build_dmatable (drive)) {
		ide_map_sg(drive, rq);
		return 1;
	}

	drive->waiting_for_dma = 1;

	return 0;
}


cris_ide_reset() and cris_ide_init() should be marked with __init
(for both archs)


There is also number of changes w.r.t. v10 support:
* reset and initialization sequences are changed
* "PIO comment" is gone
* RESET_DMA()/WAIT_DMA() pairs are gone
* 65536 sg size limit is gone
* ->speedproc() method is added
* ...

It would make much sense to separate these changes from addition of v32 
support, this way testing for potential regressions would be much easier:

1. do v10 changes
2. add abstraction layer
3. add v32 support
4. rename driver

One big patch is also fine with me as long as it is correct
(IMHO it is easier to achieve correctness with a patch series).

Cheers,
Bartlomiej
