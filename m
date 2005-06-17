From: "Mikael Starvik" <mikael.starvik@axis.com>
Subject: RE: New IDE driver for review
Date: Fri, 17 Jun 2005 16:16:58 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668030B4C92@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C668030176E7@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0057_01C57357.FC9F1440"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.it.axis.com ([193.13.178.9]:39046 "EHLO bart.se.axis.com")
	by vger.kernel.org with ESMTP id S261984AbVFQORA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jun 2005 10:17:00 -0400
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668030176E7@exmail1.se.axis.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, Mikael Starvik <starvik@axis.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0057_01C57357.FC9F1440
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I have created a merged driver for CRIS v10 and v32. Do you think this
approach is better? In that case you'll also need a Makefile patch as
follows below.

/Mikael

Index: Makefile
===================================================================
RCS file: /usr/local/cvs/linux/os/linux-2.6/drivers/ide/cris/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- Makefile	27 Dec 2004 08:21:33 -0000	1.1
+++ Makefile	17 Jun 2005 14:14:52 -0000
@@ -1,3 +1,3 @@
 EXTRA_CFLAGS				+= -Idrivers/ide
 
-obj-$(CONFIG_ETRAX_ARCH_V10)		+= ide-v10.o
+obj-y					+= ide-cris.o

-----Original Message-----
From: Bartlomiej Zolnierkiewicz [mailto:bzolnier@gmail.com] 
Sent: Thursday, June 09, 2005 5:10 PM
To: Mikael Starvik
Cc: linux-ide@vger.kernel.org
Subject: Re: New IDE driver for review


On 6/9/05, Mikael Starvik <mikael.starvik@axis.com> wrote:
> Ok, updated driver and requested include files attached.

Thanks.

> The drivers are similar but it would still require many ugly ifdef:s or
> similar to combine them. I could of course extract the stuff that is the
> same to a common file to make the arch-specific files smaller. These
drivers
> are rarley touched so I see no major maintanence benefit by combining
them.

I still would like to see one driver:
* less maintenance for IDE people
* better readability of ide-v10.c
  (IDE specific stuff separated from arch specific stuff)
* good opportunity to cleanup ide-v10.c a bit

this won't require many ugly ifdef's, ie.

#ifdef v10
static void etrax_ide_set_pio(u8 setup, u8 strobe, u8 hold)
{
	*R_ATA_CONFIG =
		IO_FIELD(R_ATA_CONFIG, enable,         1 ) |
		IO_FIELD(R_ATA_CONFIG, dma_strobe, ATA_DMA2_STROBE) |
		IO_FIELD(R_ATA_CONFIG, dma_hold,    ATA_DMA2_HOLD) |
		IO_FIELD(R_ATA_CONFIG, pio_setup,    setup) |
		IO_FIELD(R_ATA_CONFIG, pio_strobe,   strobe) |
		IO_FIELD(R_ATA_CONFIG, pio_hold,      hold);
}
...
#else
static void etrax_ide_set_pio(u8 setup, u8 strobe, u8 hold)
{
	reg_ata_rw_ctrl0 ctrl0 = REG_RD(ata, regi_ata, rw_ctrl0);

	ctrl0.pio_setup = setup;
	ctrl0.pio_strb = strobe;
	ctrl0.pio_hold = hold;

	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);
}
...
#endif

and later just use etrax_ide_set_pio()

Bartlomiej

------=_NextPart_000_0057_01C57357.FC9F1440
Content-Type: application/octet-stream;
	name="ide-cris.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ide-cris.c"

/* $Id$=0A=
 *=0A=
 * Etrax specific IDE functions, like init and PIO-mode setting etc.=0A=
 * Almost the entire ide.c is used for the rest of the Etrax ATA driver.=0A=
 * Copyright (c) 2000-2005 Axis Communications AB=0A=
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
#include <asm/dma.h>=0A=
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
enum /* Transfer types */=0A=
{=0A=
	TYPE_PIO,=0A=
	TYPE_DMA,=0A=
	TYPE_UDMA=0A=
};=0A=
=0A=
/* CRISv32 specifics */=0A=
#ifdef CONFIG_ETRAX_ARCH_V32=0A=
#include <asm/arch/hwregs/ata_defs.h>=0A=
#include <asm/arch/hwregs/dma_defs.h>=0A=
#include <asm/arch/hwregs/dma.h>=0A=
#include <asm/arch/pinmux.h>=0A=
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
int =0A=
cris_ide_ack_intr(ide_hwif_t* hwif)=0A=
{=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D REG_TYPE_CONV(reg_ata_rw_ctrl2, =0A=
	                         int, hwif->io_ports[0]);=0A=
	REG_WR_INT(ata, regi_ata, rw_ack_intr, 1 << ctrl2.sel);=0A=
	return 1;=0A=
}=0A=
=0A=
static inline int=0A=
cris_ide_busy(void)=0A=
{=0A=
	reg_ata_rs_stat_data stat_data;=0A=
	stat_data =3D REG_RD(ata, regi_ata, rs_stat_data);=0A=
	return stat_data.busy;=0A=
}=0A=
=0A=
static inline int=0A=
cris_ide_data_available(unsigned short* data)=0A=
{=0A=
	reg_ata_rs_stat_data stat_data;=0A=
	stat_data =3D REG_RD(ata, regi_ata, rs_stat_data);=0A=
	*data =3D stat_data.data;=0A=
	return stat_data.dav;=0A=
}=0A=
=0A=
static void=0A=
cris_ide_write_command(unsigned long command)=0A=
{	=0A=
	REG_WR_INT(ata, regi_ata, rw_ctrl2, command); /* write data to the =
drive's register */=0A=
}=0A=
=0A=
static void=0A=
cris_ide_set_speed(int type, int setup, int strobe, int hold)=0A=
{=0A=
	reg_ata_rw_ctrl0 ctrl0 =3D REG_RD(ata, regi_ata, rw_ctrl0);=0A=
	reg_ata_rw_ctrl1 ctrl1 =3D REG_RD(ata, regi_ata, rw_ctrl1);=0A=
=0A=
	if (type =3D=3D TYPE_PIO) {=0A=
		ctrl0.pio_setup =3D setup;=0A=
		ctrl0.pio_strb =3D strobe;=0A=
		ctrl0.pio_hold =3D hold;=0A=
	} else if (type =3D=3D TYPE_DMA) {=0A=
		ctrl0.dma_strb =3D strobe;=0A=
		ctrl0.dma_hold =3D hold;=0A=
	} else if (type =3D=3D TYPE_UDMA) {=0A=
		ctrl1.udma_tcyc =3D setup;=0A=
		ctrl1.udma_tdvs =3D strobe;=0A=
	}=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
	REG_WR(ata, regi_ata, rw_ctrl1, ctrl1);=0A=
}=0A=
=0A=
static unsigned long=0A=
cris_ide_base_address(int bus)=0A=
{=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D {0};=0A=
	ctrl2.sel =3D bus;=0A=
	return REG_TYPE_CONV(int, reg_ata_rw_ctrl2, ctrl2);=0A=
}=0A=
=0A=
static unsigned long=0A=
cris_ide_reg_addr(unsigned long addr, int cs0, int cs1)=0A=
{=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D {0};=0A=
	ctrl2.addr =3D addr;=0A=
	ctrl2.cs1 =3D cs1;=0A=
	ctrl2.cs0 =3D cs0;=0A=
	return REG_TYPE_CONV(int, reg_ata_rw_ctrl2, ctrl2);=0A=
}=0A=
=0A=
static void=0A=
cris_ide_reset(unsigned val)=0A=
{=0A=
	reg_ata_rw_ctrl0 ctrl0 =3D {0};=0A=
	ctrl0.rst =3D val ? regk_ata_active : regk_ata_inactive;=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
}=0A=
=0A=
static void=0A=
cris_ide_init(void)=0A=
{=0A=
	reg_ata_rw_ctrl0 ctrl0 =3D {0};=0A=
	reg_ata_rw_intr_mask intr_mask =3D {0};=0A=
=0A=
	ctrl0.en =3D regk_ata_yes;=0A=
	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);=0A=
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
	DMA_WR_CMD (regi_dma3, regk_dma_set_w_size2);	=0A=
}=0A=
=0A=
static dma_descr_context mycontext __attribute__ ((__aligned__(32)));=0A=
=0A=
#define cris_dma_descr_type dma_descr_data=0A=
#define cris_pio_read regk_ata_rd=0A=
#define cris_ultra_mask 0x7=0A=
=0A=
static void=0A=
cris_ide_fill_descriptor(cris_dma_descr_type *d, void* buf, unsigned int =
len, int last)=0A=
{=0A=
	d->buf =3D (char*)virt_to_phys(buf);=0A=
	d->after =3D d->buf + len;=0A=
	d->eol =3D last;=0A=
}=0A=
=0A=
static void=0A=
cris_ide_start_dma(ide_drive_t *drive, cris_dma_descr_type *d, int =
dir,int type,int len)=0A=
{=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D REG_TYPE_CONV(reg_ata_rw_ctrl2, int, =
IDE_DATA_REG);=0A=
	reg_ata_rw_trf_cnt trf_cnt =3D {0};=0A=
=0A=
	mycontext.saved_data =3D (dma_descr_data*)virt_to_phys(d);=0A=
	mycontext.saved_data_buf =3D d->buf;=0A=
	/* start the dma channel */=0A=
	DMA_START_CONTEXT(dir ? regi_dma3 : regi_dma2, =
virt_to_phys(&mycontext));=0A=
	=0A=
	/* initiate a multi word dma read using PIO handshaking */=0A=
	trf_cnt.cnt =3D len >> 1;=0A=
	/* Due to a "feature" the transfer count has to be one extra word for =
UDMA. */=0A=
	if (type =3D=3D TYPE_UDMA)=0A=
		trf_cnt.cnt++;=0A=
	REG_WR(ata, regi_ata, rw_trf_cnt, trf_cnt);=0A=
=0A=
	ctrl2.rw =3D dir ? regk_ata_rd : regk_ata_wr;=0A=
	ctrl2.trf_mode =3D regk_ata_dma;=0A=
	ctrl2.hsh =3D type =3D=3D TYPE_PIO ? regk_ata_pio : =0A=
	            type =3D=3D TYPE_DMA ? regk_ata_dma : regk_ata_udma;=0A=
	ctrl2.multi =3D regk_ata_yes;=0A=
	ctrl2.dma_size =3D regk_ata_word;=0A=
	REG_WR(ata, regi_ata, rw_ctrl2, ctrl2);=0A=
}=0A=
=0A=
static void=0A=
cris_ide_wait_dma(int dir)=0A=
{=0A=
	reg_dma_rw_stat status;=0A=
	do=0A=
	{=0A=
		status =3D REG_RD(dma, dir ? regi_dma3 : regi_dma2, rw_stat);=0A=
	} while(status.list_state !=3D regk_dma_data_at_eol);=0A=
}=0A=
=0A=
static int cris_dma_test_irq(ide_drive_t *drive)=0A=
{=0A=
	int intr =3D REG_RD_INT(ata, regi_ata, r_intr);=0A=
	reg_ata_rw_ctrl2 ctrl2 =3D REG_TYPE_CONV(reg_ata_rw_ctrl2, int, =
IDE_DATA_REG);=0A=
	return intr & (1 << ctrl2.sel) ? 1 : 0;=0A=
}=0A=
=0A=
#else=0A=
/* CRISv10 specifics */=0A=
#include <asm/arch/svinto.h>=0A=
#include <asm/arch/io_interface_mux.h>=0A=
=0A=
#define ATA_UDMA2_CYC    0 /* No UDMA supported, just to make it =
compile. */=0A=
#define ATA_UDMA2_DVS    0=0A=
#define ATA_UDMA1_CYC    0=0A=
#define ATA_UDMA1_DVS    0=0A=
#define ATA_UDMA0_CYC    0=0A=
#define ATA_UDMA0_DVS    0=0A=
#define ATA_DMA2_STROBE  4=0A=
#define ATA_DMA2_HOLD    0=0A=
#define ATA_DMA1_STROBE  4=0A=
#define ATA_DMA1_HOLD    1=0A=
#define ATA_DMA0_STROBE 12=0A=
#define ATA_DMA0_HOLD    9=0A=
#define ATA_PIO4_SETUP   1=0A=
#define ATA_PIO4_STROBE  5=0A=
#define ATA_PIO4_HOLD    0=0A=
#define ATA_PIO3_SETUP   1=0A=
#define ATA_PIO3_STROBE  5=0A=
#define ATA_PIO3_HOLD    1=0A=
#define ATA_PIO2_SETUP   1=0A=
#define ATA_PIO2_STROBE  6=0A=
#define ATA_PIO2_HOLD    2=0A=
#define ATA_PIO1_SETUP   2=0A=
#define ATA_PIO1_STROBE 11=0A=
#define ATA_PIO1_HOLD    4=0A=
#define ATA_PIO0_SETUP   4=0A=
#define ATA_PIO0_STROBE 19=0A=
#define ATA_PIO0_HOLD    4=0A=
=0A=
int =0A=
cris_ide_ack_intr(ide_hwif_t* hwif)=0A=
{=0A=
	return 1;=0A=
}=0A=
=0A=
static inline int=0A=
cris_ide_busy(void)=0A=
{=0A=
	return *R_ATA_STATUS_DATA & IO_MASK(R_ATA_STATUS_DATA, busy) ; =0A=
}=0A=
=0A=
static inline int=0A=
cris_ide_data_available(unsigned short* data)=0A=
{=0A=
	unsigned long status =3D *R_ATA_STATUS_DATA;=0A=
	*data =3D (unsigned short)status;=0A=
	return status & IO_MASK(R_ATA_STATUS_DATA, dav);=0A=
}=0A=
	=0A=
static void=0A=
cris_ide_write_command(unsigned long command)=0A=
{=0A=
	*R_ATA_CTRL_DATA =3D command; =0A=
}		=0A=
=0A=
static void=0A=
cris_ide_set_speed(int type, int setup, int strobe, int hold)=0A=
{=0A=
	static int pio_setup =3D ATA_PIO4_SETUP;=0A=
	static int pio_strobe =3D ATA_PIO4_STROBE;=0A=
	static int pio_hold =3D ATA_PIO4_HOLD;=0A=
	static int dma_strobe =3D ATA_DMA2_STROBE;=0A=
	static int dma_hold =3D ATA_DMA2_HOLD;=0A=
=0A=
	if (type =3D=3D TYPE_PIO) {=0A=
		pio_setup =3D setup;=0A=
		pio_strobe =3D strobe;=0A=
		pio_hold =3D hold;=0A=
	} else if (type =3D=3D TYPE_DMA) {=0A=
		dma_strobe =3D strobe;=0A=
	  dma_hold =3D hold;=0A=
	}=0A=
	*R_ATA_CONFIG =3D ( IO_FIELD( R_ATA_CONFIG, enable, 1 ) |=0A=
	  IO_FIELD( R_ATA_CONFIG, dma_strobe, dma_strobe ) |=0A=
		IO_FIELD( R_ATA_CONFIG, dma_hold,   dma_hold ) |=0A=
		IO_FIELD( R_ATA_CONFIG, pio_setup,  pio_setup ) |=0A=
		IO_FIELD( R_ATA_CONFIG, pio_strobe, pio_strobe ) |=0A=
		IO_FIELD( R_ATA_CONFIG, pio_hold,   pio_hold ) );=0A=
}=0A=
=0A=
static unsigned long=0A=
cris_ide_base_address(int bus)=0A=
{=0A=
	return IO_FIELD(R_ATA_CTRL_DATA, sel, bus);=0A=
}=0A=
=0A=
static unsigned long=0A=
cris_ide_reg_addr(unsigned long addr, int cs0, int cs1)=0A=
{=0A=
	return IO_FIELD(R_ATA_CTRL_DATA, addr, addr) |=0A=
	       IO_FIELD(R_ATA_CTRL_DATA, cs0, cs0) |=0A=
	       IO_FIELD(R_ATA_CTRL_DATA, cs1, cs1);=0A=
}=0A=
=0A=
static void=0A=
cris_ide_reset(unsigned val)=0A=
{=0A=
#ifdef CONFIG_ETRAX_IDE_G27_RESET=0A=
	REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow, 27, val);=0A=
#endif=0A=
#ifdef CONFIG_ETRAX_IDE_CSE1_16_RESET=0A=
	REG_SHADOW_SET(port_cse1_addr, port_cse1_shadow, 16, val);=0A=
#endif=0A=
#ifdef CONFIG_ETRAX_IDE_CSP0_8_RESET=0A=
	REG_SHADOW_SET(port_csp0_addr, port_csp0_shadow, 8, val);=0A=
#endif=0A=
#ifdef CONFIG_ETRAX_IDE_PB7_RESET=0A=
	port_pb_dir_shadow =3D port_pb_dir_shadow |=0A=
		IO_STATE(R_PORT_PB_DIR, dir7, output);=0A=
	*R_PORT_PB_DIR =3D port_pb_dir_shadow;=0A=
	REG_SHADOW_SET(R_PORT_PB_DATA, port_pb_data_shadow, 7, val);=0A=
#endif=0A=
}=0A=
=0A=
static void=0A=
cris_ide_init(void)=0A=
{=0A=
	volatile unsigned int dummy;=0A=
=0A=
	*R_ATA_CTRL_DATA =3D 0;=0A=
	*R_ATA_TRANSFER_CNT =3D 0;=0A=
	*R_ATA_CONFIG =3D 0;=0A=
=0A=
	if (cris_request_io_interface(if_ata, "ETRAX100LX IDE")) {=0A=
		printk(KERN_CRIT "ide: Failed to get IO interface\n");=0A=
		return;=0A=
	} else if (cris_request_dma(ATA_TX_DMA_NBR,=0A=
		                          "ETRAX100LX IDE TX",=0A=
		                          DMA_VERBOSE_ON_ERROR,=0A=
		                          dma_ata)) {=0A=
		cris_free_io_interface(if_ata);=0A=
		printk(KERN_CRIT "ide: Failed to get Tx DMA channel\n");=0A=
		return;=0A=
	} else if (cris_request_dma(ATA_RX_DMA_NBR,=0A=
		                          "ETRAX100LX IDE RX",=0A=
		                          DMA_VERBOSE_ON_ERROR,=0A=
		                          dma_ata)) {=0A=
		cris_free_dma(ATA_TX_DMA_NBR, "ETRAX100LX IDE Tx");=0A=
		cris_free_io_interface(if_ata);=0A=
		printk(KERN_CRIT "ide: Failed to get Rx DMA channel\n");=0A=
		return;=0A=
	}=0A=
=0A=
	/* make a dummy read to set the ata controller in a proper state */=0A=
	dummy =3D *R_ATA_STATUS_DATA;=0A=
=0A=
	*R_ATA_CONFIG =3D ( IO_FIELD( R_ATA_CONFIG, enable, 1 ));=0A=
	*R_ATA_CTRL_DATA =3D ( IO_STATE( R_ATA_CTRL_DATA, rw,   read) |=0A=
	                     IO_FIELD( R_ATA_CTRL_DATA, addr, 1   ) );=0A=
=0A=
	while(*R_ATA_STATUS_DATA & IO_MASK(R_ATA_STATUS_DATA, busy)); /* wait =
for busy flag*/=0A=
=0A=
	*R_IRQ_MASK0_SET =3D ( IO_STATE( R_IRQ_MASK0_SET, ata_irq0, set ) |=0A=
	                     IO_STATE( R_IRQ_MASK0_SET, ata_irq1, set ) |=0A=
	                     IO_STATE( R_IRQ_MASK0_SET, ata_irq2, set ) |=0A=
	                     IO_STATE( R_IRQ_MASK0_SET, ata_irq3, set ) );=0A=
=0A=
	/* reset the dma channels we will use */=0A=
=0A=
	RESET_DMA(ATA_TX_DMA_NBR);=0A=
	RESET_DMA(ATA_RX_DMA_NBR);=0A=
	WAIT_DMA(ATA_TX_DMA_NBR);=0A=
	WAIT_DMA(ATA_RX_DMA_NBR);=0A=
}=0A=
=0A=
#define cris_dma_descr_type etrax_dma_descr=0A=
#define cris_pio_read IO_STATE(R_ATA_CTRL_DATA, rw, read)=0A=
#define cris_ultra_mask 0x0=0A=
=0A=
static void=0A=
cris_ide_fill_descriptor(cris_dma_descr_type *d, void* buf, unsigned int =
len, int last)=0A=
{=0A=
	d->buf =3D virt_to_phys(buf);=0A=
	d->sw_len =3D len;=0A=
	if (last)=0A=
		d->ctrl |=3D d_eol;=0A=
}=0A=
=0A=
static void cris_ide_start_dma(ide_drive_t *drive, cris_dma_descr_type =
*d, int dir, int type, int len)=0A=
{=0A=
	unsigned long cmd;=0A=
=0A=
	if (dir) {=0A=
		/* need to do this before RX DMA due to a chip bug=0A=
		 * it is enough to just flush the part of the cache that=0A=
		 * corresponds to the buffers we start, but since HD transfers=0A=
		 * usually are more than 8 kB, it is easier to optimize for the=0A=
		 * normal case and just flush the entire cache. its the only=0A=
		 * way to be sure! (OB movie quote)=0A=
		 */=0A=
		flush_etrax_cache();=0A=
		*R_DMA_CH3_FIRST =3D virt_to_phys(d);=0A=
		*R_DMA_CH3_CMD   =3D IO_STATE(R_DMA_CH3_CMD, cmd, start);=0A=
=0A=
	} else {=0A=
		*R_DMA_CH2_FIRST =3D virt_to_phys(d);=0A=
		*R_DMA_CH2_CMD   =3D IO_STATE(R_DMA_CH2_CMD, cmd, start);=0A=
	}=0A=
	=0A=
	/* initiate a multi word dma read using DMA handshaking */=0A=
=0A=
	*R_ATA_TRANSFER_CNT =3D=0A=
		IO_FIELD(R_ATA_TRANSFER_CNT, count, len >> 1);=0A=
=0A=
	cmd =3D dir ? IO_STATE(R_ATA_CTRL_DATA, rw, read) : =
IO_STATE(R_ATA_CTRL_DATA, rw, write);=0A=
	cmd |=3D type =3D=3D TYPE_PIO ? IO_STATE(R_ATA_CTRL_DATA, handsh, pio) =
: =0A=
	                          IO_STATE(R_ATA_CTRL_DATA, handsh, dma);=0A=
	*R_ATA_CTRL_DATA =3D=0A=
		cmd |=0A=
		IO_FIELD(R_ATA_CTRL_DATA, data, IDE_DATA_REG) |=0A=
		IO_STATE(R_ATA_CTRL_DATA, src_dst,  dma)  |=0A=
		IO_STATE(R_ATA_CTRL_DATA, multi,    on)   |=0A=
		IO_STATE(R_ATA_CTRL_DATA, dma_size, word);=0A=
}=0A=
=0A=
static void=0A=
cris_ide_wait_dma(int dir)=0A=
{=0A=
	if (dir)=0A=
		WAIT_DMA(ATA_RX_DMA_NBR);=0A=
	else=0A=
		WAIT_DMA(ATA_TX_DMA_NBR);=0A=
}=0A=
=0A=
static int cris_dma_test_irq(ide_drive_t *drive)=0A=
{=0A=
	int intr =3D *R_IRQ_MASK0_RD;=0A=
	int bus =3D IO_EXTRACT(R_ATA_CTRL_DATA, sel, IDE_DATA_REG);=0A=
	return intr & (1 << (bus + IO_BITNR(R_IRQ_MASK0_RD, ata_irq0))) ? 1 : 0;=0A=
}=0A=
=0A=
#endif=0A=
		=0A=
void=0A=
cris_ide_outw(unsigned short data, unsigned long reg) {=0A=
	int timeleft;=0A=
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
	} while(timeleft && cris_ide_busy());=0A=
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
	cris_ide_write_command(reg|data); /* write data to the drive's register =
*/ =0A=
=0A=
	timeleft =3D IDE_REGISTER_TIMEOUT;=0A=
	/* wait for transmitter ready */=0A=
	do {=0A=
		timeleft--;=0A=
	} while(timeleft && cris_ide_busy());=0A=
}=0A=
=0A=
void=0A=
cris_ide_outb(unsigned char data, unsigned long reg)=0A=
{=0A=
	cris_ide_outw(data, reg);=0A=
}=0A=
=0A=
void=0A=
cris_ide_outbsync(ide_drive_t *drive, u8 addr, unsigned long port)=0A=
{=0A=
	cris_ide_outw(addr, port);=0A=
}=0A=
=0A=
unsigned short=0A=
cris_ide_inw(unsigned long reg) {=0A=
	int timeleft;=0A=
	unsigned short val;=0A=
=0A=
	timeleft =3D IDE_REGISTER_TIMEOUT;=0A=
	/* wait for busy flag */=0A=
	do {=0A=
		timeleft--;=0A=
	} while(timeleft && cris_ide_busy());=0A=
=0A=
	if(!timeleft)=0A=
		return 0;=0A=
=0A=
	cris_ide_write_command(reg | cris_pio_read);=0A=
=0A=
	timeleft =3D IDE_REGISTER_TIMEOUT;=0A=
	/* wait for available */=0A=
	do {=0A=
		timeleft--;=0A=
	} while(timeleft && !cris_ide_data_available(&val));=0A=
=0A=
	if(!timeleft)=0A=
		return 0;=0A=
=0A=
	LOWDB(printk("inb: 0x%x from reg 0x%x\n", val & 0xff, reg));=0A=
=0A=
	return val;=0A=
}=0A=
=0A=
unsigned char=0A=
cris_ide_inb(unsigned long reg)=0A=
{=0A=
	return (unsigned char)cris_ide_inw(reg);=0A=
}=0A=
=0A=
static int cris_dma_check (ide_drive_t *drive);=0A=
static int cris_dma_end (ide_drive_t *drive);=0A=
static int cris_dma_setup (ide_drive_t *drive);=0A=
static void cris_dma_exec_cmd (ide_drive_t *drive, u8 command);=0A=
static int cris_dma_test_irq(ide_drive_t *drive);=0A=
static void cris_dma_start(ide_drive_t *drive);=0A=
static void cris_ide_input_data (ide_drive_t *drive, void *, unsigned =
int);=0A=
static void cris_ide_output_data (ide_drive_t *drive, void *, unsigned =
int);=0A=
static void cris_atapi_input_bytes(ide_drive_t *drive, void *, unsigned =
int);=0A=
static void cris_atapi_output_bytes(ide_drive_t *drive, void *, unsigned =
int);=0A=
static int cris_dma_off (ide_drive_t *drive);=0A=
static int cris_dma_on (ide_drive_t *drive);=0A=
=0A=
static void tune_cris_ide(ide_drive_t *drive, u8 pio)=0A=
{=0A=
	int setup, strobe, hold;=0A=
=0A=
	switch(pio)=0A=
	{	=0A=
		case 0:=0A=
			setup =3D ATA_PIO0_SETUP;=0A=
			strobe =3D ATA_PIO0_STROBE;=0A=
			hold =3D ATA_PIO0_HOLD;=0A=
			break;=0A=
		case 1:=0A=
			setup =3D ATA_PIO1_SETUP;=0A=
			strobe =3D ATA_PIO1_STROBE;=0A=
			hold =3D ATA_PIO1_HOLD;=0A=
			break;=0A=
		case 2:=0A=
			setup =3D ATA_PIO2_SETUP;=0A=
			strobe =3D ATA_PIO2_STROBE;=0A=
			hold =3D ATA_PIO2_HOLD;=0A=
			break;=0A=
		case 3:=0A=
			setup =3D ATA_PIO3_SETUP;=0A=
			strobe =3D ATA_PIO3_STROBE;=0A=
			hold =3D ATA_PIO3_HOLD;=0A=
			break;=0A=
		case 4:=0A=
			setup =3D ATA_PIO4_SETUP;=0A=
			strobe =3D ATA_PIO4_STROBE;=0A=
			hold =3D ATA_PIO4_HOLD;=0A=
			break;    =0A=
		default:=0A=
			return;=0A=
	}=0A=
=0A=
	cris_ide_set_speed(TYPE_PIO, setup, strobe, hold);=0A=
}=0A=
=0A=
static int speed_cris_ide(ide_drive_t *drive, u8 speed)=0A=
{=0A=
	int cyc =3D 0, dvs =3D 0, strobe =3D 0, hold =3D 0;=0A=
=0A=
	if (speed >=3D XFER_PIO_0 && speed <=3D XFER_PIO_4) {=0A=
		tune_cris_ide(drive, speed - XFER_PIO_0);=0A=
		return 0;=0A=
	}=0A=
        =0A=
	switch(speed)=0A=
	{	=0A=
		case XFER_UDMA_0:=0A=
			cyc =3D ATA_UDMA0_CYC;=0A=
			dvs =3D ATA_UDMA0_DVS;=0A=
			break;=0A=
		case XFER_UDMA_1:=0A=
			cyc =3D ATA_UDMA1_CYC;=0A=
			dvs =3D ATA_UDMA1_DVS;=0A=
			break;=0A=
		case XFER_UDMA_2:=0A=
			cyc =3D ATA_UDMA2_CYC;=0A=
			dvs =3D ATA_UDMA2_DVS;=0A=
			break;=0A=
		case XFER_MW_DMA_0:=0A=
			strobe =3D ATA_DMA0_STROBE;=0A=
			hold =3D ATA_DMA0_HOLD;=0A=
			break;=0A=
		case XFER_MW_DMA_1:=0A=
			strobe =3D ATA_DMA1_STROBE;=0A=
			hold =3D ATA_DMA1_HOLD;=0A=
			break;=0A=
		case XFER_MW_DMA_2:=0A=
			strobe =3D ATA_DMA2_STROBE;=0A=
			hold =3D ATA_DMA2_HOLD;=0A=
			break;=0A=
		default:=0A=
			return 0;=0A=
	}=0A=
=0A=
	if (speed >=3D XFER_UDMA_0)=0A=
		cris_ide_set_speed(TYPE_UDMA, cyc, dvs, 0);=0A=
	else=0A=
		cris_ide_set_speed(TYPE_DMA, 0, strobe, hold);	=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
void __init=0A=
init_e100_ide (void)=0A=
{=0A=
	hw_regs_t hw;=0A=
	int ide_offsets[IDE_NR_PORTS];=0A=
	int h;=0A=
	int i;=0A=
=0A=
	printk("ide: ETRAX FS built-in ATA DMA controller\n");=0A=
=0A=
	for (i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; i++)=0A=
		ide_offsets[i] =3D cris_ide_reg_addr(i, 0, 1);=0A=
=0A=
	/* the IDE control register is at ATA address 6, with CS1 active =
instead of CS0 */=0A=
	ide_offsets[IDE_CONTROL_OFFSET] =3D cris_ide_reg_addr(6, 1, 0);=0A=
=0A=
	/* first fill in some stuff in the ide_hwifs fields */=0A=
=0A=
	for(h =3D 0; h < MAX_HWIFS; h++) {=0A=
		ide_hwif_t *hwif =3D &ide_hwifs[h];=0A=
		ide_setup_ports(&hw, cris_ide_base_address(h), =0A=
		                ide_offsets,=0A=
		                0, 0, cris_ide_ack_intr,=0A=
		                ide_default_irq(0));=0A=
		ide_register_hw(&hw, &hwif);=0A=
		hwif->mmio =3D 2;=0A=
		hwif->chipset =3D ide_etrax100;=0A=
		hwif->tuneproc =3D &tune_cris_ide;=0A=
		hwif->speedproc =3D &speed_cris_ide;=0A=
		hwif->ata_input_data =3D &cris_ide_input_data;=0A=
		hwif->ata_output_data =3D &cris_ide_output_data;=0A=
		hwif->atapi_input_bytes =3D &cris_atapi_input_bytes;=0A=
		hwif->atapi_output_bytes =3D &cris_atapi_output_bytes;=0A=
		hwif->ide_dma_check =3D &cris_dma_check;=0A=
		hwif->ide_dma_end =3D &cris_dma_end;=0A=
		hwif->dma_setup =3D &cris_dma_setup;=0A=
		hwif->dma_exec_cmd =3D &cris_dma_exec_cmd;=0A=
		hwif->ide_dma_test_irq =3D &cris_dma_test_irq;=0A=
		hwif->dma_start =3D &cris_dma_start;=0A=
		hwif->OUTB =3D &cris_ide_outb;=0A=
		hwif->OUTW =3D &cris_ide_outw;=0A=
		hwif->OUTBSYNC =3D &cris_ide_outbsync;=0A=
		hwif->INB =3D &cris_ide_inb;=0A=
		hwif->INW =3D &cris_ide_inw;=0A=
		hwif->ide_dma_host_off =3D &cris_dma_off;=0A=
		hwif->ide_dma_host_on =3D &cris_dma_on;=0A=
		hwif->ide_dma_off_quietly =3D &cris_dma_off;=0A=
		hwif->udma_four =3D 0;=0A=
		hwif->ultra_mask =3D cris_ultra_mask;=0A=
		hwif->mwdma_mask =3D 0x07; /* Multiword DMA 0-2 */=0A=
		hwif->swdma_mask =3D 0x07; /* Singleword DMA 0-2 */=0A=
	}=0A=
=0A=
	/* Reset pulse */=0A=
	cris_ide_reset(0);=0A=
	udelay(25);=0A=
	cris_ide_reset(1);=0A=
=0A=
	cris_ide_init();=0A=
=0A=
	cris_ide_set_speed(TYPE_PIO, ATA_PIO4_SETUP, ATA_PIO4_STROBE, =
ATA_PIO4_HOLD);=0A=
	cris_ide_set_speed(TYPE_DMA, 0, ATA_DMA2_STROBE, ATA_DMA2_HOLD);=0A=
	cris_ide_set_speed(TYPE_UDMA, ATA_UDMA2_CYC, ATA_UDMA2_DVS, 0);=0A=
}=0A=
=0A=
static int cris_dma_off (ide_drive_t *drive)=0A=
{=0A=
	return 0;=0A=
}=0A=
=0A=
static int cris_dma_on (ide_drive_t *drive)=0A=
{=0A=
	return 0;=0A=
}=0A=
=0A=
=0A=
static cris_dma_descr_type mydescr __attribute__ ((__aligned__(16)));=0A=
=0A=
/*=0A=
 * The following routines are mainly used by the ATAPI drivers.=0A=
 *=0A=
 * These routines will round up any request for an odd number of bytes,=0A=
 * so if an odd bytecount is specified, be sure that there's at least one=0A=
 * extra byte allocated for the buffer.=0A=
 */=0A=
static void=0A=
cris_atapi_input_bytes (ide_drive_t *drive, void *buffer, unsigned int =
bytecount)=0A=
{=0A=
	D(printk("atapi_input_bytes, buffer 0x%x, count %d\n",=0A=
	         buffer, bytecount));=0A=
=0A=
	if(bytecount & 1) {=0A=
		printk("warning, odd bytecount in cdrom_in_bytes =3D %d.\n", =
bytecount);=0A=
		bytecount++; /* to round off */=0A=
	}=0A=
=0A=
	/* setup DMA and start transfer */=0A=
=0A=
	cris_ide_fill_descriptor(&mydescr, buffer, bytecount, 1);=0A=
	cris_ide_start_dma(drive, &mydescr, 1, TYPE_PIO, bytecount);=0A=
=0A=
	/* wait for completion */=0A=
	LED_DISK_READ(1);=0A=
	cris_ide_wait_dma(1);=0A=
	LED_DISK_READ(0);=0A=
}=0A=
=0A=
static void=0A=
cris_atapi_output_bytes (ide_drive_t *drive, void *buffer, unsigned int =
bytecount)=0A=
{=0A=
	D(printk("atapi_output_bytes, dreg 0x%x, buffer 0x%x, count %d\n",=0A=
	         0, buffer, bytecount));=0A=
=0A=
	if(bytecount & 1) {=0A=
		printk("odd bytecount %d in atapi_out_bytes!\n", bytecount);=0A=
		bytecount++;=0A=
	}=0A=
=0A=
	cris_ide_fill_descriptor(&mydescr, buffer, bytecount, 1);=0A=
	cris_ide_start_dma(drive, &mydescr, 0, TYPE_PIO, bytecount);=0A=
=0A=
	/* wait for completion */=0A=
=0A=
	LED_DISK_WRITE(1);=0A=
	LED_DISK_READ(1);=0A=
	cris_ide_wait_dma(1);=0A=
	LED_DISK_WRITE(0);=0A=
}=0A=
=0A=
/*=0A=
 * This is used for most PIO data transfers *from* the IDE interface=0A=
 */=0A=
static void=0A=
cris_ide_input_data (ide_drive_t *drive, void *buffer, unsigned int =
wcount)=0A=
{=0A=
	cris_atapi_input_bytes(drive, buffer, wcount << 2);=0A=
}=0A=
=0A=
/*=0A=
 * This is used for most PIO data transfers *to* the IDE interface=0A=
 */=0A=
static void=0A=
cris_ide_output_data (ide_drive_t *drive, void *buffer, unsigned int =
wcount)=0A=
{=0A=
	cris_atapi_output_bytes(drive, buffer, wcount << 2);=0A=
}=0A=
=0A=
/* we only have one DMA channel on the chip for ATA, so we can keep =
these statically */=0A=
static cris_dma_descr_type ata_descrs[MAX_DMA_DESCRS] __attribute__ =
((__aligned__(16)));=0A=
static unsigned int ata_tot_size;=0A=
=0A=
/*=0A=
 * cris_ide_build_dmatable() prepares a dma request.=0A=
 * Returns 0 if all went okay, returns 1 otherwise.=0A=
 */=0A=
static int cris_ide_build_dmatable (ide_drive_t *drive)=0A=
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
		cris_ide_fill_descriptor(&ata_descrs[count], (void*)addr, size,i ? 0 : =
1);=0A=
		count++;=0A=
		ata_tot_size +=3D size;=0A=
	}=0A=
=0A=
	if (count) {=0A=
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
 * cris_dma_intr() is the handler for disk read/write DMA interrupts=0A=
 */=0A=
static ide_startstop_t cris_dma_intr (ide_drive_t *drive)=0A=
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
static int cris_dma_check(ide_drive_t *drive)=0A=
{=0A=
	int speed =3D ide_dma_speed(drive, 0); /* No UDMA for now */=0A=
	speed_cris_ide(drive, speed);=0A=
	ide_config_drive_speed(drive, speed);=0A=
	return config_drive_for_dma (drive);=0A=
}=0A=
=0A=
static int cris_dma_end(ide_drive_t *drive)=0A=
{=0A=
	drive->waiting_for_dma =3D 0;=0A=
	return 0;=0A=
}=0A=
=0A=
static int cris_prepare_dma(ide_drive_t *drive, int atapi, int reading)=0A=
{=0A=
	struct request *rq =3D drive->hwif->hwgroup->rq;=0A=
	if (cris_ide_build_dmatable (drive)) {=0A=
		ide_map_sg(drive, rq);=0A=
		return 1;=0A=
	}=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static int cris_dma_setup(ide_drive_t *drive)=0A=
{=0A=
	struct request *rq =3D drive->hwif->hwgroup->rq;=0A=
	int ret;=0A=
	if (rq_data_dir(rq))=0A=
		ret =3D cris_prepare_dma(drive, 0, 0);=0A=
        else=0A=
		ret =3D cris_prepare_dma(drive, 0, 1);=0A=
	if (ret)=0A=
		return ret;=0A=
	drive->waiting_for_dma =3D 1;=0A=
	return 0;=0A=
}=0A=
=0A=
static void cris_dma_exec_cmd(ide_drive_t *drive, u8 command)=0A=
{=0A=
	/* set the irq handler which will finish the request when DMA is done */=0A=
	ide_set_handler(drive, &cris_dma_intr, WAIT_CMD, NULL);=0A=
=0A=
	/* issue cmd to drive */=0A=
	cris_ide_outb(command, IDE_COMMAND_REG);=0A=
}=0A=
=0A=
static void cris_dma_start(ide_drive_t *drive)=0A=
{=0A=
	struct request *rq =3D drive->hwif->hwgroup->rq;=0A=
	int writing =3D rq_data_dir(rq);=0A=
	int type =3D TYPE_DMA;=0A=
	=0A=
	if (drive->current_speed >=3D XFER_UDMA_0)=0A=
		type =3D TYPE_UDMA;=0A=
=0A=
	cris_ide_start_dma(drive, &ata_descrs[0], writing ? 0 : 1, type, =
ata_tot_size);=0A=
=0A=
	if (writing) {=0A=
		LED_DISK_WRITE(1);=0A=
	} else {=0A=
		LED_DISK_READ(1);=0A=
	}=0A=
}=0A=

------=_NextPart_000_0057_01C57357.FC9F1440--

