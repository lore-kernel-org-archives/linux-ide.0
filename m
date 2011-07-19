From: =?UTF-8?b?UmFmYcWC?= Bilski <rafalbilski@interia.pl>
Subject: [PATCH] pata_via: Add SATA registers for VX800 SATA/PATA controller
Date: Tue, 19 Jul 2011 23:28:08 +0100
Message-ID: <1311114488-1135-1-git-send-email-rafalbilski@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?b?UmFmYcWC?= Bilski <rafalbilski@interia.pl>
List-Id: linux-ide@vger.kernel.org

I bought Elonex Webbook to have C7 system. I have installed Arch Linux =
on it.=20
=46rom start it has proven unreliable. Commands:
$ cd linux-3.0.0-rc7
$ make
would lead to
kernel: ata1: soft resetting link
kernel: ata1.00: configured for UDMA/133
kernel: ata1: EH complete
[...]
kernel: ata1: soft resetting link
kernel: ata1.00: configured for UDMA/33
kernel: ata1: EH complete
in random intervals, sometimes very long. Eventually
kernel: ata1: soft resetting link
kernel: ata1: SRST failed (errno=3D-16)
kernel: ata1 reset failed, giving up
kernel: ata1.00: disabled
kernel: ata1: EH complete
I have noticed that my system is using pata_via driver and that kernel =
thinks=20
that disk is PATA when in fact it is SATA disk. I have copied some line=
s from=20
sata_via.c to allow Linux access to SError register. Sadly booting unch=
anged=20
Linux 3.0.0-rc7-git5 solved problem for me. I can't reproduce it anymor=
e=20
on 3.0.0-rc7-git5, 2.6.39-ARCH nor 2.6.33-ARCH.

This patch allows Linux to access SATA registers present on VX700. I'm =
not
sure if my chipset is VX700, but it isn't CX700 nor VX800. Device ID se=
ems
to point to VX800, but rest of IDs doesn't match. Subdevice ID is same =
as
on CX700. I'm not sure if this chipset supports multiword DMA because
datasheet for VX800 is preliminary, so I just copied sata_via.c.

00:0f.0 IDE interface: VIA Technologies, Inc. VX800 Serial ATA and EIDE
Controller
kernel: ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
kernel: ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
kernel: ata1.00: SATA link up 1.5 Gbps (SStatus 13 SControl 300)
kernel: ata1.01: SATA link down (SStatus 11 SControl 300)
kernel: ata1.00: ATA-7: WDC WD800BEVS-22RST0, 04.01G04, max UDMA/133
kernel: ata1.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 0/32)
kernel: ata1.00: configured for UDMA/133

Signed-off-by: Rafa=C5=82 Bilski <rafalbilski@interia.pl>
---
 drivers/ata/pata_via.c |  137 ++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index ac8d7d9..6193cbd 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -93,6 +93,7 @@ static const struct via_isa_bridge {
 	u8 udma_mask;
 	u8 flags;
 } via_isa_bridges[] =3D {
+	{ "vx700/800",	PCI_DEVICE_ID_VIA_SATA_EIDE, 0x00, 0x2f, ATA_UDMA6, VI=
A_BAD_AST | VIA_SATA_PATA },
 	{ "vx855",	PCI_DEVICE_ID_VIA_VX855,    0x00, 0x2f, ATA_UDMA6, VIA_BAD=
_AST | VIA_SATA_PATA },
 	{ "vx800",	PCI_DEVICE_ID_VIA_VX800,    0x00, 0x2f, ATA_UDMA6, VIA_BAD=
_AST | VIA_SATA_PATA },
 	{ "vt8261",	PCI_DEVICE_ID_VIA_8261,     0x00, 0x2f, ATA_UDMA6, VIA_BA=
D_AST },
@@ -437,6 +438,83 @@ static int via_port_start(struct ata_port *ap)
 	return 0;
 }
=20
+/* On VX800 SStatus, SError and SControl registers are located in PCI =
config
+ * space. SStatus and SControl registers are only 8 bits wide. VT8251 =
is the
+ * same. Copy & paste from sata_via.c */
+
+static int vx800_scr_read(struct ata_link *link, unsigned int scr, u32=
 *val)
+{
+	static const u8 ipm_tbl[] =3D { 1, 2, 6, 0 };
+	struct pci_dev *pdev =3D to_pci_dev(link->ap->host->dev);
+	int slot =3D 2 * link->ap->port_no + link->pmp;
+	u32 v =3D 0;
+	u8 raw;
+
+	switch (scr) {
+	case SCR_STATUS:
+		pci_read_config_byte(pdev, 0xA0 + slot, &raw);
+
+		/* read the DET field, bit0 and 1 of the config byte */
+		v |=3D raw & 0x03;
+
+		/* read the SPD field, bit4 of the configure byte */
+		if (raw & (1 << 4))
+			v |=3D 0x02 << 4;
+		else
+			v |=3D 0x01 << 4;
+
+		/* read the IPM field, bit2 and 3 of the config byte */
+		v |=3D ipm_tbl[(raw >> 2) & 0x3];
+		break;
+
+	case SCR_ERROR:
+		pci_read_config_dword(pdev, 0xA8 + slot * 4, &v);
+		break;
+
+	case SCR_CONTROL:
+		pci_read_config_byte(pdev, 0xA4 + slot, &raw);
+
+		/* read the DET field, bit0 and bit1 */
+		v |=3D ((raw & 0x02) << 1) | (raw & 0x01);
+
+		/* read the IPM field, bit2 and bit3 */
+		v |=3D ((raw >> 2) & 0x03) << 8;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	*val =3D v;
+	return 0;
+}
+
+static int vx800_scr_write(struct ata_link *link, unsigned int scr, u3=
2 val)
+{
+	struct pci_dev *pdev =3D to_pci_dev(link->ap->host->dev);
+	int slot =3D 2 * link->ap->port_no + link->pmp;
+	u32 v =3D 0;
+
+	switch (scr) {
+	case SCR_ERROR:
+		pci_write_config_dword(pdev, 0xA8 + slot * 4, val);
+		return 0;
+
+	case SCR_CONTROL:
+		/* set the DET field */
+		v |=3D ((val & 0x4) >> 1) | (val & 0x1);
+
+		/* set the IPM field */
+		v |=3D ((val >> 8) & 0x3) << 2;
+
+		pci_write_config_byte(pdev, 0xA4 + slot, v);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static struct scsi_host_template via_sht =3D {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
@@ -457,6 +535,12 @@ static struct ata_port_operations via_port_ops_noi=
rq =3D {
 	.sff_data_xfer	=3D ata_sff_data_xfer_noirq,
 };
=20
+static struct ata_port_operations vx800_sata_ops =3D {
+	.inherits		=3D &via_port_ops,
+	.scr_read		=3D vx800_scr_read,
+	.scr_write		=3D vx800_scr_write,
+};
+
 /**
  *	via_config_fifo		-	set up the FIFO
  *	@pdev: PCI device
@@ -548,7 +632,22 @@ static int via_init_one(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
 		.udma_mask =3D ATA_UDMA6,	/* FIXME: should check north bridge */
 		.port_ops =3D &via_port_ops
 	};
-	const struct ata_port_info *ppi[] =3D { NULL, NULL };
+	static const struct ata_port_info via_vx800_sata_info =3D {
+		.flags		=3D ATA_FLAG_SATA,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA6,
+		.port_ops	=3D &vx800_sata_ops,
+	};
+	static const struct ata_port_info via_vx800_pata_info =3D {
+		.flags		=3D ATA_FLAG_SLAVE_POSS,
+		.pio_mask	=3D ATA_PIO4,
+		/* No MWDMA */
+		.udma_mask	=3D ATA_UDMA6,
+		.port_ops	=3D &via_port_ops,
+	};
+
+	const struct ata_port_info *ppi[] =3D { NULL, NULL, NULL };
 	struct pci_dev *isa;
 	const struct via_isa_bridge *config;
 	static int printed_version;
@@ -629,7 +728,41 @@ static int via_init_one(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
 	}
=20
 	/* We have established the device type, now fire it up */
-	return ata_pci_bmdma_init_one(pdev, ppi, &via_sht, (void *)config, 0)=
;
+	if (config->id !=3D PCI_DEVICE_ID_VIA_SATA_EIDE)
+		return ata_pci_bmdma_init_one(pdev, ppi, &via_sht,
+						(void *)config, 0);
+	/* VX800 has two SATA links on first port and two PATA links on=20
+	 * second port. This is just to get SError in dmesg. */
+	else {
+		struct ata_host *host;
+		struct device *dev =3D &pdev->dev;
+		int rc;
+
+		ppi[0] =3D &via_vx800_sata_info;
+		ppi[1] =3D &via_vx800_pata_info;
+		dev_printk(KERN_INFO, &pdev->dev, "VIA VX800 SATA/PATA\n");
+
+		if (!devres_open_group(dev, NULL, GFP_KERNEL))
+			return -ENOMEM;
+
+		rc =3D ata_pci_bmdma_prepare_host(pdev, ppi, &host);
+		if (rc)
+			return rc;
+
+		host->private_data =3D (void *)config;
+		/* Do we need to set any? */
+		host->flags |=3D 0;
+		/* Only first port has separate cables for devices */
+		ata_slave_link_init(host->ports[0]);
+		pci_set_master(pdev);
+		rc =3D ata_pci_sff_activate_host(host, ata_bmdma_interrupt,=20
+						&via_sht);
+		if (rc =3D=3D 0)
+			devres_remove_group(&pdev->dev, NULL);
+		else
+			devres_release_group(&pdev->dev, NULL);
+		return rc;
+	}
 }
=20
 #ifdef CONFIG_PM
--=20
1.7.6


----------------------------------------------------------------
Najwieksza baza samochodow nowych i uzywanych
Sprawdz >> http://linkint.pl/f29e3
