From: "Mikael Starvik" <mikael.starvik@axis.com>
Subject: New IDE driver for review
Date: Thu, 9 Jun 2005 09:18:52 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7A60@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0CB6_01C56CD4.41096B10"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from miranda.se.axis.com ([193.13.178.8]:6102 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S262308AbVFIHS5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Jun 2005 03:18:57 -0400
Received: from PCSTARVIK (dh10-84-127-78.se.axis.com [10.84.127.78])
	by miranda.se.axis.com (8.12.9/8.12.9/Debian-5local0.1) with ESMTP id j597IqNc009810
	for <linux-ide@vger.kernel.org>; Thu, 9 Jun 2005 09:18:52 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0CB6_01C56CD4.41096B10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am about to release a new subarchitecture to the cris architcecture.
A part of this release is a new IDE driver. Basically just a port of
the IDE driver for the old architecture with the addition of UDMA 0-2.

The driver is attached if anyone wants to review it before submission.
I understand if no one is interrested in taking a look at it (CRIS
is really a minor arch).

If no one objects I'll send this to Andrew after the 2.6.12 release.

/Mikael

 

------=_NextPart_000_0CB6_01C56CD4.41096B10
Content-Type: application/octet-stream;
	name="ide-v32.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ide-v32.c"

/* $Id: ide-v32.c,v 1.5 2005/06/09 07:11:54 starvik Exp $=0A=
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
static void tune_crisv32_ide(ide_drive_t *drive, byte pio)=0A=
{=0A=
	reg_ata_rw_ctrl0 ctrl0 =3D REG_RD(ata, regi_ata, rw_ctrl0);=0A=
	reg_ata_rw_ctrl1 ctrl1 =3D REG_RD(ata, regi_ata, rw_ctrl1);=0A=
=0A=
	if (pio <=3D 4)=0A=
		pio =3D ide_get_best_pio_mode(drive, pio, 4, NULL);=0A=
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
	REG_WR(ata, regi_ata, rw_ctrl1, ctrl1);=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
}=0A=
=0A=
static int speed_crisv32_ide(ide_drive_t *drive, byte speed)=0A=
{=0A=
	reg_ata_rw_ctrl0 ctrl0 =3D REG_RD(ata, regi_ata, rw_ctrl0);=0A=
	reg_ata_rw_ctrl1 ctrl1 =3D REG_RD(ata, regi_ata, rw_ctrl1);=0A=
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
		case XFER_MW_DMA_2:=0A=
			ctrl0.dma_strb =3D ATA_DMA0_STROBE;=0A=
			ctrl0.dma_hold =3D ATA_DMA0_HOLD;=0A=
			break;=0A=
		case XFER_MW_DMA_1:=0A=
			ctrl0.dma_strb =3D ATA_DMA1_STROBE;=0A=
			ctrl0.dma_hold =3D ATA_DMA1_HOLD;=0A=
			break;=0A=
		case XFER_MW_DMA_0:=0A=
			ctrl0.dma_strb =3D ATA_DMA2_STROBE;=0A=
			ctrl0.dma_hold =3D ATA_DMA2_HOLD;=0A=
			break;=0A=
		case XFER_PIO_0:=0A=
			ctrl0.pio_setup =3D ATA_PIO0_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO0_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO0_HOLD;=0A=
			break;=0A=
		case XFER_PIO_1:=0A=
			ctrl0.pio_setup =3D ATA_PIO1_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO1_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO1_HOLD;=0A=
			break;=0A=
		case XFER_PIO_2:=0A=
			ctrl0.pio_setup =3D ATA_PIO2_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO2_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO2_HOLD;=0A=
			break;=0A=
		case XFER_PIO_3:=0A=
			ctrl0.pio_setup =3D ATA_PIO3_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO3_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO3_HOLD;=0A=
			break;=0A=
		case XFER_PIO_4:=0A=
			ctrl0.pio_setup =3D ATA_PIO4_SETUP;=0A=
			ctrl0.pio_strb =3D ATA_PIO4_STROBE;=0A=
			ctrl0.pio_hold =3D ATA_PIO4_HOLD;=0A=
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
		hwif->udma_four =3D 1;=0A=
		hwif->ultra_mask =3D 0x07; /* UDMA 0-2 */=0A=
		hwif->mwdma_mask =3D 0x07; /* Multiword DMA 0-2 */=0A=
		hwif->swdma_mask =3D 0x07; /* Singleword DMA 0-2 */=0A=
		hwif->sg_table =3D=0A=
		  kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES, GFP_KERNEL);=0A=
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
	ctrl1.udma_tcyc =3D ATA_UDMA6_CYC;=0A=
	ctrl1.udma_tdvs =3D ATA_UDMA6_DVS;=0A=
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
	ide_hwif_t *hwif =3D HWIF(drive);=0A=
	struct scatterlist* sg;=0A=
	struct request *rq  =3D HWGROUP(drive)->rq;=0A=
	unsigned long size, addr;=0A=
	unsigned int count =3D 0;=0A=
	int i =3D 0;=0A=
=0A=
	sg =3D hwif->sg_table;=0A=
=0A=
	ata_tot_size =3D 0;=0A=
=0A=
	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {=0A=
		u8 *virt_addr =3D rq->buffer;=0A=
		int sector_count =3D rq->nr_sectors;=0A=
		memset(&sg[0], 0, sizeof(*sg));=0A=
		sg[0].page =3D virt_to_page(virt_addr);=0A=
		sg[0].offset =3D offset_in_page(virt_addr);=0A=
		sg[0].length =3D  sector_count  * SECTOR_SIZE;=0A=
		hwif->sg_nents =3D i =3D 1;=0A=
	}=0A=
	else=0A=
	{=0A=
		hwif->sg_nents =3D i =3D blk_rq_map_sg(drive->queue, rq, =
hwif->sg_table);=0A=
	}=0A=
=0A=
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
	int i, dma_stat;=0A=
	byte stat;=0A=
=0A=
	LED_DISK_READ(0);=0A=
	LED_DISK_WRITE(0);=0A=
=0A=
	dma_stat =3D HWIF(drive)->ide_dma_end(drive);=0A=
	stat =3D HWIF(drive)->INB(IDE_STATUS_REG);		/* get drive status */=0A=
	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {=0A=
		if (!dma_stat) {=0A=
			struct request *rq;=0A=
			rq =3D HWGROUP(drive)->rq;=0A=
			for (i =3D rq->nr_sectors; i > 0;) {=0A=
				i -=3D rq->current_nr_sectors;=0A=
				DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);=0A=
			}=0A=
			return ide_stopped;=0A=
		}=0A=
		printk("%s: bad DMA status\n", drive->name);=0A=
	}=0A=
	return ide_error(drive, "dma_intr", stat);=0A=
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
	struct request *rq =3D HWGROUP(drive)->rq;=0A=
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
	struct request *rq =3D HWGROUP(drive)->rq;=0A=
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

------=_NextPart_000_0CB6_01C56CD4.41096B10--

