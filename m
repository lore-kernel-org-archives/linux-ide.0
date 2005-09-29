From: Tom Rini <trini@kernel.crashing.org>
Subject: [PATCH, review] IDE driver for MIPS Toshiba RBTX4939
Date: Thu, 29 Sep 2005 09:22:28 -0700
Message-ID: <20050929162228.GS18074@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:32185 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932232AbVI2QW3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Sep 2005 12:22:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Hiroshi DOYU <hdoyu@mvista.com>

Hello.  I'm submitting, mainly for review (questions, comments, etc) the
IDE driver for the MIPS-based Toshiba RBTX4939.  In some private emails
with Bartlomiej about the ide-dma changes, I understand there's at least
one problem with the driver (happy to fix with a pointer to a good
example).  And I see real quickly there's a few style things a
Lindent'ing would fix.  Thanks.

Signed-off-by: Hiroshi DOYU <hdoyu@mvista.com>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: linux-2.6.10/drivers/ide/Kconfig
===================================================================
--- linux-2.6.10.orig/drivers/ide/Kconfig
+++ linux-2.6.10/drivers/ide/Kconfig
@@ -1015,6 +1015,11 @@ config BLK_DEV_UMC8672
 	  See the files <file:Documentation/ide.txt> and
 	  <file:drivers/ide/legacy/umc8672.c> for more info.
 
+config BLK_DEV_IDE_TX4939
+	tristate "TX4939 internal IDE support"
+	depends TOSHIBA_RBTX4939
+	help
+
 endif
 
 config BLK_DEV_IDEDMA
Index: linux-2.6.10/drivers/ide/ide-cd.c
===================================================================
--- linux-2.6.10.orig/drivers/ide/ide-cd.c
+++ linux-2.6.10/drivers/ide/ide-cd.c
@@ -678,6 +678,13 @@ static int cdrom_decode_status(ide_drive
 	err = HWIF(drive)->INB(IDE_ERROR_REG);
 	sense_key = err >> 4;
 
+#if defined(CONFIG_BLK_DEV_IDE_TX4939)
+        if (IS_IDE_TX4939) {
+		extern void tx4939_ide_softreset(ide_drive_t*);
+		tx4939_ide_softreset(drive);
+        }
+#endif
+
 	if (rq == NULL) {
 		printk("%s: missing rq in cdrom_decode_status\n", drive->name);
 		return 1;
@@ -3254,7 +3261,12 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	info->changer_info      = NULL;
 	info->last_block	= 0;
 	info->start_seek	= 0;
-
+#ifdef CONFIG_BLK_DEV_IDE_TX4939
+	{
+		extern void tx4939_ide_cdrom_setup(ide_drive_t *drive);
+		tx4939_ide_cdrom_setup(drive);
+	}
+#endif
 	nslots = ide_cdrom_probe_capabilities (drive);
 
 	/*
Index: linux-2.6.10/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.10.orig/drivers/ide/ide-dma.c
+++ linux-2.6.10/drivers/ide/ide-dma.c
@@ -856,7 +856,8 @@ int ide_mapped_mmio_dma (ide_hwif_t *hwi
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
 
 	hwif->dma_base = base;
-	if (hwif->cds->extra && hwif->channel == 0)
+
+	if (hwif->cds && hwif->cds->extra && hwif->channel == 0)
 		hwif->dma_extra = hwif->cds->extra;
 
 	if(hwif->mate)
@@ -875,7 +876,7 @@ int ide_iomio_dma (ide_hwif_t *hwif, uns
 		return 1;
 	}
 	hwif->dma_base = base;
-	if ((hwif->cds->extra) && (hwif->channel == 0)) {
+	if (hwif->cds && (hwif->cds->extra) && (hwif->channel == 0)) {
 		request_region(base+16, hwif->cds->extra, hwif->cds->name);
 		hwif->dma_extra = hwif->cds->extra;
 	}
Index: linux-2.6.10/drivers/ide/ide-proc.c
===================================================================
--- linux-2.6.10.orig/drivers/ide/ide-proc.c
+++ linux-2.6.10/drivers/ide/ide-proc.c
@@ -64,6 +64,7 @@ static int proc_ide_read_imodel
 		case ide_cy82c693:	name = "cy82c693";	break;
 		case ide_4drives:	name = "4drives";	break;
 		case ide_pmac:		name = "mac-io";	break;
+		case ide_tx4939:	name = "tx4939";	break;
 		default:		name = "(unknown)";	break;
 	}
 	len = sprintf(page, "%s\n", name);
Index: linux-2.6.10/drivers/ide/ide.c
===================================================================
--- linux-2.6.10.orig/drivers/ide/ide.c
+++ linux-2.6.10/drivers/ide/ide.c
@@ -2151,6 +2151,15 @@ static void __init probe_for_hwifs (void
 		swarm_ide_probe();
 	}
 #endif /* CONFIG_BLK_IDE_SWARM */
+#ifdef CONFIG_BLK_DEV_IDE_TX4939
+	{
+		extern void tx4939_ide_init(int ch);
+		tx4939_ide_init(0);
+#ifdef CONFIG_TOSHIBA_TX4939_MPLEX_ATA1
+		tx4939_ide_init(1);
+#endif
+	}
+#endif /* CONFIG_BLK_DEV_IDE_TX4939 */
 #ifdef CONFIG_BLK_DEV_BUDDHA
 	{
 		extern void buddha_init(void);
Index: linux-2.6.10/drivers/ide/mips/Makefile
===================================================================
--- linux-2.6.10.orig/drivers/ide/mips/Makefile
+++ linux-2.6.10/drivers/ide/mips/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
+obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= ide-tx4939.o
 
 EXTRA_CFLAGS	:= -I../
Index: linux-2.6.10/drivers/ide/mips/ide-tx4939.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/ide/mips/ide-tx4939.c
@@ -0,0 +1,534 @@
+/*
+ * drivers/ide/mips/ide-tx4939.c
+ *
+ * TX4939 internal IDE driver
+ *
+ * (C) Copyright TOSHIBA CORPORATION SEMICONDUCTOR COMPANY 2000-2001,2005
+ *
+ * 2001-2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4939 in 2.6 - Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
+ */
+
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <asm/bootinfo.h>
+#include <asm/pci.h>
+#include <asm/delay.h>
+#include <asm/tx4939/tx4939.h>
+
+/* from ide-cd.h */
+#define CD_FRAMESIZE    2048
+#define SECTOR_BITS                     9
+#define SECTORS_PER_FRAME       (CD_FRAMESIZE >> SECTOR_BITS)
+
+/* add command line TX4939 IDE DMA setteing */
+byte tx4939_ide_udma_mode;
+
+/* wait for transfer end */
+static u16 wait_transfer_end[2];
+
+#define IS_ATAPI(drive) ((drive)->media == ide_cdrom || (drive)->media == ide_scsi)
+#define GET_CH(hwif) (hwif->irq == TX4939_IRQ_ATA(0) ? 0 : 1)
+
+void tx4939_ide_softreset(ide_drive_t * drive)
+{
+	int ch = GET_CH(HWIF(drive));
+	u16 lo_bcnt, hi_bcnt, s;
+
+	/* save ata controller valiable */
+	lo_bcnt = reg_rd16(&tx4939_ataptr(ch)->lo_bcnt);
+	hi_bcnt = reg_rd16(&tx4939_ataptr(ch)->hi_bcnt);
+
+	/* Soft Reset */
+	s = reg_rd16(&tx4939_ataptr(ch)->sysctl1);
+	reg_wr16(&tx4939_ataptr(ch)->sysctl1, s|TX4939_ATA_SC_SOFT_RESET);
+	wbflush();
+	udelay(1);
+
+	/* load ata controller valiable */
+	reg_wr16(&tx4939_ataptr(ch)->lo_bcnt, lo_bcnt);
+	reg_wr16(&tx4939_ataptr(ch)->hi_bcnt, hi_bcnt);
+}
+
+/**
+ * tx4939_ide_tune_drive - ide_tuneproc_t function for TX4939-IDE
+ * @drive: This is the drive data.
+ * @pio: This is used to select the PIO mode by number (0,1,2,3,4,5).
+ *
+ * An ide_tuneproc_t() is used to set the speed of an IDE interface
+ * to a particular PIO mode.  The "byte" parameter is used
+ * to select the PIO mode by number (0,1,2,3,4,5), and a value of 255
+ * indicates that the interface driver should "auto-tune" the PIO mode
+ * according to the drive capabilities in drive->id;
+ *
+ * Not all interface types support tuning, and not all of those
+ * support all possible PIO settings.  They may silently ignore
+ * or round values as they see fit.
+ */
+
+static void tx4939_ide_tune_drive(ide_drive_t * drive, byte pio)
+{
+	u16 data = 0;
+	u16 mode = 0;
+	byte speed = XFER_PIO_0;
+	unsigned long data_port;
+	unsigned long sc_port;
+	int is_slave = (&HWIF(drive)->drives[1] == drive);
+	ide_hwif_t *hwif = drive->hwif;
+
+	data_port = (unsigned long)hwif->io_ports[IDE_DATA_OFFSET];
+	sc_port = (!is_slave) ?
+		data_port + TX4939_ATA_SYSTEM_CONTROL1_OFFSET :
+		data_port + TX4939_ATA_SYSTEM_CONTROL2_OFFSET;
+
+	if (!hwif->channel) {	/* primary */
+		pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+		switch (pio) {
+		case 4:
+			mode = TX4939_ATA_SC_MODE_XFER_PIO_4;
+			speed = XFER_PIO_4;
+			break;
+		case 3:
+			mode = TX4939_ATA_SC_MODE_XFER_PIO_3;
+			speed = XFER_PIO_3;
+			break;
+		case 2:
+			mode = TX4939_ATA_SC_MODE_XFER_PIO_2;
+			speed = XFER_PIO_2;
+			break;
+		case 1:
+			mode = TX4939_ATA_SC_MODE_XFER_PIO_1;
+			speed = XFER_PIO_1;
+			break;
+		case 0:
+			mode = TX4939_ATA_SC_MODE_XFER_PIO_0;
+			speed = XFER_PIO_0;
+			break;
+		default:
+			break;
+		}
+
+		data = inw(sc_port);
+		data &= ~TX4939_ATA_SC_MODE_MASK;
+		data |= mode;
+		outw(data, sc_port);
+	}
+
+	drive->current_speed = speed;
+	ide_config_drive_speed(drive, speed);
+}
+
+/**
+ * tx4939_ide_tune_chipset - ide_speedproc_t function for TX4939-IDE
+ * @drive: This is the drive data.
+ * @speed: This parameter is used to select the transfer mode.
+ *
+ * This function sets the transfer mode.
+ */
+
+static int tx4939_ide_tune_chipset(ide_drive_t * drive, byte speed)
+{
+	u16 data = 0;
+	u16 mode = 0;
+	unsigned long data_port;
+	unsigned long sc_port;
+	int err;
+
+	int is_slave = (&HWIF(drive)->drives[1] == drive);
+	ide_hwif_t *hwif = HWIF(drive);
+	data_port = (unsigned long)hwif->io_ports[IDE_DATA_OFFSET];
+	sc_port = (!is_slave) ?
+		data_port + TX4939_ATA_SYSTEM_CONTROL1_OFFSET :
+		data_port + TX4939_ATA_SYSTEM_CONTROL2_OFFSET;
+
+	if (!hwif->channel) {
+		switch (speed) {
+		case XFER_UDMA_5:
+			mode = TX4939_ATA_SC_MODE_XFER_UDMA_5;
+			break;
+		case XFER_UDMA_4:
+			mode = TX4939_ATA_SC_MODE_XFER_UDMA_4;
+			break;
+		case XFER_UDMA_3:
+			mode = TX4939_ATA_SC_MODE_XFER_UDMA_3;
+			break;
+		case XFER_UDMA_2:
+			mode = TX4939_ATA_SC_MODE_XFER_UDMA_2;
+			break;
+		case XFER_UDMA_1:
+			mode = TX4939_ATA_SC_MODE_XFER_UDMA_1;
+			break;
+		case XFER_UDMA_0:
+			mode = TX4939_ATA_SC_MODE_XFER_UDMA_0;
+			break;
+		case XFER_MW_DMA_2:
+			mode = TX4939_ATA_SC_MODE_XFER_MDMA_2;
+			break;
+		case XFER_MW_DMA_1:
+			mode = TX4939_ATA_SC_MODE_XFER_MDMA_1;
+			break;
+		case XFER_MW_DMA_0:
+			mode = TX4939_ATA_SC_MODE_XFER_MDMA_0;
+			break;
+		default:
+			return -1;
+		}
+
+		data = inw(sc_port);
+		data &= ~TX4939_ATA_SC_MODE_MASK;
+		data |=
+			mode | (TX4939_ATA_SC_MODE_XFER_PIO_4 &
+				TX4939_ATA_SC_CMD_MODE_MASK);
+		outw(data, sc_port);
+	}
+
+	if (!drive->init_speed) {
+		drive->init_speed = speed;
+	}
+
+	drive->current_speed = speed;
+	err = ide_config_drive_speed(drive, speed);
+
+	return err;
+}
+
+/* called from ide_cdrom_setup */
+void tx4939_ide_cdrom_setup(ide_drive_t * drive)
+{
+	unsigned int ch = GET_CH(HWIF(drive));
+	ide_hwif_t *hwif = HWIF(drive);
+	int is_slave = (&hwif->drives[1] == drive);
+
+	if (!is_slave)
+		reg_wr16(&tx4939_ataptr(ch)->xfer_cnt1, CD_FRAMESIZE / 2);	/* word, not byte */
+	else
+		reg_wr16(&tx4939_ataptr(ch)->xfer_cnt2, CD_FRAMESIZE / 2);
+}
+
+/* called from cdrom_transfer_packet_bytes */
+static void
+tx4939_ide_atapi_output_bytes(ide_drive_t * drive, void *buffer,
+				unsigned int bytecount)
+{
+	unsigned int ch = GET_CH(HWIF(drive));
+	unsigned int i;
+	u16 s;
+
+	if (bytecount < 12) {
+		printk(KERN_ERR "tx4939_ide_atapi_output_command: bad count %d\n",
+		       bytecount);
+		return;
+	}
+#if 0				/* This driver uses Packet Command Register */
+	for (i = 0; i < bytecount; i += 2) {
+		OUT_WORD(*(u16 *) (buffer + i), IDE_DATA_REG);
+	}
+	do {
+	} while ((IN_BYTE(IDE_NSECTOR_REG) & 0x1) == 0x1);	/* wait C/D clear */
+	return;
+#endif
+
+	/* set interrupt mask (Data Transfer End) */
+	reg_wr16(&tx4939_ataptr(ch)->int_ctl, TX4939_ATA_IC_DATA_TRANSFER_END << 8);
+
+	/* set the command packet in FIFO */
+	for (i = 0; i < bytecount; i += 2) {
+		reg_wr16(&tx4939_ataptr(ch)->pkt_cmd, *(u16 *) (buffer + i));
+	}
+
+	/* set the transfer count and the packet start bit */
+	reg_wr16(&tx4939_ataptr(ch)->pkt_xfer_ct,
+		((bytecount / 2 - 1) << 8) | TX4939_ATA_PTC_PACKET_START);
+
+	/* wait for command out from FIFO (Data Transfer End) */
+	do {
+		s = reg_rd16(&tx4939_ataptr(ch)->int_ctl);
+	} while (!(s & TX4939_ATA_IC_DATA_TRANSFER_END));
+	reg_wr16(&tx4939_ataptr(ch)->int_ctl, s & TX4939_ATA_IC_DATA_TRANSFER_END);
+
+	/* clear packet transfer count register and */
+	reg_wr16(&tx4939_ataptr(ch)->pkt_xfer_ct, 0);
+}
+
+/**
+ * tx4939_ide_intr - interrupt handler for TX4939-IDE
+ * @hwif:
+ *
+ * This function calls from ide_intr function which is entry point for
+ * all interrupts of IDE driver.
+ *
+ * If TX4939-IDE has HOSTINT interrupt (which indicates INTRQ),
+ * continues ide_intr process.
+ */
+
+#define INT_ERROR_MASK  (TX4939_ATA_IC_BUS_ERROR |\
+                         TX4939_ATA_IC_DEV_TIMING_ERROR |\
+                         TX4939_ATA_IC_REACH_MALTIPLE_INT |\
+                         TX4939_ATA_IC_ADDRESS_ERROR_INT)
+
+static int tx4939_ide_intr(struct hwif_s *hwif)
+{
+	unsigned int ch = GET_CH(hwif);
+	ide_drive_t *drive;
+	u16 int_ctl;
+
+	drive = hwif->drives;
+
+	/* get and clear interrupt status */
+	int_ctl = reg_rd16(&tx4939_ataptr(ch)->int_ctl);
+	reg_wr16(&tx4939_ataptr(ch)->int_ctl, int_ctl);
+#ifdef  DEBUG
+	/* check error sattus */
+	if (int_ctl & INT_ERROR_MASK) {
+		if (int_ctl & TX4939_ATA_IC_ADDRESS_ERROR_INT)
+			printk(KERN_INFO "%s: Address Error\n", drive->name);
+		if (int_ctl & TX4939_ATA_IC_REACH_MALTIPLE_INT)
+			printk(KERN_INFO "%s: PIO transfer in the break state\n",
+			       drive->name);
+		if (int_ctl & TX4939_ATA_IC_DEV_TIMING_ERROR)
+			printk(KERN_INFO "%s: Device timing error (out of spec) - 0x%04x\n",
+			       drive->name, reg_rd16(&tx4939_ataptr(ch)->dev_terr));
+		if (int_ctl & TX4939_ATA_IC_DMA_DEV_TERMINATE) {
+			printk(KERN_INFO
+			       "%s: The device terminated DMA transfer\n",
+			       drive->name);
+		}
+		if (int_ctl & TX4939_ATA_IC_BUS_ERROR)
+			printk(KERN_INFO "%s: Bus error\n", drive->name);
+	}
+#endif
+	/* wait for transfer end in DMA mode */
+	if (drive->waiting_for_dma == 1) {
+		wait_transfer_end[ch] |= int_ctl;
+		if ((wait_transfer_end[ch] & 0x3) == 0x3)
+			return 1;
+		return 0;
+	}
+	return (int_ctl & TX4939_ATA_IC_HOSTINT);
+	/* HOSTINT indicates that INTRQ */
+}
+
+/* returns 1 on error, 0 otherwise */
+static int tx4939_ide_dma_end(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned int ch = GET_CH(HWIF(drive));
+
+	u8 dma_stat = 0, dma_cmd = 0;
+
+	drive->waiting_for_dma = 0;
+	/* get dma_command mode */
+	dma_cmd = hwif->INB(hwif->dma_command);
+	/* stop DMA */
+	hwif->OUTB(dma_cmd&~1, hwif->dma_command);
+	/* get DMA status */
+	dma_stat = hwif->INB(hwif->dma_status);
+	/* clear the INTR & ERROR bits */
+	hwif->OUTB(dma_stat|6, hwif->dma_status);
+	/* purge DMA mappings */
+	ide_destroy_dmatable(drive);
+
+	return (reg_rd16(&tx4939_ataptr(ch)->sec_cnt) != 0);
+}
+
+static int tx4939_ide_dma_test_irq (ide_drive_t *drive)
+{
+	return 1;
+}
+
+/**
+ * tx4939_ide_config_drive_for_dma
+ * @drive
+ *
+ */
+
+static int
+tx4939_ide_config_drive_for_dma(ide_drive_t * drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct hd_driveid *id = drive->id;
+	int ultra = 1;
+	byte speed = 0;
+	byte udma_66 = eighty_ninty_three(drive);	/* hwif->udma_four 0:default 1:ATA66 */
+
+	if ((id->dma_ultra & 0x0020) && (ultra)) {
+		speed = (udma_66) ? XFER_UDMA_5 : XFER_UDMA_2;
+	} else if ((id->dma_ultra & 0x0010) && (ultra)) {
+		speed = (udma_66) ? XFER_UDMA_4 : XFER_UDMA_2;
+	} else if ((id->dma_ultra & 0x0008) && (ultra)) {
+		speed = (udma_66) ? XFER_UDMA_3 : XFER_UDMA_1;
+	} else if ((id->dma_ultra & 0x0004) && (ultra)) {
+		speed = XFER_UDMA_2;
+	} else if ((id->dma_ultra & 0x0002) && (ultra)) {
+		speed = XFER_UDMA_1;
+	} else if ((id->dma_ultra & 0x0001) && (ultra)) {
+		speed = XFER_UDMA_0;
+	} else if (id->dma_mword & 0x0004) {
+		speed = XFER_MW_DMA_2;
+	} else if (id->dma_mword & 0x0002) {
+		speed = XFER_MW_DMA_1;
+	} else if (id->dma_1word & 0x0004) {
+		speed = XFER_SW_DMA_2;
+	} else {
+		/* speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL); */
+		return hwif->ide_dma_off_quietly(drive);
+	}
+
+	/* add command line TX4939IDE DMA setting */
+	if (tx4939_ide_udma_mode && speed >= XFER_UDMA_0) {
+		speed =
+		    (tx4939_ide_udma_mode >
+		     speed) ? speed : tx4939_ide_udma_mode;
+	}
+
+	tx4939_ide_tune_chipset(drive, speed);
+
+	return ((int) ((id->dma_ultra >> 11) & 7) ? hwif->ide_dma_on(drive) :
+		((id->dma_ultra >> 8) & 7) ? hwif->ide_dma_on(drive) :
+		((id->dma_mword >> 8) & 7) ? hwif->ide_dma_on(drive) :
+		((id->dma_1word >> 8) & 7) ? hwif->ide_dma_on(drive) : hwif->ide_dma_off_quietly(drive));
+}
+
+
+/**
+ *	tx4939_ide_dma_check		-	check DMA setup
+ *	@drive: drive to check
+ *
+ *	Don't use - due for extermination
+ */
+
+static int tx4939_ide_dma_check (ide_drive_t *drive)
+{
+	return tx4939_ide_config_drive_for_dma(drive);
+}
+
+/**
+ *	tx4939_ide_dma_setup	-	begin a DMA phase
+ *	@drive: target device
+ *
+ *	Build an IDE DMA PRD (IDE speak for scatter gather table)
+ *	and then set up the DMA transfer registers for a device
+ *	that follows generic IDE PCI DMA behaviour. Controllers can
+ *	override this function if they need to
+ *
+ *	Returns 0 on success. If a PIO fallback is required then 1
+ *	is returned.
+ */
+
+static int tx4939_ide_dma_setup(ide_drive_t *drive)
+{
+	unsigned int ch = GET_CH(HWIF(drive));
+	ide_hwif_t *hwif = HWIF(drive);
+	struct request *rq = HWGROUP(drive)->rq;
+	unsigned int reading;
+	u8 dma_stat;
+	u16 s;
+
+	/* FIFO reset */
+	s = reg_rd16(&tx4939_ataptr(ch)->sysctl1);
+	reg_wr16(&tx4939_ataptr(ch)->sysctl1, s|TX4939_ATA_SC_FIFO_RESET);
+	wbflush();
+	udelay(1);	/* ATA I/F controller spec 12 UPSCLK cycles */
+
+	/* set sector count (cpu:c10h) */
+	if (!IS_ATAPI(drive)) {
+		reg_wr16(&tx4939_ataptr(ch)->sec_cnt, rq->nr_sectors);
+	} else {
+		unsigned int nframes = 0;
+		struct bio *b = rq->bio;
+		int is_slave = (&hwif->drives[1] == drive);
+
+		do {
+			nframes += b->bi_size;
+		} while ((b = b->bi_next) != NULL);
+		nframes /= CD_FRAMESIZE;
+		reg_wr16(&tx4939_ataptr(ch)->sec_cnt, nframes);
+
+		if (!is_slave)
+			reg_wr16(&tx4939_ataptr(ch)->xfer_cnt1, CD_FRAMESIZE / 2); /* word, not byte */
+		else
+			reg_wr16(&tx4939_ataptr(ch)->xfer_cnt2, CD_FRAMESIZE / 2);
+
+	}
+
+	wait_transfer_end[ch] = 0;
+
+	return ide_dma_setup(drive);
+}
+
+/**
+ * tx4939_ide_init - initialize TX4939 IDE function
+ * @ch: TX4939-ATA controller channel
+ *
+ */
+void __init tx4939_ide_init(int ch)
+{
+	hw_regs_t hw;
+	int i, idx;
+	int offsets[IDE_NR_PORTS];
+	void *base;
+	ide_hwif_t *hwif;
+	unsigned long dma_base;
+
+	for (i = 0; i < 8; i++)
+		offsets[i] = i;
+
+	offsets[IDE_CONTROL_OFFSET] = TX4939_ATA_ALT_STATUS_OFFSET;
+	base = (void *)(TX4939_ATA_REG(ch) - mips_io_port_base);
+
+	memset(&hw, 0, sizeof(hw));
+
+	ide_setup_ports(&hw, (unsigned long)base, offsets,
+			0, 0, tx4939_ide_intr, TX4939_IRQ_ATA(ch));
+
+	idx = ide_register_hw(&hw, NULL);
+	if (idx == -1) {
+		printk(KERN_ERR "%s: IDE I/F register failed\n", __FILE__);
+		return;
+	}
+
+	hwif = &ide_hwifs[idx];
+	printk(KERN_INFO "%s: TX4939 IDE interface\n", hwif->name);
+
+	/* set hwif functions */
+	hwif->chipset = ide_tx4939;
+	hwif->tuneproc = tx4939_ide_tune_drive;
+	hwif->speedproc = tx4939_ide_tune_chipset;
+
+	hwif->ultra_mask = 0x7f;
+	hwif->mwdma_mask = 0x07;
+	hwif->swdma_mask = 0x07;
+
+	hwif->mmio = 0;
+
+	/* cable(PDIAGN) check */
+	if (!(hwif->udma_four)) {
+		unsigned int pdiagn;
+		/* bit13(PDIAGN) = 0:(80pin cable) 1:(40pin cable) */
+		pdiagn = (reg_rd16(&tx4939_ataptr(ch)->sysctl1) & TX4939_ATA_SC_PDIAGN);
+		hwif->udma_four = pdiagn ? 0 : 1;
+	}
+#ifdef CONFIG_BLK_DEV_IDEDMA
+	hwif->autodma = 1;
+	hwif->atapi_dma = 1;
+	hwif->ide_dma_check = &tx4939_ide_dma_check;
+	hwif->dma_setup = &tx4939_ide_dma_setup;
+	hwif->ide_dma_test_irq = &tx4939_ide_dma_test_irq;
+	hwif->ide_dma_end = &tx4939_ide_dma_end;
+	hwif->atapi_output_bytes = &tx4939_ide_atapi_output_bytes;
+	dma_base = TX4939_ATA_REG(ch) + TX4939_ATA_DMA_BASE_OFFSET  - mips_io_port_base;
+	ide_setup_dma(hwif, dma_base, 8);
+#endif	/*CONFIG_BLK_DEV_IDEDMA */
+}
+
Index: linux-2.6.10/include/asm-mips/tx4939/ide.h
===================================================================
--- /dev/null
+++ linux-2.6.10/include/asm-mips/tx4939/ide.h
@@ -0,0 +1,71 @@
+/*
+ * include/asm-mips/tx4939/ide.h
+ *
+ * ide supplement routines
+ *
+ * (C) Copyright TOSHIBA CORPORATION SEMICONDUCTOR COMPANY 2005
+ *
+ * Author: source@mvista.com,
+ *               Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ */
+
+#ifndef __ASM_MACH_TX4939_IDE_H
+#define __ASM_MACH_TX4939_IDE_H
+
+#ifdef __KERNEL__
+
+#ifndef MAX_HWIFS
+# ifdef CONFIG_BLK_DEV_IDEPCI
+#define MAX_HWIFS	10
+# else
+#define MAX_HWIFS	6
+# endif
+#endif
+
+/*
+ * Our Physical Region Descriptor (PRD) table should be large enough
+ * to handle the biggest I/O request we are likely to see.  Since requests
+ * can have no more than 256 sectors, and since the typical blocksize is
+ * two or more sectors, we could get by with a limit of 128 entries here for
+ * the usual worst case.  Most requests seem to include some contiguous blocks,
+ * further reducing the number of table entries required.
+ *
+ * The driver reverts to PIO mode for individual requests that exceed
+ * this limit (possible with 512 byte blocksizes, eg. MSDOS f/s), so handling
+ * 100% of all crazy scenarios here is not necessary.
+ *
+ * As it turns out though, we must allocate a full 4KB page for this,
+ * so the two PRD tables (ide0 & ide1) will each get half of that,
+ * allowing each to have about 256 entries (8 bytes each) from this.
+ */
+
+#define PRD_BYTES       8
+#define PRD_ENTRIES     (PAGE_SIZE / (2 * PRD_BYTES))
+
+
+#define ide_ack_intr(hwif) (hwif->hw.ack_intr ? hwif->hw.ack_intr(hwif) : 1)
+#define IDE_ARCH_ACK_INTR
+
+#define __ide_insw	insw
+#define __ide_insl	insl
+#define __ide_outsw	outsw
+#define __ide_outsl	outsl
+
+#define __ide_mm_insw	readsw
+#define __ide_mm_insl	readsl
+#define __ide_mm_outsw	writesw
+#define __ide_mm_outsl	writesl
+
+
+#endif /* __KERNEL__ */
+
+#define IS_IDE_TX4939 (HWIF(drive)->chipset == ide_tx4939)
+
+#endif /* __ASM_MACH_TX4939_IDE_H */
+
Index: linux-2.6.10/include/linux/ide.h
===================================================================
--- linux-2.6.10.orig/include/linux/ide.h
+++ linux-2.6.10/include/linux/ide.h
@@ -223,6 +223,7 @@ typedef enum {	ide_unknown,	ide_generic,
 		ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_etrax100,	ide_acorn,
+		ide_tx4939,
 		ide_forced
 } hwif_chipset_t;
 
-- 
Tom Rini
http://gate.crashing.org/~trini/
