From: "Mikael Starvik" <mikael.starvik@axis.com>
Subject: RE: New IDE driver for review
Date: Thu, 9 Jun 2005 14:54:39 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7A6E@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C668030174FD@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0D38_01C56D03.2A60E5D0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from miranda.se.axis.com ([193.13.178.8]:41657 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S262382AbVFIMy4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Jun 2005 08:54:56 -0400
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668030174FD@exmail1.se.axis.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, Mikael Starvik <mikael.starvik@axis.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0D38_01C56D03.2A60E5D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok, updated driver and requested include files attached.=20

The drivers are similar but it would still require many ugly ifdef:s or
similar to combine them. I could of course extract the stuff that is the
same to a common file to make the arch-specific files smaller. These =
drivers
are rarley touched so I see no major maintanence benefit by combining =
them.

/Mikael

A patch for the Makefile in drives/ide/cris is also necessary:

Index: Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /usr/local/cvs/linux/os/linux-2.6/drivers/ide/cris/Makefile,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -r1.1.1.1 -r1.2
3a4
> obj-$(CONFIG_ETRAX_ARCH_V32)		+=3D ide-v32.o

-----Original Message-----
From: Bartlomiej Zolnierkiewicz [mailto:bzolnier@gmail.com]=20
Sent: Thursday, June 09, 2005 12:14 PM
To: Mikael Starvik
Cc: linux-ide@vger.kernel.org
Subject: Re: New IDE driver for review


Hi,

On 6/9/05, Mikael Starvik <mikael.starvik@axis.com> wrote:
> I am about to release a new subarchitecture to the cris architcecture.
> A part of this release is a new IDE driver. Basically just a port of
> the IDE driver for the old architecture with the addition of UDMA 0-2.
>=20
> The driver is attached if anyone wants to review it before submission.
> I understand if no one is interrested in taking a look at it (CRIS
> is really a minor arch).

it depends on the IDE subsystem so...

> If no one objects I'll send this to Andrew after the 2.6.12 release.

>From the quick review:

following files are needed to really understand what the driver is =
doing...

> #include <asm/arch/hwregs/ata_defs.h>
> #include <asm/arch/hwregs/dma_defs.h>
> #include <asm/arch/hwregs/dma.h>

...

> static void tune_crisv32_ide(ide_drive_t *drive, byte pio)
> {

please use 'u8' instead of 'byte' (everywhere)

> 	reg_ata_rw_ctrl0 ctrl0 =3D REG_RD(ata, regi_ata, rw_ctrl0);
> 	reg_ata_rw_ctrl1 ctrl1 =3D REG_RD(ata, regi_ata, rw_ctrl1);

ctrl1 variable is not modified anywhere in tune_crisv32_ide(),
if hardware doesn't require related registers (can't tell more - you =
haven't
attached include files) to be refreshed it can be removed

> 	if (pio <=3D 4)
> 		pio =3D ide_get_best_pio_mode(drive, pio, 4, NULL);

ide_get_best_pio_mode() call with such parameters returns 'pio',
you can remove these two lines

> 	switch(pio)
> 	{
> 		case 0:
> 			ctrl0.pio_setup =3D ATA_PIO0_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO0_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO0_HOLD;
> 			break;
> 		case 1:
> 			ctrl0.pio_setup =3D ATA_PIO1_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO1_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO1_HOLD;
> 			break;
> 		case 2:
> 			ctrl0.pio_setup =3D ATA_PIO2_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO2_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO2_HOLD;
> 			break;
> 		case 3:
> 			ctrl0.pio_setup =3D ATA_PIO3_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO3_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO3_HOLD;
> 			break;
> 		case 4:
> 			ctrl0.pio_setup =3D ATA_PIO4_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO4_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO4_HOLD;
> 			break;
> 	}
>=20
> 	REG_WR(ata, regi_ata, rw_ctrl1, ctrl1);
> 	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);
> }
>=20
> static int speed_crisv32_ide(ide_drive_t *drive, byte speed)
> {
> 	reg_ata_rw_ctrl0 ctrl0 =3D REG_RD(ata, regi_ata, rw_ctrl0);
> 	reg_ata_rw_ctrl1 ctrl1 =3D REG_RD(ata, regi_ata, rw_ctrl1);
>=20
> 	switch(speed)
> 	{
> 		case XFER_UDMA_0:
> 			ctrl1.udma_tcyc =3D ATA_UDMA0_CYC;
> 			ctrl1.udma_tdvs =3D ATA_UDMA0_DVS;
> 			break;
> 		case XFER_UDMA_1:
> 			ctrl1.udma_tcyc =3D ATA_UDMA1_CYC;
> 			ctrl1.udma_tdvs =3D ATA_UDMA1_DVS;
> 			break;
> 		case XFER_UDMA_2:
> 			ctrl1.udma_tcyc =3D ATA_UDMA2_CYC;
> 			ctrl1.udma_tdvs =3D ATA_UDMA2_DVS;
> 			break;
> 		case XFER_MW_DMA_2:
> 			ctrl0.dma_strb =3D ATA_DMA0_STROBE;
> 			ctrl0.dma_hold =3D ATA_DMA0_HOLD;
> 			break;

is this correct: XFER_MW_DMA_2 -> ATA_DMA0_* ?

> 		case XFER_MW_DMA_0:
> 			ctrl0.dma_strb =3D ATA_DMA2_STROBE;
> 			ctrl0.dma_hold =3D ATA_DMA2_HOLD;
> 			break;

ditto

> 		case XFER_PIO_0:
> 			ctrl0.pio_setup =3D ATA_PIO0_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO0_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO0_HOLD;
> 			break;
> 		case XFER_PIO_1:
> 			ctrl0.pio_setup =3D ATA_PIO1_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO1_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO1_HOLD;
> 			break;
> 		case XFER_PIO_2:
> 			ctrl0.pio_setup =3D ATA_PIO2_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO2_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO2_HOLD;
> 			break;
> 		case XFER_PIO_3:
> 			ctrl0.pio_setup =3D ATA_PIO3_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO3_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO3_HOLD;
> 			break;
> 		case XFER_PIO_4:
> 			ctrl0.pio_setup =3D ATA_PIO4_SETUP;
> 			ctrl0.pio_strb =3D ATA_PIO4_STROBE;
> 			ctrl0.pio_hold =3D ATA_PIO4_HOLD;
> 			break;
> 	}

PIO setup code is _identical_ to that in tune_crisv32_ide(),
speed_crisv32_ide() can be rewritten to use tune_crisv32_ide():

static int speed_crisv32_ide(ide_drive_t *drive, u8 speed)
{
        reg_ata_rw_ctrl0 ctrl0;
        reg_ata_rw_ctrl1 ctrl1;

        if (speed >=3D XFER_PIO_0 && speed <=3D XFER_PIO_4)
                return tune_crisv32_ide(drive, speed);

        ctrl0 =3D REG_RD(ata, regi_ata, rw_ctrl0);
        ctrl1 =3D REG_RD(ata, regi_ata, rw_ctrl1);

        ...
}

> 	REG_WR(ata, regi_ata, rw_ctrl1, ctrl1);
> 	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);
>=20
> 	return 0;
> }

> void __init
> init_e100_ide (void)
> {

> 		hwif->udma_four =3D 1;

why is host side 80-wires cable flag always set?
this controller doesn't even support UDMA > 2

> 		hwif->sg_table =3D
> 		  kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
GFP_KERNEL);

this will memleak memory as hwif->sg_table is allocated during probe

> static int crisv32_ide_build_dmatable (ide_drive_t *drive)
> {
> 	ide_hwif_t *hwif =3D HWIF(drive);

please use 'drive->hwif' instead of HWIF() (everywhere)

> 	struct scatterlist* sg;
> 	struct request *rq  =3D HWGROUP(drive)->rq;

please use 'drive->hwif->hwgroup' instead of HWGROUP() (everywhere)

> 	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
> 		u8 *virt_addr =3D rq->buffer;
> 		int sector_count =3D rq->nr_sectors;
> 		memset(&sg[0], 0, sizeof(*sg));
> 		sg[0].page =3D virt_to_page(virt_addr);
> 		sg[0].offset =3D offset_in_page(virt_addr);
> 		sg[0].length =3D  sector_count  * SECTOR_SIZE;
> 		hwif->sg_nents =3D i =3D 1;
> 	}
> 	else
> 	{
> 		hwif->sg_nents =3D i =3D blk_rq_map_sg(drive->queue, rq,
hwif->sg_table);
> 	}

above code should be replaced by:

        ide_map_sg(drive, rq);
        i =3D hwif->sg_nents;

> static ide_startstop_t crisv32_dma_intr (ide_drive_t *drive)
> {
> 	int i, dma_stat;
> 	byte stat;
>=20
> 	LED_DISK_READ(0);
> 	LED_DISK_WRITE(0);
>=20
> 	dma_stat =3D HWIF(drive)->ide_dma_end(drive);
> 	stat =3D HWIF(drive)->INB(IDE_STATUS_REG);		/* get drive
status */
> 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
> 		if (!dma_stat) {
> 			struct request *rq;
> 			rq =3D HWGROUP(drive)->rq;
> 			for (i =3D rq->nr_sectors; i > 0;) {
> 				i -=3D rq->current_nr_sectors;
> 				DRIVER(drive)->end_request(drive, 1,
rq->nr_sectors);
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

------=_NextPart_000_0D38_01C56D03.2A60E5D0
Content-Type: application/octet-stream;
	name="ide-v32.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ide-v32.c"

/* $Id: ide-v32.c,v 1.6 2005/06/09 12:40:48 starvik Exp $=0A=
 *=0A=
 * Etrax specific IDE functions, like init and PIO-mode setting etc.=0A=
 * Almost the entire ide.c is used for the rest of the Etrax ATA driver.=0A=
 * Copyright (c) 2000-2004 Axis Communications AB=0A=
 *=0A=
 * Authors:    Bjorn Wesen        (initial version)=0A=
 *             Mikael Starvik     (crisv32 port)=0A=
 */=0A=
=0A=
/* Regarding DMA:=0A=
 *=0A=
 * There are two forms of DMA - "DMA handshaking" between the interface =
and the drive,=0A=
 * and DMA between the memory and the interface. We can ALWAYS use the =
latter, since it's=0A=
 * something built-in in the Etrax. However only some drives support the =
DMA-mode handshaking=0A=
 * on the ATA-bus. The normal PC driver and Triton interface disables =
memory-if DMA when the=0A=
 * device can't do DMA handshaking for some stupid reason. We don't need =
to do that.=0A=
 */=0A=
=0A=
#undef REALLY_SLOW_IO           /* most systems can safely undef this */=0A=
=0A=
#include <linux/config.h>=0A=
#include <linux/types.h>=0A=
#include <linux/kernel.h>=0A=
#include <linux/timer.h>=0A=
#include <linux/mm.h>=0A=
#include <linux/interrupt.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/blkdev.h>=0A=
#include <linux/hdreg.h>=0A=
#include <linux/ide.h>=0A=
#include <linux/init.h>=0A=
=0A=
#include <asm/io.h>=0A=
#include <asm/arch/hwregs/ata_defs.h>=0A=
#include <asm/arch/hwregs/dma_defs.h>=0A=
#include <asm/arch/hwregs/dma.h>=0A=
#include <asm/dma.h>=0A=
#include <asm/arch/pinmux.h>=0A=
=0A=
/* number of DMA descriptors */=0A=
#define MAX_DMA_DESCRS 64=0A=
=0A=
/* number of times to retry busy-flags when reading/writing IDE-registers=0A=
 * this can't be too high because a hung harddisk might cause the =
watchdog=0A=
 * to trigger (sometimes INB and OUTB are called with irq's disabled)=0A=
 */=0A=
=0A=
#define IDE_REGISTER_TIMEOUT 300=0A=
=0A=
#define LOWDB(x) =0A=
#define D(x) =0A=
=0A=
int crisv32_ide_ack_intr(ide_hwif_t* hwif)=0A=
{=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D REG_TYPE_CONV(reg_ata_rw_ctrl2, =0A=
	                         int, hwif->io_ports[0]);=0A=
	REG_WR_INT(ata, regi_ata, rw_ack_intr, 1 << ctrl2.sel);=0A=
	return 1;=0A=
}=0A=
void=0A=
crisv32_ide_outw(unsigned short data, unsigned long reg) {=0A=
	int timeleft;=0A=
	reg_ata_rs_stat_data stat_data;=0A=
=0A=
	LOWDB(printk("ow: data 0x%x, reg 0x%x\n", data, reg));=0A=
=0A=
	/* note the lack of handling any timeouts. we stop waiting, but we don't=0A=
	 * really notify anybody.=0A=
	 */=0A=
=0A=
	timeleft =3D IDE_REGISTER_TIMEOUT;=0A=
	/* wait for busy flag */=0A=
	do {=0A=
		timeleft--;=0A=
		stat_data =3D REG_RD(ata, regi_ata, rs_stat_data);=0A=
	} while(timeleft && stat_data.busy);=0A=
=0A=
	/*=0A=
	 * Fall through at a timeout, so the ongoing command will be=0A=
	 * aborted by the write below, which is expected to be a dummy=0A=
	 * command to the command register.  This happens when a faulty=0A=
	 * drive times out on a command.  See comment on timeout in=0A=
	 * INB.=0A=
	 */=0A=
	if(!timeleft)=0A=
		printk("ATA timeout reg 0x%lx :=3D 0x%x\n", reg, data);=0A=
=0A=
	REG_WR_INT(ata, regi_ata, rw_ctrl2, reg | data); /* write data to the =
drive's register */=0A=
=0A=
	timeleft =3D IDE_REGISTER_TIMEOUT;=0A=
	/* wait for transmitter ready */=0A=
	do {=0A=
		timeleft--;=0A=
		stat_data =3D REG_RD(ata, regi_ata, rs_stat_data);=0A=
	} while(timeleft && stat_data.busy);=0A=
}=0A=
=0A=
void=0A=
crisv32_ide_outb(unsigned char data, unsigned long reg)=0A=
{=0A=
	crisv32_ide_outw(data, reg);=0A=
}=0A=
=0A=
void=0A=
crisv32_ide_outbsync(ide_drive_t *drive, u8 addr, unsigned long port)=0A=
{=0A=
	crisv32_ide_outw(addr, port);=0A=
}=0A=
=0A=
unsigned short=0A=
crisv32_ide_inw(unsigned long reg) {=0A=
	int timeleft;=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D REG_TYPE_CONV(reg_ata_rw_ctrl2, unsigned =
long, reg);=0A=
	reg_ata_rs_stat_data stat_data;=0A=
=0A=
	timeleft =3D IDE_REGISTER_TIMEOUT;=0A=
	/* wait for busy flag */=0A=
	do {=0A=
		timeleft--;=0A=
		stat_data =3D REG_RD(ata, regi_ata, rs_stat_data);=0A=
	} while(timeleft && stat_data.busy);=0A=
=0A=
	if(!timeleft) {=0A=
=0A=
		/*=0A=
		 * If we're asked to read the status register, like for=0A=
		 * example when a command does not complete for an=0A=
		 * extended time, but the ATA interface is stuck in a=0A=
		 * busy state at the *ETRAX* ATA interface level (as has=0A=
		 * happened repeatedly with at least one bad disk), then=0A=
		 * the best thing to do is to pretend that we read=0A=
		 * "busy" in the status register, so the IDE driver will=0A=
		 * time-out, abort the ongoing command and perform a=0A=
		 * reset sequence.  Note that the subsequent OUT_BYTE=0A=
		 * call will also timeout on busy, but as long as the=0A=
		 * write is still performed, everything will be fine.=0A=
		 */=0A=
		if (ctrl2.addr =3D=3D IDE_STATUS_OFFSET)=0A=
			return BUSY_STAT;=0A=
		else=0A=
			/* For other rare cases we assume 0 is good enough.  */=0A=
			return 0;=0A=
	}=0A=
 =0A=
=0A=
	ctrl2.rw =3D regk_ata_rd;=0A=
	REG_WR(ata, regi_ata, rw_ctrl2, ctrl2);=0A=
=0A=
	timeleft =3D IDE_REGISTER_TIMEOUT;=0A=
	/* wait for available */=0A=
	do {=0A=
		timeleft--;=0A=
		stat_data =3D REG_RD(ata, regi_ata, rs_stat_data);=0A=
	} while(timeleft && !stat_data.dav);=0A=
=0A=
	if(!timeleft)=0A=
		return 0;=0A=
=0A=
	LOWDB(printk("inb: 0x%x from reg 0x%x\n", stat_data.data & 0xff, reg));=0A=
=0A=
	return (unsigned short)stat_data.data;=0A=
}=0A=
=0A=
unsigned char=0A=
crisv32_ide_inb(unsigned long reg)=0A=
{=0A=
	return (unsigned char)crisv32_ide_inw(reg);=0A=
}=0A=
=0A=
=0A=
#define ATA_UDMA2_CYC    2=0A=
#define ATA_UDMA2_DVS    3=0A=
#define ATA_UDMA1_CYC    2=0A=
#define ATA_UDMA1_DVS    4=0A=
#define ATA_UDMA0_CYC    4=0A=
#define ATA_UDMA0_DVS    6=0A=
#define ATA_DMA2_STROBE  7=0A=
#define ATA_DMA2_HOLD    1=0A=
#define ATA_DMA1_STROBE  8=0A=
#define ATA_DMA1_HOLD    3=0A=
#define ATA_DMA0_STROBE 25=0A=
#define ATA_DMA0_HOLD   19=0A=
#define ATA_PIO4_SETUP   3=0A=
#define ATA_PIO4_STROBE  7=0A=
#define ATA_PIO4_HOLD    1=0A=
#define ATA_PIO3_SETUP   3=0A=
#define ATA_PIO3_STROBE  9=0A=
#define ATA_PIO3_HOLD    3=0A=
#define ATA_PIO2_SETUP   3=0A=
#define ATA_PIO2_STROBE 13=0A=
#define ATA_PIO2_HOLD    5=0A=
#define ATA_PIO1_SETUP   5=0A=
#define ATA_PIO1_STROBE 23=0A=
#define ATA_PIO1_HOLD    9=0A=
#define ATA_PIO0_SETUP   9=0A=
#define ATA_PIO0_STROBE 39=0A=
#define ATA_PIO0_HOLD    9=0A=
=0A=
static int crisv32_dma_check (ide_drive_t *drive);=0A=
static int crisv32_dma_end (ide_drive_t *drive);=0A=
static int crisv32_dma_setup (ide_drive_t *drive);=0A=
static void crisv32_dma_exec_cmd (ide_drive_t *drive, u8 command);=0A=
static int crisv32_dma_test_irq(ide_drive_t *drive);=0A=
static void crisv32_dma_start(ide_drive_t *drive);=0A=
static void crisv32_ide_input_data (ide_drive_t *drive, void *, unsigned =
int);=0A=
static void crisv32_ide_output_data (ide_drive_t *drive, void *, =
unsigned int);=0A=
static void crisv32_atapi_input_bytes(ide_drive_t *drive, void *, =
unsigned int);=0A=
static void crisv32_atapi_output_bytes(ide_drive_t *drive, void *, =
unsigned int);=0A=
static int crisv32_dma_off (ide_drive_t *drive);=0A=
static int crisv32_dma_on (ide_drive_t *drive);=0A=
=0A=
static void tune_crisv32_ide(ide_drive_t *drive, u8 pio)=0A=
{=0A=
	reg_ata_rw_ctrl0 ctrl0 =3D REG_RD(ata, regi_ata, rw_ctrl0);=0A=
=0A=
	switch(pio)=0A=
	{	=0A=
		case 0:=0A=
			ctrl0.pio_setup =3D ATA_PIO0_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO0_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO0_HOLD;=0A=
			break;=0A=
		case 1:=0A=
			ctrl0.pio_setup =3D ATA_PIO1_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO1_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO1_HOLD;=0A=
			break;=0A=
		case 2:=0A=
			ctrl0.pio_setup =3D ATA_PIO2_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO2_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO2_HOLD;=0A=
			break;=0A=
		case 3:=0A=
			ctrl0.pio_setup =3D ATA_PIO3_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO3_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO3_HOLD;=0A=
			break;=0A=
		case 4:=0A=
			ctrl0.pio_setup =3D ATA_PIO4_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO4_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO4_HOLD;=0A=
			break;    =0A=
	}=0A=
=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
}=0A=
=0A=
static int speed_crisv32_ide(ide_drive_t *drive, u8 speed)=0A=
{=0A=
	reg_ata_rw_ctrl0 ctrl0 =3D REG_RD(ata, regi_ata, rw_ctrl0);=0A=
	reg_ata_rw_ctrl1 ctrl1 =3D REG_RD(ata, regi_ata, rw_ctrl1);=0A=
=0A=
	if (speed >=3D XFER_PIO_0 && speed <=3D XFER_PIO_4) {=0A=
		tune_crisv32_ide(drive, speed - XFER_PIO_0);=0A=
		return 0;=0A=
	}=0A=
        =0A=
	switch(speed)=0A=
	{	=0A=
		case XFER_UDMA_0:=0A=
			ctrl1.udma_tcyc =3D ATA_UDMA0_CYC;=0A=
			ctrl1.udma_tdvs =3D ATA_UDMA0_DVS;=0A=
			break;=0A=
		case XFER_UDMA_1:=0A=
			ctrl1.udma_tcyc =3D ATA_UDMA1_CYC;=0A=
			ctrl1.udma_tdvs =3D ATA_UDMA1_DVS;=0A=
			break;=0A=
		case XFER_UDMA_2:=0A=
			ctrl1.udma_tcyc =3D ATA_UDMA2_CYC;=0A=
			ctrl1.udma_tdvs =3D ATA_UDMA2_DVS;=0A=
			break;=0A=
		case XFER_MW_DMA_0:=0A=
			ctrl0.dma_strb =3D ATA_DMA0_STROBE;=0A=
			ctrl0.dma_hold =3D ATA_DMA0_HOLD;=0A=
			break;=0A=
		case XFER_MW_DMA_1:=0A=
			ctrl0.dma_strb =3D ATA_DMA1_STROBE;=0A=
			ctrl0.dma_hold =3D ATA_DMA1_HOLD;=0A=
			break;=0A=
		case XFER_MW_DMA_2:=0A=
			ctrl0.dma_strb =3D ATA_DMA2_STROBE;=0A=
			ctrl0.dma_hold =3D ATA_DMA2_HOLD;=0A=
			break;=0A=
	}=0A=
=0A=
	REG_WR(ata, regi_ata, rw_ctrl1, ctrl1);=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
void __init=0A=
init_e100_ide (void)=0A=
{=0A=
	reg_ata_rw_ctrl0 ctrl0 =3D {0};=0A=
	reg_ata_rw_ctrl1 ctrl1 =3D {0};=0A=
	reg_ata_rw_intr_mask intr_mask =3D {0};=0A=
        hw_regs_t hw;=0A=
	int ide_offsets[IDE_NR_PORTS];=0A=
	int h;=0A=
	int i;=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D {0};=0A=
=0A=
	printk("ide: ETRAX FS built-in ATA DMA controller\n");=0A=
=0A=
	for (i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; i++) {=0A=
		ctrl2.addr =3D i;=0A=
		ctrl2.cs0 =3D regk_ata_active;=0A=
		ide_offsets[i] =3D REG_TYPE_CONV(int, reg_ata_rw_ctrl2, ctrl2);=0A=
	}=0A=
=0A=
	/* the IDE control register is at ATA address 6, with CS1 active =
instead of CS0 */=0A=
	ctrl2.addr =3D 6;=0A=
	ctrl2.cs1 =3D regk_ata_active;=0A=
	ctrl2.cs0 =3D regk_ata_inactive;=0A=
	ide_offsets[IDE_CONTROL_OFFSET] =3D REG_TYPE_CONV(int, =
reg_ata_rw_ctrl2, ctrl2);=0A=
=0A=
	memset(&ctrl2, 0, sizeof(ctrl2));=0A=
=0A=
	/* first fill in some stuff in the ide_hwifs fields */=0A=
=0A=
	for(h =3D 0; h < MAX_HWIFS; h++) {=0A=
		reg_ata_rw_ctrl2 ctrl2 =3D {.sel =3D h};=0A=
		ide_hwif_t *hwif =3D &ide_hwifs[h];=0A=
		ide_setup_ports(&hw, REG_TYPE_CONV(int, reg_ata_rw_ctrl2, ctrl2), =0A=
		                ide_offsets,=0A=
		                0, 0, crisv32_ide_ack_intr,=0A=
		                ATA_INTR_VECT);=0A=
		ide_register_hw(&hw, &hwif);=0A=
		hwif->mmio =3D 2;=0A=
		hwif->chipset =3D ide_etrax100;=0A=
		hwif->tuneproc =3D &tune_crisv32_ide;=0A=
		hwif->speedproc =3D &speed_crisv32_ide;=0A=
		hwif->ata_input_data =3D &crisv32_ide_input_data;=0A=
		hwif->ata_output_data =3D &crisv32_ide_output_data;=0A=
		hwif->atapi_input_bytes =3D &crisv32_atapi_input_bytes;=0A=
		hwif->atapi_output_bytes =3D &crisv32_atapi_output_bytes;=0A=
		hwif->ide_dma_check =3D &crisv32_dma_check;=0A=
		hwif->ide_dma_end =3D &crisv32_dma_end;=0A=
		hwif->dma_setup =3D &crisv32_dma_setup;=0A=
		hwif->dma_exec_cmd =3D &crisv32_dma_exec_cmd;=0A=
		hwif->ide_dma_test_irq =3D &crisv32_dma_test_irq;=0A=
		hwif->dma_start =3D &crisv32_dma_start;=0A=
		hwif->OUTB =3D &crisv32_ide_outb;=0A=
		hwif->OUTW =3D &crisv32_ide_outw;=0A=
		hwif->OUTBSYNC =3D &crisv32_ide_outbsync;=0A=
		hwif->INB =3D &crisv32_ide_inb;=0A=
		hwif->INW =3D &crisv32_ide_inw;=0A=
		hwif->ide_dma_host_off =3D &crisv32_dma_off;=0A=
		hwif->ide_dma_host_on =3D &crisv32_dma_on;=0A=
		hwif->ide_dma_off_quietly =3D &crisv32_dma_off;=0A=
		hwif->udma_four =3D 0;=0A=
		hwif->ultra_mask =3D 0x07; /* UDMA 0-2 */=0A=
		hwif->mwdma_mask =3D 0x07; /* Multiword DMA 0-2 */=0A=
		hwif->swdma_mask =3D 0x07; /* Singleword DMA 0-2 */=0A=
	}=0A=
=0A=
	/* actually reset and configure the crisv32 ide/ata interface */=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
=0A=
	/* pull the chosen /reset-line low */=0A=
	ctrl0.rst =3D regk_ata_active;=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
=0A=
	/* wait some */=0A=
	udelay(25);=0A=
=0A=
	/* de-assert bus-reset */=0A=
	ctrl0.rst =3D regk_ata_inactive;=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
=0A=
	ctrl0.en =3D regk_ata_yes;=0A=
	ctrl0.dma_strb =3D ATA_DMA2_STROBE;=0A=
	ctrl0.dma_hold =3D ATA_DMA2_HOLD;=0A=
	ctrl0.pio_setup =3D ATA_PIO4_SETUP;=0A=
	ctrl0.pio_strb =3D ATA_PIO4_STROBE;=0A=
	ctrl0.pio_hold =3D ATA_PIO4_HOLD;=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
=0A=
	ctrl1.udma_tcyc =3D ATA_UDMA2_CYC;=0A=
	ctrl1.udma_tdvs =3D ATA_UDMA2_DVS;=0A=
	REG_WR(ata, regi_ata, rw_ctrl1, ctrl1);=0A=
=0A=
	intr_mask.bus0 =3D regk_ata_yes;=0A=
	intr_mask.bus1 =3D regk_ata_yes;=0A=
	intr_mask.bus2 =3D regk_ata_yes;		=0A=
	intr_mask.bus3 =3D regk_ata_yes;=0A=
=0A=
	REG_WR(ata, regi_ata, rw_intr_mask, intr_mask);=0A=
=0A=
	crisv32_request_dma(2, "ETRAX FS built-in ATA", DMA_VERBOSE_ON_ERROR, =
0, dma_ata);=0A=
	crisv32_request_dma(3, "ETRAX FS built-in ATA", DMA_VERBOSE_ON_ERROR, =
0, dma_ata);=0A=
        =0A=
	crisv32_pinmux_alloc_fixed(pinmux_ata);=0A=
	crisv32_pinmux_alloc_fixed(pinmux_ata0);=0A=
	crisv32_pinmux_alloc_fixed(pinmux_ata1);=0A=
	crisv32_pinmux_alloc_fixed(pinmux_ata2);=0A=
	crisv32_pinmux_alloc_fixed(pinmux_ata3);=0A=
=0A=
	DMA_RESET(regi_dma2);=0A=
	DMA_ENABLE(regi_dma2);=0A=
	DMA_RESET(regi_dma3);=0A=
	DMA_ENABLE(regi_dma3);=0A=
=0A=
	DMA_WR_CMD (regi_dma2, regk_dma_set_w_size2);=0A=
	DMA_WR_CMD (regi_dma3, regk_dma_set_w_size2);=0A=
}=0A=
=0A=
static int crisv32_dma_off (ide_drive_t *drive)=0A=
{=0A=
	return 0;=0A=
}=0A=
=0A=
static int crisv32_dma_on (ide_drive_t *drive)=0A=
{=0A=
	return 0;=0A=
}=0A=
=0A=
static dma_descr_context mycontext __attribute__ ((__aligned__(32)));=0A=
static dma_descr_data mydescr __attribute__ ((__aligned__(16)));=0A=
=0A=
/*=0A=
 * The following routines are mainly used by the ATAPI drivers.=0A=
 *=0A=
 * These routines will round up any request for an odd number of bytes,=0A=
 * so if an odd bytecount is specified, be sure that there's at least one=0A=
 * extra byte allocated for the buffer.=0A=
 */=0A=
static void=0A=
crisv32_atapi_input_bytes (ide_drive_t *drive, void *buffer, unsigned =
int bytecount)=0A=
{=0A=
	reg_ata_rw_trf_cnt trf_cnt =3D {0};=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D REG_TYPE_CONV(reg_ata_rw_ctrl2, int, =
IDE_DATA_REG);=0A=
	reg_dma_rw_stat status;=0A=
	unsigned char* d;=0A=
=0A=
	D(printk("atapi_input_bytes, buffer 0x%x, count %d\n",=0A=
	         buffer, bytecount));=0A=
=0A=
	if(bytecount & 1) {=0A=
		printk("warning, odd bytecount in cdrom_in_bytes =3D %d.\n", =
bytecount);=0A=
		bytecount++; /* to round off */=0A=
	}=0A=
=0A=
	/* setup DMA descriptor */=0A=
=0A=
	mydescr.eol =3D 1;=0A=
	mydescr.buf =3D (char*)virt_to_phys(buffer);=0A=
	mydescr.after =3D mydescr.buf + bytecount;=0A=
	mycontext.saved_data =3D (dma_descr_data*)virt_to_phys(&mydescr);=0A=
	mycontext.saved_data_buf =3D mydescr.buf;=0A=
=0A=
	/* start the dma channel */=0A=
	DMA_START_CONTEXT(regi_dma3, virt_to_phys(&mycontext));=0A=
=0A=
	/* initiate a multi word dma read using PIO handshaking */=0A=
	trf_cnt.cnt =3D bytecount >> 1;=0A=
	REG_WR(ata, regi_ata, rw_trf_cnt, trf_cnt);=0A=
=0A=
	d =3D buffer;=0A=
        =0A=
	ctrl2.rw =3D regk_ata_rd;=0A=
	ctrl2.trf_mode =3D regk_ata_dma;=0A=
	ctrl2.hsh =3D regk_ata_pio;=0A=
	ctrl2.multi =3D regk_ata_yes;=0A=
	ctrl2.dma_size =3D regk_ata_word;=0A=
	REG_WR(ata, regi_ata, rw_ctrl2, ctrl2);=0A=
=0A=
	/* wait for completion */=0A=
	LED_DISK_READ(1);=0A=
	do=0A=
	{=0A=
		status =3D REG_RD(dma, regi_dma3, rw_stat);=0A=
	} while(status.list_state !=3D regk_dma_data_at_eol);=0A=
	LED_DISK_READ(0);=0A=
}=0A=
=0A=
static void=0A=
crisv32_atapi_output_bytes (ide_drive_t *drive, void *buffer, unsigned =
int bytecount)=0A=
{=0A=
	reg_ata_rw_trf_cnt trf_cnt =3D {0};=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D REG_TYPE_CONV(reg_ata_rw_ctrl2, int, =
IDE_DATA_REG);=0A=
	reg_dma_rw_stat status;=0A=
=0A=
	D(printk("atapi_output_bytes, dreg 0x%x, buffer 0x%x, count %d\n",=0A=
		 0, buffer, bytecount));=0A=
=0A=
	if(bytecount & 1) {=0A=
		printk("odd bytecount %d in atapi_out_bytes!\n", bytecount);=0A=
		bytecount++;=0A=
	}=0A=
=0A=
	/* setup DMA descriptor */=0A=
=0A=
	mydescr.eol =3D 1;=0A=
	mydescr.buf =3D (char*)virt_to_phys(buffer);=0A=
	mydescr.after =3D mydescr.buf + bytecount;=0A=
	mycontext.saved_data =3D (dma_descr_data*)virt_to_phys(&mydescr);=0A=
	mycontext.saved_data_buf =3D mydescr.buf;=0A=
=0A=
	/* start the dma channel */=0A=
	DMA_START_CONTEXT(regi_dma2, virt_to_phys(&mycontext));=0A=
=0A=
	/* initiate a multi word dma write using PIO handshaking */=0A=
	trf_cnt.cnt =3D bytecount >> 1;=0A=
	REG_WR(ata, regi_ata, rw_trf_cnt, trf_cnt);	=0A=
=0A=
	ctrl2.rw =3D regk_ata_wr;=0A=
	ctrl2.trf_mode =3D regk_ata_dma;=0A=
	ctrl2.hsh =3D regk_ata_pio;=0A=
	ctrl2.multi =3D regk_ata_yes;=0A=
	ctrl2.dma_size =3D regk_ata_word;=0A=
	REG_WR(ata, regi_ata, rw_ctrl2, ctrl2);=0A=
=0A=
	/* wait for completion */=0A=
=0A=
	LED_DISK_WRITE(1);=0A=
	LED_DISK_READ(1);=0A=
	do=0A=
	{=0A=
		status =3D REG_RD(dma, regi_dma2, rw_stat);=0A=
	} while(status.list_state !=3D regk_dma_data_at_eol);=0A=
	LED_DISK_WRITE(0);=0A=
}=0A=
=0A=
/*=0A=
 * This is used for most PIO data transfers *from* the IDE interface=0A=
 */=0A=
static void=0A=
crisv32_ide_input_data (ide_drive_t *drive, void *buffer, unsigned int =
wcount)=0A=
{=0A=
	crisv32_atapi_input_bytes(drive, buffer, wcount << 2);=0A=
}=0A=
=0A=
/*=0A=
 * This is used for most PIO data transfers *to* the IDE interface=0A=
 */=0A=
static void=0A=
crisv32_ide_output_data (ide_drive_t *drive, void *buffer, unsigned int =
wcount)=0A=
{=0A=
	crisv32_atapi_output_bytes(drive, buffer, wcount << 2);=0A=
}=0A=
=0A=
/* we only have one DMA channel on the chip for ATA, so we can keep =
these statically */=0A=
static dma_descr_data ata_descrs[MAX_DMA_DESCRS] __attribute__ =
((__aligned__(16)));=0A=
static unsigned int ata_tot_size;=0A=
=0A=
/*=0A=
 * crisv32_ide_build_dmatable() prepares a dma request.=0A=
 * Returns 0 if all went okay, returns 1 otherwise.=0A=
 */=0A=
static int crisv32_ide_build_dmatable (ide_drive_t *drive)=0A=
{=0A=
	ide_hwif_t *hwif =3D drive->hwif;=0A=
	struct scatterlist* sg;=0A=
	struct request *rq  =3D drive->hwif->hwgroup->rq;=0A=
	unsigned long size, addr;=0A=
	unsigned int count =3D 0;=0A=
	int i =3D 0;=0A=
=0A=
	sg =3D hwif->sg_table;=0A=
=0A=
	ata_tot_size =3D 0;=0A=
=0A=
	ide_map_sg(drive, rq);=0A=
	i =3D hwif->sg_nents;=0A=
=0A=
	while(i) {=0A=
		/*=0A=
		 * Determine addr and size of next buffer area.  We assume that=0A=
		 * individual virtual buffers are always composed linearly in=0A=
		 * physical memory.  For example, we assume that any 8kB buffer=0A=
		 * is always composed of two adjacent physical 4kB pages rather=0A=
		 * than two possibly non-adjacent physical 4kB pages.=0A=
		 */=0A=
		/* group sequential buffers into one large buffer */=0A=
		addr =3D page_to_phys(sg->page) + sg->offset;=0A=
		size =3D sg_dma_len(sg);=0A=
		while (sg++, --i) {=0A=
			if ((addr + size) !=3D page_to_phys(sg->page) + sg->offset)=0A=
				break;=0A=
			size +=3D sg_dma_len(sg);=0A=
		}=0A=
=0A=
		/* did we run out of descriptors? */=0A=
=0A=
		if(count >=3D MAX_DMA_DESCRS) {=0A=
			printk("%s: too few DMA descriptors\n", drive->name);=0A=
			return 1;=0A=
		}=0A=
=0A=
		/* however, this case is more difficult - rw_trf_cnt cannot be more=0A=
		   than 65536 words per transfer, so in that case we need to either=0A=
		   1) use a DMA interrupt to re-trigger rw_trf_cnt and continue with=0A=
		      the descriptors, or=0A=
		   2) simply do the request here, and get dma_intr to only =
ide_end_request on=0A=
		      those blocks that were actually set-up for transfer.=0A=
		*/=0A=
=0A=
		if(ata_tot_size + size > 131072) {=0A=
			printk("too large total ATA DMA request, %d + %d!\n", ata_tot_size, =
(int)size);=0A=
			return 1;=0A=
		}=0A=
=0A=
		ata_descrs[count].eol =3D 0;=0A=
		ata_descrs[count].buf =3D (char*)addr;=0A=
		ata_descrs[count].after =3D ata_descrs[count].buf + size;=0A=
		ata_descrs[count].next =3D =
(dma_descr_data*)virt_to_phys(&ata_descrs[count + 1]);=0A=
		count++;=0A=
		ata_tot_size +=3D size;=0A=
	}=0A=
=0A=
	if (count) {=0A=
		/* set the end-of-list flag on the last descriptor */=0A=
		ata_descrs[count - 1].eol =3D 1;=0A=
		/* return and say all is ok */=0A=
		return 0;=0A=
	}=0A=
=0A=
	printk("%s: empty DMA table?\n", drive->name);=0A=
	return 1;	/* let the PIO routines handle this weirdness */=0A=
}=0A=
=0A=
static int config_drive_for_dma (ide_drive_t *drive)=0A=
{=0A=
	struct hd_driveid *id =3D drive->id;=0A=
=0A=
	if (id && (id->capability & 1)) {=0A=
		/* Enable DMA on any drive that supports mword2 DMA */=0A=
		if ((id->field_valid & 2) && =0A=
		    ((id->dma_mword & 0xff00) || (id->dma_ultra & 0xff00))) {=0A=
			drive->using_dma =3D 1;=0A=
			return 0;               /* DMA enabled */=0A=
		}=0A=
	}=0A=
	drive->using_dma =3D 0;=0A=
	return 0;       /* DMA not enabled */=0A=
}=0A=
=0A=
/*=0A=
 * crisv32_dma_intr() is the handler for disk read/write DMA interrupts=0A=
 */=0A=
static ide_startstop_t crisv32_dma_intr (ide_drive_t *drive)=0A=
{=0A=
	LED_DISK_READ(0);=0A=
	LED_DISK_WRITE(0);=0A=
=0A=
	return ide_dma_intr(drive);=0A=
}=0A=
=0A=
/*=0A=
 * Functions below initiates/aborts DMA read/write operations on a drive.=0A=
 *=0A=
 * The caller is assumed to have selected the drive and programmed the =
drive's=0A=
 * sector address using CHS or LBA.  All that remains is to prepare for =
DMA=0A=
 * and then issue the actual read/write DMA/PIO command to the drive.=0A=
 *=0A=
 * For ATAPI devices, we just prepare for DMA and return. The caller =
should=0A=
 * then issue the packet command to the drive and call us again with=0A=
 * ide_dma_begin afterwards.=0A=
 *=0A=
 * Returns 0 if all went well.=0A=
 * Returns 1 if DMA read/write could not be started, in which case=0A=
 * the caller should revert to PIO for the current request.=0A=
 */=0A=
=0A=
static int crisv32_dma_check(ide_drive_t *drive)=0A=
{=0A=
	int speed =3D ide_dma_speed(drive, 0); /* No UDMA for now */=0A=
	speed_crisv32_ide(drive, speed);=0A=
	ide_config_drive_speed(drive, speed);=0A=
	return config_drive_for_dma (drive);=0A=
}=0A=
=0A=
static int crisv32_dma_end(ide_drive_t *drive)=0A=
{=0A=
	drive->waiting_for_dma =3D 0;=0A=
	return 0;=0A=
}=0A=
=0A=
static int crisv32_prepare_dma(ide_drive_t *drive, int atapi, int =
reading)=0A=
{=0A=
	struct request *rq =3D drive->hwif->hwgroup->rq;=0A=
	if (crisv32_ide_build_dmatable (drive)) {=0A=
		ide_map_sg(drive, rq);=0A=
		return 1;=0A=
	}=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static int crisv32_dma_setup(ide_drive_t *drive)=0A=
{=0A=
	struct request *rq =3D drive->hwif->hwgroup->rq;=0A=
	int ret;=0A=
	if (rq_data_dir(rq))=0A=
		ret =3D crisv32_prepare_dma(drive, 0, 0);=0A=
        else=0A=
		ret =3D crisv32_prepare_dma(drive, 0, 1);=0A=
	if (ret)=0A=
		return ret;=0A=
	drive->waiting_for_dma =3D 1;=0A=
	return 0;=0A=
}=0A=
=0A=
static void crisv32_dma_exec_cmd(ide_drive_t *drive, u8 command)=0A=
{=0A=
	/* set the irq handler which will finish the request when DMA is done */=0A=
	ide_set_handler(drive, &crisv32_dma_intr, WAIT_CMD, NULL);=0A=
=0A=
	/* issue cmd to drive */=0A=
	crisv32_ide_outb(command, IDE_COMMAND_REG);=0A=
}=0A=
=0A=
static int crisv32_dma_test_irq(ide_drive_t *drive)=0A=
{=0A=
	int intr =3D REG_RD_INT(ata, regi_ata, r_intr);=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D REG_TYPE_CONV(reg_ata_rw_ctrl2, int, =
IDE_DATA_REG);=0A=
	return intr & (1 << ctrl2.sel) ? 1 : 0;=0A=
}=0A=
=0A=
=0A=
static void crisv32_dma_start(ide_drive_t *drive)=0A=
{=0A=
	struct request *rq =3D drive->hwif->hwgroup->rq;=0A=
	reg_ata_rw_trf_cnt trf_cnt =3D {0};=0A=
	int writing =3D rq_data_dir(rq);=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D REG_TYPE_CONV(reg_ata_rw_ctrl2, int, =
IDE_DATA_REG);=0A=
=0A=
	/* initiate a multi word dma read using DMA handshaking */=0A=
	mycontext.saved_data =3D (dma_descr_data*)virt_to_phys(&ata_descrs[0]);=0A=
	mycontext.saved_data_buf =3D ata_descrs[0].buf;=0A=
=0A=
	if (writing)=0A=
		DMA_START_CONTEXT(regi_dma2, virt_to_phys(&mycontext));=0A=
	else=0A=
		DMA_START_CONTEXT(regi_dma3, virt_to_phys(&mycontext));=0A=
=0A=
	trf_cnt.cnt =3D ata_tot_size >> 1;=0A=
	ctrl2.rw =3D writing ? regk_ata_wr : regk_ata_rd;=0A=
	ctrl2.trf_mode =3D regk_ata_dma;=0A=
	if (drive->current_speed >=3D XFER_UDMA_0) {=0A=
		/* Due to a "feature" the transfer count has to be one extra word for =
UDMA. */=0A=
		trf_cnt.cnt++;=0A=
		ctrl2.hsh =3D regk_ata_udma;=0A=
	}=0A=
	else=0A=
		ctrl2.hsh =3D regk_ata_dma;=0A=
	ctrl2.multi =3D regk_ata_yes;=0A=
	ctrl2.dma_size =3D regk_ata_word;=0A=
	REG_WR(ata, regi_ata, rw_trf_cnt, trf_cnt);=0A=
	REG_WR(ata, regi_ata, rw_ctrl2, ctrl2);=0A=
=0A=
	if (writing) {=0A=
		LED_DISK_WRITE(1);=0A=
	} else {=0A=
		LED_DISK_READ(1);=0A=
	}=0A=
}=0A=
=0A=

------=_NextPart_000_0D38_01C56D03.2A60E5D0
Content-Type: application/octet-stream;
	name="dma_defs.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dma_defs.h"

#ifndef __dma_defs_h=0A=
#define __dma_defs_h=0A=
=0A=
/*=0A=
 * This file is autogenerated from=0A=
 *   file:           ../../inst/dma/inst/dma_common/rtl/dma_regdes.r=0A=
 *     id:           dma_regdes.r,v 1.39 2005/02/10 14:07:23 janb Exp =0A=
 *     last modfied: Mon Apr 11 16:06:51 2005=0A=
 * =0A=
 *   by /n/asic/design/tools/rdesc/src/rdes2c --outfile dma_defs.h =
../../inst/dma/inst/dma_common/rtl/dma_regdes.r=0A=
 *      id: $Id: dma_defs.h,v 1.7 2005/04/24 18:30:58 starvik Exp $=0A=
 * Any changes here will be lost.=0A=
 *=0A=
 * -*- buffer-read-only: t -*-=0A=
 */=0A=
/* Main access macros */=0A=
#ifndef REG_RD=0A=
#define REG_RD( scope, inst, reg ) \=0A=
  REG_READ( reg_##scope##_##reg, \=0A=
            (inst) + REG_RD_ADDR_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_WR=0A=
#define REG_WR( scope, inst, reg, val ) \=0A=
  REG_WRITE( reg_##scope##_##reg, \=0A=
             (inst) + REG_WR_ADDR_##scope##_##reg, (val) )=0A=
#endif=0A=
=0A=
#ifndef REG_RD_VECT=0A=
#define REG_RD_VECT( scope, inst, reg, index ) \=0A=
  REG_READ( reg_##scope##_##reg, \=0A=
            (inst) + REG_RD_ADDR_##scope##_##reg + \=0A=
	    (index) * STRIDE_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_WR_VECT=0A=
#define REG_WR_VECT( scope, inst, reg, index, val ) \=0A=
  REG_WRITE( reg_##scope##_##reg, \=0A=
             (inst) + REG_WR_ADDR_##scope##_##reg + \=0A=
	     (index) * STRIDE_##scope##_##reg, (val) )=0A=
#endif=0A=
=0A=
#ifndef REG_RD_INT=0A=
#define REG_RD_INT( scope, inst, reg ) \=0A=
  REG_READ( int, (inst) + REG_RD_ADDR_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_WR_INT=0A=
#define REG_WR_INT( scope, inst, reg, val ) \=0A=
  REG_WRITE( int, (inst) + REG_WR_ADDR_##scope##_##reg, (val) )=0A=
#endif=0A=
=0A=
#ifndef REG_RD_INT_VECT=0A=
#define REG_RD_INT_VECT( scope, inst, reg, index ) \=0A=
  REG_READ( int, (inst) + REG_RD_ADDR_##scope##_##reg + \=0A=
	    (index) * STRIDE_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_WR_INT_VECT=0A=
#define REG_WR_INT_VECT( scope, inst, reg, index, val ) \=0A=
  REG_WRITE( int, (inst) + REG_WR_ADDR_##scope##_##reg + \=0A=
	     (index) * STRIDE_##scope##_##reg, (val) )=0A=
#endif=0A=
=0A=
#ifndef REG_TYPE_CONV=0A=
#define REG_TYPE_CONV( type, orgtype, val ) \=0A=
  ( { union { orgtype o; type n; } r; r.o =3D val; r.n; } )=0A=
#endif=0A=
=0A=
#ifndef reg_page_size=0A=
#define reg_page_size 8192=0A=
#endif=0A=
=0A=
#ifndef REG_ADDR=0A=
#define REG_ADDR( scope, inst, reg ) \=0A=
  ( (inst) + REG_RD_ADDR_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_ADDR_VECT=0A=
#define REG_ADDR_VECT( scope, inst, reg, index ) \=0A=
  ( (inst) + REG_RD_ADDR_##scope##_##reg + \=0A=
    (index) * STRIDE_##scope##_##reg )=0A=
#endif=0A=
=0A=
/* C-code for register scope dma */=0A=
=0A=
/* Register rw_data, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_data;=0A=
#define REG_RD_ADDR_dma_rw_data 0=0A=
#define REG_WR_ADDR_dma_rw_data 0=0A=
=0A=
/* Register rw_data_next, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_data_next;=0A=
#define REG_RD_ADDR_dma_rw_data_next 4=0A=
#define REG_WR_ADDR_dma_rw_data_next 4=0A=
=0A=
/* Register rw_data_buf, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_data_buf;=0A=
#define REG_RD_ADDR_dma_rw_data_buf 8=0A=
#define REG_WR_ADDR_dma_rw_data_buf 8=0A=
=0A=
/* Register rw_data_ctrl, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int eol     : 1;=0A=
  unsigned int dummy1  : 2;=0A=
  unsigned int out_eop : 1;=0A=
  unsigned int intr    : 1;=0A=
  unsigned int wait    : 1;=0A=
  unsigned int dummy2  : 26;=0A=
} reg_dma_rw_data_ctrl;=0A=
#define REG_RD_ADDR_dma_rw_data_ctrl 12=0A=
#define REG_WR_ADDR_dma_rw_data_ctrl 12=0A=
=0A=
/* Register rw_data_stat, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int dummy1 : 3;=0A=
  unsigned int in_eop : 1;=0A=
  unsigned int dummy2 : 28;=0A=
} reg_dma_rw_data_stat;=0A=
#define REG_RD_ADDR_dma_rw_data_stat 16=0A=
#define REG_WR_ADDR_dma_rw_data_stat 16=0A=
=0A=
/* Register rw_data_md, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int md : 16;=0A=
  unsigned int dummy1 : 16;=0A=
} reg_dma_rw_data_md;=0A=
#define REG_RD_ADDR_dma_rw_data_md 20=0A=
#define REG_WR_ADDR_dma_rw_data_md 20=0A=
=0A=
/* Register rw_data_md_s, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int md_s : 16;=0A=
  unsigned int dummy1 : 16;=0A=
} reg_dma_rw_data_md_s;=0A=
#define REG_RD_ADDR_dma_rw_data_md_s 24=0A=
#define REG_WR_ADDR_dma_rw_data_md_s 24=0A=
=0A=
/* Register rw_data_after, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_data_after;=0A=
#define REG_RD_ADDR_dma_rw_data_after 28=0A=
#define REG_WR_ADDR_dma_rw_data_after 28=0A=
=0A=
/* Register rw_ctxt, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt;=0A=
#define REG_RD_ADDR_dma_rw_ctxt 32=0A=
#define REG_WR_ADDR_dma_rw_ctxt 32=0A=
=0A=
/* Register rw_ctxt_next, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt_next;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_next 36=0A=
#define REG_WR_ADDR_dma_rw_ctxt_next 36=0A=
=0A=
/* Register rw_ctxt_ctrl, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int eol        : 1;=0A=
  unsigned int dummy1     : 3;=0A=
  unsigned int intr       : 1;=0A=
  unsigned int dummy2     : 1;=0A=
  unsigned int store_mode : 1;=0A=
  unsigned int en         : 1;=0A=
  unsigned int dummy3     : 24;=0A=
} reg_dma_rw_ctxt_ctrl;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_ctrl 40=0A=
#define REG_WR_ADDR_dma_rw_ctxt_ctrl 40=0A=
=0A=
/* Register rw_ctxt_stat, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int dummy1 : 7;=0A=
  unsigned int dis : 1;=0A=
  unsigned int dummy2 : 24;=0A=
} reg_dma_rw_ctxt_stat;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_stat 44=0A=
#define REG_WR_ADDR_dma_rw_ctxt_stat 44=0A=
=0A=
/* Register rw_ctxt_md0, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int md0 : 16;=0A=
  unsigned int dummy1 : 16;=0A=
} reg_dma_rw_ctxt_md0;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md0 48=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md0 48=0A=
=0A=
/* Register rw_ctxt_md0_s, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int md0_s : 16;=0A=
  unsigned int dummy1 : 16;=0A=
} reg_dma_rw_ctxt_md0_s;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md0_s 52=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md0_s 52=0A=
=0A=
/* Register rw_ctxt_md1, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt_md1;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md1 56=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md1 56=0A=
=0A=
/* Register rw_ctxt_md1_s, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt_md1_s;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md1_s 60=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md1_s 60=0A=
=0A=
/* Register rw_ctxt_md2, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt_md2;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md2 64=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md2 64=0A=
=0A=
/* Register rw_ctxt_md2_s, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt_md2_s;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md2_s 68=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md2_s 68=0A=
=0A=
/* Register rw_ctxt_md3, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt_md3;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md3 72=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md3 72=0A=
=0A=
/* Register rw_ctxt_md3_s, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt_md3_s;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md3_s 76=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md3_s 76=0A=
=0A=
/* Register rw_ctxt_md4, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt_md4;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md4 80=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md4 80=0A=
=0A=
/* Register rw_ctxt_md4_s, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_ctxt_md4_s;=0A=
#define REG_RD_ADDR_dma_rw_ctxt_md4_s 84=0A=
#define REG_WR_ADDR_dma_rw_ctxt_md4_s 84=0A=
=0A=
/* Register rw_saved_data, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_saved_data;=0A=
#define REG_RD_ADDR_dma_rw_saved_data 88=0A=
#define REG_WR_ADDR_dma_rw_saved_data 88=0A=
=0A=
/* Register rw_saved_data_buf, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_saved_data_buf;=0A=
#define REG_RD_ADDR_dma_rw_saved_data_buf 92=0A=
#define REG_WR_ADDR_dma_rw_saved_data_buf 92=0A=
=0A=
/* Register rw_group, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_group;=0A=
#define REG_RD_ADDR_dma_rw_group 96=0A=
#define REG_WR_ADDR_dma_rw_group 96=0A=
=0A=
/* Register rw_group_next, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_group_next;=0A=
#define REG_RD_ADDR_dma_rw_group_next 100=0A=
#define REG_WR_ADDR_dma_rw_group_next 100=0A=
=0A=
/* Register rw_group_ctrl, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int eol  : 1;=0A=
  unsigned int tol  : 1;=0A=
  unsigned int bol  : 1;=0A=
  unsigned int dummy1 : 1;=0A=
  unsigned int intr : 1;=0A=
  unsigned int dummy2 : 2;=0A=
  unsigned int en   : 1;=0A=
  unsigned int dummy3 : 24;=0A=
} reg_dma_rw_group_ctrl;=0A=
#define REG_RD_ADDR_dma_rw_group_ctrl 104=0A=
#define REG_WR_ADDR_dma_rw_group_ctrl 104=0A=
=0A=
/* Register rw_group_stat, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int dummy1 : 7;=0A=
  unsigned int dis : 1;=0A=
  unsigned int dummy2 : 24;=0A=
} reg_dma_rw_group_stat;=0A=
#define REG_RD_ADDR_dma_rw_group_stat 108=0A=
#define REG_WR_ADDR_dma_rw_group_stat 108=0A=
=0A=
/* Register rw_group_md, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int md : 16;=0A=
  unsigned int dummy1 : 16;=0A=
} reg_dma_rw_group_md;=0A=
#define REG_RD_ADDR_dma_rw_group_md 112=0A=
#define REG_WR_ADDR_dma_rw_group_md 112=0A=
=0A=
/* Register rw_group_md_s, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int md_s : 16;=0A=
  unsigned int dummy1 : 16;=0A=
} reg_dma_rw_group_md_s;=0A=
#define REG_RD_ADDR_dma_rw_group_md_s 116=0A=
#define REG_WR_ADDR_dma_rw_group_md_s 116=0A=
=0A=
/* Register rw_group_up, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_group_up;=0A=
#define REG_RD_ADDR_dma_rw_group_up 120=0A=
#define REG_WR_ADDR_dma_rw_group_up 120=0A=
=0A=
/* Register rw_group_down, scope dma, type rw */=0A=
typedef unsigned int reg_dma_rw_group_down;=0A=
#define REG_RD_ADDR_dma_rw_group_down 124=0A=
#define REG_WR_ADDR_dma_rw_group_down 124=0A=
=0A=
/* Register rw_cmd, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int cont_data : 1;=0A=
  unsigned int dummy1    : 31;=0A=
} reg_dma_rw_cmd;=0A=
#define REG_RD_ADDR_dma_rw_cmd 128=0A=
#define REG_WR_ADDR_dma_rw_cmd 128=0A=
=0A=
/* Register rw_cfg, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int en   : 1;=0A=
  unsigned int stop : 1;=0A=
  unsigned int dummy1 : 30;=0A=
} reg_dma_rw_cfg;=0A=
#define REG_RD_ADDR_dma_rw_cfg 132=0A=
#define REG_WR_ADDR_dma_rw_cfg 132=0A=
=0A=
/* Register rw_stat, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int mode           : 5;=0A=
  unsigned int list_state     : 3;=0A=
  unsigned int stream_cmd_src : 8;=0A=
  unsigned int dummy1         : 8;=0A=
  unsigned int buf            : 8;=0A=
} reg_dma_rw_stat;=0A=
#define REG_RD_ADDR_dma_rw_stat 136=0A=
#define REG_WR_ADDR_dma_rw_stat 136=0A=
=0A=
/* Register rw_intr_mask, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int group      : 1;=0A=
  unsigned int ctxt       : 1;=0A=
  unsigned int data       : 1;=0A=
  unsigned int in_eop     : 1;=0A=
  unsigned int stream_cmd : 1;=0A=
  unsigned int dummy1     : 27;=0A=
} reg_dma_rw_intr_mask;=0A=
#define REG_RD_ADDR_dma_rw_intr_mask 140=0A=
#define REG_WR_ADDR_dma_rw_intr_mask 140=0A=
=0A=
/* Register rw_ack_intr, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int group      : 1;=0A=
  unsigned int ctxt       : 1;=0A=
  unsigned int data       : 1;=0A=
  unsigned int in_eop     : 1;=0A=
  unsigned int stream_cmd : 1;=0A=
  unsigned int dummy1     : 27;=0A=
} reg_dma_rw_ack_intr;=0A=
#define REG_RD_ADDR_dma_rw_ack_intr 144=0A=
#define REG_WR_ADDR_dma_rw_ack_intr 144=0A=
=0A=
/* Register r_intr, scope dma, type r */=0A=
typedef struct {=0A=
  unsigned int group      : 1;=0A=
  unsigned int ctxt       : 1;=0A=
  unsigned int data       : 1;=0A=
  unsigned int in_eop     : 1;=0A=
  unsigned int stream_cmd : 1;=0A=
  unsigned int dummy1     : 27;=0A=
} reg_dma_r_intr;=0A=
#define REG_RD_ADDR_dma_r_intr 148=0A=
=0A=
/* Register r_masked_intr, scope dma, type r */=0A=
typedef struct {=0A=
  unsigned int group      : 1;=0A=
  unsigned int ctxt       : 1;=0A=
  unsigned int data       : 1;=0A=
  unsigned int in_eop     : 1;=0A=
  unsigned int stream_cmd : 1;=0A=
  unsigned int dummy1     : 27;=0A=
} reg_dma_r_masked_intr;=0A=
#define REG_RD_ADDR_dma_r_masked_intr 152=0A=
=0A=
/* Register rw_stream_cmd, scope dma, type rw */=0A=
typedef struct {=0A=
  unsigned int cmd  : 10;=0A=
  unsigned int dummy1 : 6;=0A=
  unsigned int n    : 8;=0A=
  unsigned int dummy2 : 7;=0A=
  unsigned int busy : 1;=0A=
} reg_dma_rw_stream_cmd;=0A=
#define REG_RD_ADDR_dma_rw_stream_cmd 156=0A=
#define REG_WR_ADDR_dma_rw_stream_cmd 156=0A=
=0A=
=0A=
/* Constants */=0A=
enum {=0A=
  regk_dma_ack_pkt                         =3D 0x00000100,=0A=
  regk_dma_anytime                         =3D 0x00000001,=0A=
  regk_dma_array                           =3D 0x00000008,=0A=
  regk_dma_burst                           =3D 0x00000020,=0A=
  regk_dma_client                          =3D 0x00000002,=0A=
  regk_dma_copy_next                       =3D 0x00000010,=0A=
  regk_dma_copy_up                         =3D 0x00000020,=0A=
  regk_dma_data_at_eol                     =3D 0x00000001,=0A=
  regk_dma_dis_c                           =3D 0x00000010,=0A=
  regk_dma_dis_g                           =3D 0x00000020,=0A=
  regk_dma_idle                            =3D 0x00000001,=0A=
  regk_dma_intern                          =3D 0x00000004,=0A=
  regk_dma_load_c                          =3D 0x00000200,=0A=
  regk_dma_load_c_n                        =3D 0x00000280,=0A=
  regk_dma_load_c_next                     =3D 0x00000240,=0A=
  regk_dma_load_d                          =3D 0x00000140,=0A=
  regk_dma_load_g                          =3D 0x00000300,=0A=
  regk_dma_load_g_down                     =3D 0x000003c0,=0A=
  regk_dma_load_g_next                     =3D 0x00000340,=0A=
  regk_dma_load_g_up                       =3D 0x00000380,=0A=
  regk_dma_next_en                         =3D 0x00000010,=0A=
  regk_dma_next_pkt                        =3D 0x00000010,=0A=
  regk_dma_no                              =3D 0x00000000,=0A=
  regk_dma_only_at_wait                    =3D 0x00000000,=0A=
  regk_dma_restore                         =3D 0x00000020,=0A=
  regk_dma_rst                             =3D 0x00000001,=0A=
  regk_dma_running                         =3D 0x00000004,=0A=
  regk_dma_rw_cfg_default                  =3D 0x00000000,=0A=
  regk_dma_rw_cmd_default                  =3D 0x00000000,=0A=
  regk_dma_rw_intr_mask_default            =3D 0x00000000,=0A=
  regk_dma_rw_stat_default                 =3D 0x00000101,=0A=
  regk_dma_rw_stream_cmd_default           =3D 0x00000000,=0A=
  regk_dma_save_down                       =3D 0x00000020,=0A=
  regk_dma_save_up                         =3D 0x00000020,=0A=
  regk_dma_set_reg                         =3D 0x00000050,=0A=
  regk_dma_set_w_size1                     =3D 0x00000190,=0A=
  regk_dma_set_w_size2                     =3D 0x000001a0,=0A=
  regk_dma_set_w_size4                     =3D 0x000001c0,=0A=
  regk_dma_stopped                         =3D 0x00000002,=0A=
  regk_dma_store_c                         =3D 0x00000002,=0A=
  regk_dma_store_descr                     =3D 0x00000000,=0A=
  regk_dma_store_g                         =3D 0x00000004,=0A=
  regk_dma_store_md                        =3D 0x00000001,=0A=
  regk_dma_sw                              =3D 0x00000008,=0A=
  regk_dma_update_down                     =3D 0x00000020,=0A=
  regk_dma_yes                             =3D 0x00000001=0A=
};=0A=
#endif /* __dma_defs_h */=0A=

------=_NextPart_000_0D38_01C56D03.2A60E5D0
Content-Type: application/octet-stream;
	name="dma.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dma.h"

/* $Id: dma.h,v 1.7 2005/04/24 18:30:58 starvik Exp $=0A=
 *=0A=
 * DMA C definitions and help macros =0A=
 *=0A=
 */=0A=
=0A=
#ifndef dma_h=0A=
#define dma_h=0A=
=0A=
/* registers */ /* Really needed, since both are listed in sw.list? */=0A=
#include "dma_defs.h"=0A=
=0A=
=0A=
/* descriptors */=0A=
=0A=
// ------------------------------------------------------------ =
dma_descr_group=0A=
typedef struct dma_descr_group {=0A=
  struct dma_descr_group       *next;=0A=
  unsigned                      eol        : 1;=0A=
  unsigned                      tol        : 1;=0A=
  unsigned                      bol        : 1;=0A=
  unsigned                                 : 1;=0A=
  unsigned                      intr       : 1;=0A=
  unsigned                                 : 2;=0A=
  unsigned                      en         : 1;=0A=
  unsigned                                 : 7;=0A=
  unsigned                      dis        : 1;=0A=
  unsigned                      md         : 16;=0A=
  struct dma_descr_group       *up;=0A=
  union {=0A=
    struct dma_descr_context   *context;=0A=
    struct dma_descr_group     *group;=0A=
  }                             down;=0A=
} dma_descr_group;=0A=
=0A=
// ---------------------------------------------------------- =
dma_descr_context=0A=
typedef struct dma_descr_context {=0A=
  struct dma_descr_context     *next;=0A=
  unsigned                      eol        : 1;=0A=
  unsigned                                 : 3;=0A=
  unsigned                      intr       : 1;=0A=
  unsigned                                 : 1;=0A=
  unsigned                      store_mode : 1;=0A=
  unsigned                      en         : 1;=0A=
  unsigned                                 : 7;=0A=
  unsigned                      dis        : 1;=0A=
  unsigned                      md0        : 16;=0A=
  unsigned                      md1;=0A=
  unsigned                      md2;=0A=
  unsigned                      md3;=0A=
  unsigned                      md4;=0A=
  struct dma_descr_data        *saved_data;=0A=
  char                         *saved_data_buf;=0A=
} dma_descr_context;=0A=
=0A=
// ------------------------------------------------------------- =
dma_descr_data=0A=
typedef struct dma_descr_data {=0A=
  struct dma_descr_data        *next;=0A=
  char                         *buf;=0A=
  unsigned                      eol        : 1;=0A=
  unsigned                                 : 2;=0A=
  unsigned                      out_eop    : 1;=0A=
  unsigned                      intr       : 1;=0A=
  unsigned                      wait       : 1;=0A=
  unsigned                                 : 2;=0A=
  unsigned                                 : 3;=0A=
  unsigned                      in_eop     : 1;=0A=
  unsigned                                 : 4;=0A=
  unsigned                      md         : 16;=0A=
  char                         *after;=0A=
} dma_descr_data;=0A=
=0A=
// --------------------------------------------------------------------- =
macros=0A=
=0A=
// enable DMA channel=0A=
#define DMA_ENABLE( inst ) \=0A=
   do { reg_dma_rw_cfg e =3D REG_RD( dma, inst, rw_cfg );\=0A=
        e.en =3D regk_dma_yes; \=0A=
        REG_WR( dma, inst, rw_cfg, e); } while( 0 )=0A=
=0A=
// reset DMA channel=0A=
#define DMA_RESET( inst ) \=0A=
   do { reg_dma_rw_cfg r =3D REG_RD( dma, inst, rw_cfg );\=0A=
        r.en =3D regk_dma_no; \=0A=
        REG_WR( dma, inst, rw_cfg, r); } while( 0 )=0A=
=0A=
// stop DMA channel=0A=
#define DMA_STOP( inst ) \=0A=
   do { reg_dma_rw_cfg s =3D REG_RD( dma, inst, rw_cfg );\=0A=
        s.stop =3D regk_dma_yes; \=0A=
        REG_WR( dma, inst, rw_cfg, s); } while( 0 )=0A=
=0A=
// continue DMA channel operation=0A=
#define DMA_CONTINUE( inst ) \=0A=
   do { reg_dma_rw_cfg c =3D REG_RD( dma, inst, rw_cfg );\=0A=
        c.stop =3D regk_dma_no; \=0A=
        REG_WR( dma, inst, rw_cfg, c); } while( 0 )=0A=
=0A=
// give stream command=0A=
#define DMA_WR_CMD( inst, cmd_par ) \=0A=
   do { reg_dma_rw_stream_cmd r =3D {0}; \=0A=
        do { r =3D REG_RD( dma, inst, rw_stream_cmd ); } while( r.busy =
); \=0A=
        r.cmd =3D (cmd_par); \=0A=
        REG_WR( dma, inst, rw_stream_cmd, r ); \=0A=
      } while( 0 )=0A=
=0A=
// load: g,c,d:burst=0A=
#define DMA_START_GROUP( inst, group_descr ) \=0A=
   do { REG_WR_INT( dma, inst, rw_group, (int) group_descr ); \=0A=
        DMA_WR_CMD( inst, regk_dma_load_g ); \=0A=
        DMA_WR_CMD( inst, regk_dma_load_c ); \=0A=
        DMA_WR_CMD( inst, regk_dma_load_d | regk_dma_burst ); \=0A=
      } while( 0 )=0A=
=0A=
// load: c,d:burst=0A=
#define DMA_START_CONTEXT( inst, ctx_descr ) \=0A=
   do { REG_WR_INT( dma, inst, rw_group_down, (int) ctx_descr ); \=0A=
        DMA_WR_CMD( inst, regk_dma_load_c ); \=0A=
        DMA_WR_CMD( inst, regk_dma_load_d | regk_dma_burst ); \=0A=
      } while( 0 )=0A=
=0A=
// if the DMA is at the end of the data list, the last data descr is =
reloaded=0A=
#define DMA_CONTINUE_DATA( inst ) \=0A=
do { reg_dma_rw_cmd c =3D {0}; \=0A=
     c.cont_data =3D regk_dma_yes;\=0A=
     REG_WR( dma, inst, rw_cmd, c ); } while( 0 )=0A=
=0A=
#endif=0A=

------=_NextPart_000_0D38_01C56D03.2A60E5D0
Content-Type: application/octet-stream;
	name="ata_defs.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ata_defs.h"

#ifndef __ata_defs_h=0A=
#define __ata_defs_h=0A=
=0A=
/*=0A=
 * This file is autogenerated from=0A=
 *   file:           ../../inst/ata/rtl/ata_regs.r=0A=
 *     id:           ata_regs.r,v 1.11 2005/02/09 08:27:36 kriskn Exp =0A=
 *     last modfied: Mon Apr 11 16:06:25 2005=0A=
 * =0A=
 *   by /n/asic/design/tools/rdesc/src/rdes2c --outfile ata_defs.h =
../../inst/ata/rtl/ata_regs.r=0A=
 *      id: $Id: ata_defs.h,v 1.7 2005/04/24 18:30:58 starvik Exp $=0A=
 * Any changes here will be lost.=0A=
 *=0A=
 * -*- buffer-read-only: t -*-=0A=
 */=0A=
/* Main access macros */=0A=
#ifndef REG_RD=0A=
#define REG_RD( scope, inst, reg ) \=0A=
  REG_READ( reg_##scope##_##reg, \=0A=
            (inst) + REG_RD_ADDR_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_WR=0A=
#define REG_WR( scope, inst, reg, val ) \=0A=
  REG_WRITE( reg_##scope##_##reg, \=0A=
             (inst) + REG_WR_ADDR_##scope##_##reg, (val) )=0A=
#endif=0A=
=0A=
#ifndef REG_RD_VECT=0A=
#define REG_RD_VECT( scope, inst, reg, index ) \=0A=
  REG_READ( reg_##scope##_##reg, \=0A=
            (inst) + REG_RD_ADDR_##scope##_##reg + \=0A=
	    (index) * STRIDE_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_WR_VECT=0A=
#define REG_WR_VECT( scope, inst, reg, index, val ) \=0A=
  REG_WRITE( reg_##scope##_##reg, \=0A=
             (inst) + REG_WR_ADDR_##scope##_##reg + \=0A=
	     (index) * STRIDE_##scope##_##reg, (val) )=0A=
#endif=0A=
=0A=
#ifndef REG_RD_INT=0A=
#define REG_RD_INT( scope, inst, reg ) \=0A=
  REG_READ( int, (inst) + REG_RD_ADDR_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_WR_INT=0A=
#define REG_WR_INT( scope, inst, reg, val ) \=0A=
  REG_WRITE( int, (inst) + REG_WR_ADDR_##scope##_##reg, (val) )=0A=
#endif=0A=
=0A=
#ifndef REG_RD_INT_VECT=0A=
#define REG_RD_INT_VECT( scope, inst, reg, index ) \=0A=
  REG_READ( int, (inst) + REG_RD_ADDR_##scope##_##reg + \=0A=
	    (index) * STRIDE_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_WR_INT_VECT=0A=
#define REG_WR_INT_VECT( scope, inst, reg, index, val ) \=0A=
  REG_WRITE( int, (inst) + REG_WR_ADDR_##scope##_##reg + \=0A=
	     (index) * STRIDE_##scope##_##reg, (val) )=0A=
#endif=0A=
=0A=
#ifndef REG_TYPE_CONV=0A=
#define REG_TYPE_CONV( type, orgtype, val ) \=0A=
  ( { union { orgtype o; type n; } r; r.o =3D val; r.n; } )=0A=
#endif=0A=
=0A=
#ifndef reg_page_size=0A=
#define reg_page_size 8192=0A=
#endif=0A=
=0A=
#ifndef REG_ADDR=0A=
#define REG_ADDR( scope, inst, reg ) \=0A=
  ( (inst) + REG_RD_ADDR_##scope##_##reg )=0A=
#endif=0A=
=0A=
#ifndef REG_ADDR_VECT=0A=
#define REG_ADDR_VECT( scope, inst, reg, index ) \=0A=
  ( (inst) + REG_RD_ADDR_##scope##_##reg + \=0A=
    (index) * STRIDE_##scope##_##reg )=0A=
#endif=0A=
=0A=
/* C-code for register scope ata */=0A=
=0A=
/* Register rw_ctrl0, scope ata, type rw */=0A=
typedef struct {=0A=
  unsigned int pio_hold  : 6;=0A=
  unsigned int pio_strb  : 6;=0A=
  unsigned int pio_setup : 6;=0A=
  unsigned int dma_hold  : 6;=0A=
  unsigned int dma_strb  : 6;=0A=
  unsigned int rst       : 1;=0A=
  unsigned int en        : 1;=0A=
} reg_ata_rw_ctrl0;=0A=
#define REG_RD_ADDR_ata_rw_ctrl0 12=0A=
#define REG_WR_ADDR_ata_rw_ctrl0 12=0A=
=0A=
/* Register rw_ctrl1, scope ata, type rw */=0A=
typedef struct {=0A=
  unsigned int udma_tcyc : 4;=0A=
  unsigned int udma_tdvs : 4;=0A=
  unsigned int dummy1    : 24;=0A=
} reg_ata_rw_ctrl1;=0A=
#define REG_RD_ADDR_ata_rw_ctrl1 16=0A=
#define REG_WR_ADDR_ata_rw_ctrl1 16=0A=
=0A=
/* Register rw_ctrl2, scope ata, type rw */=0A=
typedef struct {=0A=
  unsigned int data     : 16;=0A=
  unsigned int dummy1   : 3;=0A=
  unsigned int dma_size : 1;=0A=
  unsigned int multi    : 1;=0A=
  unsigned int hsh      : 2;=0A=
  unsigned int trf_mode : 1;=0A=
  unsigned int rw       : 1;=0A=
  unsigned int addr     : 3;=0A=
  unsigned int cs0      : 1;=0A=
  unsigned int cs1      : 1;=0A=
  unsigned int sel      : 2;=0A=
} reg_ata_rw_ctrl2;=0A=
#define REG_RD_ADDR_ata_rw_ctrl2 0=0A=
#define REG_WR_ADDR_ata_rw_ctrl2 0=0A=
=0A=
/* Register rs_stat_data, scope ata, type rs */=0A=
typedef struct {=0A=
  unsigned int data : 16;=0A=
  unsigned int dav  : 1;=0A=
  unsigned int busy : 1;=0A=
  unsigned int dummy1 : 14;=0A=
} reg_ata_rs_stat_data;=0A=
#define REG_RD_ADDR_ata_rs_stat_data 4=0A=
=0A=
/* Register r_stat_data, scope ata, type r */=0A=
typedef struct {=0A=
  unsigned int data : 16;=0A=
  unsigned int dav  : 1;=0A=
  unsigned int busy : 1;=0A=
  unsigned int dummy1 : 14;=0A=
} reg_ata_r_stat_data;=0A=
#define REG_RD_ADDR_ata_r_stat_data 8=0A=
=0A=
/* Register rw_trf_cnt, scope ata, type rw */=0A=
typedef struct {=0A=
  unsigned int cnt : 17;=0A=
  unsigned int dummy1 : 15;=0A=
} reg_ata_rw_trf_cnt;=0A=
#define REG_RD_ADDR_ata_rw_trf_cnt 20=0A=
#define REG_WR_ADDR_ata_rw_trf_cnt 20=0A=
=0A=
/* Register r_stat_misc, scope ata, type r */=0A=
typedef struct {=0A=
  unsigned int crc : 16;=0A=
  unsigned int dummy1 : 16;=0A=
} reg_ata_r_stat_misc;=0A=
#define REG_RD_ADDR_ata_r_stat_misc 24=0A=
=0A=
/* Register rw_intr_mask, scope ata, type rw */=0A=
typedef struct {=0A=
  unsigned int bus0 : 1;=0A=
  unsigned int bus1 : 1;=0A=
  unsigned int bus2 : 1;=0A=
  unsigned int bus3 : 1;=0A=
  unsigned int dummy1 : 28;=0A=
} reg_ata_rw_intr_mask;=0A=
#define REG_RD_ADDR_ata_rw_intr_mask 28=0A=
#define REG_WR_ADDR_ata_rw_intr_mask 28=0A=
=0A=
/* Register rw_ack_intr, scope ata, type rw */=0A=
typedef struct {=0A=
  unsigned int bus0 : 1;=0A=
  unsigned int bus1 : 1;=0A=
  unsigned int bus2 : 1;=0A=
  unsigned int bus3 : 1;=0A=
  unsigned int dummy1 : 28;=0A=
} reg_ata_rw_ack_intr;=0A=
#define REG_RD_ADDR_ata_rw_ack_intr 32=0A=
#define REG_WR_ADDR_ata_rw_ack_intr 32=0A=
=0A=
/* Register r_intr, scope ata, type r */=0A=
typedef struct {=0A=
  unsigned int bus0 : 1;=0A=
  unsigned int bus1 : 1;=0A=
  unsigned int bus2 : 1;=0A=
  unsigned int bus3 : 1;=0A=
  unsigned int dummy1 : 28;=0A=
} reg_ata_r_intr;=0A=
#define REG_RD_ADDR_ata_r_intr 36=0A=
=0A=
/* Register r_masked_intr, scope ata, type r */=0A=
typedef struct {=0A=
  unsigned int bus0 : 1;=0A=
  unsigned int bus1 : 1;=0A=
  unsigned int bus2 : 1;=0A=
  unsigned int bus3 : 1;=0A=
  unsigned int dummy1 : 28;=0A=
} reg_ata_r_masked_intr;=0A=
#define REG_RD_ADDR_ata_r_masked_intr 40=0A=
=0A=
=0A=
/* Constants */=0A=
enum {=0A=
  regk_ata_active                          =3D 0x00000001,=0A=
  regk_ata_byte                            =3D 0x00000001,=0A=
  regk_ata_data                            =3D 0x00000001,=0A=
  regk_ata_dma                             =3D 0x00000001,=0A=
  regk_ata_inactive                        =3D 0x00000000,=0A=
  regk_ata_no                              =3D 0x00000000,=0A=
  regk_ata_nodata                          =3D 0x00000000,=0A=
  regk_ata_pio                             =3D 0x00000000,=0A=
  regk_ata_rd                              =3D 0x00000001,=0A=
  regk_ata_reg                             =3D 0x00000000,=0A=
  regk_ata_rw_ctrl0_default                =3D 0x00000000,=0A=
  regk_ata_rw_ctrl2_default                =3D 0x00000000,=0A=
  regk_ata_rw_intr_mask_default            =3D 0x00000000,=0A=
  regk_ata_udma                            =3D 0x00000002,=0A=
  regk_ata_word                            =3D 0x00000000,=0A=
  regk_ata_wr                              =3D 0x00000000,=0A=
  regk_ata_yes                             =3D 0x00000001=0A=
};=0A=
#endif /* __ata_defs_h */=0A=

------=_NextPart_000_0D38_01C56D03.2A60E5D0--

