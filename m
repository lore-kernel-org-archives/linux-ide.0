From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata queued updated yet again
Date: Fri, 15 Oct 2004 03:06:40 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041015070639.GA5807@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:55965 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266252AbUJOHGl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Oct 2004 03:06:41 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Added a couple patches from Bart, and included the patch inline.

The patch is also available at
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-rc4-=
libata2.patch.bz2
(as soon as the robot gets around to updating, at least)

BK users:

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/Kconfig       |    8 +
 drivers/scsi/Makefile      |    1=20
 drivers/scsi/ata_piix.c    |   26 ++--
 drivers/scsi/libata-core.c |    8 +
 drivers/scsi/libata-scsi.c |    2=20
 drivers/scsi/sata_nv.c     |   38 +++---
 drivers/scsi/sata_uli.c    |  282 ++++++++++++++++++++++++++++++++++++=
+++++++++
 include/linux/libata.h     |    2=20
 8 files changed, 334 insertions(+), 33 deletions(-)

through these ChangeSets:

Bartlomiej Zolnierkiewicz:
  o [libata piix] Fix PATA UDMA masks
  o [libata] do not memset() SCSI request buf in a get-reference style =
function
  o libata: PCI IDE legacy mode fix

=46ran=E7ois Romieu:
  o sata_nv: housekeeping for goto labels
  o sata_nv: wrong failure path and leak
  o sata_nv: enable hotplug event on successfull init only

Jeff Garzik:
  o [libata sata_uli] add dev_select hook
  o [libata] add sata_uli driver for ULi (formerly ALi) SATA

diff -Nru a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/Kconfig	2004-10-15 03:02:43 -04:00
@@ -465,6 +465,14 @@
=20
 	  If unsure, say N.
=20
+config SCSI_SATA_ULI
+	tristate "ULi Electronics SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for ULi Electronics SATA.
+
+	  If unsure, say N.
+
 config SCSI_SATA_VIA
 	tristate "VIA SATA support"
 	depends on SCSI_SATA && PCI && EXPERIMENTAL
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/Makefile	2004-10-15 03:02:43 -04:00
@@ -130,6 +130,7 @@
 obj-$(CONFIG_SCSI_SATA_SIS)	+=3D libata.o sata_sis.o
 obj-$(CONFIG_SCSI_SATA_SX4)	+=3D libata.o sata_sx4.o
 obj-$(CONFIG_SCSI_SATA_NV)	+=3D libata.o sata_nv.o
+obj-$(CONFIG_SCSI_SATA_ULI)	+=3D libata.o sata_uli.o
=20
 obj-$(CONFIG_ARM)		+=3D arm/
=20
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-10-15 03:02:43 -04:00
@@ -184,7 +184,7 @@
 #else
 		.mwdma_mask	=3D 0x00, /* mwdma broken */
 #endif
-		.udma_mask	=3D ATA_UDMA_MASK_40C, /* FIXME: cbl det */
+		.udma_mask	=3D 0x3f, /* udma0-5 */
 		.port_ops	=3D &piix_pata_ops,
 	},
=20
@@ -209,7 +209,7 @@
 #else
 		.mwdma_mask	=3D 0x00, /* mwdma broken */
 #endif
-		.udma_mask	=3D ATA_UDMA_MASK_40C, /* FIXME: cbl det */
+		.udma_mask	=3D ATA_UDMA_MASK_40C,
 		.port_ops	=3D &piix_pata_ops,
 	},
=20
@@ -252,7 +252,7 @@
  *	piix_pata_cbl_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
  *
- *	Read 80c cable indicator from SATA PCI device's PCI config
+ *	Read 80c cable indicator from ATA PCI device's PCI config
  *	register.  This register is normally set by firmware (BIOS).
  *
  *	LOCKING:
@@ -268,7 +268,7 @@
 		goto cbl40;
=20
 	/* check BIOS cable detect results */
-	mask =3D ap->port_no =3D=3D 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
+	mask =3D ap->hard_port_no =3D=3D 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
 	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
 	if ((tmp & mask) =3D=3D 0)
 		goto cbl40;
@@ -294,7 +294,7 @@
 static void piix_pata_phy_reset(struct ata_port *ap)
 {
 	if (!pci_test_config_bits(ap->host_set->pdev,
-				  &piix_enable_bits[ap->port_no])) {
+				  &piix_enable_bits[ap->hard_port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return;
@@ -327,8 +327,8 @@
 	int orig_mask, mask, i;
 	u8 pcs;
=20
-	mask =3D (PIIX_PORT_PRESENT << ap->port_no) |
-	       (PIIX_PORT_ENABLED << ap->port_no);
+	mask =3D (PIIX_PORT_PRESENT << ap->hard_port_no) |
+	       (PIIX_PORT_ENABLED << ap->hard_port_no);
=20
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
 	orig_mask =3D (int) pcs & 0xff;
@@ -345,7 +345,7 @@
 		mask =3D (PIIX_PORT_PRESENT << i) | (PIIX_PORT_ENABLED << i);
=20
 		if ((orig_mask & mask) =3D=3D mask)
-			if (combined || (i =3D=3D ap->port_no))
+			if (combined || (i =3D=3D ap->hard_port_no))
 				return 1;
 	}
=20
@@ -394,7 +394,7 @@
 	unsigned int pio	=3D adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	=3D ap->host_set->pdev;
 	unsigned int is_slave	=3D (adev->devno !=3D 0);
-	unsigned int master_port=3D ap->port_no ? 0x42 : 0x40;
+	unsigned int master_port=3D ap->hard_port_no ? 0x42 : 0x40;
 	unsigned int slave_port	=3D 0x44;
 	u16 master_data;
 	u8 slave_data;
@@ -412,10 +412,10 @@
 		/* enable PPE, IE and TIME */
 		master_data |=3D 0x0070;
 		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data &=3D (ap->port_no ? 0x0f : 0xf0);
+		slave_data &=3D (ap->hard_port_no ? 0x0f : 0xf0);
 		slave_data |=3D
 			(timings[pio][0] << 2) |
-			(timings[pio][1] << (ap->port_no ? 4 : 0));
+			(timings[pio][1] << (ap->hard_port_no ? 4 : 0));
 	} else {
 		master_data &=3D 0xccf8;
 		/* enable PPE, IE and TIME */
@@ -445,9 +445,9 @@
 {
 	unsigned int udma	=3D adev->dma_mode; /* FIXME: MWDMA too */
 	struct pci_dev *dev	=3D ap->host_set->pdev;
-	u8 maslave		=3D ap->port_no ? 0x42 : 0x40;
+	u8 maslave		=3D ap->hard_port_no ? 0x42 : 0x40;
 	u8 speed		=3D udma;
-	unsigned int drive_dn	=3D (ap->port_no ? 2 : 0) + adev->devno;
+	unsigned int drive_dn	=3D (ap->hard_port_no ? 2 : 0) + adev->devno;
 	int a_speed		=3D 3 << (drive_dn * 4);
 	int u_flag		=3D 1 << drive_dn;
 	int v_flag		=3D 0x01 << drive_dn;
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/libata-core.c	2004-10-15 03:02:43 -04:00
@@ -3032,6 +3032,8 @@
 	ap->ctl =3D ATA_DEVCTL_OBS;
 	ap->host_set =3D host_set;
 	ap->port_no =3D port_no;
+	ap->hard_port_no =3D
+		ent->legacy_mode ? ent->hard_port_no : port_no;
 	ap->pio_mask =3D ent->pio_mask;
 	ap->mwdma_mask =3D ent->mwdma_mask;
 	ap->udma_mask =3D ent->udma_mask;
@@ -3338,8 +3340,14 @@
 	probe_ent[0].n_ports =3D 1;
 	probe_ent[0].irq =3D 14;
=20
+	probe_ent[0].hard_port_no =3D 0;
+	probe_ent[0].legacy_mode =3D 1;
+
 	probe_ent[1].n_ports =3D 1;
 	probe_ent[1].irq =3D 15;
+
+	probe_ent[1].hard_port_no =3D 1;
+	probe_ent[1].legacy_mode =3D 1;
=20
 	probe_ent[0].port[0].cmd_addr =3D 0x1f0;
 	probe_ent[0].port[0].altstatus_addr =3D
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-15 03:02:43 -04:00
@@ -731,7 +731,6 @@
 		buflen =3D cmd->request_bufflen;
 	}
=20
-	memset(buf, 0, buflen);
 	*buf_out =3D buf;
 	return buflen;
 }
@@ -780,6 +779,7 @@
 	struct scsi_cmnd *cmd =3D args->cmd;
=20
 	buflen =3D ata_scsi_rbuf_get(cmd, &rbuf);
+	memset(rbuf, 0, buflen);
 	rc =3D actor(args, rbuf, buflen);
 	ata_scsi_rbuf_put(cmd);
=20
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-10-15 03:02:43 -04:00
@@ -311,7 +311,7 @@
 	static int printed_version =3D 0;
 	struct nv_host *host;
 	struct ata_port_info *ppi;
-	struct ata_probe_ent *probe_ent =3D NULL;
+	struct ata_probe_ent *probe_ent;
 	int rc;
=20
 	if (!printed_version++)
@@ -319,11 +319,11 @@
=20
 	rc =3D pci_enable_device(pdev);
 	if (rc)
-		return rc;
+		goto err_out;
=20
 	rc =3D pci_request_regions(pdev, DRV_NAME);
 	if (rc)
-		goto err_out;
+		goto err_out_disable;
=20
 	rc =3D pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -332,18 +332,16 @@
 	if (rc)
 		goto err_out_regions;
=20
+	rc =3D -ENOMEM;
+
 	ppi =3D &nv_port_info;
 	probe_ent =3D ata_pci_init_native_mode(pdev, &ppi);
-	if (!probe_ent) {
-		rc =3D -ENOMEM;
+	if (!probe_ent)
 		goto err_out_regions;
-	}
=20
 	host =3D kmalloc(sizeof(struct nv_host), GFP_KERNEL);
-	if (!host) {
-		rc =3D -ENOMEM;
+	if (!host)
 		goto err_out_free_ent;
-	}
=20
 	host->host_desc =3D &nv_device_tbl[ent->driver_data];
=20
@@ -354,8 +352,10 @@
=20
 		probe_ent->mmio_base =3D ioremap(pci_resource_start(pdev, 5),
 				pci_resource_len(pdev, 5));
-		if (probe_ent->mmio_base =3D=3D NULL)
-			goto err_out_iounmap;
+		if (probe_ent->mmio_base =3D=3D NULL) {
+			rc =3D -EIO;
+			goto err_out_free_host;
+		}
=20
 		base =3D (unsigned long)probe_ent->mmio_base;
=20
@@ -373,14 +373,14 @@
=20
 	pci_set_master(pdev);
=20
-	// Enable hotplug event interrupts.
-	if (host->host_desc->enable_hotplug)
-		host->host_desc->enable_hotplug(probe_ent);
-
 	rc =3D ata_device_add(probe_ent);
 	if (rc !=3D NV_PORTS)
 		goto err_out_iounmap;
=20
+	// Enable hotplug event interrupts.
+	if (host->host_desc->enable_hotplug)
+		host->host_desc->enable_hotplug(probe_ent);
+
 	kfree(probe_ent);
=20
 	return 0;
@@ -388,15 +388,15 @@
 err_out_iounmap:
 	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
 		iounmap(probe_ent->mmio_base);
-
+err_out_free_host:
+	kfree(host);
 err_out_free_ent:
 	kfree(probe_ent);
-
 err_out_regions:
 	pci_release_regions(pdev);
-
-err_out:
+err_out_disable:
 	pci_disable_device(pdev);
+err_out:
 	return rc;
 }
=20
diff -Nru a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/scsi/sata_uli.c	2004-10-15 03:02:43 -04:00
@@ -0,0 +1,282 @@
+/*
+ *  sata_uli.c - ULi Electronics SATA
+ *
+ *  The contents of this file are subject to the Open
+ *  Software License version 1.1 that can be found at
+ *  http://www.opensource.org/licenses/osl-1.1.txt and is included her=
ein
+ *  by reference.
+ *
+ *  Alternatively, the contents of this file may be used under the ter=
ms
+ *  of the GNU General Public License version 2 (the "GPL") as distrib=
uted
+ *  in the kernel source COPYING file, in which case the provisions of
+ *  the GPL are applicable instead of the above.  If you wish to allow
+ *  the use of your version of this file only under the terms of the
+ *  GPL and not to allow others to use your version of this file under
+ *  the OSL, indicate your decision by deleting the provisions above a=
nd
+ *  replace them with the notice and other provisions required by the =
GPL.
+ *  If you do not delete the provisions above, a recipient may use you=
r
+ *  version of this file under either the OSL or the GPL.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include "scsi.h"
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+
+#define DRV_NAME	"sata_uli"
+#define DRV_VERSION	"0.11"
+
+enum {
+	uli_5289		=3D 0,
+	uli_5287		=3D 1,
+
+	/* PCI configuration registers */
+	ULI_SCR_BASE		=3D 0x90, /* sata0 phy SCR registers */
+	ULI_SATA1_OFS		=3D 0x10, /* offset from sata0->sata1 phy regs */
+
+};
+
+static int uli_init_one (struct pci_dev *pdev, const struct pci_device=
_id *ent);
+static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u=
32 val);
+
+static struct pci_device_id uli_pci_tbl[] =3D {
+	{ PCI_VENDOR_ID_AL, 0x5289, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5289 },
+	{ PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5287 },
+	{ }	/* terminate list */
+};
+
+
+static struct pci_driver uli_pci_driver =3D {
+	.name			=3D DRV_NAME,
+	.id_table		=3D uli_pci_tbl,
+	.probe			=3D uli_init_one,
+	.remove			=3D ata_pci_remove_one,
+};
+
+static Scsi_Host_Template uli_sht =3D {
+	.module			=3D THIS_MODULE,
+	.name			=3D DRV_NAME,
+	.ioctl			=3D ata_scsi_ioctl,
+	.queuecommand		=3D ata_scsi_queuecmd,
+	.eh_strategy_handler	=3D ata_scsi_error,
+	.can_queue		=3D ATA_DEF_QUEUE,
+	.this_id		=3D ATA_SHT_THIS_ID,
+	.sg_tablesize		=3D LIBATA_MAX_PRD,
+	.max_sectors		=3D ATA_MAX_SECTORS,
+	.cmd_per_lun		=3D ATA_SHT_CMD_PER_LUN,
+	.emulated		=3D ATA_SHT_EMULATED,
+	.use_clustering		=3D ATA_SHT_USE_CLUSTERING,
+	.proc_name		=3D DRV_NAME,
+	.dma_boundary		=3D ATA_DMA_BOUNDARY,
+	.slave_configure	=3D ata_scsi_slave_config,
+	.bios_param		=3D ata_std_bios_param,
+};
+
+static struct ata_port_operations uli_ops =3D {
+	.port_disable		=3D ata_port_disable,
+
+	.tf_load		=3D ata_tf_load,
+	.tf_read		=3D ata_tf_read,
+	.check_status		=3D ata_check_status,
+	.exec_command		=3D ata_exec_command,
+	.dev_select		=3D ata_std_dev_select,
+
+	.phy_reset		=3D sata_phy_reset,
+
+	.bmdma_setup            =3D ata_bmdma_setup,
+	.bmdma_start            =3D ata_bmdma_start,
+	.qc_prep		=3D ata_qc_prep,
+	.qc_issue		=3D ata_qc_issue_prot,
+
+	.eng_timeout		=3D ata_eng_timeout,
+
+	.irq_handler		=3D ata_interrupt,
+	.irq_clear		=3D ata_bmdma_irq_clear,
+
+	.scr_read		=3D uli_scr_read,
+	.scr_write		=3D uli_scr_write,
+
+	.port_start		=3D ata_port_start,
+	.port_stop		=3D ata_port_stop,
+};
+
+static struct ata_port_info uli_port_info =3D {
+	.sht            =3D &uli_sht,
+	.host_flags     =3D ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
+			  ATA_FLAG_NO_LEGACY,
+	.pio_mask       =3D 0x03,		//support pio mode 4 (FIXME)
+	.udma_mask      =3D 0x7f,		//support udma mode 6
+	.port_ops       =3D &uli_ops,
+};
+
+
+MODULE_AUTHOR("Peer Chen");
+MODULE_DESCRIPTION("low-level driver for ULi Electronics SATA controll=
er");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, uli_pci_tbl);
+
+static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned in=
t sc_reg)
+{
+	unsigned int addr =3D ULI_SCR_BASE + (4 * sc_reg);
+
+	switch (port_no) {
+	case 0:
+		break;
+	case 1:
+		addr +=3D ULI_SATA1_OFS;
+		break;
+	case 2:
+		addr +=3D ULI_SATA1_OFS*4;
+		break;
+	case 3:
+		addr +=3D ULI_SATA1_OFS*5;
+		break;
+	default:
+		BUG();
+		break;
+	}
+	return addr;
+}
+
+static u32 uli_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
+{
+	unsigned int cfg_addr =3D get_scr_cfg_addr(ap->port_no, sc_reg);
+	u32 val;
+
+	pci_read_config_dword(ap->host_set->pdev, cfg_addr, &val);
+	return val;
+}
+
+static void uli_scr_cfg_write (struct ata_port *ap, unsigned int scr, =
u32 val)
+{
+	unsigned int cfg_addr =3D get_scr_cfg_addr(ap->port_no, scr);
+
+	pci_write_config_dword(ap->host_set->pdev, cfg_addr, val);
+}
+
+static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg)
+{
+	if (sc_reg > SCR_CONTROL)
+		return 0xffffffffU;
+
+	return uli_scr_cfg_read(ap, sc_reg);
+}
+
+static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u=
32 val)
+{
+	if (sc_reg > SCR_CONTROL)	//SCR_CONTROL=3D2, SCR_ERROR=3D1, SCR_STATU=
S=3D0
+		return;
+
+	uli_scr_cfg_write(ap, sc_reg, val);
+}
+
+/* move to PCI layer, integrate w/ MSI stuff */
+static void pci_enable_intx(struct pci_dev *pdev)
+{
+	u16 pci_command;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
+		pci_command &=3D ~PCI_COMMAND_INTX_DISABLE;
+		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+	}
+}
+
+static int uli_init_one (struct pci_dev *pdev, const struct pci_device=
_id *ent)
+{
+	struct ata_probe_ent *probe_ent;
+	struct ata_port_info *ppi;
+	int rc;
+	unsigned int board_idx =3D (unsigned int) ent->driver_data;
+
+	rc =3D pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc =3D pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto err_out;
+
+	rc =3D pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		goto err_out_regions;
+	rc =3D pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		goto err_out_regions;
+
+	ppi =3D &uli_port_info;
+	probe_ent =3D ata_pci_init_native_mode(pdev, &ppi);
+	if (!probe_ent) {
+		rc =3D -ENOMEM;
+		goto err_out_regions;
+	}
+
+	switch (board_idx) {
+	case uli_5287:
+       		probe_ent->n_ports =3D 4;
+
+       		probe_ent->port[2].cmd_addr =3D pci_resource_start(pdev, 0) +=
 8;
+		probe_ent->port[2].altstatus_addr =3D
+		probe_ent->port[2].ctl_addr =3D
+			(pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS) + 4;
+		probe_ent->port[2].bmdma_addr =3D pci_resource_start(pdev, 4) + 16;
+
+		probe_ent->port[3].cmd_addr =3D pci_resource_start(pdev, 2) + 8;
+		probe_ent->port[3].altstatus_addr =3D
+		probe_ent->port[3].ctl_addr =3D
+			(pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS) + 4;
+		probe_ent->port[3].bmdma_addr =3D pci_resource_start(pdev, 4) + 24;
+
+		ata_std_ports(&probe_ent->port[2]);
+		ata_std_ports(&probe_ent->port[3]);
+		break;
+
+	case uli_5289:
+		/* do nothing; ata_pci_init_native_mode did it all */
+		break;
+
+	default:
+		BUG();
+		break;
+	}
+
+	pci_set_master(pdev);
+	pci_enable_intx(pdev);
+
+	/* FIXME: check ata_device_add return value */
+	ata_device_add(probe_ent);
+	kfree(probe_ent);
+
+	return 0;
+
+err_out_regions:
+	pci_release_regions(pdev);
+
+err_out:
+	pci_disable_device(pdev);
+	return rc;
+
+}
+
+static int __init uli_init(void)
+{
+	return pci_module_init(&uli_pci_driver);
+}
+
+static void __exit uli_exit(void)
+{
+	pci_unregister_driver(&uli_pci_driver);
+}
+
+
+module_init(uli_init);
+module_exit(uli_exit);
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-10-15 03:02:43 -04:00
+++ b/include/linux/libata.h	2004-10-15 03:02:43 -04:00
@@ -189,6 +189,7 @@
 	Scsi_Host_Template	*sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
+	unsigned int		hard_port_no;
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
@@ -273,6 +274,7 @@
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		id;	/* unique id req'd by scsi midlyr */
 	unsigned int		port_no; /* unique port #; from zero */
+	unsigned int		hard_port_no;	/* hardware port #; from zero */
=20
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
