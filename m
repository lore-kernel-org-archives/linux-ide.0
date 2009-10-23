From: "Milan Burgdorf" <milan@wwwburgdorf.de>
Subject: Request to 2.6.24/patch-sata_promise-limit-sataii-to-1.5Gbps-2.6.24 because it doesn't work
Date: Fri, 23 Oct 2009 14:31:37 +0200 (MEST)
Message-ID: <200910231231.n9NCVbIV011530@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from em-p00-ob.rzone.de ([81.169.146.224]:13363 "EHLO
	em-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbZJWMmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 08:42:54 -0400
Received: from post.webmailer.de (bel.store [192.168.41.68])
	by scum-em-02.store (RZmta 22.1) with ESMTP id J067afl9MMjTLT
	for <linux-ide@vger.kernel.org>; Fri, 23 Oct 2009 14:31:38 +0200 (MEST)
Received: (from httpd@localhost)
	by post.webmailer.de (8.13.7/8.13.6) id n9NCVbIV011530
	for linux-ide@vger.kernel.org; Fri, 23 Oct 2009 14:31:37 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear Mr. Pettersson and the whole LINUX-IDE-team,


I'm working with Xubuntu 8.04 by using Kernel 2.6.24-24-generic. My two
2,5-Zoll SATA-II-Harddisks are connected with a Promise SATA 300 TX2
Plus-Controller.

When the disks work with high I/O, than I become the similar problems
like they are described in

"http://marc.info/?l=linux-ide&m=121475606225101&w=2" and
"http://marc.info/?l=linux-ide&m=120134441006713&w=2":

Oct 15 20:20:46 alexandria-epia kernel: [ 5731.478618] res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct 15 20:20:51 alexandria-epia kernel: [ 5736.825857] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:20:56 alexandria-epia kernel: [ 5741.526446] ata1: device not
ready (errno=-16), forcing hardreset
Oct 15 20:20:56 alexandria-epia kernel: [ 5741.526472] ata1: hard
resetting link
Oct 15 20:21:02 alexandria-epia kernel: [ 5747.713897] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:21:06 alexandria-epia kernel: [ 5751.575082] ata1: hard
resetting link
Oct 15 20:21:12 alexandria-epia kernel: [ 5757.762534] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:21:16 alexandria-epia kernel: [ 5761.623715] ata1: hard
resetting link
Oct 15 20:21:22 alexandria-epia kernel: [ 5767.811162] ata1: port is
slow to respond, please be patient (Status 0xff)
Oct 15 20:21:51 alexandria-epia kernel: [ 5796.650099] ata1: limiting
SATA link speed to 1.5 Gbps
Oct 15 20:21:51 alexandria-epia kernel: [ 5796.650114] ata1: hard
resetting link
Oct 15 20:21:56 alexandria-epia kernel: [ 5801.658417] ata1.00: disabled

To solve my problem I patched the sata_promise-Module with your three
patches from "http://user.it.uu.se/~mikpe/linux/patches/2.6/OLD/2.6.24/"
and installed the new module.

After this I checked hopefully my /var/log/messages, but the disk run
anymore in 3.0GB/s-Mode, and again I become the I/O-problems:

Aug 24 16:21:40 alexandria-epia kernel: [ 25.804737] scsi0 : sata_promise
Aug 24 16:21:40 alexandria-epia kernel: [ 25.812721] scsi1 : sata_promise
Aug 24 16:21:40 alexandria-epia kernel: [ 25.832765] scsi2 : sata_promise
Aug 24 16:21:40 alexandria-epia kernel: [ 25.832958] ata1: SATA max
UDMA/133 mmio m4096@0xe8021000 port 0xe8021200 irq 10
Aug 24 16:21:40 alexandria-epia kernel: [ 25.833023] ata2: SATA max
UDMA/133 mmio m4096@0xe8021000 port 0xe8021280 irq 10
Aug 24 16:21:40 alexandria-epia kernel: [ 25.833085] ata3: PATA max
UDMA/133 mmio m4096@0xe8021000 port 0xe8021300 irq 10
Aug 24 16:21:40 alexandria-epia kernel: [ 26.300682] ata1: SATA link
up 3.0 Gbps (SStatus 123 SControl 300)
Aug 24 16:21:40 alexandria-epia kernel: [ 26.664283] ata1.00: ATA-8:
WDC WD2500BEVT-22ZCT0, 11.01A11, max UDMA/133
Aug 24 16:21:40 alexandria-epia kernel: [ 26.664355] ata1.00:
488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Aug 24 16:21:40 alexandria-epia kernel: [ 26.674118] ata1.00:
configured for UDMA/133
Aug 24 16:21:40 alexandria-epia kernel: [ 26.988560] usb 1-1: new low
speed USB device using uhci_hcd and address 3
Aug 24 16:21:40 alexandria-epia kernel: [ 27.140550] ata2: SATA link
up 3.0 Gbps (SStatus 123 SControl 300)
Aug 24 16:21:40 alexandria-epia kernel: [ 27.148799] ata2.00: ATA-8:
ST9250827AS, 3.AAA, max UDMA/133
Aug 24 16:21:40 alexandria-epia kernel: [ 27.148865] ata2.00:
488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Aug 24 16:21:40 alexandria-epia kernel: [ 27.163553] usb 1-1:
configuration #1 chosen from 1 choice
Aug 24 16:21:40 alexandria-epia kernel: [ 27.164844] ata2.00:
configured for UDMA/133
Aug 24 16:21:40 alexandria-epia kernel: [ 27.320749] scsi 0:0:0:0:
Direct-Access ATA WDC WD2500BEVT-2 11.0 PQ: 0 ANSI: 5
Aug 24 16:21:40 alexandria-epia kernel: [ 27.321316] scsi 1:0:0:0:
Direct-Access ATA ST9250827AS 3.AA PQ: 0 ANSI: 5


Is there another possibility to force the Promise-Controller down to 1.5
GB/s?


Best regards,
Milan W. Burgdorf


---------------------------------------------------------------------------------------------


My controller:

00:14.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA
300 TX2plus) (rev 02)

Subsystem: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus)
Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 10
I/O ports at e800 [size=128]
I/O ports at ec00 [size=256]
Memory at e8021000 (32-bit, non-prefetchable) [size=4K]
Memory at e8000000 (32-bit, non-prefetchable) [size=128K]
[virtual] Expansion ROM at 20000000 [disabled] [size=32K]
Capabilities: [60] Power Management version 2


My patched sata_promise.c:

/*
* sata_promise.c - Promise SATA
*
* Maintained by: Jeff Garzik <jgarzik@pobox.com>
* Mikael Pettersson <mikpe@it.uu.se>
* Please ALWAYS copy linux-ide@vger.kernel.org
* on emails.
*
* Copyright 2003-2004 Red Hat, Inc.
*
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2, or (at your option)
* any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; see the file COPYING. If not, write to
* the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
*
*
* libata documentation is available via 'make {ps|pdf}docs',
* as Documentation/DocBook/libata.*
*
* Hardware information only available under NDA.
*
*/

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <linux/device.h>
#include <scsi/scsi.h>
#include <scsi/scsi_host.h>
#include <scsi/scsi_cmnd.h>
#include <linux/libata.h>
#include "sata_promise.h"

#define DRV_NAME "sata_promise"
#define DRV_VERSION "2.11"

enum {
PDC_MAX_PORTS = 4,
PDC_MMIO_BAR = 3,
PDC_MAX_PRD = LIBATA_MAX_PRD - 1, /* -1 for ASIC PRD bug workaround */

/* register offsets */
PDC_FEATURE = 0x04, /* Feature/Error reg (per port) */
PDC_SECTOR_COUNT = 0x08, /* Sector count reg (per port) */
PDC_SECTOR_NUMBER = 0x0C, /* Sector number reg (per port) */
PDC_CYLINDER_LOW = 0x10, /* Cylinder low reg (per port) */
PDC_CYLINDER_HIGH = 0x14, /* Cylinder high reg (per port) */
PDC_DEVICE = 0x18, /* Device/Head reg (per port) */
PDC_COMMAND = 0x1C, /* Command/status reg (per port) */
PDC_ALTSTATUS = 0x38, /* Alternate-status/device-control reg (per port) */
PDC_PKT_SUBMIT = 0x40, /* Command packet pointer addr */
PDC_INT_SEQMASK = 0x40, /* Mask of asserted SEQ INTs */
PDC_FLASH_CTL = 0x44, /* Flash control register */
PDC_GLOBAL_CTL = 0x48, /* Global control/status (per port) */
PDC_CTLSTAT = 0x60, /* IDE control and status (per port) */
PDC_SATA_PLUG_CSR = 0x6C, /* SATA Plug control/status reg */
PDC2_SATA_PLUG_CSR = 0x60, /* SATAII Plug control/status reg */
PDC_TBG_MODE = 0x41C, /* TBG mode (not SATAII) */
PDC_SLEW_CTL = 0x470, /* slew rate control reg (not SATAII) */

/* PDC_GLOBAL_CTL bit definitions */
PDC_PH_ERR = (1 << 8), /* PCI error while loading packet */
PDC_SH_ERR = (1 << 9), /* PCI error while loading S/G table */
PDC_DH_ERR = (1 << 10), /* PCI error while loading data */
PDC2_HTO_ERR = (1 << 12), /* host bus timeout */
PDC2_ATA_HBA_ERR = (1 << 13), /* error during SATA DATA FIS transmission */
PDC2_ATA_DMA_CNT_ERR = (1 << 14), /* DMA DATA FIS size differs from S/G
count */
PDC_OVERRUN_ERR = (1 << 19), /* S/G byte count larger than HD requires */
PDC_UNDERRUN_ERR = (1 << 20), /* S/G byte count less than HD requires */
PDC_DRIVE_ERR = (1 << 21), /* drive error */
PDC_PCI_SYS_ERR = (1 << 22), /* PCI system error */
PDC1_PCI_PARITY_ERR = (1 << 23), /* PCI parity error (from SATA150
driver) */
PDC1_ERR_MASK = PDC1_PCI_PARITY_ERR,
PDC2_ERR_MASK = PDC2_HTO_ERR | PDC2_ATA_HBA_ERR |
PDC2_ATA_DMA_CNT_ERR,
PDC_ERR_MASK = PDC_PH_ERR | PDC_SH_ERR | PDC_DH_ERR |
PDC_OVERRUN_ERR | PDC_UNDERRUN_ERR |
PDC_DRIVE_ERR | PDC_PCI_SYS_ERR |
PDC1_ERR_MASK | PDC2_ERR_MASK,

board_2037x = 0, /* FastTrak S150 TX2plus */
board_2037x_pata = 1, /* FastTrak S150 TX2plus PATA port */
board_20319 = 2, /* FastTrak S150 TX4 */
board_20619 = 3, /* FastTrak TX4000 */
board_2057x = 4, /* SATAII150 Tx2plus */
board_2057x_pata = 5, /* SATAII150 Tx2plus PATA port */
board_40518 = 6, /* SATAII150 Tx4 */

PDC_HAS_PATA = (1 << 1), /* PDC20375/20575 has PATA */

/* Sequence counter control registers bit definitions */
PDC_SEQCNTRL_INT_MASK = (1 << 5), /* Sequence Interrupt Mask */

/* Feature register values */
PDC_FEATURE_ATAPI_PIO = 0x00, /* ATAPI data xfer by PIO */
PDC_FEATURE_ATAPI_DMA = 0x01, /* ATAPI data xfer by DMA */

/* Device/Head register values */
PDC_DEVICE_SATA = 0xE0, /* Device/Head value for SATA devices */

/* PDC_CTLSTAT bit definitions */
PDC_DMA_ENABLE = (1 << 7),
PDC_IRQ_DISABLE = (1 << 10),
PDC_RESET = (1 << 11), /* HDMA reset */

PDC_COMMON_FLAGS = ATA_FLAG_NO_LEGACY |
ATA_FLAG_MMIO |
ATA_FLAG_PIO_POLLING,

/* ap->flags bits */
PDC_FLAG_GEN_II = (1 << 24),
PDC_FLAG_SATA_PATA = (1 << 25), /* supports SATA + PATA */
PDC_FLAG_4_PORTS = (1 << 26), /* 4 ports */
};

struct pdc_port_priv {
u8 *pkt;
dma_addr_t pkt_dma;
};

static int pdc_sata_scr_read(struct ata_port *ap, unsigned int sc_reg,
u32 *val);
static int pdc_sata_scr_write(struct ata_port *ap, unsigned int sc_reg,
u32 val);
static int pdc_ata_init_one (struct pci_dev *pdev, const struct
pci_device_id *ent);
static int pdc_common_port_start(struct ata_port *ap);
static int pdc_sata_port_start(struct ata_port *ap);
static void pdc_qc_prep(struct ata_queued_cmd *qc);
static void pdc_tf_load_mmio(struct ata_port *ap, const struct
ata_taskfile *tf);
static void pdc_exec_command_mmio(struct ata_port *ap, const struct
ata_taskfile *tf);
static int pdc_check_atapi_dma(struct ata_queued_cmd *qc);
static int pdc_old_sata_check_atapi_dma(struct ata_queued_cmd *qc);
static void pdc_irq_clear(struct ata_port *ap);
static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
static void pdc_freeze(struct ata_port *ap);
static void pdc_sata_freeze(struct ata_port *ap);
static void pdc_thaw(struct ata_port *ap);
static void pdc_sata_thaw(struct ata_port *ap);
static void pdc_pata_error_handler(struct ata_port *ap);
static void pdc_sata_error_handler(struct ata_port *ap);
static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
static int pdc_pata_cable_detect(struct ata_port *ap);
static int pdc_sata_cable_detect(struct ata_port *ap);

static struct scsi_host_template pdc_ata_sht = {
.module = THIS_MODULE,
.name = DRV_NAME,
.ioctl = ata_scsi_ioctl,
.queuecommand = ata_scsi_queuecmd,
.can_queue = ATA_DEF_QUEUE,
.this_id = ATA_SHT_THIS_ID,
.sg_tablesize = PDC_MAX_PRD,
.cmd_per_lun = ATA_SHT_CMD_PER_LUN,
.emulated = ATA_SHT_EMULATED,
.use_clustering = ATA_SHT_USE_CLUSTERING,
.proc_name = DRV_NAME,
.dma_boundary = ATA_DMA_BOUNDARY,
.slave_configure = ata_scsi_slave_config,
.slave_destroy = ata_scsi_slave_destroy,
.bios_param = ata_std_bios_param,
};

static const struct ata_port_operations pdc_sata_ops = {
.tf_load = pdc_tf_load_mmio,
.tf_read = ata_tf_read,
.check_status = ata_check_status,
.exec_command = pdc_exec_command_mmio,
.dev_select = ata_std_dev_select,
.check_atapi_dma = pdc_check_atapi_dma,

.qc_prep = pdc_qc_prep,
.qc_issue = pdc_qc_issue_prot,
.freeze = pdc_sata_freeze,
.thaw = pdc_sata_thaw,
.error_handler = pdc_sata_error_handler,
.post_internal_cmd = pdc_post_internal_cmd,
.cable_detect = pdc_sata_cable_detect,
.data_xfer = ata_data_xfer,
.irq_clear = pdc_irq_clear,
.irq_on = ata_irq_on,

.scr_read = pdc_sata_scr_read,
.scr_write = pdc_sata_scr_write,
.port_start = pdc_sata_port_start,
};

/* First-generation chips need a more restrictive ->check_atapi_dma op */
static const struct ata_port_operations pdc_old_sata_ops = {
.tf_load = pdc_tf_load_mmio,
.tf_read = ata_tf_read,
.check_status = ata_check_status,
.exec_command = pdc_exec_command_mmio,
.dev_select = ata_std_dev_select,
.check_atapi_dma = pdc_old_sata_check_atapi_dma,

.qc_prep = pdc_qc_prep,
.qc_issue = pdc_qc_issue_prot,
.freeze = pdc_sata_freeze,
.thaw = pdc_sata_thaw,
.error_handler = pdc_sata_error_handler,
.post_internal_cmd = pdc_post_internal_cmd,
.cable_detect = pdc_sata_cable_detect,
.data_xfer = ata_data_xfer,
.irq_clear = pdc_irq_clear,
.irq_on = ata_irq_on,

.scr_read = pdc_sata_scr_read,
.scr_write = pdc_sata_scr_write,
.port_start = pdc_sata_port_start,
};

static const struct ata_port_operations pdc_pata_ops = {
.tf_load = pdc_tf_load_mmio,
.tf_read = ata_tf_read,
.check_status = ata_check_status,
.exec_command = pdc_exec_command_mmio,
.dev_select = ata_std_dev_select,
.check_atapi_dma = pdc_check_atapi_dma,

.qc_prep = pdc_qc_prep,
.qc_issue = pdc_qc_issue_prot,
.freeze = pdc_freeze,
.thaw = pdc_thaw,
.error_handler = pdc_pata_error_handler,
.post_internal_cmd = pdc_post_internal_cmd,
.cable_detect = pdc_pata_cable_detect,
.data_xfer = ata_data_xfer,
.irq_clear = pdc_irq_clear,
.irq_on = ata_irq_on,

.port_start = pdc_common_port_start,
};

static const struct ata_port_info pdc_port_info[] = {
[board_2037x] =
{
.flags = PDC_COMMON_FLAGS | ATA_FLAG_SATA |
PDC_FLAG_SATA_PATA,
.pio_mask = 0x1f, /* pio0-4 */
.mwdma_mask = 0x07, /* mwdma0-2 */
.udma_mask = ATA_UDMA6,
.port_ops = &pdc_old_sata_ops,
},

[board_2037x_pata] =
{
.flags = PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
.pio_mask = 0x1f, /* pio0-4 */
.mwdma_mask = 0x07, /* mwdma0-2 */
.udma_mask = ATA_UDMA6,
.port_ops = &pdc_pata_ops,
},

[board_20319] =
{
.flags = PDC_COMMON_FLAGS | ATA_FLAG_SATA |
PDC_FLAG_4_PORTS,
.pio_mask = 0x1f, /* pio0-4 */
.mwdma_mask = 0x07, /* mwdma0-2 */
.udma_mask = ATA_UDMA6,
.port_ops = &pdc_old_sata_ops,
},

[board_20619] =
{
.flags = PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS |
PDC_FLAG_4_PORTS,
.pio_mask = 0x1f, /* pio0-4 */
.mwdma_mask = 0x07, /* mwdma0-2 */
.udma_mask = ATA_UDMA6,
.port_ops = &pdc_pata_ops,
},

[board_2057x] =
{
.flags = PDC_COMMON_FLAGS | ATA_FLAG_SATA |
PDC_FLAG_GEN_II | PDC_FLAG_SATA_PATA,
.pio_mask = 0x1f, /* pio0-4 */
.mwdma_mask = 0x07, /* mwdma0-2 */
.udma_mask = ATA_UDMA6,
.port_ops = &pdc_sata_ops,
},

[board_2057x_pata] =
{
.flags = PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS |
PDC_FLAG_GEN_II,
.pio_mask = 0x1f, /* pio0-4 */
.mwdma_mask = 0x07, /* mwdma0-2 */
.udma_mask = ATA_UDMA6,
.port_ops = &pdc_pata_ops,
},

[board_40518] =
{
.flags = PDC_COMMON_FLAGS | ATA_FLAG_SATA |
PDC_FLAG_GEN_II | PDC_FLAG_4_PORTS,
.pio_mask = 0x1f, /* pio0-4 */
.mwdma_mask = 0x07, /* mwdma0-2 */
.udma_mask = ATA_UDMA6,
.port_ops = &pdc_sata_ops,
},
};

static const struct pci_device_id pdc_ata_pci_tbl[] = {
{ PCI_VDEVICE(PROMISE, 0x3371), board_2037x },
{ PCI_VDEVICE(PROMISE, 0x3373), board_2037x },
{ PCI_VDEVICE(PROMISE, 0x3375), board_2037x },
{ PCI_VDEVICE(PROMISE, 0x3376), board_2037x },
{ PCI_VDEVICE(PROMISE, 0x3570), board_2057x },
{ PCI_VDEVICE(PROMISE, 0x3571), board_2057x },
{ PCI_VDEVICE(PROMISE, 0x3574), board_2057x },
{ PCI_VDEVICE(PROMISE, 0x3577), board_2057x },
{ PCI_VDEVICE(PROMISE, 0x3d73), board_2057x },
{ PCI_VDEVICE(PROMISE, 0x3d75), board_2057x },

{ PCI_VDEVICE(PROMISE, 0x3318), board_20319 },
{ PCI_VDEVICE(PROMISE, 0x3319), board_20319 },
{ PCI_VDEVICE(PROMISE, 0x3515), board_40518 },
{ PCI_VDEVICE(PROMISE, 0x3519), board_40518 },
{ PCI_VDEVICE(PROMISE, 0x3d17), board_40518 },
{ PCI_VDEVICE(PROMISE, 0x3d18), board_40518 },

{ PCI_VDEVICE(PROMISE, 0x6629), board_20619 },

{ } /* terminate list */
};

static struct pci_driver pdc_ata_pci_driver = {
.name = DRV_NAME,
.id_table = pdc_ata_pci_tbl,
.probe = pdc_ata_init_one,
.remove = ata_pci_remove_one,
};

static int pdc_common_port_start(struct ata_port *ap)
{
struct device *dev = ap->host->dev;
struct pdc_port_priv *pp;
int rc;

rc = ata_port_start(ap);
if (rc)
return rc;

pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
if (!pp)
return -ENOMEM;

pp->pkt = dmam_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
if (!pp->pkt)
return -ENOMEM;

ap->private_data = pp;

return 0;
}

static int pdc_sata_port_start(struct ata_port *ap)
{
int rc;

rc = pdc_common_port_start(ap);
if (rc)
return rc;

/* fix up PHYMODE4 align timing */
if (ap->flags & PDC_FLAG_GEN_II) {
void __iomem *mmio = ap->ioaddr.scr_addr;
unsigned int tmp;

tmp = readl(mmio + 0x014);
tmp = (tmp & ~3) | 1; /* set bits 1:0 = 0:1 */
writel(tmp, mmio + 0x014);
}

/* hack SControl to limit speed to 1.5Gbps */
if (ap->flags & PDC_FLAG_GEN_II) {
void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
unsigned int tmp1, tmp2;

tmp1 = readl(mmio + 0x008);
tmp2 = (tmp1 & 0xffffff00) | 0x00000011;
writel(tmp2, mmio + 0x008);
readl(mmio + 0x008); /* flush */
printk("%s(port %u): adjusted SControl from 0x%08x to 0x%08x\n",
__FUNCTION__, ap->port_no, tmp1, tmp2);
}

return 0;
}

static void pdc_reset_port(struct ata_port *ap)
{
void __iomem *mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT;
unsigned int i;
u32 tmp;

for (i = 11; i > 0; i--) {
tmp = readl(mmio);
if (tmp & PDC_RESET)
break;

udelay(100);

tmp |= PDC_RESET;
writel(tmp, mmio);
}

tmp &= ~PDC_RESET;
writel(tmp, mmio);
readl(mmio); /* flush */
}

static int pdc_pata_cable_detect(struct ata_port *ap)
{
u8 tmp;
void __iomem *mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;

tmp = readb(mmio);
if (tmp & 0x01)
return ATA_CBL_PATA40;
return ATA_CBL_PATA80;
}

static int pdc_sata_cable_detect(struct ata_port *ap)
{
return ATA_CBL_SATA;
}

static int pdc_sata_scr_read(struct ata_port *ap, unsigned int sc_reg,
u32 *val)
{
if (sc_reg > SCR_CONTROL)
return -EINVAL;
*val = readl(ap->ioaddr.scr_addr + (sc_reg * 4));
return 0;
}

static int pdc_sata_scr_write(struct ata_port *ap, unsigned int sc_reg,
u32 val)
{
if (sc_reg > SCR_CONTROL)
return -EINVAL;
writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
return 0;
}

static void pdc_atapi_pkt(struct ata_queued_cmd *qc)
{
struct ata_port *ap = qc->ap;
dma_addr_t sg_table = ap->prd_dma;
unsigned int cdb_len = qc->dev->cdb_len;
u8 *cdb = qc->cdb;
struct pdc_port_priv *pp = ap->private_data;
u8 *buf = pp->pkt;
u32 *buf32 = (u32 *) buf;
unsigned int dev_sel, feature, nbytes;

/* set control bits (byte 0), zero delay seq id (byte 3),
* and seq id (byte 2)
*/
switch (qc->tf.protocol) {
case ATA_PROT_ATAPI_DMA:
if (!(qc->tf.flags & ATA_TFLAG_WRITE))
buf32[0] = cpu_to_le32(PDC_PKT_READ);
else
buf32[0] = 0;
break;
case ATA_PROT_ATAPI_NODATA:
buf32[0] = cpu_to_le32(PDC_PKT_NODATA);
break;
default:
BUG();
break;
}
buf32[1] = cpu_to_le32(sg_table); /* S/G table addr */
buf32[2] = 0; /* no next-packet */

/* select drive */
if (sata_scr_valid(&ap->link)) {
dev_sel = PDC_DEVICE_SATA;
} else {
dev_sel = ATA_DEVICE_OBS;
if (qc->dev->devno != 0)
dev_sel |= ATA_DEV1;
}
buf[12] = (1 << 5) | ATA_REG_DEVICE;
buf[13] = dev_sel;
buf[14] = (1 << 5) | ATA_REG_DEVICE | PDC_PKT_CLEAR_BSY;
buf[15] = dev_sel; /* once more, waiting for BSY to clear */

buf[16] = (1 << 5) | ATA_REG_NSECT;
buf[17] = 0x00;
buf[18] = (1 << 5) | ATA_REG_LBAL;
buf[19] = 0x00;

/* set feature and byte counter registers */
if (qc->tf.protocol != ATA_PROT_ATAPI_DMA) {
feature = PDC_FEATURE_ATAPI_PIO;
/* set byte counter register to real transfer byte count */
nbytes = qc->nbytes;
if (nbytes > 0xffff)
nbytes = 0xffff;
} else {
feature = PDC_FEATURE_ATAPI_DMA;
/* set byte counter register to 0 */
nbytes = 0;
}
buf[20] = (1 << 5) | ATA_REG_FEATURE;
buf[21] = feature;
buf[22] = (1 << 5) | ATA_REG_BYTEL;
buf[23] = nbytes & 0xFF;
buf[24] = (1 << 5) | ATA_REG_BYTEH;
buf[25] = (nbytes >> 8) & 0xFF;

/* send ATAPI packet command 0xA0 */
buf[26] = (1 << 5) | ATA_REG_CMD;
buf[27] = ATA_CMD_PACKET;

/* select drive and check DRQ */
buf[28] = (1 << 5) | ATA_REG_DEVICE | PDC_PKT_WAIT_DRDY;
buf[29] = dev_sel;

/* we can represent cdb lengths 2/4/6/8/10/12/14/16 */
BUG_ON(cdb_len & ~0x1E);

/* append the CDB as the final part */
buf[30] = (((cdb_len >> 1) & 7) << 5) | ATA_REG_DATA | PDC_LAST_REG;
memcpy(buf+31, cdb, cdb_len);
}

/**
* pdc_fill_sg - Fill PCI IDE PRD table
* @qc: Metadata associated with taskfile to be transferred
*
* Fill PCI IDE PRD (scatter-gather) table with segments
* associated with the current disk command.
* Make sure hardware does not choke on it.
*
* LOCKING:
* spin_lock_irqsave(host lock)
*
*/
static void pdc_fill_sg(struct ata_queued_cmd *qc)
{
struct ata_port *ap = qc->ap;
struct scatterlist *sg;
unsigned int idx;
const u32 SG_COUNT_ASIC_BUG = 41*4;

if (!(qc->flags & ATA_QCFLAG_DMAMAP))
return;

WARN_ON(qc->__sg == NULL);
WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);

idx = 0;
ata_for_each_sg(sg, qc) {
u32 addr, offset;
u32 sg_len, len;

/* determine if physical DMA addr spans 64K boundary.
* Note h/w doesn't support 64-bit, so we unconditionally
* truncate dma_addr_t to u32.
*/
addr = (u32) sg_dma_address(sg);
sg_len = sg_dma_len(sg);

while (sg_len) {
offset = addr & 0xffff;
len = sg_len;
if ((offset + sg_len) > 0x10000)
len = 0x10000 - offset;

ap->prd[idx].addr = cpu_to_le32(addr);
ap->prd[idx].flags_len = cpu_to_le32(len & 0xffff);
VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);

idx++;
sg_len -= len;
addr += len;
}
}

if (idx) {
u32 len = le32_to_cpu(ap->prd[idx - 1].flags_len);

if (len > SG_COUNT_ASIC_BUG) {
u32 addr;

VPRINTK("Splitting last PRD.\n");

addr = le32_to_cpu(ap->prd[idx - 1].addr);
ap->prd[idx - 1].flags_len = cpu_to_le32(len - SG_COUNT_ASIC_BUG);
VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);

addr = addr + len - SG_COUNT_ASIC_BUG;
len = SG_COUNT_ASIC_BUG;
ap->prd[idx].addr = cpu_to_le32(addr);
ap->prd[idx].flags_len = cpu_to_le32(len);
VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);

idx++;
}

ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
}
}

static void pdc_qc_prep(struct ata_queued_cmd *qc)
{
struct pdc_port_priv *pp = qc->ap->private_data;
unsigned int i;

VPRINTK("ENTER\n");

switch (qc->tf.protocol) {
case ATA_PROT_DMA:
pdc_fill_sg(qc);
/* fall through */

case ATA_PROT_NODATA:
i = pdc_pkt_header(&qc->tf, qc->ap->prd_dma,
qc->dev->devno, pp->pkt);

if (qc->tf.flags & ATA_TFLAG_LBA48)
i = pdc_prep_lba48(&qc->tf, pp->pkt, i);
else
i = pdc_prep_lba28(&qc->tf, pp->pkt, i);

pdc_pkt_footer(&qc->tf, pp->pkt, i);
break;

case ATA_PROT_ATAPI:
pdc_fill_sg(qc);
break;

case ATA_PROT_ATAPI_DMA:
pdc_fill_sg(qc);
/*FALLTHROUGH*/
case ATA_PROT_ATAPI_NODATA:
pdc_atapi_pkt(qc);
break;

default:
break;
}
}

static int pdc_is_sataii_tx4(unsigned long flags)
{
const unsigned long mask = PDC_FLAG_GEN_II | PDC_FLAG_4_PORTS;
return (flags & mask) == mask;
}

static unsigned int pdc_port_no_to_ata_no(unsigned int port_no,
int is_sataii_tx4)
{
static const unsigned char sataii_tx4_port_remap[4] = { 3, 1, 0, 2};
return is_sataii_tx4 ? sataii_tx4_port_remap[port_no] : port_no;
}

static unsigned int pdc_sata_nr_ports(const struct ata_port *ap)
{
return (ap->flags & PDC_FLAG_4_PORTS) ? 4 : 2;
}

static unsigned int pdc_sata_ata_port_to_ata_no(const struct ata_port *ap)
{
const struct ata_host *host = ap->host;
unsigned int nr_ports = pdc_sata_nr_ports(ap);
unsigned int i;

for(i = 0; i < nr_ports && host->ports[i] != ap; ++i)
;
BUG_ON(i >= nr_ports);
return pdc_port_no_to_ata_no(i, pdc_is_sataii_tx4(ap->flags));
}

static unsigned int pdc_sata_hotplug_offset(const struct ata_port *ap)
{
return (ap->flags & PDC_FLAG_GEN_II) ? PDC2_SATA_PLUG_CSR :
PDC_SATA_PLUG_CSR;
}

static void pdc_freeze(struct ata_port *ap)
{
void __iomem *mmio = ap->ioaddr.cmd_addr;
u32 tmp;

tmp = readl(mmio + PDC_CTLSTAT);
tmp |= PDC_IRQ_DISABLE;
tmp &= ~PDC_DMA_ENABLE;
writel(tmp, mmio + PDC_CTLSTAT);
readl(mmio + PDC_CTLSTAT); /* flush */
}

static void pdc_sata_freeze(struct ata_port *ap)
{
struct ata_host *host = ap->host;
void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
unsigned int hotplug_offset = pdc_sata_hotplug_offset(ap);
unsigned int ata_no = pdc_sata_ata_port_to_ata_no(ap);
u32 hotplug_status;

/* Disable hotplug events on this port.
*
* Locking:
* 1) hotplug register accesses must be serialised via host->lock
* 2) ap->lock == &ap->host->lock
* 3) ->freeze() and ->thaw() are called with ap->lock held
*/
hotplug_status = readl(host_mmio + hotplug_offset);
hotplug_status |= 0x11 << (ata_no + 16);
writel(hotplug_status, host_mmio + hotplug_offset);
readl(host_mmio + hotplug_offset); /* flush */

pdc_freeze(ap);
}

static void pdc_thaw(struct ata_port *ap)
{
void __iomem *mmio = ap->ioaddr.cmd_addr;
u32 tmp;

/* clear IRQ */
readl(mmio + PDC_COMMAND);

/* turn IRQ back on */
tmp = readl(mmio + PDC_CTLSTAT);
tmp &= ~PDC_IRQ_DISABLE;
writel(tmp, mmio + PDC_CTLSTAT);
readl(mmio + PDC_CTLSTAT); /* flush */
}

static void pdc_sata_thaw(struct ata_port *ap)
{
struct ata_host *host = ap->host;
void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
unsigned int hotplug_offset = pdc_sata_hotplug_offset(ap);
unsigned int ata_no = pdc_sata_ata_port_to_ata_no(ap);
u32 hotplug_status;

pdc_thaw(ap);

/* Enable hotplug events on this port.
* Locking: see pdc_sata_freeze().
*/
hotplug_status = readl(host_mmio + hotplug_offset);
hotplug_status |= 0x11 << ata_no;
hotplug_status &= ~(0x11 << (ata_no + 16));
writel(hotplug_status, host_mmio + hotplug_offset);
readl(host_mmio + hotplug_offset); /* flush */
}

static void pdc_common_error_handler(struct ata_port *ap, ata_reset_fn_t
hardreset)
{
if (!(ap->pflags & ATA_PFLAG_FROZEN))
pdc_reset_port(ap);

/* perform recovery */
ata_do_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
ata_std_postreset);
}

static void pdc_pata_error_handler(struct ata_port *ap)
{
pdc_common_error_handler(ap, NULL);
}

static void pdc_sata_error_handler(struct ata_port *ap)
{
pdc_common_error_handler(ap, sata_std_hardreset);
}

static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
{
struct ata_port *ap = qc->ap;

/* make DMA engine forget about the failed command */
if (qc->flags & ATA_QCFLAG_FAILED)
pdc_reset_port(ap);
}

static void pdc_error_intr(struct ata_port *ap, struct ata_queued_cmd *qc,
u32 port_status, u32 err_mask)
{
struct ata_eh_info *ehi = &ap->link.eh_info;
unsigned int ac_err_mask = 0;

ata_ehi_clear_desc(ehi);
ata_ehi_push_desc(ehi, "port_status 0x%08x", port_status);
port_status &= err_mask;

if (port_status & PDC_DRIVE_ERR)
ac_err_mask |= AC_ERR_DEV;
if (port_status & (PDC_OVERRUN_ERR | PDC_UNDERRUN_ERR))
ac_err_mask |= AC_ERR_HSM;
if (port_status & (PDC2_ATA_HBA_ERR | PDC2_ATA_DMA_CNT_ERR))
ac_err_mask |= AC_ERR_ATA_BUS;
if (port_status & (PDC_PH_ERR | PDC_SH_ERR | PDC_DH_ERR | PDC2_HTO_ERR
| PDC_PCI_SYS_ERR | PDC1_PCI_PARITY_ERR))
ac_err_mask |= AC_ERR_HOST_BUS;

if (sata_scr_valid(&ap->link)) {
u32 serror;

pdc_sata_scr_read(ap, SCR_ERROR, &serror);
ehi->serror |= serror;
}

qc->err_mask |= ac_err_mask;

pdc_reset_port(ap);

ata_port_abort(ap);
}

static inline unsigned int pdc_host_intr(struct ata_port *ap,
struct ata_queued_cmd *qc)
{
unsigned int handled = 0;
void __iomem *port_mmio = ap->ioaddr.cmd_addr;
u32 port_status, err_mask;

err_mask = PDC_ERR_MASK;
if (ap->flags & PDC_FLAG_GEN_II)
err_mask &= ~PDC1_ERR_MASK;
else
err_mask &= ~PDC2_ERR_MASK;
port_status = readl(port_mmio + PDC_GLOBAL_CTL);
if (unlikely(port_status & err_mask)) {
pdc_error_intr(ap, qc, port_status, err_mask);
return 1;
}

switch (qc->tf.protocol) {
case ATA_PROT_DMA:
case ATA_PROT_NODATA:
case ATA_PROT_ATAPI_DMA:
case ATA_PROT_ATAPI_NODATA:
qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
ata_qc_complete(qc);
handled = 1;
break;

default:
ap->stats.idle_irq++;
break;
}

return handled;
}

static void pdc_irq_clear(struct ata_port *ap)
{
void __iomem *mmio = ap->ioaddr.cmd_addr;

readl(mmio + PDC_COMMAND);
}

static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
{
struct ata_host *host = dev_instance;
struct ata_port *ap;
u32 mask = 0;
unsigned int i, tmp;
unsigned int handled = 0;
void __iomem *mmio_base;
unsigned int hotplug_offset, ata_no;
u32 hotplug_status;
int is_sataii_tx4;

VPRINTK("ENTER\n");

if (!host || !host->iomap[PDC_MMIO_BAR]) {
VPRINTK("QUICK EXIT\n");
return IRQ_NONE;
}

mmio_base = host->iomap[PDC_MMIO_BAR];

spin_lock(&host->lock);

/* read and clear hotplug flags for all ports */
if (host->ports[0]->flags & PDC_FLAG_GEN_II)
hotplug_offset = PDC2_SATA_PLUG_CSR;
else
hotplug_offset = PDC_SATA_PLUG_CSR;
hotplug_status = readl(mmio_base + hotplug_offset);
if (hotplug_status & 0xff)
writel(hotplug_status | 0xff, mmio_base + hotplug_offset);
hotplug_status &= 0xff; /* clear uninteresting bits */

/* reading should also clear interrupts */
mask = readl(mmio_base + PDC_INT_SEQMASK);

if (mask == 0xffffffff && hotplug_status == 0) {
VPRINTK("QUICK EXIT 2\n");
goto done_irq;
}

mask &= 0xffff; /* only 16 tags possible */
if (mask == 0 && hotplug_status == 0) {
VPRINTK("QUICK EXIT 3\n");
goto done_irq;
}

writel(mask, mmio_base + PDC_INT_SEQMASK);

is_sataii_tx4 = pdc_is_sataii_tx4(host->ports[0]->flags);

for (i = 0; i < host->n_ports; i++) {
VPRINTK("port %u\n", i);
ap = host->ports[i];

/* check for a plug or unplug event */
ata_no = pdc_port_no_to_ata_no(i, is_sataii_tx4);
tmp = hotplug_status & (0x11 << ata_no);
if (tmp && ap &&
!(ap->flags & ATA_FLAG_DISABLED)) {
struct ata_eh_info *ehi = &ap->link.eh_info;
ata_ehi_clear_desc(ehi);
ata_ehi_hotplugged(ehi);
ata_ehi_push_desc(ehi, "hotplug_status %#x", tmp);
ata_port_freeze(ap);
++handled;
continue;
}

/* check for a packet interrupt */
tmp = mask & (1 << (i + 1));
if (tmp && ap &&
!(ap->flags & ATA_FLAG_DISABLED)) {
struct ata_queued_cmd *qc;

qc = ata_qc_from_tag(ap, ap->link.active_tag);
if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
handled += pdc_host_intr(ap, qc);
}
}

VPRINTK("EXIT\n");

done_irq:
spin_unlock(&host->lock);
return IRQ_RETVAL(handled);
}

static inline void pdc_packet_start(struct ata_queued_cmd *qc)
{
struct ata_port *ap = qc->ap;
struct pdc_port_priv *pp = ap->private_data;
void __iomem *mmio = ap->host->iomap[PDC_MMIO_BAR];
unsigned int port_no = ap->port_no;
u8 seq = (u8) (port_no + 1);

VPRINTK("ENTER, ap %p\n", ap);

writel(0x00000001, mmio + (seq * 4));
readl(mmio + (seq * 4)); /* flush */

pp->pkt[2] = seq;
wmb(); /* flush PRD, pkt writes */
writel(pp->pkt_dma, ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
readl(ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT); /* flush */
}

static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
{
switch (qc->tf.protocol) {
case ATA_PROT_ATAPI_NODATA:
if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
break;
/*FALLTHROUGH*/
case ATA_PROT_NODATA:
if (qc->tf.flags & ATA_TFLAG_POLLING)
break;
/*FALLTHROUGH*/
case ATA_PROT_ATAPI_DMA:
case ATA_PROT_DMA:
pdc_packet_start(qc);
return 0;

default:
break;
}

return ata_qc_issue_prot(qc);
}

static void pdc_tf_load_mmio(struct ata_port *ap, const struct
ata_taskfile *tf)
{
WARN_ON(tf->protocol == ATA_PROT_DMA ||
tf->protocol == ATA_PROT_ATAPI_DMA);
ata_tf_load(ap, tf);
}

static void pdc_exec_command_mmio(struct ata_port *ap,
const struct ata_taskfile *tf)
{
WARN_ON(tf->protocol == ATA_PROT_DMA ||
tf->protocol == ATA_PROT_ATAPI_DMA);
ata_exec_command(ap, tf);
}

static int pdc_check_atapi_dma(struct ata_queued_cmd *qc)
{
u8 *scsicmd = qc->scsicmd->cmnd;
int pio = 1; /* atapi dma off by default */

/* Whitelist commands that may use DMA. */
switch (scsicmd[0]) {
case WRITE_12:
case WRITE_10:
case WRITE_6:
case READ_12:
case READ_10:
case READ_6:
case 0xad: /* READ_DVD_STRUCTURE */
case 0xbe: /* READ_CD */
pio = 0;
}
/* -45150 (FFFF4FA2) to -1 (FFFFFFFF) shall use PIO mode */
if (scsicmd[0] == WRITE_10) {
unsigned int lba =
(scsicmd[2] << 24) |
(scsicmd[3] << 16) |
(scsicmd[4] << 8) |
scsicmd[5];
if (lba >= 0xFFFF4FA2)
pio = 1;
}
return pio;
}

static int pdc_old_sata_check_atapi_dma(struct ata_queued_cmd *qc)
{
/* First generation chips cannot use ATAPI DMA on SATA ports */
return 1;
}

static void pdc_ata_setup_port(struct ata_port *ap,
void __iomem *base, void __iomem *scr_addr)
{
ap->ioaddr.cmd_addr = base;
ap->ioaddr.data_addr = base;
ap->ioaddr.feature_addr =
ap->ioaddr.error_addr = base + 0x4;
ap->ioaddr.nsect_addr = base + 0x8;
ap->ioaddr.lbal_addr = base + 0xc;
ap->ioaddr.lbam_addr = base + 0x10;
ap->ioaddr.lbah_addr = base + 0x14;
ap->ioaddr.device_addr = base + 0x18;
ap->ioaddr.command_addr =
ap->ioaddr.status_addr = base + 0x1c;
ap->ioaddr.altstatus_addr =
ap->ioaddr.ctl_addr = base + 0x38;
ap->ioaddr.scr_addr = scr_addr;
}

static void pdc_host_init(struct ata_host *host)
{
void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
int is_gen2 = host->ports[0]->flags & PDC_FLAG_GEN_II;
int hotplug_offset;
u32 tmp;

if (is_gen2)
hotplug_offset = PDC2_SATA_PLUG_CSR;
else
hotplug_offset = PDC_SATA_PLUG_CSR;

/*
* Except for the hotplug stuff, this is voodoo from the
* Promise driver. Label this entire section
* "TODO: figure out why we do this"
*/

/* enable BMR_BURST, maybe change FIFO_SHD to 8 dwords */
tmp = readl(mmio + PDC_FLASH_CTL);
tmp |= 0x02000; /* bit 13 (enable bmr burst) */
if (!is_gen2)
tmp |= 0x10000; /* bit 16 (fifo threshold at 8 dw) */
writel(tmp, mmio + PDC_FLASH_CTL);

/* clear plug/unplug flags for all ports */
tmp = readl(mmio + hotplug_offset);
writel(tmp | 0xff, mmio + hotplug_offset);

/* unmask plug/unplug ints */
tmp = readl(mmio + hotplug_offset);
writel(tmp & ~0xff0000, mmio + hotplug_offset);

/* don't initialise TBG or SLEW on 2nd generation chips */
if (is_gen2)
return;

/* reduce TBG clock to 133 Mhz. */
tmp = readl(mmio + PDC_TBG_MODE);
tmp &= ~0x30000; /* clear bit 17, 16*/
tmp |= 0x10000; /* set bit 17:16 = 0:1 */
writel(tmp, mmio + PDC_TBG_MODE);

readl(mmio + PDC_TBG_MODE); /* flush */
msleep(10);

/* adjust slew rate control register. */
tmp = readl(mmio + PDC_SLEW_CTL);
tmp &= 0xFFFFF03F; /* clear bit 11 ~ 6 */
tmp |= 0x00000900; /* set bit 11-9 = 100b , bit 8-6 = 100 */
writel(tmp, mmio + PDC_SLEW_CTL);
}

static int pdc_ata_init_one(struct pci_dev *pdev,
const struct pci_device_id *ent)
{
static int printed_version;
const struct ata_port_info *pi = &pdc_port_info[ent->driver_data];
const struct ata_port_info *ppi[PDC_MAX_PORTS];
struct ata_host *host;
void __iomem *base;
int n_ports, i, rc;
int is_sataii_tx4;

if (!printed_version++)
dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");

/* enable and acquire resources */
rc = pcim_enable_device(pdev);
if (rc)
return rc;

rc = pcim_iomap_regions(pdev, 1 << PDC_MMIO_BAR, DRV_NAME);
if (rc == -EBUSY)
pcim_pin_device(pdev);
if (rc)
return rc;
base = pcim_iomap_table(pdev)[PDC_MMIO_BAR];

/* determine port configuration and setup host */
n_ports = 2;
if (pi->flags & PDC_FLAG_4_PORTS)
n_ports = 4;
for (i = 0; i < n_ports; i++)
ppi[i] = pi;

if (pi->flags & PDC_FLAG_SATA_PATA) {
u8 tmp = readb(base + PDC_FLASH_CTL+1);
if (!(tmp & 0x80))
ppi[n_ports++] = pi + 1;
}

host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
if (!host) {
dev_printk(KERN_ERR, &pdev->dev, "failed to allocate host\n");
return -ENOMEM;
}
host->iomap = pcim_iomap_table(pdev);

is_sataii_tx4 = pdc_is_sataii_tx4(pi->flags);
for (i = 0; i < host->n_ports; i++) {
struct ata_port *ap = host->ports[i];
unsigned int ata_no = pdc_port_no_to_ata_no(i, is_sataii_tx4);
unsigned int port_offset = 0x200 + ata_no * 0x80;
unsigned int scr_offset = 0x400 + ata_no * 0x100;

pdc_ata_setup_port(ap, base + port_offset, base + scr_offset);

ata_port_pbar_desc(ap, PDC_MMIO_BAR, -1, "mmio");
ata_port_pbar_desc(ap, PDC_MMIO_BAR, port_offset, "port");
}

/* initialize adapter */
pdc_host_init(host);

rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
if (rc)
return rc;
rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
if (rc)
return rc;

/* start host, request IRQ and attach */
pci_set_master(pdev);
return ata_host_activate(host, pdev->irq, pdc_interrupt, IRQF_SHARED,
&pdc_ata_sht);
}

static int __init pdc_ata_init(void)
{
return pci_register_driver(&pdc_ata_pci_driver);
}

static void __exit pdc_ata_exit(void)
{
pci_unregister_driver(&pdc_ata_pci_driver);
}

MODULE_AUTHOR("Jeff Garzik");
MODULE_DESCRIPTION("Promise ATA TX2/TX4/TX4000 low-level driver");
MODULE_LICENSE("GPL");
MODULE_DEVICE_TABLE(pci, pdc_ata_pci_tbl);
MODULE_VERSION(DRV_VERSION);

module_init(pdc_ata_init);
module_exit(pdc_ata_exit);

