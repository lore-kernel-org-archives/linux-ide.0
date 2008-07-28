From: "eric" <eric@pozicom.net>
Subject: (unknown)
Date: Mon, 28 Jul 2008 18:23:25 -0400
Message-ID: <20080728231012.BEBEE437FB@mail.pozicom.net>
Reply-To: <eric@pozicom.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003B_01C8F0DF.072704B0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx01.pozicom.net ([70.88.103.169]:54286 "EHLO mail.pozicom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbYG1Wqd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jul 2008 18:46:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.pozicom.net (Postfix) with ESMTP id D642543800
	for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 19:10:13 -0400 (EDT)
Received: from mail.pozicom.net ([127.0.0.1])
 by localhost (mail.pozicom.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 22818-05-4 for <linux-ide@vger.kernel.org>;
 Mon, 28 Jul 2008 19:10:12 -0400 (EDT)
Received: from pozwks1 (unknown [70.88.103.172])
	by mail.pozicom.net (Postfix) with ESMTP id BEBEE437FB
	for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 19:10:11 -0400 (EDT)
Subject: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_003B_01C8F0DF.072704B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

To whom it may concern:

We have the HighPoint 1740 SATAII RAID card.  I had to modify the sata_mv.c
(attached) to get it to work with my card.  The interesting bits are as
follows:

/* RocketRAID 1740/174x have different identifiers */

/* { PCI_VDEVICE(TTI, 0x1740), chip_508x }, */

/* Pozicom: GenII 1740 cards use 88sx6042 chip */

{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },

{ PCI_VDEVICE(TTI, 0x1742), chip_508x },

 
It appears the same card has different chip set depending upon when you
purchased your card.  Looking through the code, the GenI vs. GenII vs.
GenIIe is done after the call to mv_pci_init_one thus passing a table of
values that are incorrect.  It would appear to make sense to solve this by
creating two or more tables and make mv_pci_tbl a pci_device_id global * and
reference it accordingly after the Rev. level was determined.
 
Hope this helps.  I don't have access to older 1740 cards else I'd formulate
a better solution.
 
Hope this helps.  I did a fair amount of testing with this and it appears to
work rather well.
 
 
Eric Mayo
Pozicom Technologies, Inc.
Email:  My First name 'at' pozicom.net


------=_NextPart_000_003B_01C8F0DF.072704B0
Content-Type: application/octet-stream;
	name="sata_mv.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sata_mv.c"

/*=0A=
 * sata_mv.c - Marvell SATA support=0A=
 *=0A=
 * Copyright 2008: Marvell Corporation, all rights reserved.=0A=
 * Copyright 2005: EMC Corporation, all rights reserved.=0A=
 * Copyright 2005 Red Hat, Inc.  All rights reserved.=0A=
 *=0A=
 * Please ALWAYS copy linux-ide@vger.kernel.org on emails.=0A=
 *=0A=
 * This program is free software; you can redistribute it and/or modify=0A=
 * it under the terms of the GNU General Public License as published by=0A=
 * the Free Software Foundation; version 2 of the License.=0A=
 *=0A=
 * This program is distributed in the hope that it will be useful,=0A=
 * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
 * GNU General Public License for more details.=0A=
 *=0A=
 * You should have received a copy of the GNU General Public License=0A=
 * along with this program; if not, write to the Free Software=0A=
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA=0A=
 *=0A=
 */=0A=
=0A=
/*=0A=
 * sata_mv TODO list:=0A=
 *=0A=
 * --> Errata workaround for NCQ device errors.=0A=
 *=0A=
 * --> More errata workarounds for PCI-X.=0A=
 *=0A=
 * --> Complete a full errata audit for all chipsets to identify others.=0A=
 *=0A=
 * --> ATAPI support (Marvell claims the 60xx/70xx chips can do it).=0A=
 *=0A=
 * --> Investigate problems with PCI Message Signalled Interrupts (MSI).=0A=
 *=0A=
 * --> Cache frequently-accessed registers in mv_port_priv to reduce =
overhead.=0A=
 *=0A=
 * --> Develop a low-power-consumption strategy, and implement it.=0A=
 *=0A=
 * --> [Experiment, low priority] Investigate interrupt coalescing.=0A=
 *       Quite often, especially with PCI Message Signalled Interrupts =
(MSI),=0A=
 *       the overhead reduced by interrupt mitigation is quite often not=0A=
 *       worth the latency cost.=0A=
 *=0A=
 * --> [Experiment, Marvell value added] Is it possible to use target=0A=
 *       mode to cross-connect two Linux boxes with Marvell cards?  If =
so,=0A=
 *       creating LibATA target mode support would be very interesting.=0A=
 *=0A=
 *       Target mode, for those without docs, is the ability to directly=0A=
 *       connect two SATA ports.=0A=
 */=0A=
=0A=
#include <linux/kernel.h>=0A=
#include <linux/module.h>=0A=
#include <linux/pci.h>=0A=
#include <linux/init.h>=0A=
#include <linux/blkdev.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/interrupt.h>=0A=
#include <linux/dmapool.h>=0A=
#include <linux/dma-mapping.h>=0A=
#include <linux/device.h>=0A=
#include <linux/platform_device.h>=0A=
#include <linux/ata_platform.h>=0A=
#include <linux/mbus.h>=0A=
#include <linux/bitops.h>=0A=
#include <scsi/scsi_host.h>=0A=
#include <scsi/scsi_cmnd.h>=0A=
#include <scsi/scsi_device.h>=0A=
#include <linux/libata.h>=0A=
=0A=
#define DRV_NAME	"sata_mv"=0A=
#define DRV_VERSION	"1.24"=0A=
=0A=
enum {=0A=
	/* BAR's are enumerated in terms of pci_resource_start() terms */=0A=
	MV_PRIMARY_BAR		=3D 0,	/* offset 0x10: memory space */=0A=
	MV_IO_BAR		=3D 2,	/* offset 0x18: IO space */=0A=
	MV_MISC_BAR		=3D 3,	/* offset 0x1c: FLASH, NVRAM, SRAM */=0A=
=0A=
	MV_MAJOR_REG_AREA_SZ	=3D 0x10000,	/* 64KB */=0A=
	MV_MINOR_REG_AREA_SZ	=3D 0x2000,	/* 8KB */=0A=
=0A=
	MV_PCI_REG_BASE		=3D 0,=0A=
	MV_IRQ_COAL_REG_BASE	=3D 0x18000,	/* 6xxx part only */=0A=
	MV_IRQ_COAL_CAUSE		=3D (MV_IRQ_COAL_REG_BASE + 0x08),=0A=
	MV_IRQ_COAL_CAUSE_LO		=3D (MV_IRQ_COAL_REG_BASE + 0x88),=0A=
	MV_IRQ_COAL_CAUSE_HI		=3D (MV_IRQ_COAL_REG_BASE + 0x8c),=0A=
	MV_IRQ_COAL_THRESHOLD		=3D (MV_IRQ_COAL_REG_BASE + 0xcc),=0A=
	MV_IRQ_COAL_TIME_THRESHOLD	=3D (MV_IRQ_COAL_REG_BASE + 0xd0),=0A=
=0A=
	MV_SATAHC0_REG_BASE	=3D 0x20000,=0A=
	MV_FLASH_CTL_OFS	=3D 0x1046c,=0A=
	MV_GPIO_PORT_CTL_OFS	=3D 0x104f0,=0A=
	MV_RESET_CFG_OFS	=3D 0x180d8,=0A=
=0A=
	MV_PCI_REG_SZ		=3D MV_MAJOR_REG_AREA_SZ,=0A=
	MV_SATAHC_REG_SZ	=3D MV_MAJOR_REG_AREA_SZ,=0A=
	MV_SATAHC_ARBTR_REG_SZ	=3D MV_MINOR_REG_AREA_SZ,		/* arbiter */=0A=
	MV_PORT_REG_SZ		=3D MV_MINOR_REG_AREA_SZ,=0A=
=0A=
	MV_MAX_Q_DEPTH		=3D 32,=0A=
	MV_MAX_Q_DEPTH_MASK	=3D MV_MAX_Q_DEPTH - 1,=0A=
=0A=
	/* CRQB needs alignment on a 1KB boundary. Size =3D=3D 1KB=0A=
	 * CRPB needs alignment on a 256B boundary. Size =3D=3D 256B=0A=
	 * ePRD (SG) entries need alignment on a 16B boundary. Size =3D=3D 16B=0A=
	 */=0A=
	MV_CRQB_Q_SZ		=3D (32 * MV_MAX_Q_DEPTH),=0A=
	MV_CRPB_Q_SZ		=3D (8 * MV_MAX_Q_DEPTH),=0A=
	MV_MAX_SG_CT		=3D 256,=0A=
	MV_SG_TBL_SZ		=3D (16 * MV_MAX_SG_CT),=0A=
=0A=
	/* Determine hc from 0-7 port: hc =3D port >> MV_PORT_HC_SHIFT */=0A=
	MV_PORT_HC_SHIFT	=3D 2,=0A=
	MV_PORTS_PER_HC		=3D (1 << MV_PORT_HC_SHIFT), /* 4 */=0A=
	/* Determine hc port from 0-7 port: hardport =3D port & MV_PORT_MASK */=0A=
	MV_PORT_MASK		=3D (MV_PORTS_PER_HC - 1),   /* 3 */=0A=
=0A=
	/* Host Flags */=0A=
	MV_FLAG_DUAL_HC		=3D (1 << 30),  /* two SATA Host Controllers */=0A=
	MV_FLAG_IRQ_COALESCE	=3D (1 << 29),  /* IRQ coalescing capability */=0A=
=0A=
	MV_COMMON_FLAGS		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |=0A=
				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |=0A=
				  ATA_FLAG_PIO_POLLING,=0A=
=0A=
	MV_6XXX_FLAGS		=3D MV_FLAG_IRQ_COALESCE,=0A=
=0A=
	MV_GENIIE_FLAGS		=3D MV_COMMON_FLAGS | MV_6XXX_FLAGS |=0A=
				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |=0A=
				  ATA_FLAG_NCQ | ATA_FLAG_AN,=0A=
=0A=
	CRQB_FLAG_READ		=3D (1 << 0),=0A=
	CRQB_TAG_SHIFT		=3D 1,=0A=
	CRQB_IOID_SHIFT		=3D 6,	/* CRQB Gen-II/IIE IO Id shift */=0A=
	CRQB_PMP_SHIFT		=3D 12,	/* CRQB Gen-II/IIE PMP shift */=0A=
	CRQB_HOSTQ_SHIFT	=3D 17,	/* CRQB Gen-II/IIE HostQueTag shift */=0A=
	CRQB_CMD_ADDR_SHIFT	=3D 8,=0A=
	CRQB_CMD_CS		=3D (0x2 << 11),=0A=
	CRQB_CMD_LAST		=3D (1 << 15),=0A=
=0A=
	CRPB_FLAG_STATUS_SHIFT	=3D 8,=0A=
	CRPB_IOID_SHIFT_6	=3D 5,	/* CRPB Gen-II IO Id shift */=0A=
	CRPB_IOID_SHIFT_7	=3D 7,	/* CRPB Gen-IIE IO Id shift */=0A=
=0A=
	EPRD_FLAG_END_OF_TBL	=3D (1 << 31),=0A=
=0A=
	/* PCI interface registers */=0A=
=0A=
	PCI_COMMAND_OFS		=3D 0xc00,=0A=
	PCI_COMMAND_MRDTRIG	=3D (1 << 7),	/* PCI Master Read Trigger */=0A=
=0A=
	PCI_MAIN_CMD_STS_OFS	=3D 0xd30,=0A=
	STOP_PCI_MASTER		=3D (1 << 2),=0A=
	PCI_MASTER_EMPTY	=3D (1 << 3),=0A=
	GLOB_SFT_RST		=3D (1 << 4),=0A=
=0A=
	MV_PCI_MODE_OFS		=3D 0xd00,=0A=
	MV_PCI_MODE_MASK	=3D 0x30,=0A=
=0A=
	MV_PCI_EXP_ROM_BAR_CTL	=3D 0xd2c,=0A=
	MV_PCI_DISC_TIMER	=3D 0xd04,=0A=
	MV_PCI_MSI_TRIGGER	=3D 0xc38,=0A=
	MV_PCI_SERR_MASK	=3D 0xc28,=0A=
	MV_PCI_XBAR_TMOUT_OFS	=3D 0x1d04,=0A=
	MV_PCI_ERR_LOW_ADDRESS	=3D 0x1d40,=0A=
	MV_PCI_ERR_HIGH_ADDRESS	=3D 0x1d44,=0A=
	MV_PCI_ERR_ATTRIBUTE	=3D 0x1d48,=0A=
	MV_PCI_ERR_COMMAND	=3D 0x1d50,=0A=
=0A=
	PCI_IRQ_CAUSE_OFS	=3D 0x1d58,=0A=
	PCI_IRQ_MASK_OFS	=3D 0x1d5c,=0A=
	PCI_UNMASK_ALL_IRQS	=3D 0x7fffff,	/* bits 22-0 */=0A=
=0A=
	PCIE_IRQ_CAUSE_OFS	=3D 0x1900,=0A=
	PCIE_IRQ_MASK_OFS	=3D 0x1910,=0A=
	PCIE_UNMASK_ALL_IRQS	=3D 0x40a,	/* assorted bits */=0A=
=0A=
	/* Host Controller Main Interrupt Cause/Mask registers (1 per-chip) */=0A=
	PCI_HC_MAIN_IRQ_CAUSE_OFS =3D 0x1d60,=0A=
	PCI_HC_MAIN_IRQ_MASK_OFS  =3D 0x1d64,=0A=
	SOC_HC_MAIN_IRQ_CAUSE_OFS =3D 0x20020,=0A=
	SOC_HC_MAIN_IRQ_MASK_OFS  =3D 0x20024,=0A=
	ERR_IRQ			=3D (1 << 0),	/* shift by port # */=0A=
	DONE_IRQ		=3D (1 << 1),	/* shift by port # */=0A=
	HC0_IRQ_PEND		=3D 0x1ff,	/* bits 0-8 =3D HC0's ports */=0A=
	HC_SHIFT		=3D 9,		/* bits 9-17 =3D HC1's ports */=0A=
	PCI_ERR			=3D (1 << 18),=0A=
	TRAN_LO_DONE		=3D (1 << 19),	/* 6xxx: IRQ coalescing */=0A=
	TRAN_HI_DONE		=3D (1 << 20),	/* 6xxx: IRQ coalescing */=0A=
	PORTS_0_3_COAL_DONE	=3D (1 << 8),=0A=
	PORTS_4_7_COAL_DONE	=3D (1 << 17),=0A=
	PORTS_0_7_COAL_DONE	=3D (1 << 21),	/* 6xxx: IRQ coalescing */=0A=
	GPIO_INT		=3D (1 << 22),=0A=
	SELF_INT		=3D (1 << 23),=0A=
	TWSI_INT		=3D (1 << 24),=0A=
	HC_MAIN_RSVD		=3D (0x7f << 25),	/* bits 31-25 */=0A=
	HC_MAIN_RSVD_5		=3D (0x1fff << 19), /* bits 31-19 */=0A=
	HC_MAIN_RSVD_SOC	=3D (0x3fffffb << 6),     /* bits 31-9, 7-6 */=0A=
=0A=
	/* SATAHC registers */=0A=
	HC_CFG_OFS		=3D 0,=0A=
=0A=
	HC_IRQ_CAUSE_OFS	=3D 0x14,=0A=
	DMA_IRQ			=3D (1 << 0),	/* shift by port # */=0A=
	HC_COAL_IRQ		=3D (1 << 4),	/* IRQ coalescing */=0A=
	DEV_IRQ			=3D (1 << 8),	/* shift by port # */=0A=
=0A=
	/* Shadow block registers */=0A=
	SHD_BLK_OFS		=3D 0x100,=0A=
	SHD_CTL_AST_OFS		=3D 0x20,		/* ofs from SHD_BLK_OFS */=0A=
=0A=
	/* SATA registers */=0A=
	SATA_STATUS_OFS		=3D 0x300,  /* ctrl, err regs follow status */=0A=
	SATA_ACTIVE_OFS		=3D 0x350,=0A=
	SATA_FIS_IRQ_CAUSE_OFS	=3D 0x364,=0A=
	SATA_FIS_IRQ_AN		=3D (1 << 9),	/* async notification */=0A=
=0A=
	LTMODE_OFS		=3D 0x30c,=0A=
	LTMODE_BIT8		=3D (1 << 8),	/* unknown, but necessary */=0A=
=0A=
	PHY_MODE3		=3D 0x310,=0A=
	PHY_MODE4		=3D 0x314,=0A=
	PHY_MODE4_CFG_MASK	=3D 0x00000003,	/* phy internal config field */=0A=
	PHY_MODE4_CFG_VALUE	=3D 0x00000001,	/* phy internal config field */=0A=
	PHY_MODE4_RSVD_ZEROS	=3D 0x5de3fffa,	/* Gen2e always write zeros */=0A=
	PHY_MODE4_RSVD_ONES	=3D 0x00000005,	/* Gen2e always write ones */=0A=
=0A=
	PHY_MODE2		=3D 0x330,=0A=
	SATA_IFCTL_OFS		=3D 0x344,=0A=
	SATA_TESTCTL_OFS	=3D 0x348,=0A=
	SATA_IFSTAT_OFS		=3D 0x34c,=0A=
	VENDOR_UNIQUE_FIS_OFS	=3D 0x35c,=0A=
=0A=
	FISCFG_OFS		=3D 0x360,=0A=
	FISCFG_WAIT_DEV_ERR	=3D (1 << 8),	/* wait for host on DevErr */=0A=
	FISCFG_SINGLE_SYNC	=3D (1 << 16),	/* SYNC on DMA activation */=0A=
=0A=
	MV5_PHY_MODE		=3D 0x74,=0A=
	MV5_LTMODE_OFS		=3D 0x30,=0A=
	MV5_PHY_CTL_OFS		=3D 0x0C,=0A=
	SATA_INTERFACE_CFG_OFS	=3D 0x050,=0A=
=0A=
	MV_M2_PREAMP_MASK	=3D 0x7e0,=0A=
=0A=
	/* Port registers */=0A=
	EDMA_CFG_OFS		=3D 0,=0A=
	EDMA_CFG_Q_DEPTH	=3D 0x1f,		/* max device queue depth */=0A=
	EDMA_CFG_NCQ		=3D (1 << 5),	/* for R/W FPDMA queued */=0A=
	EDMA_CFG_NCQ_GO_ON_ERR	=3D (1 << 14),	/* continue on error */=0A=
	EDMA_CFG_RD_BRST_EXT	=3D (1 << 11),	/* read burst 512B */=0A=
	EDMA_CFG_WR_BUFF_LEN	=3D (1 << 13),	/* write buffer 512B */=0A=
	EDMA_CFG_EDMA_FBS	=3D (1 << 16),	/* EDMA FIS-Based Switching */=0A=
	EDMA_CFG_FBS		=3D (1 << 26),	/* FIS-Based Switching */=0A=
=0A=
	EDMA_ERR_IRQ_CAUSE_OFS	=3D 0x8,=0A=
	EDMA_ERR_IRQ_MASK_OFS	=3D 0xc,=0A=
	EDMA_ERR_D_PAR		=3D (1 << 0),	/* UDMA data parity err */=0A=
	EDMA_ERR_PRD_PAR	=3D (1 << 1),	/* UDMA PRD parity err */=0A=
	EDMA_ERR_DEV		=3D (1 << 2),	/* device error */=0A=
	EDMA_ERR_DEV_DCON	=3D (1 << 3),	/* device disconnect */=0A=
	EDMA_ERR_DEV_CON	=3D (1 << 4),	/* device connected */=0A=
	EDMA_ERR_SERR		=3D (1 << 5),	/* SError bits [WBDST] raised */=0A=
	EDMA_ERR_SELF_DIS	=3D (1 << 7),	/* Gen II/IIE self-disable */=0A=
	EDMA_ERR_SELF_DIS_5	=3D (1 << 8),	/* Gen I self-disable */=0A=
	EDMA_ERR_BIST_ASYNC	=3D (1 << 8),	/* BIST FIS or Async Notify */=0A=
	EDMA_ERR_TRANS_IRQ_7	=3D (1 << 8),	/* Gen IIE transprt layer irq */=0A=
	EDMA_ERR_CRQB_PAR	=3D (1 << 9),	/* CRQB parity error */=0A=
	EDMA_ERR_CRPB_PAR	=3D (1 << 10),	/* CRPB parity error */=0A=
	EDMA_ERR_INTRL_PAR	=3D (1 << 11),	/* internal parity error */=0A=
	EDMA_ERR_IORDY		=3D (1 << 12),	/* IORdy timeout */=0A=
=0A=
	EDMA_ERR_LNK_CTRL_RX	=3D (0xf << 13),	/* link ctrl rx error */=0A=
	EDMA_ERR_LNK_CTRL_RX_0	=3D (1 << 13),	/* transient: CRC err */=0A=
	EDMA_ERR_LNK_CTRL_RX_1	=3D (1 << 14),	/* transient: FIFO err */=0A=
	EDMA_ERR_LNK_CTRL_RX_2	=3D (1 << 15),	/* fatal: caught SYNC */=0A=
	EDMA_ERR_LNK_CTRL_RX_3	=3D (1 << 16),	/* transient: FIS rx err */=0A=
=0A=
	EDMA_ERR_LNK_DATA_RX	=3D (0xf << 17),	/* link data rx error */=0A=
=0A=
	EDMA_ERR_LNK_CTRL_TX	=3D (0x1f << 21),	/* link ctrl tx error */=0A=
	EDMA_ERR_LNK_CTRL_TX_0	=3D (1 << 21),	/* transient: CRC err */=0A=
	EDMA_ERR_LNK_CTRL_TX_1	=3D (1 << 22),	/* transient: FIFO err */=0A=
	EDMA_ERR_LNK_CTRL_TX_2	=3D (1 << 23),	/* transient: caught SYNC */=0A=
	EDMA_ERR_LNK_CTRL_TX_3	=3D (1 << 24),	/* transient: caught DMAT */=0A=
	EDMA_ERR_LNK_CTRL_TX_4	=3D (1 << 25),	/* transient: FIS collision */=0A=
=0A=
	EDMA_ERR_LNK_DATA_TX	=3D (0x1f << 26),	/* link data tx error */=0A=
=0A=
	EDMA_ERR_TRANS_PROTO	=3D (1 << 31),	/* transport protocol error */=0A=
	EDMA_ERR_OVERRUN_5	=3D (1 << 5),=0A=
	EDMA_ERR_UNDERRUN_5	=3D (1 << 6),=0A=
=0A=
	EDMA_ERR_IRQ_TRANSIENT  =3D EDMA_ERR_LNK_CTRL_RX_0 |=0A=
				  EDMA_ERR_LNK_CTRL_RX_1 |=0A=
				  EDMA_ERR_LNK_CTRL_RX_3 |=0A=
				  EDMA_ERR_LNK_CTRL_TX,=0A=
=0A=
	EDMA_EH_FREEZE		=3D EDMA_ERR_D_PAR |=0A=
				  EDMA_ERR_PRD_PAR |=0A=
				  EDMA_ERR_DEV_DCON |=0A=
				  EDMA_ERR_DEV_CON |=0A=
				  EDMA_ERR_SERR |=0A=
				  EDMA_ERR_SELF_DIS |=0A=
				  EDMA_ERR_CRQB_PAR |=0A=
				  EDMA_ERR_CRPB_PAR |=0A=
				  EDMA_ERR_INTRL_PAR |=0A=
				  EDMA_ERR_IORDY |=0A=
				  EDMA_ERR_LNK_CTRL_RX_2 |=0A=
				  EDMA_ERR_LNK_DATA_RX |=0A=
				  EDMA_ERR_LNK_DATA_TX |=0A=
				  EDMA_ERR_TRANS_PROTO,=0A=
=0A=
	EDMA_EH_FREEZE_5	=3D EDMA_ERR_D_PAR |=0A=
				  EDMA_ERR_PRD_PAR |=0A=
				  EDMA_ERR_DEV_DCON |=0A=
				  EDMA_ERR_DEV_CON |=0A=
				  EDMA_ERR_OVERRUN_5 |=0A=
				  EDMA_ERR_UNDERRUN_5 |=0A=
				  EDMA_ERR_SELF_DIS_5 |=0A=
				  EDMA_ERR_CRQB_PAR |=0A=
				  EDMA_ERR_CRPB_PAR |=0A=
				  EDMA_ERR_INTRL_PAR |=0A=
				  EDMA_ERR_IORDY,=0A=
=0A=
	EDMA_REQ_Q_BASE_HI_OFS	=3D 0x10,=0A=
	EDMA_REQ_Q_IN_PTR_OFS	=3D 0x14,		/* also contains BASE_LO */=0A=
=0A=
	EDMA_REQ_Q_OUT_PTR_OFS	=3D 0x18,=0A=
	EDMA_REQ_Q_PTR_SHIFT	=3D 5,=0A=
=0A=
	EDMA_RSP_Q_BASE_HI_OFS	=3D 0x1c,=0A=
	EDMA_RSP_Q_IN_PTR_OFS	=3D 0x20,=0A=
	EDMA_RSP_Q_OUT_PTR_OFS	=3D 0x24,		/* also contains BASE_LO */=0A=
	EDMA_RSP_Q_PTR_SHIFT	=3D 3,=0A=
=0A=
	EDMA_CMD_OFS		=3D 0x28,		/* EDMA command register */=0A=
	EDMA_EN			=3D (1 << 0),	/* enable EDMA */=0A=
	EDMA_DS			=3D (1 << 1),	/* disable EDMA; self-negated */=0A=
	EDMA_RESET		=3D (1 << 2),	/* reset eng/trans/link/phy */=0A=
=0A=
	EDMA_STATUS_OFS		=3D 0x30,		/* EDMA engine status */=0A=
	EDMA_STATUS_CACHE_EMPTY	=3D (1 << 6),	/* GenIIe command cache empty */=0A=
	EDMA_STATUS_IDLE	=3D (1 << 7),	/* GenIIe EDMA enabled/idle */=0A=
=0A=
	EDMA_IORDY_TMOUT_OFS	=3D 0x34,=0A=
	EDMA_ARB_CFG_OFS	=3D 0x38,=0A=
=0A=
	EDMA_HALTCOND_OFS	=3D 0x60,		/* GenIIe halt conditions */=0A=
=0A=
	GEN_II_NCQ_MAX_SECTORS	=3D 256,		/* max sects/io on Gen2 w/NCQ */=0A=
=0A=
	/* Host private flags (hp_flags) */=0A=
	MV_HP_FLAG_MSI		=3D (1 << 0),=0A=
	MV_HP_ERRATA_50XXB0	=3D (1 << 1),=0A=
	MV_HP_ERRATA_50XXB2	=3D (1 << 2),=0A=
	MV_HP_ERRATA_60X1B2	=3D (1 << 3),=0A=
	MV_HP_ERRATA_60X1C0	=3D (1 << 4),=0A=
	MV_HP_GEN_I		=3D (1 << 6),	/* Generation I: 50xx */=0A=
	MV_HP_GEN_II		=3D (1 << 7),	/* Generation II: 60xx */=0A=
	MV_HP_GEN_IIE		=3D (1 << 8),	/* Generation IIE: 6042/7042 */=0A=
	MV_HP_PCIE		=3D (1 << 9),	/* PCIe bus/regs: 7042 */=0A=
	MV_HP_CUT_THROUGH	=3D (1 << 10),	/* can use EDMA cut-through */=0A=
	MV_HP_FLAG_SOC		=3D (1 << 11),	/* SystemOnChip, no PCI */=0A=
=0A=
	/* Port private flags (pp_flags) */=0A=
	MV_PP_FLAG_EDMA_EN	=3D (1 << 0),	/* is EDMA engine enabled? */=0A=
	MV_PP_FLAG_NCQ_EN	=3D (1 << 1),	/* is EDMA set up for NCQ? */=0A=
	MV_PP_FLAG_FBS_EN	=3D (1 << 2),	/* is EDMA set up for FBS? */=0A=
	MV_PP_FLAG_DELAYED_EH	=3D (1 << 3),	/* delayed dev err handling */=0A=
};=0A=
=0A=
#define IS_GEN_I(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_I)=0A=
#define IS_GEN_II(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_II)=0A=
#define IS_GEN_IIE(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_IIE)=0A=
#define IS_PCIE(hpriv) ((hpriv)->hp_flags & MV_HP_PCIE)=0A=
#define IS_SOC(hpriv) ((hpriv)->hp_flags & MV_HP_FLAG_SOC)=0A=
=0A=
#define WINDOW_CTRL(i)		(0x20030 + ((i) << 4))=0A=
#define WINDOW_BASE(i)		(0x20034 + ((i) << 4))=0A=
=0A=
enum {=0A=
	/* DMA boundary 0xffff is required by the s/g splitting=0A=
	 * we need on /length/ in mv_fill-sg().=0A=
	 */=0A=
	MV_DMA_BOUNDARY		=3D 0xffffU,=0A=
=0A=
	/* mask of register bits containing lower 32 bits=0A=
	 * of EDMA request queue DMA address=0A=
	 */=0A=
	EDMA_REQ_Q_BASE_LO_MASK	=3D 0xfffffc00U,=0A=
=0A=
	/* ditto, for response queue */=0A=
	EDMA_RSP_Q_BASE_LO_MASK	=3D 0xffffff00U,=0A=
};=0A=
=0A=
enum chip_type {=0A=
	chip_504x,=0A=
	chip_508x,=0A=
	chip_5080,=0A=
	chip_604x,=0A=
	chip_608x,=0A=
	chip_6042,=0A=
	chip_7042,=0A=
	chip_soc,=0A=
};=0A=
=0A=
/* Command ReQuest Block: 32B */=0A=
struct mv_crqb {=0A=
	__le32			sg_addr;=0A=
	__le32			sg_addr_hi;=0A=
	__le16			ctrl_flags;=0A=
	__le16			ata_cmd[11];=0A=
};=0A=
=0A=
struct mv_crqb_iie {=0A=
	__le32			addr;=0A=
	__le32			addr_hi;=0A=
	__le32			flags;=0A=
	__le32			len;=0A=
	__le32			ata_cmd[4];=0A=
};=0A=
=0A=
/* Command ResPonse Block: 8B */=0A=
struct mv_crpb {=0A=
	__le16			id;=0A=
	__le16			flags;=0A=
	__le32			tmstmp;=0A=
};=0A=
=0A=
/* EDMA Physical Region Descriptor (ePRD); A.K.A. SG */=0A=
struct mv_sg {=0A=
	__le32			addr;=0A=
	__le32			flags_size;=0A=
	__le32			addr_hi;=0A=
	__le32			reserved;=0A=
};=0A=
=0A=
struct mv_port_priv {=0A=
	struct mv_crqb		*crqb;=0A=
	dma_addr_t		crqb_dma;=0A=
	struct mv_crpb		*crpb;=0A=
	dma_addr_t		crpb_dma;=0A=
	struct mv_sg		*sg_tbl[MV_MAX_Q_DEPTH];=0A=
	dma_addr_t		sg_tbl_dma[MV_MAX_Q_DEPTH];=0A=
=0A=
	unsigned int		req_idx;=0A=
	unsigned int		resp_idx;=0A=
=0A=
	u32			pp_flags;=0A=
	unsigned int		delayed_eh_pmp_map;=0A=
};=0A=
=0A=
struct mv_port_signal {=0A=
	u32			amps;=0A=
	u32			pre;=0A=
};=0A=
=0A=
struct mv_host_priv {=0A=
	u32			hp_flags;=0A=
	u32			main_irq_mask;=0A=
	struct mv_port_signal	signal[8];=0A=
	const struct mv_hw_ops	*ops;=0A=
	int			n_ports;=0A=
	void __iomem		*base;=0A=
	void __iomem		*main_irq_cause_addr;=0A=
	void __iomem		*main_irq_mask_addr;=0A=
	u32			irq_cause_ofs;=0A=
	u32			irq_mask_ofs;=0A=
	u32			unmask_all_irqs;=0A=
	/*=0A=
	 * These consistent DMA memory pools give us guaranteed=0A=
	 * alignment for hardware-accessed data structures,=0A=
	 * and less memory waste in accomplishing the alignment.=0A=
	 */=0A=
	struct dma_pool		*crqb_pool;=0A=
	struct dma_pool		*crpb_pool;=0A=
	struct dma_pool		*sg_tbl_pool;=0A=
};=0A=
=0A=
struct mv_hw_ops {=0A=
	void (*phy_errata)(struct mv_host_priv *hpriv, void __iomem *mmio,=0A=
			   unsigned int port);=0A=
	void (*enable_leds)(struct mv_host_priv *hpriv, void __iomem *mmio);=0A=
	void (*read_preamp)(struct mv_host_priv *hpriv, int idx,=0A=
			   void __iomem *mmio);=0A=
	int (*reset_hc)(struct mv_host_priv *hpriv, void __iomem *mmio,=0A=
			unsigned int n_hc);=0A=
	void (*reset_flash)(struct mv_host_priv *hpriv, void __iomem *mmio);=0A=
	void (*reset_bus)(struct ata_host *host, void __iomem *mmio);=0A=
};=0A=
=0A=
static int mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 =
*val);=0A=
static int mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 =
val);=0A=
static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 =
*val);=0A=
static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, =
u32 val);=0A=
static int mv_port_start(struct ata_port *ap);=0A=
static void mv_port_stop(struct ata_port *ap);=0A=
static int mv_qc_defer(struct ata_queued_cmd *qc);=0A=
static void mv_qc_prep(struct ata_queued_cmd *qc);=0A=
static void mv_qc_prep_iie(struct ata_queued_cmd *qc);=0A=
static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);=0A=
static int mv_hardreset(struct ata_link *link, unsigned int *class,=0A=
			unsigned long deadline);=0A=
static void mv_eh_freeze(struct ata_port *ap);=0A=
static void mv_eh_thaw(struct ata_port *ap);=0A=
static void mv6_dev_config(struct ata_device *dev);=0A=
=0A=
static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem =
*mmio,=0A=
			   unsigned int port);=0A=
static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem =
*mmio);=0A=
static void mv5_read_preamp(struct mv_host_priv *hpriv, int idx,=0A=
			   void __iomem *mmio);=0A=
static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,=0A=
			unsigned int n_hc);=0A=
static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem =
*mmio);=0A=
static void mv5_reset_bus(struct ata_host *host, void __iomem *mmio);=0A=
=0A=
static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem =
*mmio,=0A=
			   unsigned int port);=0A=
static void mv6_enable_leds(struct mv_host_priv *hpriv, void __iomem =
*mmio);=0A=
static void mv6_read_preamp(struct mv_host_priv *hpriv, int idx,=0A=
			   void __iomem *mmio);=0A=
static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,=0A=
			unsigned int n_hc);=0A=
static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem =
*mmio);=0A=
static void mv_soc_enable_leds(struct mv_host_priv *hpriv,=0A=
				      void __iomem *mmio);=0A=
static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,=0A=
				      void __iomem *mmio);=0A=
static int mv_soc_reset_hc(struct mv_host_priv *hpriv,=0A=
				  void __iomem *mmio, unsigned int n_hc);=0A=
static void mv_soc_reset_flash(struct mv_host_priv *hpriv,=0A=
				      void __iomem *mmio);=0A=
static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio);=0A=
static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio);=0A=
static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem =
*mmio,=0A=
			     unsigned int port_no);=0A=
static int mv_stop_edma(struct ata_port *ap);=0A=
static int mv_stop_edma_engine(void __iomem *port_mmio);=0A=
static void mv_edma_cfg(struct ata_port *ap, int want_ncq);=0A=
=0A=
static void mv_pmp_select(struct ata_port *ap, int pmp);=0A=
static int mv_pmp_hardreset(struct ata_link *link, unsigned int *class,=0A=
				unsigned long deadline);=0A=
static int  mv_softreset(struct ata_link *link, unsigned int *class,=0A=
				unsigned long deadline);=0A=
static void mv_pmp_error_handler(struct ata_port *ap);=0A=
static void mv_process_crpb_entries(struct ata_port *ap,=0A=
					struct mv_port_priv *pp);=0A=
=0A=
/* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below=0A=
 * because we have to allow room for worst case splitting of=0A=
 * PRDs for 64K boundaries in mv_fill_sg().=0A=
 */=0A=
static struct scsi_host_template mv5_sht =3D {=0A=
	ATA_BASE_SHT(DRV_NAME),=0A=
	.sg_tablesize		=3D MV_MAX_SG_CT / 2,=0A=
	.dma_boundary		=3D MV_DMA_BOUNDARY,=0A=
};=0A=
=0A=
static struct scsi_host_template mv6_sht =3D {=0A=
	ATA_NCQ_SHT(DRV_NAME),=0A=
	.can_queue		=3D MV_MAX_Q_DEPTH - 1,=0A=
	.sg_tablesize		=3D MV_MAX_SG_CT / 2,=0A=
	.dma_boundary		=3D MV_DMA_BOUNDARY,=0A=
};=0A=
=0A=
static struct ata_port_operations mv5_ops =3D {=0A=
	.inherits		=3D &ata_sff_port_ops,=0A=
=0A=
	.qc_defer		=3D mv_qc_defer,=0A=
	.qc_prep		=3D mv_qc_prep,=0A=
	.qc_issue		=3D mv_qc_issue,=0A=
=0A=
	.freeze			=3D mv_eh_freeze,=0A=
	.thaw			=3D mv_eh_thaw,=0A=
	.hardreset		=3D mv_hardreset,=0A=
	.error_handler		=3D ata_std_error_handler, /* avoid SFF EH */=0A=
	.post_internal_cmd	=3D ATA_OP_NULL,=0A=
=0A=
	.scr_read		=3D mv5_scr_read,=0A=
	.scr_write		=3D mv5_scr_write,=0A=
=0A=
	.port_start		=3D mv_port_start,=0A=
	.port_stop		=3D mv_port_stop,=0A=
};=0A=
=0A=
static struct ata_port_operations mv6_ops =3D {=0A=
	.inherits		=3D &mv5_ops,=0A=
	.dev_config             =3D mv6_dev_config,=0A=
	.scr_read		=3D mv_scr_read,=0A=
	.scr_write		=3D mv_scr_write,=0A=
=0A=
	.pmp_hardreset		=3D mv_pmp_hardreset,=0A=
	.pmp_softreset		=3D mv_softreset,=0A=
	.softreset		=3D mv_softreset,=0A=
	.error_handler		=3D mv_pmp_error_handler,=0A=
};=0A=
=0A=
static struct ata_port_operations mv_iie_ops =3D {=0A=
	.inherits		=3D &mv6_ops,=0A=
	.dev_config		=3D ATA_OP_NULL,=0A=
	.qc_prep		=3D mv_qc_prep_iie,=0A=
};=0A=
=0A=
static const struct ata_port_info mv_port_info[] =3D {=0A=
	{  /* chip_504x */=0A=
		.flags		=3D MV_COMMON_FLAGS,=0A=
		.pio_mask	=3D 0x1f,	/* pio0-4 */=0A=
		.udma_mask	=3D ATA_UDMA6,=0A=
		.port_ops	=3D &mv5_ops,=0A=
	},=0A=
	{  /* chip_508x */=0A=
		.flags		=3D MV_COMMON_FLAGS | MV_FLAG_DUAL_HC,=0A=
		.pio_mask	=3D 0x1f,	/* pio0-4 */=0A=
		.udma_mask	=3D ATA_UDMA6,=0A=
		.port_ops	=3D &mv5_ops,=0A=
	},=0A=
	{  /* chip_5080 */=0A=
		.flags		=3D MV_COMMON_FLAGS | MV_FLAG_DUAL_HC,=0A=
		.pio_mask	=3D 0x1f,	/* pio0-4 */=0A=
		.udma_mask	=3D ATA_UDMA6,=0A=
		.port_ops	=3D &mv5_ops,=0A=
	},=0A=
	{  /* chip_604x */=0A=
		.flags		=3D MV_COMMON_FLAGS | MV_6XXX_FLAGS |=0A=
				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |=0A=
				  ATA_FLAG_NCQ,=0A=
		.pio_mask	=3D 0x1f,	/* pio0-4 */=0A=
		.udma_mask	=3D ATA_UDMA6,=0A=
		.port_ops	=3D &mv6_ops,=0A=
	},=0A=
	{  /* chip_608x */=0A=
		.flags		=3D MV_COMMON_FLAGS | MV_6XXX_FLAGS |=0A=
				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |=0A=
				  ATA_FLAG_NCQ | MV_FLAG_DUAL_HC,=0A=
		.pio_mask	=3D 0x1f,	/* pio0-4 */=0A=
		.udma_mask	=3D ATA_UDMA6,=0A=
		.port_ops	=3D &mv6_ops,=0A=
	},=0A=
	{  /* chip_6042 */=0A=
		.flags		=3D MV_GENIIE_FLAGS,=0A=
		.pio_mask	=3D 0x1f,	/* pio0-4 */=0A=
		.udma_mask	=3D ATA_UDMA6,=0A=
		.port_ops	=3D &mv_iie_ops,=0A=
	},=0A=
	{  /* chip_7042 */=0A=
		.flags		=3D MV_GENIIE_FLAGS,=0A=
		.pio_mask	=3D 0x1f,	/* pio0-4 */=0A=
		.udma_mask	=3D ATA_UDMA6,=0A=
		.port_ops	=3D &mv_iie_ops,=0A=
	},=0A=
	{  /* chip_soc */=0A=
		.flags		=3D MV_GENIIE_FLAGS,=0A=
		.pio_mask	=3D 0x1f,	/* pio0-4 */=0A=
		.udma_mask	=3D ATA_UDMA6,=0A=
		.port_ops	=3D &mv_iie_ops,=0A=
	},=0A=
};=0A=
=0A=
static const struct pci_device_id mv_pci_tbl[] =3D {=0A=
	{ PCI_VDEVICE(MARVELL, 0x5040), chip_504x },=0A=
	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },=0A=
	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },=0A=
	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },=0A=
	/* RocketRAID 1740/174x have different identifiers */=0A=
=0A=
	/* { PCI_VDEVICE(TTI, 0x1740), chip_508x }, */=0A=
        /* Pozicom:  GenII 1740 cards use 88sx6042 chip */=0A=
=0A=
	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },=0A=
	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },=0A=
=0A=
	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },=0A=
	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },=0A=
	{ PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },=0A=
	{ PCI_VDEVICE(MARVELL, 0x6080), chip_608x },=0A=
	{ PCI_VDEVICE(MARVELL, 0x6081), chip_608x },=0A=
=0A=
	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },=0A=
=0A=
	/* Adaptec 1430SA */=0A=
	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },=0A=
=0A=
	/* Marvell 7042 support */=0A=
	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },=0A=
=0A=
	/* Highpoint RocketRAID PCIe series */=0A=
	{ PCI_VDEVICE(TTI, 0x2300), chip_7042 },=0A=
	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },=0A=
=0A=
	{ }			/* terminate list */=0A=
};=0A=
=0A=
static const struct mv_hw_ops mv5xxx_ops =3D {=0A=
	.phy_errata		=3D mv5_phy_errata,=0A=
	.enable_leds		=3D mv5_enable_leds,=0A=
	.read_preamp		=3D mv5_read_preamp,=0A=
	.reset_hc		=3D mv5_reset_hc,=0A=
	.reset_flash		=3D mv5_reset_flash,=0A=
	.reset_bus		=3D mv5_reset_bus,=0A=
};=0A=
=0A=
static const struct mv_hw_ops mv6xxx_ops =3D {=0A=
	.phy_errata		=3D mv6_phy_errata,=0A=
	.enable_leds		=3D mv6_enable_leds,=0A=
	.read_preamp		=3D mv6_read_preamp,=0A=
	.reset_hc		=3D mv6_reset_hc,=0A=
	.reset_flash		=3D mv6_reset_flash,=0A=
	.reset_bus		=3D mv_reset_pci_bus,=0A=
};=0A=
=0A=
static const struct mv_hw_ops mv_soc_ops =3D {=0A=
	.phy_errata		=3D mv6_phy_errata,=0A=
	.enable_leds		=3D mv_soc_enable_leds,=0A=
	.read_preamp		=3D mv_soc_read_preamp,=0A=
	.reset_hc		=3D mv_soc_reset_hc,=0A=
	.reset_flash		=3D mv_soc_reset_flash,=0A=
	.reset_bus		=3D mv_soc_reset_bus,=0A=
};=0A=
=0A=
/*=0A=
 * Functions=0A=
 */=0A=
=0A=
static inline void writelfl(unsigned long data, void __iomem *addr)=0A=
{=0A=
	writel(data, addr);=0A=
	(void) readl(addr);	/* flush to avoid PCI posted write */=0A=
}=0A=
=0A=
static inline unsigned int mv_hc_from_port(unsigned int port)=0A=
{=0A=
	return port >> MV_PORT_HC_SHIFT;=0A=
}=0A=
=0A=
static inline unsigned int mv_hardport_from_port(unsigned int port)=0A=
{=0A=
	return port & MV_PORT_MASK;=0A=
}=0A=
=0A=
/*=0A=
 * Consolidate some rather tricky bit shift calculations.=0A=
 * This is hot-path stuff, so not a function.=0A=
 * Simple code, with two return values, so macro rather than inline.=0A=
 *=0A=
 * port is the sole input, in range 0..7.=0A=
 * shift is one output, for use with main_irq_cause / main_irq_mask =
registers.=0A=
 * hardport is the other output, in range 0..3.=0A=
 *=0A=
 * Note that port and hardport may be the same variable in some cases.=0A=
 */=0A=
#define MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport)	\=0A=
{								\=0A=
	shift    =3D mv_hc_from_port(port) * HC_SHIFT;		\=0A=
	hardport =3D mv_hardport_from_port(port);			\=0A=
	shift   +=3D hardport * 2;				\=0A=
}=0A=
=0A=
static inline void __iomem *mv_hc_base(void __iomem *base, unsigned int =
hc)=0A=
{=0A=
	return (base + MV_SATAHC0_REG_BASE + (hc * MV_SATAHC_REG_SZ));=0A=
}=0A=
=0A=
static inline void __iomem *mv_hc_base_from_port(void __iomem *base,=0A=
						 unsigned int port)=0A=
{=0A=
	return mv_hc_base(base, mv_hc_from_port(port));=0A=
}=0A=
=0A=
static inline void __iomem *mv_port_base(void __iomem *base, unsigned =
int port)=0A=
{=0A=
	return  mv_hc_base_from_port(base, port) +=0A=
		MV_SATAHC_ARBTR_REG_SZ +=0A=
		(mv_hardport_from_port(port) * MV_PORT_REG_SZ);=0A=
}=0A=
=0A=
static void __iomem *mv5_phy_base(void __iomem *mmio, unsigned int port)=0A=
{=0A=
	void __iomem *hc_mmio =3D mv_hc_base_from_port(mmio, port);=0A=
	unsigned long ofs =3D (mv_hardport_from_port(port) + 1) * 0x100UL;=0A=
=0A=
	return hc_mmio + ofs;=0A=
}=0A=
=0A=
static inline void __iomem *mv_host_base(struct ata_host *host)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	return hpriv->base;=0A=
}=0A=
=0A=
static inline void __iomem *mv_ap_base(struct ata_port *ap)=0A=
{=0A=
	return mv_port_base(mv_host_base(ap->host), ap->port_no);=0A=
}=0A=
=0A=
static inline int mv_get_hc_count(unsigned long port_flags)=0A=
{=0A=
	return ((port_flags & MV_FLAG_DUAL_HC) ? 2 : 1);=0A=
}=0A=
=0A=
static void mv_set_edma_ptrs(void __iomem *port_mmio,=0A=
			     struct mv_host_priv *hpriv,=0A=
			     struct mv_port_priv *pp)=0A=
{=0A=
	u32 index;=0A=
=0A=
	/*=0A=
	 * initialize request queue=0A=
	 */=0A=
	pp->req_idx &=3D MV_MAX_Q_DEPTH_MASK;	/* paranoia */=0A=
	index =3D pp->req_idx << EDMA_REQ_Q_PTR_SHIFT;=0A=
=0A=
	WARN_ON(pp->crqb_dma & 0x3ff);=0A=
	writel((pp->crqb_dma >> 16) >> 16, port_mmio + EDMA_REQ_Q_BASE_HI_OFS);=0A=
	writelfl((pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK) | index,=0A=
		 port_mmio + EDMA_REQ_Q_IN_PTR_OFS);=0A=
	writelfl(index, port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);=0A=
=0A=
	/*=0A=
	 * initialize response queue=0A=
	 */=0A=
	pp->resp_idx &=3D MV_MAX_Q_DEPTH_MASK;	/* paranoia */=0A=
	index =3D pp->resp_idx << EDMA_RSP_Q_PTR_SHIFT;=0A=
=0A=
	WARN_ON(pp->crpb_dma & 0xff);=0A=
	writel((pp->crpb_dma >> 16) >> 16, port_mmio + EDMA_RSP_Q_BASE_HI_OFS);=0A=
	writelfl(index, port_mmio + EDMA_RSP_Q_IN_PTR_OFS);=0A=
	writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) | index,=0A=
		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);=0A=
}=0A=
=0A=
static void mv_set_main_irq_mask(struct ata_host *host,=0A=
				 u32 disable_bits, u32 enable_bits)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	u32 old_mask, new_mask;=0A=
=0A=
	old_mask =3D hpriv->main_irq_mask;=0A=
	new_mask =3D (old_mask & ~disable_bits) | enable_bits;=0A=
	if (new_mask !=3D old_mask) {=0A=
		hpriv->main_irq_mask =3D new_mask;=0A=
		writelfl(new_mask, hpriv->main_irq_mask_addr);=0A=
	}=0A=
}=0A=
=0A=
static void mv_enable_port_irqs(struct ata_port *ap,=0A=
				     unsigned int port_bits)=0A=
{=0A=
	unsigned int shift, hardport, port =3D ap->port_no;=0A=
	u32 disable_bits, enable_bits;=0A=
=0A=
	MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);=0A=
=0A=
	disable_bits =3D (DONE_IRQ | ERR_IRQ) << shift;=0A=
	enable_bits  =3D port_bits << shift;=0A=
	mv_set_main_irq_mask(ap->host, disable_bits, enable_bits);=0A=
}=0A=
=0A=
/**=0A=
 *      mv_start_dma - Enable eDMA engine=0A=
 *      @base: port base address=0A=
 *      @pp: port private data=0A=
 *=0A=
 *      Verify the local cache of the eDMA state is accurate with a=0A=
 *      WARN_ON.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static void mv_start_dma(struct ata_port *ap, void __iomem *port_mmio,=0A=
			 struct mv_port_priv *pp, u8 protocol)=0A=
{=0A=
	int want_ncq =3D (protocol =3D=3D ATA_PROT_NCQ);=0A=
=0A=
	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {=0A=
		int using_ncq =3D ((pp->pp_flags & MV_PP_FLAG_NCQ_EN) !=3D 0);=0A=
		if (want_ncq !=3D using_ncq)=0A=
			mv_stop_edma(ap);=0A=
	}=0A=
	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {=0A=
		struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
		int hardport =3D mv_hardport_from_port(ap->port_no);=0A=
		void __iomem *hc_mmio =3D mv_hc_base_from_port(=0A=
					mv_host_base(ap->host), hardport);=0A=
		u32 hc_irq_cause, ipending;=0A=
=0A=
		/* clear EDMA event indicators, if any */=0A=
		writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);=0A=
=0A=
		/* clear EDMA interrupt indicator, if any */=0A=
		hc_irq_cause =3D readl(hc_mmio + HC_IRQ_CAUSE_OFS);=0A=
		ipending =3D (DEV_IRQ | DMA_IRQ) << hardport;=0A=
		if (hc_irq_cause & ipending) {=0A=
			writelfl(hc_irq_cause & ~ipending,=0A=
				 hc_mmio + HC_IRQ_CAUSE_OFS);=0A=
		}=0A=
=0A=
		mv_edma_cfg(ap, want_ncq);=0A=
=0A=
		/* clear FIS IRQ Cause */=0A=
		if (IS_GEN_IIE(hpriv))=0A=
			writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);=0A=
=0A=
		mv_set_edma_ptrs(port_mmio, hpriv, pp);=0A=
		mv_enable_port_irqs(ap, DONE_IRQ|ERR_IRQ);=0A=
=0A=
		writelfl(EDMA_EN, port_mmio + EDMA_CMD_OFS);=0A=
		pp->pp_flags |=3D MV_PP_FLAG_EDMA_EN;=0A=
	}=0A=
}=0A=
=0A=
static void mv_wait_for_edma_empty_idle(struct ata_port *ap)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_ap_base(ap);=0A=
	const u32 empty_idle =3D (EDMA_STATUS_CACHE_EMPTY | EDMA_STATUS_IDLE);=0A=
	const int per_loop =3D 5, timeout =3D (15 * 1000 / per_loop);=0A=
	int i;=0A=
=0A=
	/*=0A=
	 * Wait for the EDMA engine to finish transactions in progress.=0A=
	 * No idea what a good "timeout" value might be, but measurements=0A=
	 * indicate that it often requires hundreds of microseconds=0A=
	 * with two drives in-use.  So we use the 15msec value above=0A=
	 * as a rough guess at what even more drives might require.=0A=
	 */=0A=
	for (i =3D 0; i < timeout; ++i) {=0A=
		u32 edma_stat =3D readl(port_mmio + EDMA_STATUS_OFS);=0A=
		if ((edma_stat & empty_idle) =3D=3D empty_idle)=0A=
			break;=0A=
		udelay(per_loop);=0A=
	}=0A=
	/* ata_port_printk(ap, KERN_INFO, "%s: %u+ usecs\n", __func__, i); */=0A=
}=0A=
=0A=
/**=0A=
 *      mv_stop_edma_engine - Disable eDMA engine=0A=
 *      @port_mmio: io base address=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static int mv_stop_edma_engine(void __iomem *port_mmio)=0A=
{=0A=
	int i;=0A=
=0A=
	/* Disable eDMA.  The disable bit auto clears. */=0A=
	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);=0A=
=0A=
	/* Wait for the chip to confirm eDMA is off. */=0A=
	for (i =3D 10000; i > 0; i--) {=0A=
		u32 reg =3D readl(port_mmio + EDMA_CMD_OFS);=0A=
		if (!(reg & EDMA_EN))=0A=
			return 0;=0A=
		udelay(10);=0A=
	}=0A=
	return -EIO;=0A=
}=0A=
=0A=
static int mv_stop_edma(struct ata_port *ap)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_ap_base(ap);=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
=0A=
	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN))=0A=
		return 0;=0A=
	pp->pp_flags &=3D ~MV_PP_FLAG_EDMA_EN;=0A=
	mv_wait_for_edma_empty_idle(ap);=0A=
	if (mv_stop_edma_engine(port_mmio)) {=0A=
		ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");=0A=
		return -EIO;=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
#ifdef ATA_DEBUG=0A=
static void mv_dump_mem(void __iomem *start, unsigned bytes)=0A=
{=0A=
	int b, w;=0A=
	for (b =3D 0; b < bytes; ) {=0A=
		DPRINTK("%p: ", start + b);=0A=
		for (w =3D 0; b < bytes && w < 4; w++) {=0A=
			printk("%08x ", readl(start + b));=0A=
			b +=3D sizeof(u32);=0A=
		}=0A=
		printk("\n");=0A=
	}=0A=
}=0A=
#endif=0A=
=0A=
static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)=0A=
{=0A=
#ifdef ATA_DEBUG=0A=
	int b, w;=0A=
	u32 dw;=0A=
	for (b =3D 0; b < bytes; ) {=0A=
		DPRINTK("%02x: ", b);=0A=
		for (w =3D 0; b < bytes && w < 4; w++) {=0A=
			(void) pci_read_config_dword(pdev, b, &dw);=0A=
			printk("%08x ", dw);=0A=
			b +=3D sizeof(u32);=0A=
		}=0A=
		printk("\n");=0A=
	}=0A=
#endif=0A=
}=0A=
static void mv_dump_all_regs(void __iomem *mmio_base, int port,=0A=
			     struct pci_dev *pdev)=0A=
{=0A=
#ifdef ATA_DEBUG=0A=
	void __iomem *hc_base =3D mv_hc_base(mmio_base,=0A=
					   port >> MV_PORT_HC_SHIFT);=0A=
	void __iomem *port_base;=0A=
	int start_port, num_ports, p, start_hc, num_hcs, hc;=0A=
=0A=
	if (0 > port) {=0A=
		start_hc =3D start_port =3D 0;=0A=
		num_ports =3D 8;		/* shld be benign for 4 port devs */=0A=
		num_hcs =3D 2;=0A=
	} else {=0A=
		start_hc =3D port >> MV_PORT_HC_SHIFT;=0A=
		start_port =3D port;=0A=
		num_ports =3D num_hcs =3D 1;=0A=
	}=0A=
	DPRINTK("All registers for port(s) %u-%u:\n", start_port,=0A=
		num_ports > 1 ? num_ports - 1 : start_port);=0A=
=0A=
	if (NULL !=3D pdev) {=0A=
		DPRINTK("PCI config space regs:\n");=0A=
		mv_dump_pci_cfg(pdev, 0x68);=0A=
	}=0A=
	DPRINTK("PCI regs:\n");=0A=
	mv_dump_mem(mmio_base+0xc00, 0x3c);=0A=
	mv_dump_mem(mmio_base+0xd00, 0x34);=0A=
	mv_dump_mem(mmio_base+0xf00, 0x4);=0A=
	mv_dump_mem(mmio_base+0x1d00, 0x6c);=0A=
	for (hc =3D start_hc; hc < start_hc + num_hcs; hc++) {=0A=
		hc_base =3D mv_hc_base(mmio_base, hc);=0A=
		DPRINTK("HC regs (HC %i):\n", hc);=0A=
		mv_dump_mem(hc_base, 0x1c);=0A=
	}=0A=
	for (p =3D start_port; p < start_port + num_ports; p++) {=0A=
		port_base =3D mv_port_base(mmio_base, p);=0A=
		DPRINTK("EDMA regs (port %i):\n", p);=0A=
		mv_dump_mem(port_base, 0x54);=0A=
		DPRINTK("SATA regs (port %i):\n", p);=0A=
		mv_dump_mem(port_base+0x300, 0x60);=0A=
	}=0A=
#endif=0A=
}=0A=
=0A=
static unsigned int mv_scr_offset(unsigned int sc_reg_in)=0A=
{=0A=
	unsigned int ofs;=0A=
=0A=
	switch (sc_reg_in) {=0A=
	case SCR_STATUS:=0A=
	case SCR_CONTROL:=0A=
	case SCR_ERROR:=0A=
		ofs =3D SATA_STATUS_OFS + (sc_reg_in * sizeof(u32));=0A=
		break;=0A=
	case SCR_ACTIVE:=0A=
		ofs =3D SATA_ACTIVE_OFS;   /* active is not with the others */=0A=
		break;=0A=
	default:=0A=
		ofs =3D 0xffffffffU;=0A=
		break;=0A=
	}=0A=
	return ofs;=0A=
}=0A=
=0A=
static int mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 =
*val)=0A=
{=0A=
	unsigned int ofs =3D mv_scr_offset(sc_reg_in);=0A=
=0A=
	if (ofs !=3D 0xffffffffU) {=0A=
		*val =3D readl(mv_ap_base(ap) + ofs);=0A=
		return 0;=0A=
	} else=0A=
		return -EINVAL;=0A=
}=0A=
=0A=
static int mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 =
val)=0A=
{=0A=
	unsigned int ofs =3D mv_scr_offset(sc_reg_in);=0A=
=0A=
	if (ofs !=3D 0xffffffffU) {=0A=
		writelfl(val, mv_ap_base(ap) + ofs);=0A=
		return 0;=0A=
	} else=0A=
		return -EINVAL;=0A=
}=0A=
=0A=
static void mv6_dev_config(struct ata_device *adev)=0A=
{=0A=
	/*=0A=
	 * Deal with Gen-II ("mv6") hardware quirks/restrictions:=0A=
	 *=0A=
	 * Gen-II does not support NCQ over a port multiplier=0A=
	 *  (no FIS-based switching).=0A=
	 *=0A=
	 * We don't have hob_nsect when doing NCQ commands on Gen-II.=0A=
	 * See mv_qc_prep() for more info.=0A=
	 */=0A=
	if (adev->flags & ATA_DFLAG_NCQ) {=0A=
		if (sata_pmp_attached(adev->link->ap)) {=0A=
			adev->flags &=3D ~ATA_DFLAG_NCQ;=0A=
			ata_dev_printk(adev, KERN_INFO,=0A=
				"NCQ disabled for command-based switching\n");=0A=
		} else if (adev->max_sectors > GEN_II_NCQ_MAX_SECTORS) {=0A=
			adev->max_sectors =3D GEN_II_NCQ_MAX_SECTORS;=0A=
			ata_dev_printk(adev, KERN_INFO,=0A=
				"max_sectors limited to %u for NCQ\n",=0A=
				adev->max_sectors);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
static int mv_qc_defer(struct ata_queued_cmd *qc)=0A=
{=0A=
	struct ata_link *link =3D qc->dev->link;=0A=
	struct ata_port *ap =3D link->ap;=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
=0A=
	/*=0A=
	 * Don't allow new commands if we're in a delayed EH state=0A=
	 * for NCQ and/or FIS-based switching.=0A=
	 */=0A=
	if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH)=0A=
		return ATA_DEFER_PORT;=0A=
	/*=0A=
	 * If the port is completely idle, then allow the new qc.=0A=
	 */=0A=
	if (ap->nr_active_links =3D=3D 0)=0A=
		return 0;=0A=
=0A=
	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {=0A=
		/*=0A=
		 * The port is operating in host queuing mode (EDMA).=0A=
		 * It can accomodate a new qc if the qc protocol=0A=
		 * is compatible with the current host queue mode.=0A=
		 */=0A=
		if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {=0A=
			/*=0A=
			 * The host queue (EDMA) is in NCQ mode.=0A=
			 * If the new qc is also an NCQ command,=0A=
			 * then allow the new qc.=0A=
			 */=0A=
			if (qc->tf.protocol =3D=3D ATA_PROT_NCQ)=0A=
				return 0;=0A=
		} else {=0A=
			/*=0A=
			 * The host queue (EDMA) is in non-NCQ, DMA mode.=0A=
			 * If the new qc is also a non-NCQ, DMA command,=0A=
			 * then allow the new qc.=0A=
			 */=0A=
			if (qc->tf.protocol =3D=3D ATA_PROT_DMA)=0A=
				return 0;=0A=
		}=0A=
	}=0A=
	return ATA_DEFER_PORT;=0A=
}=0A=
=0A=
static void mv_config_fbs(void __iomem *port_mmio, int want_ncq, int =
want_fbs)=0A=
{=0A=
	u32 new_fiscfg, old_fiscfg;=0A=
	u32 new_ltmode, old_ltmode;=0A=
	u32 new_haltcond, old_haltcond;=0A=
=0A=
	old_fiscfg   =3D readl(port_mmio + FISCFG_OFS);=0A=
	old_ltmode   =3D readl(port_mmio + LTMODE_OFS);=0A=
	old_haltcond =3D readl(port_mmio + EDMA_HALTCOND_OFS);=0A=
=0A=
	new_fiscfg   =3D old_fiscfg & ~(FISCFG_SINGLE_SYNC | =
FISCFG_WAIT_DEV_ERR);=0A=
	new_ltmode   =3D old_ltmode & ~LTMODE_BIT8;=0A=
	new_haltcond =3D old_haltcond | EDMA_ERR_DEV;=0A=
=0A=
	if (want_fbs) {=0A=
		new_fiscfg =3D old_fiscfg | FISCFG_SINGLE_SYNC;=0A=
		new_ltmode =3D old_ltmode | LTMODE_BIT8;=0A=
		if (want_ncq)=0A=
			new_haltcond &=3D ~EDMA_ERR_DEV;=0A=
		else=0A=
			new_fiscfg |=3D  FISCFG_WAIT_DEV_ERR;=0A=
	}=0A=
=0A=
	if (new_fiscfg !=3D old_fiscfg)=0A=
		writelfl(new_fiscfg, port_mmio + FISCFG_OFS);=0A=
	if (new_ltmode !=3D old_ltmode)=0A=
		writelfl(new_ltmode, port_mmio + LTMODE_OFS);=0A=
	if (new_haltcond !=3D old_haltcond)=0A=
		writelfl(new_haltcond, port_mmio + EDMA_HALTCOND_OFS);=0A=
}=0A=
=0A=
static void mv_60x1_errata_sata25(struct ata_port *ap, int want_ncq)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	u32 old, new;=0A=
=0A=
	/* workaround for 88SX60x1 FEr SATA#25 (part 1) */=0A=
	old =3D readl(hpriv->base + MV_GPIO_PORT_CTL_OFS);=0A=
	if (want_ncq)=0A=
		new =3D old | (1 << 22);=0A=
	else=0A=
		new =3D old & ~(1 << 22);=0A=
	if (new !=3D old)=0A=
		writel(new, hpriv->base + MV_GPIO_PORT_CTL_OFS);=0A=
}=0A=
=0A=
static void mv_edma_cfg(struct ata_port *ap, int want_ncq)=0A=
{=0A=
	u32 cfg;=0A=
	struct mv_port_priv *pp    =3D ap->private_data;=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	void __iomem *port_mmio    =3D mv_ap_base(ap);=0A=
=0A=
	/* set up non-NCQ EDMA configuration */=0A=
	cfg =3D EDMA_CFG_Q_DEPTH;		/* always 0x1f for *all* chips */=0A=
	pp->pp_flags &=3D ~MV_PP_FLAG_FBS_EN;=0A=
=0A=
	if (IS_GEN_I(hpriv))=0A=
		cfg |=3D (1 << 8);	/* enab config burst size mask */=0A=
=0A=
	else if (IS_GEN_II(hpriv)) {=0A=
		cfg |=3D EDMA_CFG_RD_BRST_EXT | EDMA_CFG_WR_BUFF_LEN;=0A=
		mv_60x1_errata_sata25(ap, want_ncq);=0A=
=0A=
	} else if (IS_GEN_IIE(hpriv)) {=0A=
		int want_fbs =3D sata_pmp_attached(ap);=0A=
		/*=0A=
		 * Possible future enhancement:=0A=
		 *=0A=
		 * The chip can use FBS with non-NCQ, if we allow it,=0A=
		 * But first we need to have the error handling in place=0A=
		 * for this mode (datasheet section 7.3.15.4.2.3).=0A=
		 * So disallow non-NCQ FBS for now.=0A=
		 */=0A=
		want_fbs &=3D want_ncq;=0A=
=0A=
		mv_config_fbs(port_mmio, want_ncq, want_fbs);=0A=
=0A=
		if (want_fbs) {=0A=
			pp->pp_flags |=3D MV_PP_FLAG_FBS_EN;=0A=
			cfg |=3D EDMA_CFG_EDMA_FBS; /* FIS-based switching */=0A=
		}=0A=
=0A=
		cfg |=3D (1 << 23);	/* do not mask PM field in rx'd FIS */=0A=
		cfg |=3D (1 << 22);	/* enab 4-entry host queue cache */=0A=
		if (!IS_SOC(hpriv))=0A=
			cfg |=3D (1 << 18);	/* enab early completion */=0A=
		if (hpriv->hp_flags & MV_HP_CUT_THROUGH)=0A=
			cfg |=3D (1 << 17); /* enab cut-thru (dis stor&forwrd) */=0A=
	}=0A=
=0A=
	if (want_ncq) {=0A=
		cfg |=3D EDMA_CFG_NCQ;=0A=
		pp->pp_flags |=3D  MV_PP_FLAG_NCQ_EN;=0A=
	} else=0A=
		pp->pp_flags &=3D ~MV_PP_FLAG_NCQ_EN;=0A=
=0A=
	writelfl(cfg, port_mmio + EDMA_CFG_OFS);=0A=
}=0A=
=0A=
static void mv_port_free_dma_mem(struct ata_port *ap)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
	int tag;=0A=
=0A=
	if (pp->crqb) {=0A=
		dma_pool_free(hpriv->crqb_pool, pp->crqb, pp->crqb_dma);=0A=
		pp->crqb =3D NULL;=0A=
	}=0A=
	if (pp->crpb) {=0A=
		dma_pool_free(hpriv->crpb_pool, pp->crpb, pp->crpb_dma);=0A=
		pp->crpb =3D NULL;=0A=
	}=0A=
	/*=0A=
	 * For GEN_I, there's no NCQ, so we have only a single sg_tbl.=0A=
	 * For later hardware, we have one unique sg_tbl per NCQ tag.=0A=
	 */=0A=
	for (tag =3D 0; tag < MV_MAX_Q_DEPTH; ++tag) {=0A=
		if (pp->sg_tbl[tag]) {=0A=
			if (tag =3D=3D 0 || !IS_GEN_I(hpriv))=0A=
				dma_pool_free(hpriv->sg_tbl_pool,=0A=
					      pp->sg_tbl[tag],=0A=
					      pp->sg_tbl_dma[tag]);=0A=
			pp->sg_tbl[tag] =3D NULL;=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
/**=0A=
 *      mv_port_start - Port specific init/start routine.=0A=
 *      @ap: ATA channel to manipulate=0A=
 *=0A=
 *      Allocate and point to DMA memory, init port private memory,=0A=
 *      zero indices.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static int mv_port_start(struct ata_port *ap)=0A=
{=0A=
	struct device *dev =3D ap->host->dev;=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	struct mv_port_priv *pp;=0A=
	int tag;=0A=
=0A=
	pp =3D devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);=0A=
	if (!pp)=0A=
		return -ENOMEM;=0A=
	ap->private_data =3D pp;=0A=
=0A=
	pp->crqb =3D dma_pool_alloc(hpriv->crqb_pool, GFP_KERNEL, =
&pp->crqb_dma);=0A=
	if (!pp->crqb)=0A=
		return -ENOMEM;=0A=
	memset(pp->crqb, 0, MV_CRQB_Q_SZ);=0A=
=0A=
	pp->crpb =3D dma_pool_alloc(hpriv->crpb_pool, GFP_KERNEL, =
&pp->crpb_dma);=0A=
	if (!pp->crpb)=0A=
		goto out_port_free_dma_mem;=0A=
	memset(pp->crpb, 0, MV_CRPB_Q_SZ);=0A=
=0A=
	/* 6041/6081 Rev. "C0" (and newer) are okay with async notify */=0A=
	if (hpriv->hp_flags & MV_HP_ERRATA_60X1C0)=0A=
		ap->flags |=3D ATA_FLAG_AN;=0A=
	/*=0A=
	 * For GEN_I, there's no NCQ, so we only allocate a single sg_tbl.=0A=
	 * For later hardware, we need one unique sg_tbl per NCQ tag.=0A=
	 */=0A=
	for (tag =3D 0; tag < MV_MAX_Q_DEPTH; ++tag) {=0A=
		if (tag =3D=3D 0 || !IS_GEN_I(hpriv)) {=0A=
			pp->sg_tbl[tag] =3D dma_pool_alloc(hpriv->sg_tbl_pool,=0A=
					      GFP_KERNEL, &pp->sg_tbl_dma[tag]);=0A=
			if (!pp->sg_tbl[tag])=0A=
				goto out_port_free_dma_mem;=0A=
		} else {=0A=
			pp->sg_tbl[tag]     =3D pp->sg_tbl[0];=0A=
			pp->sg_tbl_dma[tag] =3D pp->sg_tbl_dma[0];=0A=
		}=0A=
	}=0A=
	return 0;=0A=
=0A=
out_port_free_dma_mem:=0A=
	mv_port_free_dma_mem(ap);=0A=
	return -ENOMEM;=0A=
}=0A=
=0A=
/**=0A=
 *      mv_port_stop - Port specific cleanup/stop routine.=0A=
 *      @ap: ATA channel to manipulate=0A=
 *=0A=
 *      Stop DMA, cleanup port memory.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      This routine uses the host lock to protect the DMA stop.=0A=
 */=0A=
static void mv_port_stop(struct ata_port *ap)=0A=
{=0A=
	mv_stop_edma(ap);=0A=
	mv_enable_port_irqs(ap, 0);=0A=
	mv_port_free_dma_mem(ap);=0A=
}=0A=
=0A=
/**=0A=
 *      mv_fill_sg - Fill out the Marvell ePRD (scatter gather) entries=0A=
 *      @qc: queued command whose SG list to source from=0A=
 *=0A=
 *      Populate the SG list and mark the last entry.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static void mv_fill_sg(struct ata_queued_cmd *qc)=0A=
{=0A=
	struct mv_port_priv *pp =3D qc->ap->private_data;=0A=
	struct scatterlist *sg;=0A=
	struct mv_sg *mv_sg, *last_sg =3D NULL;=0A=
	unsigned int si;=0A=
=0A=
	mv_sg =3D pp->sg_tbl[qc->tag];=0A=
	for_each_sg(qc->sg, sg, qc->n_elem, si) {=0A=
		dma_addr_t addr =3D sg_dma_address(sg);=0A=
		u32 sg_len =3D sg_dma_len(sg);=0A=
=0A=
		while (sg_len) {=0A=
			u32 offset =3D addr & 0xffff;=0A=
			u32 len =3D sg_len;=0A=
=0A=
			if ((offset + sg_len > 0x10000))=0A=
				len =3D 0x10000 - offset;=0A=
=0A=
			mv_sg->addr =3D cpu_to_le32(addr & 0xffffffff);=0A=
			mv_sg->addr_hi =3D cpu_to_le32((addr >> 16) >> 16);=0A=
			mv_sg->flags_size =3D cpu_to_le32(len & 0xffff);=0A=
=0A=
			sg_len -=3D len;=0A=
			addr +=3D len;=0A=
=0A=
			last_sg =3D mv_sg;=0A=
			mv_sg++;=0A=
		}=0A=
	}=0A=
=0A=
	if (likely(last_sg))=0A=
		last_sg->flags_size |=3D cpu_to_le32(EPRD_FLAG_END_OF_TBL);=0A=
}=0A=
=0A=
static void mv_crqb_pack_cmd(__le16 *cmdw, u8 data, u8 addr, unsigned =
last)=0A=
{=0A=
	u16 tmp =3D data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |=0A=
		(last ? CRQB_CMD_LAST : 0);=0A=
	*cmdw =3D cpu_to_le16(tmp);=0A=
}=0A=
=0A=
/**=0A=
 *      mv_qc_prep - Host specific command preparation.=0A=
 *      @qc: queued command to prepare=0A=
 *=0A=
 *      This routine simply redirects to the general purpose routine=0A=
 *      if command is not DMA.  Else, it handles prep of the CRQB=0A=
 *      (command request block), does some sanity checking, and calls=0A=
 *      the SG load routine.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static void mv_qc_prep(struct ata_queued_cmd *qc)=0A=
{=0A=
	struct ata_port *ap =3D qc->ap;=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
	__le16 *cw;=0A=
	struct ata_taskfile *tf;=0A=
	u16 flags =3D 0;=0A=
	unsigned in_index;=0A=
=0A=
	if ((qc->tf.protocol !=3D ATA_PROT_DMA) &&=0A=
	    (qc->tf.protocol !=3D ATA_PROT_NCQ))=0A=
		return;=0A=
=0A=
	/* Fill in command request block=0A=
	 */=0A=
	if (!(qc->tf.flags & ATA_TFLAG_WRITE))=0A=
		flags |=3D CRQB_FLAG_READ;=0A=
	WARN_ON(MV_MAX_Q_DEPTH <=3D qc->tag);=0A=
	flags |=3D qc->tag << CRQB_TAG_SHIFT;=0A=
	flags |=3D (qc->dev->link->pmp & 0xf) << CRQB_PMP_SHIFT;=0A=
=0A=
	/* get current queue index from software */=0A=
	in_index =3D pp->req_idx;=0A=
=0A=
	pp->crqb[in_index].sg_addr =3D=0A=
		cpu_to_le32(pp->sg_tbl_dma[qc->tag] & 0xffffffff);=0A=
	pp->crqb[in_index].sg_addr_hi =3D=0A=
		cpu_to_le32((pp->sg_tbl_dma[qc->tag] >> 16) >> 16);=0A=
	pp->crqb[in_index].ctrl_flags =3D cpu_to_le16(flags);=0A=
=0A=
	cw =3D &pp->crqb[in_index].ata_cmd[0];=0A=
	tf =3D &qc->tf;=0A=
=0A=
	/* Sadly, the CRQB cannot accomodate all registers--there are=0A=
	 * only 11 bytes...so we must pick and choose required=0A=
	 * registers based on the command.  So, we drop feature and=0A=
	 * hob_feature for [RW] DMA commands, but they are needed for=0A=
	 * NCQ.  NCQ will drop hob_nsect.=0A=
	 */=0A=
	switch (tf->command) {=0A=
	case ATA_CMD_READ:=0A=
	case ATA_CMD_READ_EXT:=0A=
	case ATA_CMD_WRITE:=0A=
	case ATA_CMD_WRITE_EXT:=0A=
	case ATA_CMD_WRITE_FUA_EXT:=0A=
		mv_crqb_pack_cmd(cw++, tf->hob_nsect, ATA_REG_NSECT, 0);=0A=
		break;=0A=
	case ATA_CMD_FPDMA_READ:=0A=
	case ATA_CMD_FPDMA_WRITE:=0A=
		mv_crqb_pack_cmd(cw++, tf->hob_feature, ATA_REG_FEATURE, 0);=0A=
		mv_crqb_pack_cmd(cw++, tf->feature, ATA_REG_FEATURE, 0);=0A=
		break;=0A=
	default:=0A=
		/* The only other commands EDMA supports in non-queued and=0A=
		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none=0A=
		 * of which are defined/used by Linux.  If we get here, this=0A=
		 * driver needs work.=0A=
		 *=0A=
		 * FIXME: modify libata to give qc_prep a return value and=0A=
		 * return error here.=0A=
		 */=0A=
		BUG_ON(tf->command);=0A=
		break;=0A=
	}=0A=
	mv_crqb_pack_cmd(cw++, tf->nsect, ATA_REG_NSECT, 0);=0A=
	mv_crqb_pack_cmd(cw++, tf->hob_lbal, ATA_REG_LBAL, 0);=0A=
	mv_crqb_pack_cmd(cw++, tf->lbal, ATA_REG_LBAL, 0);=0A=
	mv_crqb_pack_cmd(cw++, tf->hob_lbam, ATA_REG_LBAM, 0);=0A=
	mv_crqb_pack_cmd(cw++, tf->lbam, ATA_REG_LBAM, 0);=0A=
	mv_crqb_pack_cmd(cw++, tf->hob_lbah, ATA_REG_LBAH, 0);=0A=
	mv_crqb_pack_cmd(cw++, tf->lbah, ATA_REG_LBAH, 0);=0A=
	mv_crqb_pack_cmd(cw++, tf->device, ATA_REG_DEVICE, 0);=0A=
	mv_crqb_pack_cmd(cw++, tf->command, ATA_REG_CMD, 1);	/* last */=0A=
=0A=
	if (!(qc->flags & ATA_QCFLAG_DMAMAP))=0A=
		return;=0A=
	mv_fill_sg(qc);=0A=
}=0A=
=0A=
/**=0A=
 *      mv_qc_prep_iie - Host specific command preparation.=0A=
 *      @qc: queued command to prepare=0A=
 *=0A=
 *      This routine simply redirects to the general purpose routine=0A=
 *      if command is not DMA.  Else, it handles prep of the CRQB=0A=
 *      (command request block), does some sanity checking, and calls=0A=
 *      the SG load routine.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static void mv_qc_prep_iie(struct ata_queued_cmd *qc)=0A=
{=0A=
	struct ata_port *ap =3D qc->ap;=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
	struct mv_crqb_iie *crqb;=0A=
	struct ata_taskfile *tf;=0A=
	unsigned in_index;=0A=
	u32 flags =3D 0;=0A=
=0A=
	if ((qc->tf.protocol !=3D ATA_PROT_DMA) &&=0A=
	    (qc->tf.protocol !=3D ATA_PROT_NCQ))=0A=
		return;=0A=
=0A=
	/* Fill in Gen IIE command request block */=0A=
	if (!(qc->tf.flags & ATA_TFLAG_WRITE))=0A=
		flags |=3D CRQB_FLAG_READ;=0A=
=0A=
	WARN_ON(MV_MAX_Q_DEPTH <=3D qc->tag);=0A=
	flags |=3D qc->tag << CRQB_TAG_SHIFT;=0A=
	flags |=3D qc->tag << CRQB_HOSTQ_SHIFT;=0A=
	flags |=3D (qc->dev->link->pmp & 0xf) << CRQB_PMP_SHIFT;=0A=
=0A=
	/* get current queue index from software */=0A=
	in_index =3D pp->req_idx;=0A=
=0A=
	crqb =3D (struct mv_crqb_iie *) &pp->crqb[in_index];=0A=
	crqb->addr =3D cpu_to_le32(pp->sg_tbl_dma[qc->tag] & 0xffffffff);=0A=
	crqb->addr_hi =3D cpu_to_le32((pp->sg_tbl_dma[qc->tag] >> 16) >> 16);=0A=
	crqb->flags =3D cpu_to_le32(flags);=0A=
=0A=
	tf =3D &qc->tf;=0A=
	crqb->ata_cmd[0] =3D cpu_to_le32(=0A=
			(tf->command << 16) |=0A=
			(tf->feature << 24)=0A=
		);=0A=
	crqb->ata_cmd[1] =3D cpu_to_le32(=0A=
			(tf->lbal << 0) |=0A=
			(tf->lbam << 8) |=0A=
			(tf->lbah << 16) |=0A=
			(tf->device << 24)=0A=
		);=0A=
	crqb->ata_cmd[2] =3D cpu_to_le32(=0A=
			(tf->hob_lbal << 0) |=0A=
			(tf->hob_lbam << 8) |=0A=
			(tf->hob_lbah << 16) |=0A=
			(tf->hob_feature << 24)=0A=
		);=0A=
	crqb->ata_cmd[3] =3D cpu_to_le32(=0A=
			(tf->nsect << 0) |=0A=
			(tf->hob_nsect << 8)=0A=
		);=0A=
=0A=
	if (!(qc->flags & ATA_QCFLAG_DMAMAP))=0A=
		return;=0A=
	mv_fill_sg(qc);=0A=
}=0A=
=0A=
/**=0A=
 *      mv_qc_issue - Initiate a command to the host=0A=
 *      @qc: queued command to start=0A=
 *=0A=
 *      This routine simply redirects to the general purpose routine=0A=
 *      if command is not DMA.  Else, it sanity checks our local=0A=
 *      caches of the request producer/consumer indices then enables=0A=
 *      DMA and bumps the request producer index.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static unsigned int mv_qc_issue(struct ata_queued_cmd *qc)=0A=
{=0A=
	struct ata_port *ap =3D qc->ap;=0A=
	void __iomem *port_mmio =3D mv_ap_base(ap);=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
	u32 in_index;=0A=
=0A=
	if ((qc->tf.protocol !=3D ATA_PROT_DMA) &&=0A=
	    (qc->tf.protocol !=3D ATA_PROT_NCQ)) {=0A=
		static int limit_warnings =3D 10;=0A=
		/*=0A=
		 * Errata SATA#16, SATA#24: warn if multiple DRQs expected.=0A=
		 *=0A=
		 * Someday, we might implement special polling workarounds=0A=
		 * for these, but it all seems rather unnecessary since we=0A=
		 * normally use only DMA for commands which transfer more=0A=
		 * than a single block of data.=0A=
		 *=0A=
		 * Much of the time, this could just work regardless.=0A=
		 * So for now, just log the incident, and allow the attempt.=0A=
		 */=0A=
		if (limit_warnings > 0 && (qc->nbytes / qc->sect_size) > 1) {=0A=
			--limit_warnings;=0A=
			ata_link_printk(qc->dev->link, KERN_WARNING, DRV_NAME=0A=
					": attempting PIO w/multiple DRQ: "=0A=
					"this may fail due to h/w errata\n");=0A=
		}=0A=
		/*=0A=
		 * We're about to send a non-EDMA capable command to the=0A=
		 * port.  Turn off EDMA so there won't be problems accessing=0A=
		 * shadow block, etc registers.=0A=
		 */=0A=
		mv_stop_edma(ap);=0A=
		mv_enable_port_irqs(ap, ERR_IRQ);=0A=
		mv_pmp_select(ap, qc->dev->link->pmp);=0A=
		return ata_sff_qc_issue(qc);=0A=
	}=0A=
=0A=
	mv_start_dma(ap, port_mmio, pp, qc->tf.protocol);=0A=
=0A=
	pp->req_idx =3D (pp->req_idx + 1) & MV_MAX_Q_DEPTH_MASK;=0A=
	in_index =3D pp->req_idx << EDMA_REQ_Q_PTR_SHIFT;=0A=
=0A=
	/* and write the request in pointer to kick the EDMA to life */=0A=
	writelfl((pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK) | in_index,=0A=
		 port_mmio + EDMA_REQ_Q_IN_PTR_OFS);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static struct ata_queued_cmd *mv_get_active_qc(struct ata_port *ap)=0A=
{=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
	struct ata_queued_cmd *qc;=0A=
=0A=
	if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)=0A=
		return NULL;=0A=
	qc =3D ata_qc_from_tag(ap, ap->link.active_tag);=0A=
	if (qc && (qc->tf.flags & ATA_TFLAG_POLLING))=0A=
		qc =3D NULL;=0A=
	return qc;=0A=
}=0A=
=0A=
static void mv_pmp_error_handler(struct ata_port *ap)=0A=
{=0A=
	unsigned int pmp, pmp_map;=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
=0A=
	if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH) {=0A=
		/*=0A=
		 * Perform NCQ error analysis on failed PMPs=0A=
		 * before we freeze the port entirely.=0A=
		 *=0A=
		 * The failed PMPs are marked earlier by mv_pmp_eh_prep().=0A=
		 */=0A=
		pmp_map =3D pp->delayed_eh_pmp_map;=0A=
		pp->pp_flags &=3D ~MV_PP_FLAG_DELAYED_EH;=0A=
		for (pmp =3D 0; pmp_map !=3D 0; pmp++) {=0A=
			unsigned int this_pmp =3D (1 << pmp);=0A=
			if (pmp_map & this_pmp) {=0A=
				struct ata_link *link =3D &ap->pmp_link[pmp];=0A=
				pmp_map &=3D ~this_pmp;=0A=
				ata_eh_analyze_ncq_error(link);=0A=
			}=0A=
		}=0A=
		ata_port_freeze(ap);=0A=
	}=0A=
	sata_pmp_error_handler(ap);=0A=
}=0A=
=0A=
static unsigned int mv_get_err_pmp_map(struct ata_port *ap)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_ap_base(ap);=0A=
=0A=
	return readl(port_mmio + SATA_TESTCTL_OFS) >> 16;=0A=
}=0A=
=0A=
static void mv_pmp_eh_prep(struct ata_port *ap, unsigned int pmp_map)=0A=
{=0A=
	struct ata_eh_info *ehi;=0A=
	unsigned int pmp;=0A=
=0A=
	/*=0A=
	 * Initialize EH info for PMPs which saw device errors=0A=
	 */=0A=
	ehi =3D &ap->link.eh_info;=0A=
	for (pmp =3D 0; pmp_map !=3D 0; pmp++) {=0A=
		unsigned int this_pmp =3D (1 << pmp);=0A=
		if (pmp_map & this_pmp) {=0A=
			struct ata_link *link =3D &ap->pmp_link[pmp];=0A=
=0A=
			pmp_map &=3D ~this_pmp;=0A=
			ehi =3D &link->eh_info;=0A=
			ata_ehi_clear_desc(ehi);=0A=
			ata_ehi_push_desc(ehi, "dev err");=0A=
			ehi->err_mask |=3D AC_ERR_DEV;=0A=
			ehi->action |=3D ATA_EH_RESET;=0A=
			ata_link_abort(link);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
static int mv_req_q_empty(struct ata_port *ap)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_ap_base(ap);=0A=
	u32 in_ptr, out_ptr;=0A=
=0A=
	in_ptr  =3D (readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS)=0A=
			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;=0A=
	out_ptr =3D (readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS)=0A=
			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;=0A=
	return (in_ptr =3D=3D out_ptr);	/* 1 =3D=3D queue_is_empty */=0A=
}=0A=
=0A=
static int mv_handle_fbs_ncq_dev_err(struct ata_port *ap)=0A=
{=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
	int failed_links;=0A=
	unsigned int old_map, new_map;=0A=
=0A=
	/*=0A=
	 * Device error during FBS+NCQ operation:=0A=
	 *=0A=
	 * Set a port flag to prevent further I/O being enqueued.=0A=
	 * Leave the EDMA running to drain outstanding commands from this port.=0A=
	 * Perform the post-mortem/EH only when all responses are complete.=0A=
	 * Follow recovery sequence from 6042/7042 datasheet (7.3.15.4.2.2).=0A=
	 */=0A=
	if (!(pp->pp_flags & MV_PP_FLAG_DELAYED_EH)) {=0A=
		pp->pp_flags |=3D MV_PP_FLAG_DELAYED_EH;=0A=
		pp->delayed_eh_pmp_map =3D 0;=0A=
	}=0A=
	old_map =3D pp->delayed_eh_pmp_map;=0A=
	new_map =3D old_map | mv_get_err_pmp_map(ap);=0A=
=0A=
	if (old_map !=3D new_map) {=0A=
		pp->delayed_eh_pmp_map =3D new_map;=0A=
		mv_pmp_eh_prep(ap, new_map & ~old_map);=0A=
	}=0A=
	failed_links =3D hweight16(new_map);=0A=
=0A=
	ata_port_printk(ap, KERN_INFO, "%s: pmp_map=3D%04x qc_map=3D%04x "=0A=
			"failed_links=3D%d nr_active_links=3D%d\n",=0A=
			__func__, pp->delayed_eh_pmp_map,=0A=
			ap->qc_active, failed_links,=0A=
			ap->nr_active_links);=0A=
=0A=
	if (ap->nr_active_links <=3D failed_links && mv_req_q_empty(ap)) {=0A=
		mv_process_crpb_entries(ap, pp);=0A=
		mv_stop_edma(ap);=0A=
		mv_eh_freeze(ap);=0A=
		ata_port_printk(ap, KERN_INFO, "%s: done\n", __func__);=0A=
		return 1;	/* handled */=0A=
	}=0A=
	ata_port_printk(ap, KERN_INFO, "%s: waiting\n", __func__);=0A=
	return 1;	/* handled */=0A=
}=0A=
=0A=
static int mv_handle_fbs_non_ncq_dev_err(struct ata_port *ap)=0A=
{=0A=
	/*=0A=
	 * Possible future enhancement:=0A=
	 *=0A=
	 * FBS+non-NCQ operation is not yet implemented.=0A=
	 * See related notes in mv_edma_cfg().=0A=
	 *=0A=
	 * Device error during FBS+non-NCQ operation:=0A=
	 *=0A=
	 * We need to snapshot the shadow registers for each failed command.=0A=
	 * Follow recovery sequence from 6042/7042 datasheet (7.3.15.4.2.3).=0A=
	 */=0A=
	return 0;	/* not handled */=0A=
}=0A=
=0A=
static int mv_handle_dev_err(struct ata_port *ap, u32 edma_err_cause)=0A=
{=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
=0A=
	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN))=0A=
		return 0;	/* EDMA was not active: not handled */=0A=
	if (!(pp->pp_flags & MV_PP_FLAG_FBS_EN))=0A=
		return 0;	/* FBS was not active: not handled */=0A=
=0A=
	if (!(edma_err_cause & EDMA_ERR_DEV))=0A=
		return 0;	/* non DEV error: not handled */=0A=
	edma_err_cause &=3D ~EDMA_ERR_IRQ_TRANSIENT;=0A=
	if (edma_err_cause & ~(EDMA_ERR_DEV | EDMA_ERR_SELF_DIS))=0A=
		return 0;	/* other problems: not handled */=0A=
=0A=
	if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {=0A=
		/*=0A=
		 * EDMA should NOT have self-disabled for this case.=0A=
		 * If it did, then something is wrong elsewhere,=0A=
		 * and we cannot handle it here.=0A=
		 */=0A=
		if (edma_err_cause & EDMA_ERR_SELF_DIS) {=0A=
			ata_port_printk(ap, KERN_WARNING,=0A=
				"%s: err_cause=3D0x%x pp_flags=3D0x%x\n",=0A=
				__func__, edma_err_cause, pp->pp_flags);=0A=
			return 0; /* not handled */=0A=
		}=0A=
		return mv_handle_fbs_ncq_dev_err(ap);=0A=
	} else {=0A=
		/*=0A=
		 * EDMA should have self-disabled for this case.=0A=
		 * If it did not, then something is wrong elsewhere,=0A=
		 * and we cannot handle it here.=0A=
		 */=0A=
		if (!(edma_err_cause & EDMA_ERR_SELF_DIS)) {=0A=
			ata_port_printk(ap, KERN_WARNING,=0A=
				"%s: err_cause=3D0x%x pp_flags=3D0x%x\n",=0A=
				__func__, edma_err_cause, pp->pp_flags);=0A=
			return 0; /* not handled */=0A=
		}=0A=
		return mv_handle_fbs_non_ncq_dev_err(ap);=0A=
	}=0A=
	return 0;	/* not handled */=0A=
}=0A=
=0A=
static void mv_unexpected_intr(struct ata_port *ap, int edma_was_enabled)=0A=
{=0A=
	struct ata_eh_info *ehi =3D &ap->link.eh_info;=0A=
	char *when =3D "idle";=0A=
=0A=
	ata_ehi_clear_desc(ehi);=0A=
	if (!ap || (ap->flags & ATA_FLAG_DISABLED)) {=0A=
		when =3D "disabled";=0A=
	} else if (edma_was_enabled) {=0A=
		when =3D "EDMA enabled";=0A=
	} else {=0A=
		struct ata_queued_cmd *qc =3D ata_qc_from_tag(ap, ap->link.active_tag);=0A=
		if (qc && (qc->tf.flags & ATA_TFLAG_POLLING))=0A=
			when =3D "polling";=0A=
	}=0A=
	ata_ehi_push_desc(ehi, "unexpected device interrupt while %s", when);=0A=
	ehi->err_mask |=3D AC_ERR_OTHER;=0A=
	ehi->action   |=3D ATA_EH_RESET;=0A=
	ata_port_freeze(ap);=0A=
}=0A=
=0A=
/**=0A=
 *      mv_err_intr - Handle error interrupts on the port=0A=
 *      @ap: ATA channel to manipulate=0A=
 *      @qc: affected command (non-NCQ), or NULL=0A=
 *=0A=
 *      Most cases require a full reset of the chip's state machine,=0A=
 *      which also performs a COMRESET.=0A=
 *      Also, if the port disabled DMA, update our cached copy to match.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static void mv_err_intr(struct ata_port *ap)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_ap_base(ap);=0A=
	u32 edma_err_cause, eh_freeze_mask, serr =3D 0;=0A=
	u32 fis_cause =3D 0;=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	unsigned int action =3D 0, err_mask =3D 0;=0A=
	struct ata_eh_info *ehi =3D &ap->link.eh_info;=0A=
	struct ata_queued_cmd *qc;=0A=
	int abort =3D 0;=0A=
=0A=
	/*=0A=
	 * Read and clear the SError and err_cause bits.=0A=
	 * For GenIIe, if EDMA_ERR_TRANS_IRQ_7 is set, we also must read/clear=0A=
	 * the FIS_IRQ_CAUSE register before clearing edma_err_cause.=0A=
	 */=0A=
	sata_scr_read(&ap->link, SCR_ERROR, &serr);=0A=
	sata_scr_write_flush(&ap->link, SCR_ERROR, serr);=0A=
=0A=
	edma_err_cause =3D readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);=0A=
	if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7)) {=0A=
		fis_cause =3D readl(port_mmio + SATA_FIS_IRQ_CAUSE_OFS);=0A=
		writelfl(~fis_cause, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);=0A=
	}=0A=
	writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);=0A=
=0A=
	if (edma_err_cause & EDMA_ERR_DEV) {=0A=
		/*=0A=
		 * Device errors during FIS-based switching operation=0A=
		 * require special handling.=0A=
		 */=0A=
		if (mv_handle_dev_err(ap, edma_err_cause))=0A=
			return;=0A=
	}=0A=
=0A=
	qc =3D mv_get_active_qc(ap);=0A=
	ata_ehi_clear_desc(ehi);=0A=
	ata_ehi_push_desc(ehi, "edma_err_cause=3D%08x pp_flags=3D%08x",=0A=
			  edma_err_cause, pp->pp_flags);=0A=
=0A=
	if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7)) {=0A=
		ata_ehi_push_desc(ehi, "fis_cause=3D%08x", fis_cause);=0A=
		if (fis_cause & SATA_FIS_IRQ_AN) {=0A=
			u32 ec =3D edma_err_cause &=0A=
			       ~(EDMA_ERR_TRANS_IRQ_7 | EDMA_ERR_IRQ_TRANSIENT);=0A=
			sata_async_notification(ap);=0A=
			if (!ec)=0A=
				return; /* Just an AN; no need for the nukes */=0A=
			ata_ehi_push_desc(ehi, "SDB notify");=0A=
		}=0A=
	}=0A=
	/*=0A=
	 * All generations share these EDMA error cause bits:=0A=
	 */=0A=
	if (edma_err_cause & EDMA_ERR_DEV) {=0A=
		err_mask |=3D AC_ERR_DEV;=0A=
		action |=3D ATA_EH_RESET;=0A=
		ata_ehi_push_desc(ehi, "dev error");=0A=
	}=0A=
	if (edma_err_cause & (EDMA_ERR_D_PAR | EDMA_ERR_PRD_PAR |=0A=
			EDMA_ERR_CRQB_PAR | EDMA_ERR_CRPB_PAR |=0A=
			EDMA_ERR_INTRL_PAR)) {=0A=
		err_mask |=3D AC_ERR_ATA_BUS;=0A=
		action |=3D ATA_EH_RESET;=0A=
		ata_ehi_push_desc(ehi, "parity error");=0A=
	}=0A=
	if (edma_err_cause & (EDMA_ERR_DEV_DCON | EDMA_ERR_DEV_CON)) {=0A=
		ata_ehi_hotplugged(ehi);=0A=
		ata_ehi_push_desc(ehi, edma_err_cause & EDMA_ERR_DEV_DCON ?=0A=
			"dev disconnect" : "dev connect");=0A=
		action |=3D ATA_EH_RESET;=0A=
	}=0A=
=0A=
	/*=0A=
	 * Gen-I has a different SELF_DIS bit,=0A=
	 * different FREEZE bits, and no SERR bit:=0A=
	 */=0A=
	if (IS_GEN_I(hpriv)) {=0A=
		eh_freeze_mask =3D EDMA_EH_FREEZE_5;=0A=
		if (edma_err_cause & EDMA_ERR_SELF_DIS_5) {=0A=
			pp->pp_flags &=3D ~MV_PP_FLAG_EDMA_EN;=0A=
			ata_ehi_push_desc(ehi, "EDMA self-disable");=0A=
		}=0A=
	} else {=0A=
		eh_freeze_mask =3D EDMA_EH_FREEZE;=0A=
		if (edma_err_cause & EDMA_ERR_SELF_DIS) {=0A=
			pp->pp_flags &=3D ~MV_PP_FLAG_EDMA_EN;=0A=
			ata_ehi_push_desc(ehi, "EDMA self-disable");=0A=
		}=0A=
		if (edma_err_cause & EDMA_ERR_SERR) {=0A=
			ata_ehi_push_desc(ehi, "SError=3D%08x", serr);=0A=
			err_mask |=3D AC_ERR_ATA_BUS;=0A=
			action |=3D ATA_EH_RESET;=0A=
		}=0A=
	}=0A=
=0A=
	if (!err_mask) {=0A=
		err_mask =3D AC_ERR_OTHER;=0A=
		action |=3D ATA_EH_RESET;=0A=
	}=0A=
=0A=
	ehi->serror |=3D serr;=0A=
	ehi->action |=3D action;=0A=
=0A=
	if (qc)=0A=
		qc->err_mask |=3D err_mask;=0A=
	else=0A=
		ehi->err_mask |=3D err_mask;=0A=
=0A=
	if (err_mask =3D=3D AC_ERR_DEV) {=0A=
		/*=0A=
		 * Cannot do ata_port_freeze() here,=0A=
		 * because it would kill PIO access,=0A=
		 * which is needed for further diagnosis.=0A=
		 */=0A=
		mv_eh_freeze(ap);=0A=
		abort =3D 1;=0A=
	} else if (edma_err_cause & eh_freeze_mask) {=0A=
		/*=0A=
		 * Note to self: ata_port_freeze() calls ata_port_abort()=0A=
		 */=0A=
		ata_port_freeze(ap);=0A=
	} else {=0A=
		abort =3D 1;=0A=
	}=0A=
=0A=
	if (abort) {=0A=
		if (qc)=0A=
			ata_link_abort(qc->dev->link);=0A=
		else=0A=
			ata_port_abort(ap);=0A=
	}=0A=
}=0A=
=0A=
static void mv_process_crpb_response(struct ata_port *ap,=0A=
		struct mv_crpb *response, unsigned int tag, int ncq_enabled)=0A=
{=0A=
	struct ata_queued_cmd *qc =3D ata_qc_from_tag(ap, tag);=0A=
=0A=
	if (qc) {=0A=
		u8 ata_status;=0A=
		u16 edma_status =3D le16_to_cpu(response->flags);=0A=
		/*=0A=
		 * edma_status from a response queue entry:=0A=
		 *   LSB is from EDMA_ERR_IRQ_CAUSE_OFS (non-NCQ only).=0A=
		 *   MSB is saved ATA status from command completion.=0A=
		 */=0A=
		if (!ncq_enabled) {=0A=
			u8 err_cause =3D edma_status & 0xff & ~EDMA_ERR_DEV;=0A=
			if (err_cause) {=0A=
				/*=0A=
				 * Error will be seen/handled by mv_err_intr().=0A=
				 * So do nothing at all here.=0A=
				 */=0A=
				return;=0A=
			}=0A=
		}=0A=
		ata_status =3D edma_status >> CRPB_FLAG_STATUS_SHIFT;=0A=
		if (!ac_err_mask(ata_status))=0A=
			ata_qc_complete(qc);=0A=
		/* else: leave it for mv_err_intr() */=0A=
	} else {=0A=
		ata_port_printk(ap, KERN_ERR, "%s: no qc for tag=3D%d\n",=0A=
				__func__, tag);=0A=
	}=0A=
}=0A=
=0A=
static void mv_process_crpb_entries(struct ata_port *ap, struct =
mv_port_priv *pp)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_ap_base(ap);=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	u32 in_index;=0A=
	bool work_done =3D false;=0A=
	int ncq_enabled =3D (pp->pp_flags & MV_PP_FLAG_NCQ_EN);=0A=
=0A=
	/* Get the hardware queue position index */=0A=
	in_index =3D (readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS)=0A=
			>> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;=0A=
=0A=
	/* Process new responses from since the last time we looked */=0A=
	while (in_index !=3D pp->resp_idx) {=0A=
		unsigned int tag;=0A=
		struct mv_crpb *response =3D &pp->crpb[pp->resp_idx];=0A=
=0A=
		pp->resp_idx =3D (pp->resp_idx + 1) & MV_MAX_Q_DEPTH_MASK;=0A=
=0A=
		if (IS_GEN_I(hpriv)) {=0A=
			/* 50xx: no NCQ, only one command active at a time */=0A=
			tag =3D ap->link.active_tag;=0A=
		} else {=0A=
			/* Gen II/IIE: get command tag from CRPB entry */=0A=
			tag =3D le16_to_cpu(response->id) & 0x1f;=0A=
		}=0A=
		mv_process_crpb_response(ap, response, tag, ncq_enabled);=0A=
		work_done =3D true;=0A=
	}=0A=
=0A=
	/* Update the software queue position index in hardware */=0A=
	if (work_done)=0A=
		writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) |=0A=
			 (pp->resp_idx << EDMA_RSP_Q_PTR_SHIFT),=0A=
			 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);=0A=
}=0A=
=0A=
static void mv_port_intr(struct ata_port *ap, u32 port_cause)=0A=
{=0A=
	struct mv_port_priv *pp;=0A=
	int edma_was_enabled;=0A=
=0A=
	if (!ap || (ap->flags & ATA_FLAG_DISABLED)) {=0A=
		mv_unexpected_intr(ap, 0);=0A=
		return;=0A=
	}=0A=
	/*=0A=
	 * Grab a snapshot of the EDMA_EN flag setting,=0A=
	 * so that we have a consistent view for this port,=0A=
	 * even if something we call of our routines changes it.=0A=
	 */=0A=
	pp =3D ap->private_data;=0A=
	edma_was_enabled =3D (pp->pp_flags & MV_PP_FLAG_EDMA_EN);=0A=
	/*=0A=
	 * Process completed CRPB response(s) before other events.=0A=
	 */=0A=
	if (edma_was_enabled && (port_cause & DONE_IRQ)) {=0A=
		mv_process_crpb_entries(ap, pp);=0A=
		if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH)=0A=
			mv_handle_fbs_ncq_dev_err(ap);=0A=
	}=0A=
	/*=0A=
	 * Handle chip-reported errors, or continue on to handle PIO.=0A=
	 */=0A=
	if (unlikely(port_cause & ERR_IRQ)) {=0A=
		mv_err_intr(ap);=0A=
	} else if (!edma_was_enabled) {=0A=
		struct ata_queued_cmd *qc =3D mv_get_active_qc(ap);=0A=
		if (qc)=0A=
			ata_sff_host_intr(ap, qc);=0A=
		else=0A=
			mv_unexpected_intr(ap, edma_was_enabled);=0A=
	}=0A=
}=0A=
=0A=
/**=0A=
 *      mv_host_intr - Handle all interrupts on the given host controller=0A=
 *      @host: host specific structure=0A=
 *      @main_irq_cause: Main interrupt cause register for the chip.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static int mv_host_intr(struct ata_host *host, u32 main_irq_cause)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	void __iomem *mmio =3D hpriv->base, *hc_mmio;=0A=
	unsigned int handled =3D 0, port;=0A=
=0A=
	for (port =3D 0; port < hpriv->n_ports; port++) {=0A=
		struct ata_port *ap =3D host->ports[port];=0A=
		unsigned int p, shift, hardport, port_cause;=0A=
=0A=
		MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);=0A=
		/*=0A=
		 * Each hc within the host has its own hc_irq_cause register,=0A=
		 * where the interrupting ports bits get ack'd.=0A=
		 */=0A=
		if (hardport =3D=3D 0) {	/* first port on this hc ? */=0A=
			u32 hc_cause =3D (main_irq_cause >> shift) & HC0_IRQ_PEND;=0A=
			u32 port_mask, ack_irqs;=0A=
			/*=0A=
			 * Skip this entire hc if nothing pending for any ports=0A=
			 */=0A=
			if (!hc_cause) {=0A=
				port +=3D MV_PORTS_PER_HC - 1;=0A=
				continue;=0A=
			}=0A=
			/*=0A=
			 * We don't need/want to read the hc_irq_cause register,=0A=
			 * because doing so hurts performance, and=0A=
			 * main_irq_cause already gives us everything we need.=0A=
			 *=0A=
			 * But we do have to *write* to the hc_irq_cause to ack=0A=
			 * the ports that we are handling this time through.=0A=
			 *=0A=
			 * This requires that we create a bitmap for those=0A=
			 * ports which interrupted us, and use that bitmap=0A=
			 * to ack (only) those ports via hc_irq_cause.=0A=
			 */=0A=
			ack_irqs =3D 0;=0A=
			for (p =3D 0; p < MV_PORTS_PER_HC; ++p) {=0A=
				if ((port + p) >=3D hpriv->n_ports)=0A=
					break;=0A=
				port_mask =3D (DONE_IRQ | ERR_IRQ) << (p * 2);=0A=
				if (hc_cause & port_mask)=0A=
					ack_irqs |=3D (DMA_IRQ | DEV_IRQ) << p;=0A=
			}=0A=
			hc_mmio =3D mv_hc_base_from_port(mmio, port);=0A=
			writelfl(~ack_irqs, hc_mmio + HC_IRQ_CAUSE_OFS);=0A=
			handled =3D 1;=0A=
		}=0A=
		/*=0A=
		 * Handle interrupts signalled for this port:=0A=
		 */=0A=
		port_cause =3D (main_irq_cause >> shift) & (DONE_IRQ | ERR_IRQ);=0A=
		if (port_cause)=0A=
			mv_port_intr(ap, port_cause);=0A=
	}=0A=
	return handled;=0A=
}=0A=
=0A=
static int mv_pci_error(struct ata_host *host, void __iomem *mmio)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	struct ata_port *ap;=0A=
	struct ata_queued_cmd *qc;=0A=
	struct ata_eh_info *ehi;=0A=
	unsigned int i, err_mask, printed =3D 0;=0A=
	u32 err_cause;=0A=
=0A=
	err_cause =3D readl(mmio + hpriv->irq_cause_ofs);=0A=
=0A=
	dev_printk(KERN_ERR, host->dev, "PCI ERROR; PCI IRQ cause=3D0x%08x\n",=0A=
		   err_cause);=0A=
=0A=
	DPRINTK("All regs @ PCI error\n");=0A=
	mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));=0A=
=0A=
	writelfl(0, mmio + hpriv->irq_cause_ofs);=0A=
=0A=
	for (i =3D 0; i < host->n_ports; i++) {=0A=
		ap =3D host->ports[i];=0A=
		if (!ata_link_offline(&ap->link)) {=0A=
			ehi =3D &ap->link.eh_info;=0A=
			ata_ehi_clear_desc(ehi);=0A=
			if (!printed++)=0A=
				ata_ehi_push_desc(ehi,=0A=
					"PCI err cause 0x%08x", err_cause);=0A=
			err_mask =3D AC_ERR_HOST_BUS;=0A=
			ehi->action =3D ATA_EH_RESET;=0A=
			qc =3D ata_qc_from_tag(ap, ap->link.active_tag);=0A=
			if (qc)=0A=
				qc->err_mask |=3D err_mask;=0A=
			else=0A=
				ehi->err_mask |=3D err_mask;=0A=
=0A=
			ata_port_freeze(ap);=0A=
		}=0A=
	}=0A=
	return 1;	/* handled */=0A=
}=0A=
=0A=
/**=0A=
 *      mv_interrupt - Main interrupt event handler=0A=
 *      @irq: unused=0A=
 *      @dev_instance: private data; in this case the host structure=0A=
 *=0A=
 *      Read the read only register to determine if any host=0A=
 *      controllers have pending interrupts.  If so, call lower level=0A=
 *      routine to handle.  Also check for PCI errors which are only=0A=
 *      reported here.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      This routine holds the host lock while processing pending=0A=
 *      interrupts.=0A=
 */=0A=
static irqreturn_t mv_interrupt(int irq, void *dev_instance)=0A=
{=0A=
	struct ata_host *host =3D dev_instance;=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	unsigned int handled =3D 0;=0A=
	u32 main_irq_cause, pending_irqs;=0A=
=0A=
	spin_lock(&host->lock);=0A=
	main_irq_cause =3D readl(hpriv->main_irq_cause_addr);=0A=
	pending_irqs   =3D main_irq_cause & hpriv->main_irq_mask;=0A=
	/*=0A=
	 * Deal with cases where we either have nothing pending, or have read=0A=
	 * a bogus register value which can indicate HW removal or PCI fault.=0A=
	 */=0A=
	if (pending_irqs && main_irq_cause !=3D 0xffffffffU) {=0A=
		if (unlikely((pending_irqs & PCI_ERR) && !IS_SOC(hpriv)))=0A=
			handled =3D mv_pci_error(host, hpriv->base);=0A=
		else=0A=
			handled =3D mv_host_intr(host, pending_irqs);=0A=
	}=0A=
	spin_unlock(&host->lock);=0A=
	return IRQ_RETVAL(handled);=0A=
}=0A=
=0A=
static unsigned int mv5_scr_offset(unsigned int sc_reg_in)=0A=
{=0A=
	unsigned int ofs;=0A=
=0A=
	switch (sc_reg_in) {=0A=
	case SCR_STATUS:=0A=
	case SCR_ERROR:=0A=
	case SCR_CONTROL:=0A=
		ofs =3D sc_reg_in * sizeof(u32);=0A=
		break;=0A=
	default:=0A=
		ofs =3D 0xffffffffU;=0A=
		break;=0A=
	}=0A=
	return ofs;=0A=
}=0A=
=0A=
static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 =
*val)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	void __iomem *mmio =3D hpriv->base;=0A=
	void __iomem *addr =3D mv5_phy_base(mmio, ap->port_no);=0A=
	unsigned int ofs =3D mv5_scr_offset(sc_reg_in);=0A=
=0A=
	if (ofs !=3D 0xffffffffU) {=0A=
		*val =3D readl(addr + ofs);=0A=
		return 0;=0A=
	} else=0A=
		return -EINVAL;=0A=
}=0A=
=0A=
static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, =
u32 val)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	void __iomem *mmio =3D hpriv->base;=0A=
	void __iomem *addr =3D mv5_phy_base(mmio, ap->port_no);=0A=
	unsigned int ofs =3D mv5_scr_offset(sc_reg_in);=0A=
=0A=
	if (ofs !=3D 0xffffffffU) {=0A=
		writelfl(val, addr + ofs);=0A=
		return 0;=0A=
	} else=0A=
		return -EINVAL;=0A=
}=0A=
=0A=
static void mv5_reset_bus(struct ata_host *host, void __iomem *mmio)=0A=
{=0A=
	struct pci_dev *pdev =3D to_pci_dev(host->dev);=0A=
	int early_5080;=0A=
=0A=
	early_5080 =3D (pdev->device =3D=3D 0x5080) && (pdev->revision =3D=3D =
0);=0A=
=0A=
	if (!early_5080) {=0A=
		u32 tmp =3D readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);=0A=
		tmp |=3D (1 << 0);=0A=
		writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);=0A=
	}=0A=
=0A=
	mv_reset_pci_bus(host, mmio);=0A=
}=0A=
=0A=
static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem =
*mmio)=0A=
{=0A=
	writel(0x0fcfffff, mmio + MV_FLASH_CTL_OFS);=0A=
}=0A=
=0A=
static void mv5_read_preamp(struct mv_host_priv *hpriv, int idx,=0A=
			   void __iomem *mmio)=0A=
{=0A=
	void __iomem *phy_mmio =3D mv5_phy_base(mmio, idx);=0A=
	u32 tmp;=0A=
=0A=
	tmp =3D readl(phy_mmio + MV5_PHY_MODE);=0A=
=0A=
	hpriv->signal[idx].pre =3D tmp & 0x1800;	/* bits 12:11 */=0A=
	hpriv->signal[idx].amps =3D tmp & 0xe0;	/* bits 7:5 */=0A=
}=0A=
=0A=
static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem =
*mmio)=0A=
{=0A=
	u32 tmp;=0A=
=0A=
	writel(0, mmio + MV_GPIO_PORT_CTL_OFS);=0A=
=0A=
	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */=0A=
=0A=
	tmp =3D readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);=0A=
	tmp |=3D ~(1 << 0);=0A=
	writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);=0A=
}=0A=
=0A=
static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem =
*mmio,=0A=
			   unsigned int port)=0A=
{=0A=
	void __iomem *phy_mmio =3D mv5_phy_base(mmio, port);=0A=
	const u32 mask =3D (1<<12) | (1<<11) | (1<<7) | (1<<6) | (1<<5);=0A=
	u32 tmp;=0A=
	int fix_apm_sq =3D (hpriv->hp_flags & MV_HP_ERRATA_50XXB0);=0A=
=0A=
	if (fix_apm_sq) {=0A=
		tmp =3D readl(phy_mmio + MV5_LTMODE_OFS);=0A=
		tmp |=3D (1 << 19);=0A=
		writel(tmp, phy_mmio + MV5_LTMODE_OFS);=0A=
=0A=
		tmp =3D readl(phy_mmio + MV5_PHY_CTL_OFS);=0A=
		tmp &=3D ~0x3;=0A=
		tmp |=3D 0x1;=0A=
		writel(tmp, phy_mmio + MV5_PHY_CTL_OFS);=0A=
	}=0A=
=0A=
	tmp =3D readl(phy_mmio + MV5_PHY_MODE);=0A=
	tmp &=3D ~mask;=0A=
	tmp |=3D hpriv->signal[port].pre;=0A=
	tmp |=3D hpriv->signal[port].amps;=0A=
	writel(tmp, phy_mmio + MV5_PHY_MODE);=0A=
}=0A=
=0A=
=0A=
#undef ZERO=0A=
#define ZERO(reg) writel(0, port_mmio + (reg))=0A=
static void mv5_reset_hc_port(struct mv_host_priv *hpriv, void __iomem =
*mmio,=0A=
			     unsigned int port)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_port_base(mmio, port);=0A=
=0A=
	mv_reset_channel(hpriv, mmio, port);=0A=
=0A=
	ZERO(0x028);	/* command */=0A=
	writel(0x11f, port_mmio + EDMA_CFG_OFS);=0A=
	ZERO(0x004);	/* timer */=0A=
	ZERO(0x008);	/* irq err cause */=0A=
	ZERO(0x00c);	/* irq err mask */=0A=
	ZERO(0x010);	/* rq bah */=0A=
	ZERO(0x014);	/* rq inp */=0A=
	ZERO(0x018);	/* rq outp */=0A=
	ZERO(0x01c);	/* respq bah */=0A=
	ZERO(0x024);	/* respq outp */=0A=
	ZERO(0x020);	/* respq inp */=0A=
	ZERO(0x02c);	/* test control */=0A=
	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT_OFS);=0A=
}=0A=
#undef ZERO=0A=
=0A=
#define ZERO(reg) writel(0, hc_mmio + (reg))=0A=
static void mv5_reset_one_hc(struct mv_host_priv *hpriv, void __iomem =
*mmio,=0A=
			unsigned int hc)=0A=
{=0A=
	void __iomem *hc_mmio =3D mv_hc_base(mmio, hc);=0A=
	u32 tmp;=0A=
=0A=
	ZERO(0x00c);=0A=
	ZERO(0x010);=0A=
	ZERO(0x014);=0A=
	ZERO(0x018);=0A=
=0A=
	tmp =3D readl(hc_mmio + 0x20);=0A=
	tmp &=3D 0x1c1c1c1c;=0A=
	tmp |=3D 0x03030303;=0A=
	writel(tmp, hc_mmio + 0x20);=0A=
}=0A=
#undef ZERO=0A=
=0A=
static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,=0A=
			unsigned int n_hc)=0A=
{=0A=
	unsigned int hc, port;=0A=
=0A=
	for (hc =3D 0; hc < n_hc; hc++) {=0A=
		for (port =3D 0; port < MV_PORTS_PER_HC; port++)=0A=
			mv5_reset_hc_port(hpriv, mmio,=0A=
					  (hc * MV_PORTS_PER_HC) + port);=0A=
=0A=
		mv5_reset_one_hc(hpriv, mmio, hc);=0A=
	}=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
#undef ZERO=0A=
#define ZERO(reg) writel(0, mmio + (reg))=0A=
static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	u32 tmp;=0A=
=0A=
	tmp =3D readl(mmio + MV_PCI_MODE_OFS);=0A=
	tmp &=3D 0xff00ffff;=0A=
	writel(tmp, mmio + MV_PCI_MODE_OFS);=0A=
=0A=
	ZERO(MV_PCI_DISC_TIMER);=0A=
	ZERO(MV_PCI_MSI_TRIGGER);=0A=
	writel(0x000100ff, mmio + MV_PCI_XBAR_TMOUT_OFS);=0A=
	ZERO(MV_PCI_SERR_MASK);=0A=
	ZERO(hpriv->irq_cause_ofs);=0A=
	ZERO(hpriv->irq_mask_ofs);=0A=
	ZERO(MV_PCI_ERR_LOW_ADDRESS);=0A=
	ZERO(MV_PCI_ERR_HIGH_ADDRESS);=0A=
	ZERO(MV_PCI_ERR_ATTRIBUTE);=0A=
	ZERO(MV_PCI_ERR_COMMAND);=0A=
}=0A=
#undef ZERO=0A=
=0A=
static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem =
*mmio)=0A=
{=0A=
	u32 tmp;=0A=
=0A=
	mv5_reset_flash(hpriv, mmio);=0A=
=0A=
	tmp =3D readl(mmio + MV_GPIO_PORT_CTL_OFS);=0A=
	tmp &=3D 0x3;=0A=
	tmp |=3D (1 << 5) | (1 << 6);=0A=
	writel(tmp, mmio + MV_GPIO_PORT_CTL_OFS);=0A=
}=0A=
=0A=
/**=0A=
 *      mv6_reset_hc - Perform the 6xxx global soft reset=0A=
 *      @mmio: base address of the HBA=0A=
 *=0A=
 *      This routine only applies to 6xxx parts.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,=0A=
			unsigned int n_hc)=0A=
{=0A=
	void __iomem *reg =3D mmio + PCI_MAIN_CMD_STS_OFS;=0A=
	int i, rc =3D 0;=0A=
	u32 t;=0A=
=0A=
	/* Following procedure defined in PCI "main command and status=0A=
	 * register" table.=0A=
	 */=0A=
	t =3D readl(reg);=0A=
	writel(t | STOP_PCI_MASTER, reg);=0A=
=0A=
	for (i =3D 0; i < 1000; i++) {=0A=
		udelay(1);=0A=
		t =3D readl(reg);=0A=
		if (PCI_MASTER_EMPTY & t)=0A=
			break;=0A=
	}=0A=
	if (!(PCI_MASTER_EMPTY & t)) {=0A=
		printk(KERN_ERR DRV_NAME ": PCI master won't flush\n");=0A=
		rc =3D 1;=0A=
		goto done;=0A=
	}=0A=
=0A=
	/* set reset */=0A=
	i =3D 5;=0A=
	do {=0A=
		writel(t | GLOB_SFT_RST, reg);=0A=
		t =3D readl(reg);=0A=
		udelay(1);=0A=
	} while (!(GLOB_SFT_RST & t) && (i-- > 0));=0A=
=0A=
	if (!(GLOB_SFT_RST & t)) {=0A=
		printk(KERN_ERR DRV_NAME ": can't set global reset\n");=0A=
		rc =3D 1;=0A=
		goto done;=0A=
	}=0A=
=0A=
	/* clear reset and *reenable the PCI master* (not mentioned in spec) */=0A=
	i =3D 5;=0A=
	do {=0A=
		writel(t & ~(GLOB_SFT_RST | STOP_PCI_MASTER), reg);=0A=
		t =3D readl(reg);=0A=
		udelay(1);=0A=
	} while ((GLOB_SFT_RST & t) && (i-- > 0));=0A=
=0A=
	if (GLOB_SFT_RST & t) {=0A=
		printk(KERN_ERR DRV_NAME ": can't clear global reset\n");=0A=
		rc =3D 1;=0A=
	}=0A=
done:=0A=
	return rc;=0A=
}=0A=
=0A=
static void mv6_read_preamp(struct mv_host_priv *hpriv, int idx,=0A=
			   void __iomem *mmio)=0A=
{=0A=
	void __iomem *port_mmio;=0A=
	u32 tmp;=0A=
=0A=
	tmp =3D readl(mmio + MV_RESET_CFG_OFS);=0A=
	if ((tmp & (1 << 0)) =3D=3D 0) {=0A=
		hpriv->signal[idx].amps =3D 0x7 << 8;=0A=
		hpriv->signal[idx].pre =3D 0x1 << 5;=0A=
		return;=0A=
	}=0A=
=0A=
	port_mmio =3D mv_port_base(mmio, idx);=0A=
	tmp =3D readl(port_mmio + PHY_MODE2);=0A=
=0A=
	hpriv->signal[idx].amps =3D tmp & 0x700;	/* bits 10:8 */=0A=
	hpriv->signal[idx].pre =3D tmp & 0xe0;	/* bits 7:5 */=0A=
}=0A=
=0A=
static void mv6_enable_leds(struct mv_host_priv *hpriv, void __iomem =
*mmio)=0A=
{=0A=
	writel(0x00000060, mmio + MV_GPIO_PORT_CTL_OFS);=0A=
}=0A=
=0A=
static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem =
*mmio,=0A=
			   unsigned int port)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_port_base(mmio, port);=0A=
=0A=
	u32 hp_flags =3D hpriv->hp_flags;=0A=
	int fix_phy_mode2 =3D=0A=
		hp_flags & (MV_HP_ERRATA_60X1B2 | MV_HP_ERRATA_60X1C0);=0A=
	int fix_phy_mode4 =3D=0A=
		hp_flags & (MV_HP_ERRATA_60X1B2 | MV_HP_ERRATA_60X1C0);=0A=
	u32 m2, m3;=0A=
=0A=
	if (fix_phy_mode2) {=0A=
		m2 =3D readl(port_mmio + PHY_MODE2);=0A=
		m2 &=3D ~(1 << 16);=0A=
		m2 |=3D (1 << 31);=0A=
		writel(m2, port_mmio + PHY_MODE2);=0A=
=0A=
		udelay(200);=0A=
=0A=
		m2 =3D readl(port_mmio + PHY_MODE2);=0A=
		m2 &=3D ~((1 << 16) | (1 << 31));=0A=
		writel(m2, port_mmio + PHY_MODE2);=0A=
=0A=
		udelay(200);=0A=
	}=0A=
=0A=
	/*=0A=
	 * Gen-II/IIe PHY_MODE3 errata RM#2:=0A=
	 * Achieves better receiver noise performance than the h/w default:=0A=
	 */=0A=
	m3 =3D readl(port_mmio + PHY_MODE3);=0A=
	m3 =3D (m3 & 0x1f) | (0x5555601 << 5);=0A=
=0A=
	/* Guideline 88F5182 (GL# SATA-S11) */=0A=
	if (IS_SOC(hpriv))=0A=
		m3 &=3D ~0x1c;=0A=
=0A=
	if (fix_phy_mode4) {=0A=
		u32 m4 =3D readl(port_mmio + PHY_MODE4);=0A=
		/*=0A=
		 * Enforce reserved-bit restrictions on GenIIe devices only.=0A=
		 * For earlier chipsets, force only the internal config field=0A=
		 *  (workaround for errata FEr SATA#10 part 1).=0A=
		 */=0A=
		if (IS_GEN_IIE(hpriv))=0A=
			m4 =3D (m4 & ~PHY_MODE4_RSVD_ZEROS) | PHY_MODE4_RSVD_ONES;=0A=
		else=0A=
			m4 =3D (m4 & ~PHY_MODE4_CFG_MASK) | PHY_MODE4_CFG_VALUE;=0A=
		writel(m4, port_mmio + PHY_MODE4);=0A=
	}=0A=
	/*=0A=
	 * Workaround for 60x1-B2 errata SATA#13:=0A=
	 * Any write to PHY_MODE4 (above) may corrupt PHY_MODE3,=0A=
	 * so we must always rewrite PHY_MODE3 after PHY_MODE4.=0A=
	 */=0A=
	writel(m3, port_mmio + PHY_MODE3);=0A=
=0A=
	/* Revert values of pre-emphasis and signal amps to the saved ones */=0A=
	m2 =3D readl(port_mmio + PHY_MODE2);=0A=
=0A=
	m2 &=3D ~MV_M2_PREAMP_MASK;=0A=
	m2 |=3D hpriv->signal[port].amps;=0A=
	m2 |=3D hpriv->signal[port].pre;=0A=
	m2 &=3D ~(1 << 16);=0A=
=0A=
	/* according to mvSata 3.6.1, some IIE values are fixed */=0A=
	if (IS_GEN_IIE(hpriv)) {=0A=
		m2 &=3D ~0xC30FF01F;=0A=
		m2 |=3D 0x0000900F;=0A=
	}=0A=
=0A=
	writel(m2, port_mmio + PHY_MODE2);=0A=
}=0A=
=0A=
/* TODO: use the generic LED interface to configure the SATA Presence */=0A=
/* & Acitivy LEDs on the board */=0A=
static void mv_soc_enable_leds(struct mv_host_priv *hpriv,=0A=
				      void __iomem *mmio)=0A=
{=0A=
	return;=0A=
}=0A=
=0A=
static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,=0A=
			   void __iomem *mmio)=0A=
{=0A=
	void __iomem *port_mmio;=0A=
	u32 tmp;=0A=
=0A=
	port_mmio =3D mv_port_base(mmio, idx);=0A=
	tmp =3D readl(port_mmio + PHY_MODE2);=0A=
=0A=
	hpriv->signal[idx].amps =3D tmp & 0x700;	/* bits 10:8 */=0A=
	hpriv->signal[idx].pre =3D tmp & 0xe0;	/* bits 7:5 */=0A=
}=0A=
=0A=
#undef ZERO=0A=
#define ZERO(reg) writel(0, port_mmio + (reg))=0A=
static void mv_soc_reset_hc_port(struct mv_host_priv *hpriv,=0A=
					void __iomem *mmio, unsigned int port)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_port_base(mmio, port);=0A=
=0A=
	mv_reset_channel(hpriv, mmio, port);=0A=
=0A=
	ZERO(0x028);		/* command */=0A=
	writel(0x101f, port_mmio + EDMA_CFG_OFS);=0A=
	ZERO(0x004);		/* timer */=0A=
	ZERO(0x008);		/* irq err cause */=0A=
	ZERO(0x00c);		/* irq err mask */=0A=
	ZERO(0x010);		/* rq bah */=0A=
	ZERO(0x014);		/* rq inp */=0A=
	ZERO(0x018);		/* rq outp */=0A=
	ZERO(0x01c);		/* respq bah */=0A=
	ZERO(0x024);		/* respq outp */=0A=
	ZERO(0x020);		/* respq inp */=0A=
	ZERO(0x02c);		/* test control */=0A=
	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT_OFS);=0A=
}=0A=
=0A=
#undef ZERO=0A=
=0A=
#define ZERO(reg) writel(0, hc_mmio + (reg))=0A=
static void mv_soc_reset_one_hc(struct mv_host_priv *hpriv,=0A=
				       void __iomem *mmio)=0A=
{=0A=
	void __iomem *hc_mmio =3D mv_hc_base(mmio, 0);=0A=
=0A=
	ZERO(0x00c);=0A=
	ZERO(0x010);=0A=
	ZERO(0x014);=0A=
=0A=
}=0A=
=0A=
#undef ZERO=0A=
=0A=
static int mv_soc_reset_hc(struct mv_host_priv *hpriv,=0A=
				  void __iomem *mmio, unsigned int n_hc)=0A=
{=0A=
	unsigned int port;=0A=
=0A=
	for (port =3D 0; port < hpriv->n_ports; port++)=0A=
		mv_soc_reset_hc_port(hpriv, mmio, port);=0A=
=0A=
	mv_soc_reset_one_hc(hpriv, mmio);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static void mv_soc_reset_flash(struct mv_host_priv *hpriv,=0A=
				      void __iomem *mmio)=0A=
{=0A=
	return;=0A=
}=0A=
=0A=
static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio)=0A=
{=0A=
	return;=0A=
}=0A=
=0A=
static void mv_setup_ifcfg(void __iomem *port_mmio, int want_gen2i)=0A=
{=0A=
	u32 ifcfg =3D readl(port_mmio + SATA_INTERFACE_CFG_OFS);=0A=
=0A=
	ifcfg =3D (ifcfg & 0xf7f) | 0x9b1000;	/* from chip spec */=0A=
	if (want_gen2i)=0A=
		ifcfg |=3D (1 << 7);		/* enable gen2i speed */=0A=
	writelfl(ifcfg, port_mmio + SATA_INTERFACE_CFG_OFS);=0A=
}=0A=
=0A=
static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem =
*mmio,=0A=
			     unsigned int port_no)=0A=
{=0A=
	void __iomem *port_mmio =3D mv_port_base(mmio, port_no);=0A=
=0A=
	/*=0A=
	 * The datasheet warns against setting EDMA_RESET when EDMA is active=0A=
	 * (but doesn't say what the problem might be).  So we first try=0A=
	 * to disable the EDMA engine before doing the EDMA_RESET operation.=0A=
	 */=0A=
	mv_stop_edma_engine(port_mmio);=0A=
	writelfl(EDMA_RESET, port_mmio + EDMA_CMD_OFS);=0A=
=0A=
	if (!IS_GEN_I(hpriv)) {=0A=
		/* Enable 3.0gb/s link speed: this survives EDMA_RESET */=0A=
		mv_setup_ifcfg(port_mmio, 1);=0A=
	}=0A=
	/*=0A=
	 * Strobing EDMA_RESET here causes a hard reset of the SATA transport,=0A=
	 * link, and physical layers.  It resets all SATA interface registers=0A=
	 * (except for SATA_INTERFACE_CFG), and issues a COMRESET to the dev.=0A=
	 */=0A=
	writelfl(EDMA_RESET, port_mmio + EDMA_CMD_OFS);=0A=
	udelay(25);	/* allow reset propagation */=0A=
	writelfl(0, port_mmio + EDMA_CMD_OFS);=0A=
=0A=
	hpriv->ops->phy_errata(hpriv, mmio, port_no);=0A=
=0A=
	if (IS_GEN_I(hpriv))=0A=
		mdelay(1);=0A=
}=0A=
=0A=
static void mv_pmp_select(struct ata_port *ap, int pmp)=0A=
{=0A=
	if (sata_pmp_supported(ap)) {=0A=
		void __iomem *port_mmio =3D mv_ap_base(ap);=0A=
		u32 reg =3D readl(port_mmio + SATA_IFCTL_OFS);=0A=
		int old =3D reg & 0xf;=0A=
=0A=
		if (old !=3D pmp) {=0A=
			reg =3D (reg & ~0xf) | pmp;=0A=
			writelfl(reg, port_mmio + SATA_IFCTL_OFS);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
static int mv_pmp_hardreset(struct ata_link *link, unsigned int *class,=0A=
				unsigned long deadline)=0A=
{=0A=
	mv_pmp_select(link->ap, sata_srst_pmp(link));=0A=
	return sata_std_hardreset(link, class, deadline);=0A=
}=0A=
=0A=
static int mv_softreset(struct ata_link *link, unsigned int *class,=0A=
				unsigned long deadline)=0A=
{=0A=
	mv_pmp_select(link->ap, sata_srst_pmp(link));=0A=
	return ata_sff_softreset(link, class, deadline);=0A=
}=0A=
=0A=
static int mv_hardreset(struct ata_link *link, unsigned int *class,=0A=
			unsigned long deadline)=0A=
{=0A=
	struct ata_port *ap =3D link->ap;=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	struct mv_port_priv *pp =3D ap->private_data;=0A=
	void __iomem *mmio =3D hpriv->base;=0A=
	int rc, attempts =3D 0, extra =3D 0;=0A=
	u32 sstatus;=0A=
	bool online;=0A=
=0A=
	mv_reset_channel(hpriv, mmio, ap->port_no);=0A=
	pp->pp_flags &=3D ~MV_PP_FLAG_EDMA_EN;=0A=
=0A=
	/* Workaround for errata FEr SATA#10 (part 2) */=0A=
	do {=0A=
		const unsigned long *timing =3D=0A=
				sata_ehc_deb_timing(&link->eh_context);=0A=
=0A=
		rc =3D sata_link_hardreset(link, timing, deadline + extra,=0A=
					 &online, NULL);=0A=
		rc =3D online ? -EAGAIN : rc;=0A=
		if (rc)=0A=
			return rc;=0A=
		sata_scr_read(link, SCR_STATUS, &sstatus);=0A=
		if (!IS_GEN_I(hpriv) && ++attempts >=3D 5 && sstatus =3D=3D 0x121) {=0A=
			/* Force 1.5gb/s link speed and try again */=0A=
			mv_setup_ifcfg(mv_ap_base(ap), 0);=0A=
			if (time_after(jiffies + HZ, deadline))=0A=
				extra =3D HZ; /* only extend it once, max */=0A=
		}=0A=
	} while (sstatus !=3D 0x0 && sstatus !=3D 0x113 && sstatus !=3D 0x123);=0A=
=0A=
	return rc;=0A=
}=0A=
=0A=
static void mv_eh_freeze(struct ata_port *ap)=0A=
{=0A=
	mv_stop_edma(ap);=0A=
	mv_enable_port_irqs(ap, 0);=0A=
}=0A=
=0A=
static void mv_eh_thaw(struct ata_port *ap)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D ap->host->private_data;=0A=
	unsigned int port =3D ap->port_no;=0A=
	unsigned int hardport =3D mv_hardport_from_port(port);=0A=
	void __iomem *hc_mmio =3D mv_hc_base_from_port(hpriv->base, port);=0A=
	void __iomem *port_mmio =3D mv_ap_base(ap);=0A=
	u32 hc_irq_cause;=0A=
=0A=
	/* clear EDMA errors on this port */=0A=
	writel(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);=0A=
=0A=
	/* clear pending irq events */=0A=
	hc_irq_cause =3D readl(hc_mmio + HC_IRQ_CAUSE_OFS);=0A=
	hc_irq_cause &=3D ~((DEV_IRQ | DMA_IRQ) << hardport);=0A=
	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);=0A=
=0A=
	mv_enable_port_irqs(ap, ERR_IRQ);=0A=
}=0A=
=0A=
/**=0A=
 *      mv_port_init - Perform some early initialization on a single =
port.=0A=
 *      @port: libata data structure storing shadow register addresses=0A=
 *      @port_mmio: base address of the port=0A=
 *=0A=
 *      Initialize shadow register mmio addresses, clear outstanding=0A=
 *      interrupts on the port, and unmask interrupts for the future=0A=
 *      start of the port.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static void mv_port_init(struct ata_ioports *port,  void __iomem =
*port_mmio)=0A=
{=0A=
	void __iomem *shd_base =3D port_mmio + SHD_BLK_OFS;=0A=
	unsigned serr_ofs;=0A=
=0A=
	/* PIO related setup=0A=
	 */=0A=
	port->data_addr =3D shd_base + (sizeof(u32) * ATA_REG_DATA);=0A=
	port->error_addr =3D=0A=
		port->feature_addr =3D shd_base + (sizeof(u32) * ATA_REG_ERR);=0A=
	port->nsect_addr =3D shd_base + (sizeof(u32) * ATA_REG_NSECT);=0A=
	port->lbal_addr =3D shd_base + (sizeof(u32) * ATA_REG_LBAL);=0A=
	port->lbam_addr =3D shd_base + (sizeof(u32) * ATA_REG_LBAM);=0A=
	port->lbah_addr =3D shd_base + (sizeof(u32) * ATA_REG_LBAH);=0A=
	port->device_addr =3D shd_base + (sizeof(u32) * ATA_REG_DEVICE);=0A=
	port->status_addr =3D=0A=
		port->command_addr =3D shd_base + (sizeof(u32) * ATA_REG_STATUS);=0A=
	/* special case: control/altstatus doesn't have ATA_REG_ address */=0A=
	port->altstatus_addr =3D port->ctl_addr =3D shd_base + SHD_CTL_AST_OFS;=0A=
=0A=
	/* unused: */=0A=
	port->cmd_addr =3D port->bmdma_addr =3D port->scr_addr =3D NULL;=0A=
=0A=
	/* Clear any currently outstanding port interrupt conditions */=0A=
	serr_ofs =3D mv_scr_offset(SCR_ERROR);=0A=
	writelfl(readl(port_mmio + serr_ofs), port_mmio + serr_ofs);=0A=
	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);=0A=
=0A=
	/* unmask all non-transient EDMA error interrupts */=0A=
	writelfl(~EDMA_ERR_IRQ_TRANSIENT, port_mmio + EDMA_ERR_IRQ_MASK_OFS);=0A=
=0A=
	VPRINTK("EDMA cfg=3D0x%08x EDMA IRQ err cause/mask=3D0x%08x/0x%08x\n",=0A=
		readl(port_mmio + EDMA_CFG_OFS),=0A=
		readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS),=0A=
		readl(port_mmio + EDMA_ERR_IRQ_MASK_OFS));=0A=
}=0A=
=0A=
static unsigned int mv_in_pcix_mode(struct ata_host *host)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	void __iomem *mmio =3D hpriv->base;=0A=
	u32 reg;=0A=
=0A=
	if (IS_SOC(hpriv) || !IS_PCIE(hpriv))=0A=
		return 0;	/* not PCI-X capable */=0A=
	reg =3D readl(mmio + MV_PCI_MODE_OFS);=0A=
	if ((reg & MV_PCI_MODE_MASK) =3D=3D 0)=0A=
		return 0;	/* conventional PCI mode */=0A=
	return 1;	/* chip is in PCI-X mode */=0A=
}=0A=
=0A=
static int mv_pci_cut_through_okay(struct ata_host *host)=0A=
{=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	void __iomem *mmio =3D hpriv->base;=0A=
	u32 reg;=0A=
=0A=
	if (!mv_in_pcix_mode(host)) {=0A=
		reg =3D readl(mmio + PCI_COMMAND_OFS);=0A=
		if (reg & PCI_COMMAND_MRDTRIG)=0A=
			return 0; /* not okay */=0A=
	}=0A=
	return 1; /* okay */=0A=
}=0A=
=0A=
static int mv_chip_id(struct ata_host *host, unsigned int board_idx)=0A=
{=0A=
	struct pci_dev *pdev =3D to_pci_dev(host->dev);=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	u32 hp_flags =3D hpriv->hp_flags;=0A=
=0A=
	switch (board_idx) {=0A=
	case chip_5080:=0A=
		hpriv->ops =3D &mv5xxx_ops;=0A=
		hp_flags |=3D MV_HP_GEN_I;=0A=
=0A=
		switch (pdev->revision) {=0A=
		case 0x1:=0A=
			hp_flags |=3D MV_HP_ERRATA_50XXB0;=0A=
			break;=0A=
		case 0x3:=0A=
			hp_flags |=3D MV_HP_ERRATA_50XXB2;=0A=
			break;=0A=
		default:=0A=
			dev_printk(KERN_WARNING, &pdev->dev,=0A=
			   "Applying 50XXB2 workarounds to unknown rev\n");=0A=
			hp_flags |=3D MV_HP_ERRATA_50XXB2;=0A=
			break;=0A=
		}=0A=
		break;=0A=
=0A=
	case chip_504x:=0A=
	case chip_508x:=0A=
		hpriv->ops =3D &mv5xxx_ops;=0A=
		hp_flags |=3D MV_HP_GEN_I;=0A=
=0A=
		switch (pdev->revision) {=0A=
		case 0x0:=0A=
			hp_flags |=3D MV_HP_ERRATA_50XXB0;=0A=
			break;=0A=
		case 0x3:=0A=
			hp_flags |=3D MV_HP_ERRATA_50XXB2;=0A=
			break;=0A=
		default:=0A=
			dev_printk(KERN_WARNING, &pdev->dev,=0A=
			   "Applying B2 workarounds to unknown rev\n");=0A=
			hp_flags |=3D MV_HP_ERRATA_50XXB2;=0A=
			break;=0A=
		}=0A=
		break;=0A=
=0A=
	case chip_604x:=0A=
	case chip_608x:=0A=
		hpriv->ops =3D &mv6xxx_ops;=0A=
		hp_flags |=3D MV_HP_GEN_II;=0A=
=0A=
		switch (pdev->revision) {=0A=
		case 0x7:=0A=
			hp_flags |=3D MV_HP_ERRATA_60X1B2;=0A=
			break;=0A=
		case 0x9:=0A=
			hp_flags |=3D MV_HP_ERRATA_60X1C0;=0A=
			break;=0A=
		default:=0A=
			dev_printk(KERN_WARNING, &pdev->dev,=0A=
				   "Applying B2 workarounds to unknown rev\n");=0A=
			hp_flags |=3D MV_HP_ERRATA_60X1B2;=0A=
			break;=0A=
		}=0A=
		break;=0A=
=0A=
	case chip_7042:=0A=
		hp_flags |=3D MV_HP_PCIE | MV_HP_CUT_THROUGH;=0A=
		if (pdev->vendor =3D=3D PCI_VENDOR_ID_TTI &&=0A=
		    (pdev->device =3D=3D 0x2300 || pdev->device =3D=3D 0x2310))=0A=
		{=0A=
			/*=0A=
			 * Highpoint RocketRAID PCIe 23xx series cards:=0A=
			 *=0A=
			 * Unconfigured drives are treated as "Legacy"=0A=
			 * by the BIOS, and it overwrites sector 8 with=0A=
			 * a "Lgcy" metadata block prior to Linux boot.=0A=
			 *=0A=
			 * Configured drives (RAID or JBOD) leave sector 8=0A=
			 * alone, but instead overwrite a high numbered=0A=
			 * sector for the RAID metadata.  This sector can=0A=
			 * be determined exactly, by truncating the physical=0A=
			 * drive capacity to a nice even GB value.=0A=
			 *=0A=
			 * RAID metadata is at: (dev->n_sectors & ~0xfffff)=0A=
			 *=0A=
			 * Warn the user, lest they think we're just buggy.=0A=
			 */=0A=
			printk(KERN_WARNING DRV_NAME ": Highpoint RocketRAID"=0A=
				" BIOS CORRUPTS DATA on all attached drives,"=0A=
				" regardless of if/how they are configured."=0A=
				" BEWARE!\n");=0A=
			printk(KERN_WARNING DRV_NAME ": For data safety, do not"=0A=
				" use sectors 8-9 on \"Legacy\" drives,"=0A=
				" and avoid the final two gigabytes on"=0A=
				" all RocketRAID BIOS initialized drives.\n");=0A=
		}=0A=
		/* drop through */=0A=
	case chip_6042:=0A=
		hpriv->ops =3D &mv6xxx_ops;=0A=
		hp_flags |=3D MV_HP_GEN_IIE;=0A=
		if (board_idx =3D=3D chip_6042 && mv_pci_cut_through_okay(host))=0A=
			hp_flags |=3D MV_HP_CUT_THROUGH;=0A=
=0A=
		switch (pdev->revision) {=0A=
		case 0x2: /* Rev.B0: the first/only public release */=0A=
			hp_flags |=3D MV_HP_ERRATA_60X1C0;=0A=
			break;=0A=
		default:=0A=
			dev_printk(KERN_WARNING, &pdev->dev,=0A=
			   "Applying 60X1C0 workarounds to unknown rev\n");=0A=
			hp_flags |=3D MV_HP_ERRATA_60X1C0;=0A=
			break;=0A=
		}=0A=
		break;=0A=
	case chip_soc:=0A=
		hpriv->ops =3D &mv_soc_ops;=0A=
		hp_flags |=3D MV_HP_FLAG_SOC | MV_HP_ERRATA_60X1C0;=0A=
		break;=0A=
=0A=
	default:=0A=
		dev_printk(KERN_ERR, host->dev,=0A=
			   "BUG: invalid board index %u\n", board_idx);=0A=
		return 1;=0A=
	}=0A=
=0A=
	hpriv->hp_flags =3D hp_flags;=0A=
	if (hp_flags & MV_HP_PCIE) {=0A=
		hpriv->irq_cause_ofs	=3D PCIE_IRQ_CAUSE_OFS;=0A=
		hpriv->irq_mask_ofs	=3D PCIE_IRQ_MASK_OFS;=0A=
		hpriv->unmask_all_irqs	=3D PCIE_UNMASK_ALL_IRQS;=0A=
	} else {=0A=
		hpriv->irq_cause_ofs	=3D PCI_IRQ_CAUSE_OFS;=0A=
		hpriv->irq_mask_ofs	=3D PCI_IRQ_MASK_OFS;=0A=
		hpriv->unmask_all_irqs	=3D PCI_UNMASK_ALL_IRQS;=0A=
	}=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
/**=0A=
 *      mv_init_host - Perform some early initialization of the host.=0A=
 *	@host: ATA host to initialize=0A=
 *      @board_idx: controller index=0A=
 *=0A=
 *      If possible, do an early global reset of the host.  Then do=0A=
 *      our port init and clear/unmask all/relevant host interrupts.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static int mv_init_host(struct ata_host *host, unsigned int board_idx)=0A=
{=0A=
	int rc =3D 0, n_hc, port, hc;=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	void __iomem *mmio =3D hpriv->base;=0A=
=0A=
	rc =3D mv_chip_id(host, board_idx);=0A=
	if (rc)=0A=
		goto done;=0A=
=0A=
	if (IS_SOC(hpriv)) {=0A=
		hpriv->main_irq_cause_addr =3D mmio + SOC_HC_MAIN_IRQ_CAUSE_OFS;=0A=
		hpriv->main_irq_mask_addr  =3D mmio + SOC_HC_MAIN_IRQ_MASK_OFS;=0A=
	} else {=0A=
		hpriv->main_irq_cause_addr =3D mmio + PCI_HC_MAIN_IRQ_CAUSE_OFS;=0A=
		hpriv->main_irq_mask_addr  =3D mmio + PCI_HC_MAIN_IRQ_MASK_OFS;=0A=
	}=0A=
=0A=
	/* global interrupt mask: 0 =3D=3D mask everything */=0A=
	mv_set_main_irq_mask(host, ~0, 0);=0A=
=0A=
	n_hc =3D mv_get_hc_count(host->ports[0]->flags);=0A=
=0A=
	for (port =3D 0; port < host->n_ports; port++)=0A=
		hpriv->ops->read_preamp(hpriv, port, mmio);=0A=
=0A=
	rc =3D hpriv->ops->reset_hc(hpriv, mmio, n_hc);=0A=
	if (rc)=0A=
		goto done;=0A=
=0A=
	hpriv->ops->reset_flash(hpriv, mmio);=0A=
	hpriv->ops->reset_bus(host, mmio);=0A=
	hpriv->ops->enable_leds(hpriv, mmio);=0A=
=0A=
	for (port =3D 0; port < host->n_ports; port++) {=0A=
		struct ata_port *ap =3D host->ports[port];=0A=
		void __iomem *port_mmio =3D mv_port_base(mmio, port);=0A=
=0A=
		mv_port_init(&ap->ioaddr, port_mmio);=0A=
=0A=
#ifdef CONFIG_PCI=0A=
		if (!IS_SOC(hpriv)) {=0A=
			unsigned int offset =3D port_mmio - mmio;=0A=
			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");=0A=
			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");=0A=
		}=0A=
#endif=0A=
	}=0A=
=0A=
	for (hc =3D 0; hc < n_hc; hc++) {=0A=
		void __iomem *hc_mmio =3D mv_hc_base(mmio, hc);=0A=
=0A=
		VPRINTK("HC%i: HC config=3D0x%08x HC IRQ cause "=0A=
			"(before clear)=3D0x%08x\n", hc,=0A=
			readl(hc_mmio + HC_CFG_OFS),=0A=
			readl(hc_mmio + HC_IRQ_CAUSE_OFS));=0A=
=0A=
		/* Clear any currently outstanding hc interrupt conditions */=0A=
		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);=0A=
	}=0A=
=0A=
	if (!IS_SOC(hpriv)) {=0A=
		/* Clear any currently outstanding host interrupt conditions */=0A=
		writelfl(0, mmio + hpriv->irq_cause_ofs);=0A=
=0A=
		/* and unmask interrupt generation for host regs */=0A=
		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);=0A=
=0A=
		/*=0A=
		 * enable only global host interrupts for now.=0A=
		 * The per-port interrupts get done later as ports are set up.=0A=
		 */=0A=
		mv_set_main_irq_mask(host, 0, PCI_ERR);=0A=
	}=0A=
done:=0A=
	return rc;=0A=
}=0A=
=0A=
static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device =
*dev)=0A=
{=0A=
	hpriv->crqb_pool   =3D dmam_pool_create("crqb_q", dev, MV_CRQB_Q_SZ,=0A=
							     MV_CRQB_Q_SZ, 0);=0A=
	if (!hpriv->crqb_pool)=0A=
		return -ENOMEM;=0A=
=0A=
	hpriv->crpb_pool   =3D dmam_pool_create("crpb_q", dev, MV_CRPB_Q_SZ,=0A=
							     MV_CRPB_Q_SZ, 0);=0A=
	if (!hpriv->crpb_pool)=0A=
		return -ENOMEM;=0A=
=0A=
	hpriv->sg_tbl_pool =3D dmam_pool_create("sg_tbl", dev, MV_SG_TBL_SZ,=0A=
							     MV_SG_TBL_SZ, 0);=0A=
	if (!hpriv->sg_tbl_pool)=0A=
		return -ENOMEM;=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static void mv_conf_mbus_windows(struct mv_host_priv *hpriv,=0A=
				 struct mbus_dram_target_info *dram)=0A=
{=0A=
	int i;=0A=
=0A=
	for (i =3D 0; i < 4; i++) {=0A=
		writel(0, hpriv->base + WINDOW_CTRL(i));=0A=
		writel(0, hpriv->base + WINDOW_BASE(i));=0A=
	}=0A=
=0A=
	for (i =3D 0; i < dram->num_cs; i++) {=0A=
		struct mbus_dram_window *cs =3D dram->cs + i;=0A=
=0A=
		writel(((cs->size - 1) & 0xffff0000) |=0A=
			(cs->mbus_attr << 8) |=0A=
			(dram->mbus_dram_target_id << 4) | 1,=0A=
			hpriv->base + WINDOW_CTRL(i));=0A=
		writel(cs->base, hpriv->base + WINDOW_BASE(i));=0A=
	}=0A=
}=0A=
=0A=
/**=0A=
 *      mv_platform_probe - handle a positive probe of an soc Marvell=0A=
 *      host=0A=
 *      @pdev: platform device found=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static int mv_platform_probe(struct platform_device *pdev)=0A=
{=0A=
	static int printed_version;=0A=
	const struct mv_sata_platform_data *mv_platform_data;=0A=
	const struct ata_port_info *ppi[] =3D=0A=
	    { &mv_port_info[chip_soc], NULL };=0A=
	struct ata_host *host;=0A=
	struct mv_host_priv *hpriv;=0A=
	struct resource *res;=0A=
	int n_ports, rc;=0A=
=0A=
	if (!printed_version++)=0A=
		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");=0A=
=0A=
	/*=0A=
	 * Simple resource validation ..=0A=
	 */=0A=
	if (unlikely(pdev->num_resources !=3D 2)) {=0A=
		dev_err(&pdev->dev, "invalid number of resources\n");=0A=
		return -EINVAL;=0A=
	}=0A=
=0A=
	/*=0A=
	 * Get the register base first=0A=
	 */=0A=
	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);=0A=
	if (res =3D=3D NULL)=0A=
		return -EINVAL;=0A=
=0A=
	/* allocate host */=0A=
	mv_platform_data =3D pdev->dev.platform_data;=0A=
	n_ports =3D mv_platform_data->n_ports;=0A=
=0A=
	host =3D ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);=0A=
	hpriv =3D devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);=0A=
=0A=
	if (!host || !hpriv)=0A=
		return -ENOMEM;=0A=
	host->private_data =3D hpriv;=0A=
	hpriv->n_ports =3D n_ports;=0A=
=0A=
	host->iomap =3D NULL;=0A=
	hpriv->base =3D devm_ioremap(&pdev->dev, res->start,=0A=
				   res->end - res->start + 1);=0A=
	hpriv->base -=3D MV_SATAHC0_REG_BASE;=0A=
=0A=
	/*=0A=
	 * (Re-)program MBUS remapping windows if we are asked to.=0A=
	 */=0A=
	if (mv_platform_data->dram !=3D NULL)=0A=
		mv_conf_mbus_windows(hpriv, mv_platform_data->dram);=0A=
=0A=
	rc =3D mv_create_dma_pools(hpriv, &pdev->dev);=0A=
	if (rc)=0A=
		return rc;=0A=
=0A=
	/* initialize adapter */=0A=
	rc =3D mv_init_host(host, chip_soc);=0A=
	if (rc)=0A=
		return rc;=0A=
=0A=
	dev_printk(KERN_INFO, &pdev->dev,=0A=
		   "slots %u ports %d\n", (unsigned)MV_MAX_Q_DEPTH,=0A=
		   host->n_ports);=0A=
=0A=
	return ata_host_activate(host, platform_get_irq(pdev, 0), mv_interrupt,=0A=
				 IRQF_SHARED, &mv6_sht);=0A=
}=0A=
=0A=
/*=0A=
 *=0A=
 *      mv_platform_remove    -       unplug a platform interface=0A=
 *      @pdev: platform device=0A=
 *=0A=
 *      A platform bus SATA device has been unplugged. Perform the needed=0A=
 *      cleanup. Also called on module unload for any active devices.=0A=
 */=0A=
static int __devexit mv_platform_remove(struct platform_device *pdev)=0A=
{=0A=
	struct device *dev =3D &pdev->dev;=0A=
	struct ata_host *host =3D dev_get_drvdata(dev);=0A=
=0A=
	ata_host_detach(host);=0A=
	return 0;=0A=
}=0A=
=0A=
static struct platform_driver mv_platform_driver =3D {=0A=
	.probe			=3D mv_platform_probe,=0A=
	.remove			=3D __devexit_p(mv_platform_remove),=0A=
	.driver			=3D {=0A=
				   .name =3D DRV_NAME,=0A=
				   .owner =3D THIS_MODULE,=0A=
				  },=0A=
};=0A=
=0A=
=0A=
#ifdef CONFIG_PCI=0A=
static int mv_pci_init_one(struct pci_dev *pdev,=0A=
			   const struct pci_device_id *ent);=0A=
=0A=
=0A=
static struct pci_driver mv_pci_driver =3D {=0A=
	.name			=3D DRV_NAME,=0A=
	.id_table		=3D mv_pci_tbl,=0A=
	.probe			=3D mv_pci_init_one,=0A=
	.remove			=3D ata_pci_remove_one,=0A=
};=0A=
=0A=
/*=0A=
 * module options=0A=
 */=0A=
static int msi;	      /* Use PCI msi; either zero (off, default) or =
non-zero */=0A=
=0A=
=0A=
/* move to PCI layer or libata core? */=0A=
static int pci_go_64(struct pci_dev *pdev)=0A=
{=0A=
	int rc;=0A=
=0A=
	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {=0A=
		rc =3D pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);=0A=
		if (rc) {=0A=
			rc =3D pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);=0A=
			if (rc) {=0A=
				dev_printk(KERN_ERR, &pdev->dev,=0A=
					   "64-bit DMA enable failed\n");=0A=
				return rc;=0A=
			}=0A=
		}=0A=
	} else {=0A=
		rc =3D pci_set_dma_mask(pdev, DMA_32BIT_MASK);=0A=
		if (rc) {=0A=
			dev_printk(KERN_ERR, &pdev->dev,=0A=
				   "32-bit DMA enable failed\n");=0A=
			return rc;=0A=
		}=0A=
		rc =3D pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);=0A=
		if (rc) {=0A=
			dev_printk(KERN_ERR, &pdev->dev,=0A=
				   "32-bit consistent DMA enable failed\n");=0A=
			return rc;=0A=
		}=0A=
	}=0A=
=0A=
	return rc;=0A=
}=0A=
=0A=
/**=0A=
 *      mv_print_info - Dump key info to kernel log for perusal.=0A=
 *      @host: ATA host to print info about=0A=
 *=0A=
 *      FIXME: complete this.=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static void mv_print_info(struct ata_host *host)=0A=
{=0A=
	struct pci_dev *pdev =3D to_pci_dev(host->dev);=0A=
	struct mv_host_priv *hpriv =3D host->private_data;=0A=
	u8 scc;=0A=
	const char *scc_s, *gen;=0A=
=0A=
	/* Use this to determine the HW stepping of the chip so we know=0A=
	 * what errata to workaround=0A=
	 */=0A=
	pci_read_config_byte(pdev, PCI_CLASS_DEVICE, &scc);=0A=
	if (scc =3D=3D 0)=0A=
		scc_s =3D "SCSI";=0A=
	else if (scc =3D=3D 0x01)=0A=
		scc_s =3D "RAID";=0A=
	else=0A=
		scc_s =3D "?";=0A=
=0A=
	if (IS_GEN_I(hpriv))=0A=
		gen =3D "I";=0A=
	else if (IS_GEN_II(hpriv))=0A=
		gen =3D "II";=0A=
	else if (IS_GEN_IIE(hpriv))=0A=
		gen =3D "IIE";=0A=
	else=0A=
		gen =3D "?";=0A=
=0A=
	dev_printk(KERN_INFO, &pdev->dev,=0A=
	       "Gen-%s %u slots %u ports %s mode IRQ via %s\n",=0A=
	       gen, (unsigned)MV_MAX_Q_DEPTH, host->n_ports,=0A=
	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");=0A=
}=0A=
=0A=
/**=0A=
 *      mv_pci_init_one - handle a positive probe of a PCI Marvell host=0A=
 *      @pdev: PCI device found=0A=
 *      @ent: PCI device ID entry for the matched host=0A=
 *=0A=
 *      LOCKING:=0A=
 *      Inherited from caller.=0A=
 */=0A=
static int mv_pci_init_one(struct pci_dev *pdev,=0A=
			   const struct pci_device_id *ent)=0A=
{=0A=
	static int printed_version;=0A=
	unsigned int board_idx =3D (unsigned int)ent->driver_data;=0A=
	const struct ata_port_info *ppi[] =3D { &mv_port_info[board_idx], NULL =
};=0A=
	struct ata_host *host;=0A=
	struct mv_host_priv *hpriv;=0A=
	int n_ports, rc;=0A=
=0A=
	if (!printed_version++)=0A=
		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");=0A=
=0A=
	/* allocate host */=0A=
	n_ports =3D mv_get_hc_count(ppi[0]->flags) * MV_PORTS_PER_HC;=0A=
=0A=
	host =3D ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);=0A=
	hpriv =3D devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);=0A=
	if (!host || !hpriv)=0A=
		return -ENOMEM;=0A=
	host->private_data =3D hpriv;=0A=
	hpriv->n_ports =3D n_ports;=0A=
=0A=
	/* acquire resources */=0A=
	rc =3D pcim_enable_device(pdev);=0A=
	if (rc)=0A=
		return rc;=0A=
=0A=
	rc =3D pcim_iomap_regions(pdev, 1 << MV_PRIMARY_BAR, DRV_NAME);=0A=
	if (rc =3D=3D -EBUSY)=0A=
		pcim_pin_device(pdev);=0A=
	if (rc)=0A=
		return rc;=0A=
	host->iomap =3D pcim_iomap_table(pdev);=0A=
	hpriv->base =3D host->iomap[MV_PRIMARY_BAR];=0A=
=0A=
	rc =3D pci_go_64(pdev);=0A=
	if (rc)=0A=
		return rc;=0A=
=0A=
	rc =3D mv_create_dma_pools(hpriv, &pdev->dev);=0A=
	if (rc)=0A=
		return rc;=0A=
=0A=
	/* initialize adapter */=0A=
	rc =3D mv_init_host(host, board_idx);=0A=
	if (rc)=0A=
		return rc;=0A=
=0A=
	/* Enable interrupts */=0A=
	if (msi && pci_enable_msi(pdev))=0A=
		pci_intx(pdev, 1);=0A=
=0A=
	mv_dump_pci_cfg(pdev, 0x68);=0A=
	mv_print_info(host);=0A=
=0A=
	pci_set_master(pdev);=0A=
	pci_try_set_mwi(pdev);=0A=
	return ata_host_activate(host, pdev->irq, mv_interrupt, IRQF_SHARED,=0A=
				 IS_GEN_I(hpriv) ? &mv5_sht : &mv6_sht);=0A=
}=0A=
#endif=0A=
=0A=
static int mv_platform_probe(struct platform_device *pdev);=0A=
static int __devexit mv_platform_remove(struct platform_device *pdev);=0A=
=0A=
static int __init mv_init(void)=0A=
{=0A=
	int rc =3D -ENODEV;=0A=
#ifdef CONFIG_PCI=0A=
	rc =3D pci_register_driver(&mv_pci_driver);=0A=
	if (rc < 0)=0A=
		return rc;=0A=
#endif=0A=
	rc =3D platform_driver_register(&mv_platform_driver);=0A=
=0A=
#ifdef CONFIG_PCI=0A=
	if (rc < 0)=0A=
		pci_unregister_driver(&mv_pci_driver);=0A=
#endif=0A=
	return rc;=0A=
}=0A=
=0A=
static void __exit mv_exit(void)=0A=
{=0A=
#ifdef CONFIG_PCI=0A=
	pci_unregister_driver(&mv_pci_driver);=0A=
#endif=0A=
	platform_driver_unregister(&mv_platform_driver);=0A=
}=0A=
=0A=
MODULE_AUTHOR("Brett Russ");=0A=
MODULE_DESCRIPTION("SCSI low-level driver for Marvell SATA controllers");=0A=
MODULE_LICENSE("GPL");=0A=
MODULE_DEVICE_TABLE(pci, mv_pci_tbl);=0A=
MODULE_VERSION(DRV_VERSION);=0A=
MODULE_ALIAS("platform:" DRV_NAME);=0A=
=0A=
#ifdef CONFIG_PCI=0A=
module_param(msi, int, 0444);=0A=
MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=3Doff, 1=3Don)");=0A=
#endif=0A=
=0A=
module_init(mv_init);=0A=
module_exit(mv_exit);=0A=

------=_NextPart_000_003B_01C8F0DF.072704B0--

