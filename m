From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: sata_sis only recognizing primary drive in 2.6.18
Date: Mon, 23 Oct 2006 10:45:51 +0200
Message-ID: <200610231045.51679.uwe.koziolek@gmx.net>
References: <20061006065816.GA5782@jim.sh> <453A8B66.8080302@gmx.net> <453C25A1.5010208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:16327 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751833AbWJWIp4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Oct 2006 04:45:56 -0400
In-Reply-To: <453C25A1.5010208@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jim Paris <jim@jtan.com>, linux-ide@vger.kernel.org, muthas@mit.edu, fragmede@gmail.com, David Wang <touch@sis.com>

Hi,

here is the patch for slave support. No fixes for the second port handl=
ing are included.

regards
Uwe

>=20
> It might be sufficient to just add ATA_FLAG_SLAVE_POSS for all=20
> controllers but in general we don't want to sprinkle that flag over=20
> controllers which don't actually support slave device - sometimes for=
=20
> safety and also for documentation purpose. =A0So, please make a separ=
ate=20
> port_info and add ATA_FLAG_SLAVE_POSS only to controllers which actua=
lly=20
> support slave devices.

--- a/drivers/ata/sata_sis.c	2006-10-18 23:15:59.000000000 +0200
+++ b/drivers/ata/sata_sis.c	2006-10-23 10:16:09.000000000 +0200
@@ -126,13 +126,26 @@
 	.host_stop		=3D ata_host_stop,
 };
=20
-static struct ata_port_info sis_port_info =3D {
-	.sht		=3D &sis_sht,
-	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0x7,
-	.udma_mask	=3D 0x7f,
-	.port_ops	=3D &sis_ops,
+static struct ata_port_info sis_port_info[] =3D {
+	/* 2 ports, SiS964, SiS965L, SiS966L */
+	{
+		.sht		=3D &sis_sht,
+		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.pio_mask	=3D 0x1f,
+		.mwdma_mask	=3D 0x7,
+		.udma_mask	=3D 0x7f,
+		.port_ops	=3D &sis_ops,
+	},
+	/* 4 ports, SiS180, SiS965, SiS966 */
+	{
+		.sht		=3D &sis_sht,
+		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SLAVE_POSS,
+		.pio_mask	=3D 0x1f,
+		.mwdma_mask	=3D 0x7,
+		.udma_mask	=3D 0x7f,
+		.port_ops	=3D &sis_ops,
+	}
 };
=20
=20
@@ -244,6 +257,8 @@
 	int pci_dev_busy =3D 0;
 	u8 pmr;
 	u8 port2_start;
+	int slave_poss =3D 0;
+	u32 chipid;
=20
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -265,7 +280,38 @@
 	if (rc)
 		goto err_out_regions;
=20
-	ppi[0] =3D ppi[1] =3D &sis_port_info;
+	switch (ent->device) {
+	case 0x0180:
+	case 0x0181:	/* SiS180/181/964 */
+		pci_read_config_byte(pdev, SIS_PMR, &pmr);
+		if ((pmr & SIS_PMR_COMBINED) =3D=3D 0) {
+			dev_printk(KERN_INFO, &pdev->dev,
+				   "Detected SiS 180/181/964 chipset in SATA mode\n");
+			port2_start =3D 64;
+		}
+		else {
+			dev_printk(KERN_INFO, &pdev->dev,
+				   "Detected SiS 180/181 chipset in combined mode\n");
+			port2_start =3D 0;
+			slave_poss =3D 1;
+		}
+		break;
+	case 0x182:		/* SiS965/965L */
+		pci_read_config_dword ( pdev, 0x6C, &chipid);
+		if (chipid & (1L << 31)) {
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182/965 chipset\n")=
;
+			slave_poss =3D 1;
+		}
+		else {
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182/965L chipset\n"=
);
+		}
+		port2_start =3D 0x20;
+		break;
+	}
+	ppi[0] =3D ppi[1] =3D &sis_port_info[0];
+	if (slave_poss) {
+		ppi[0] =3D ppi[1] =3D &sis_port_info[1];
+	}
 	probe_ent =3D ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | =
ATA_PORT_SECONDARY);
 	if (!probe_ent) {
 		rc =3D -ENOMEM;
@@ -288,24 +334,6 @@
 		probe_ent->port_flags |=3D SIS_FLAG_CFGSCR;
 	}
=20
-	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-	if (ent->device !=3D 0x182) {
-		if ((pmr & SIS_PMR_COMBINED) =3D=3D 0) {
-			dev_printk(KERN_INFO, &pdev->dev,
-				   "Detected SiS 180/181 chipset in SATA mode\n");
-			port2_start =3D 64;
-		}
-		else {
-			dev_printk(KERN_INFO, &pdev->dev,
-				   "Detected SiS 180/181 chipset in combined mode\n");
-			port2_start=3D0;
-		}
-	}
-	else {
-		dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182 chipset\n");
-		port2_start =3D 0x20;
-	}
-
 	if (!(probe_ent->port_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =3D
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR);


