From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: New IDE driver for review
Date: Thu, 9 Jun 2005 12:14:27 +0200
Message-ID: <58cb370e0506090314689ecb2a@mail.gmail.com>
References: <BFECAF9E178F144FAEF2BF4CE739C668014C7A60@exmail1.se.axis.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:59514 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262341AbVFIKO2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Jun 2005 06:14:28 -0400
Received: by wproxy.gmail.com with SMTP id 68so55117wra
        for <linux-ide@vger.kernel.org>; Thu, 09 Jun 2005 03:14:27 -0700 (PDT)
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668014C7A60@exmail1.se.axis.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: linux-ide@vger.kernel.org

Hi,

On 6/9/05, Mikael Starvik <mikael.starvik@axis.com> wrote:
> I am about to release a new subarchitecture to the cris architcecture.
> A part of this release is a new IDE driver. Basically just a port of
> the IDE driver for the old architecture with the addition of UDMA 0-2.
> 
> The driver is attached if anyone wants to review it before submission.
> I understand if no one is interrested in taking a look at it (CRIS
> is really a minor arch).

it depends on the IDE subsystem so...

> If no one objects I'll send this to Andrew after the 2.6.12 release.

>From the quick review:

following files are needed to really understand what the driver is doing...

> #include <asm/arch/hwregs/ata_defs.h>
> #include <asm/arch/hwregs/dma_defs.h>
> #include <asm/arch/hwregs/dma.h>

...

> static void tune_crisv32_ide(ide_drive_t *drive, byte pio)
> {

please use 'u8' instead of 'byte' (everywhere)

> 	reg_ata_rw_ctrl0 ctrl0 = REG_RD(ata, regi_ata, rw_ctrl0);
> 	reg_ata_rw_ctrl1 ctrl1 = REG_RD(ata, regi_ata, rw_ctrl1);

ctrl1 variable is not modified anywhere in tune_crisv32_ide(),
if hardware doesn't require related registers (can't tell more - you haven't
attached include files) to be refreshed it can be removed

> 	if (pio <= 4)
> 		pio = ide_get_best_pio_mode(drive, pio, 4, NULL);

ide_get_best_pio_mode() call with such parameters returns 'pio',
you can remove these two lines

> 	switch(pio)
> 	{
> 		case 0:
> 			ctrl0.pio_setup = ATA_PIO0_SETUP;
> 			ctrl0.pio_strb = ATA_PIO0_STROBE;
> 			ctrl0.pio_hold = ATA_PIO0_HOLD;
> 			break;
> 		case 1:
> 			ctrl0.pio_setup = ATA_PIO1_SETUP;
> 			ctrl0.pio_strb = ATA_PIO1_STROBE;
> 			ctrl0.pio_hold = ATA_PIO1_HOLD;
> 			break;
> 		case 2:
> 			ctrl0.pio_setup = ATA_PIO2_SETUP;
> 			ctrl0.pio_strb = ATA_PIO2_STROBE;
> 			ctrl0.pio_hold = ATA_PIO2_HOLD;
> 			break;
> 		case 3:
> 			ctrl0.pio_setup = ATA_PIO3_SETUP;
> 			ctrl0.pio_strb = ATA_PIO3_STROBE;
> 			ctrl0.pio_hold = ATA_PIO3_HOLD;
> 			break;
> 		case 4:
> 			ctrl0.pio_setup = ATA_PIO4_SETUP;
> 			ctrl0.pio_strb = ATA_PIO4_STROBE;
> 			ctrl0.pio_hold = ATA_PIO4_HOLD;
> 			break;
> 	}
> 
> 	REG_WR(ata, regi_ata, rw_ctrl1, ctrl1);
> 	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);
> }
> 
> static int speed_crisv32_ide(ide_drive_t *drive, byte speed)
> {
> 	reg_ata_rw_ctrl0 ctrl0 = REG_RD(ata, regi_ata, rw_ctrl0);
> 	reg_ata_rw_ctrl1 ctrl1 = REG_RD(ata, regi_ata, rw_ctrl1);
> 
> 	switch(speed)
> 	{
> 		case XFER_UDMA_0:
> 			ctrl1.udma_tcyc = ATA_UDMA0_CYC;
> 			ctrl1.udma_tdvs = ATA_UDMA0_DVS;
> 			break;
> 		case XFER_UDMA_1:
> 			ctrl1.udma_tcyc = ATA_UDMA1_CYC;
> 			ctrl1.udma_tdvs = ATA_UDMA1_DVS;
> 			break;
> 		case XFER_UDMA_2:
> 			ctrl1.udma_tcyc = ATA_UDMA2_CYC;
> 			ctrl1.udma_tdvs = ATA_UDMA2_DVS;
> 			break;
> 		case XFER_MW_DMA_2:
> 			ctrl0.dma_strb = ATA_DMA0_STROBE;
> 			ctrl0.dma_hold = ATA_DMA0_HOLD;
> 			break;

is this correct: XFER_MW_DMA_2 -> ATA_DMA0_* ?

> 		case XFER_MW_DMA_0:
> 			ctrl0.dma_strb = ATA_DMA2_STROBE;
> 			ctrl0.dma_hold = ATA_DMA2_HOLD;
> 			break;

ditto

> 		case XFER_PIO_0:
> 			ctrl0.pio_setup = ATA_PIO0_SETUP;
> 			ctrl0.pio_strb = ATA_PIO0_STROBE;
> 			ctrl0.pio_hold = ATA_PIO0_HOLD;
> 			break;
> 		case XFER_PIO_1:
> 			ctrl0.pio_setup = ATA_PIO1_SETUP;
> 			ctrl0.pio_strb = ATA_PIO1_STROBE;
> 			ctrl0.pio_hold = ATA_PIO1_HOLD;
> 			break;
> 		case XFER_PIO_2:
> 			ctrl0.pio_setup = ATA_PIO2_SETUP;
> 			ctrl0.pio_strb = ATA_PIO2_STROBE;
> 			ctrl0.pio_hold = ATA_PIO2_HOLD;
> 			break;
> 		case XFER_PIO_3:
> 			ctrl0.pio_setup = ATA_PIO3_SETUP;
> 			ctrl0.pio_strb = ATA_PIO3_STROBE;
> 			ctrl0.pio_hold = ATA_PIO3_HOLD;
> 			break;
> 		case XFER_PIO_4:
> 			ctrl0.pio_setup = ATA_PIO4_SETUP;
> 			ctrl0.pio_strb = ATA_PIO4_STROBE;
> 			ctrl0.pio_hold = ATA_PIO4_HOLD;
> 			break;
> 	}

PIO setup code is _identical_ to that in tune_crisv32_ide(),
speed_crisv32_ide() can be rewritten to use tune_crisv32_ide():

static int speed_crisv32_ide(ide_drive_t *drive, u8 speed)
{
        reg_ata_rw_ctrl0 ctrl0;
        reg_ata_rw_ctrl1 ctrl1;

        if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4)
                return tune_crisv32_ide(drive, speed);

        ctrl0 = REG_RD(ata, regi_ata, rw_ctrl0);
        ctrl1 = REG_RD(ata, regi_ata, rw_ctrl1);

        ...
}

> 	REG_WR(ata, regi_ata, rw_ctrl1, ctrl1);
> 	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);
> 
> 	return 0;
> }

> void __init
> init_e100_ide (void)
> {

> 		hwif->udma_four = 1;

why is host side 80-wires cable flag always set?
this controller doesn't even support UDMA > 2

> 		hwif->sg_table =
> 		  kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES, GFP_KERNEL);

this will memleak memory as hwif->sg_table is allocated during probe

> static int crisv32_ide_build_dmatable (ide_drive_t *drive)
> {
> 	ide_hwif_t *hwif = HWIF(drive);

please use 'drive->hwif' instead of HWIF() (everywhere)

> 	struct scatterlist* sg;
> 	struct request *rq  = HWGROUP(drive)->rq;

please use 'drive->hwif->hwgroup' instead of HWGROUP() (everywhere)

> 	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
> 		u8 *virt_addr = rq->buffer;
> 		int sector_count = rq->nr_sectors;
> 		memset(&sg[0], 0, sizeof(*sg));
> 		sg[0].page = virt_to_page(virt_addr);
> 		sg[0].offset = offset_in_page(virt_addr);
> 		sg[0].length =  sector_count  * SECTOR_SIZE;
> 		hwif->sg_nents = i = 1;
> 	}
> 	else
> 	{
> 		hwif->sg_nents = i = blk_rq_map_sg(drive->queue, rq, hwif->sg_table);
> 	}

above code should be replaced by:

        ide_map_sg(drive, rq);
        i = hwif->sg_nents;

> static ide_startstop_t crisv32_dma_intr (ide_drive_t *drive)
> {
> 	int i, dma_stat;
> 	byte stat;
> 
> 	LED_DISK_READ(0);
> 	LED_DISK_WRITE(0);
> 
> 	dma_stat = HWIF(drive)->ide_dma_end(drive);
> 	stat = HWIF(drive)->INB(IDE_STATUS_REG);		/* get drive status */
> 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
> 		if (!dma_stat) {
> 			struct request *rq;
> 			rq = HWGROUP(drive)->rq;
> 			for (i = rq->nr_sectors; i > 0;) {
> 				i -= rq->current_nr_sectors;
> 				DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
> 			}
> 			return ide_stopped;
> 		}
> 		printk("%s: bad DMA status\n", drive->name);
> 	}
> 	return ide_error(drive, "dma_intr", stat);
> }

this won't even compile with 2.6.12-rc6 (DRIVER() was removed),
besides crisv32_dma_intr() can be much simpler:

static ide_startstop_t crisv32_dma_intr(ide_drive_t *drive)
{
	LED_DISK_READ(0);
	LED_DISK_WRITE(0);

	return ide_dma_intr(drive);
}


It may be reasonable to merge ide-v10.c and ide-v32.c drivers
(using macros to abstract differences etc.) but without seeing
register layout for v32 I can't tell for sure (hint: missing include
files).

Thanks,
Bartlomiej
