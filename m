From: "James  C. Bevier" <jbev@jbsys.com>
Subject: Pata support on Promise controller under Fedora Core 3
Date: Sun, 24 Oct 2004 21:58:29 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <019801c4ba4f$451d7e40$0a01a8c0@jbsys.com>
Reply-To: "James  C. Bevier" <jbev@jbsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0195_01C4BA14.987E68F0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 24-117-200-54.cpe.cableone.net ([24.117.200.54]:55948 "EHLO
	hipeak.jbsys.com") by vger.kernel.org with ESMTP id S261395AbUJYE61
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Oct 2004 00:58:27 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0195_01C4BA14.987E68F0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Jeff,

I cut out the attached patch from the sata_promise dev patches on kernel.org.  I 
put it in the latest kernel in Fedora Core 3 RC1.  It is version 2.6.9-1.640 
kernel.  It works well enough to be able to see the first PATA drive on the 
Promise controller.  It does not see the second drive.  The code only seems to 
work for one drive.  Could you (or Erik) provide the rest of the code that will 
see the second drive.  If you could point me to specs for the controller or give 
me the register offset for the last drive, I could try to hack at it myself.  I 
really need this to work in Fedora Core 3.

Thanks for your help!

Jim Bevier 

------=_NextPart_000_0195_01C4BA14.987E68F0
Content-Type: application/octet-stream;
	name="linux-2.6.9-sata_promise.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.6.9-sata_promise.patch"

BK users:=0A=
=0A=
	bk pull bk://gkernel.bkbits.net/libata-dev-2.6=0A=
=0A=
This will update the following files:=0A=
=0A=
 drivers/scsi/sata_promise.c  |   56 ++=0A=
 /include/linux/libata.h=0A=
=0A=
<erikbenada:yahoo.ca>:=0A=
  o [libata sata_promise] support PATA ports on SATA controllers=0A=
=0A=
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c=0A=
--- a/drivers/scsi/sata_promise.c	2004-10-18 19:10:23 -04:00=0A=
+++ b/drivers/scsi/sata_promise.c	2004-10-18 19:10:23 -04:00=0A=
@@ -79,6 +79,8 @@=0A=
 static int pdc_port_start(struct ata_port *ap);=0A=
 static void pdc_port_stop(struct ata_port *ap);=0A=
 static void pdc_phy_reset(struct ata_port *ap);=0A=
+static void pdc_pata_phy_reset(struct ata_port *ap);=0A=
+static void pdc_pata_cbl_detect(struct ata_port *ap);=0A=
 static void pdc_qc_prep(struct ata_queued_cmd *qc);=0A=
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile =
*tf);=0A=
 static void pdc_exec_command_mmio(struct ata_port *ap, struct =
ata_taskfile *tf);=0A=
@@ -127,7 +129,7 @@=0A=
 	/* board_2037x */=0A=
 	{=0A=
 		.sht		=3D &pdc_sata_sht,=0A=
-		.host_flags	=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |=0A=
+		.host_flags	=3D /* ATA_FLAG_SATA | */ ATA_FLAG_NO_LEGACY |=0A=
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,=0A=
 		.pio_mask	=3D 0x1f, /* pio0-4 */=0A=
 		.mwdma_mask	=3D 0x07, /* mwdma0-2 */=0A=
@@ -244,7 +246,35 @@=0A=
 static void pdc_phy_reset(struct ata_port *ap)=0A=
 {=0A=
 	pdc_reset_port(ap);=0A=
-	sata_phy_reset(ap);=0A=
+	if (ap->flags & ATA_FLAG_SATA)=0A=
+		sata_phy_reset(ap);=0A=
+	else=0A=
+		pdc_pata_phy_reset(ap);=0A=
+}=0A=
+=0A=
+static void pdc_pata_cbl_detect(struct ata_port *ap)=0A=
+{=0A=
+	u8 tmp;=0A=
+	void *mmio =3D (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;=0A=
+=0A=
+	tmp =3D readb(mmio);=0A=
+	=0A=
+	if (tmp & 0x01)=0A=
+	{=0A=
+		ap->cbl =3D ATA_CBL_PATA40;=0A=
+		ap->udma_mask &=3D ATA_UDMA_MASK_40C;=0A=
+	}=0A=
+	else=0A=
+		ap->cbl =3D ATA_CBL_PATA80;=0A=
+}=0A=
+		=0A=
+static void pdc_pata_phy_reset(struct ata_port *ap)=0A=
+{=0A=
+	pdc_pata_cbl_detect(ap);=0A=
+=0A=
+	ata_port_probe(ap);=0A=
+	=0A=
+	ata_bus_reset(ap);=0A=
 }=0A=
 =0A=
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)=0A=
@@ -547,6 +577,7 @@=0A=
 	void *mmio_base;=0A=
 	unsigned int board_idx =3D (unsigned int) ent->driver_data;=0A=
 	int rc;=0A=
+	u8 tmp;=0A=
 =0A=
 	if (!printed_version++)=0A=
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");=0A=
@@ -605,6 +636,9 @@=0A=
 	probe_ent->port[0].scr_addr =3D base + 0x400;=0A=
 	probe_ent->port[1].scr_addr =3D base + 0x500;=0A=
 =0A=
+	probe_ent->port_flags[0] =3D ATA_FLAG_SATA;=0A=
+	probe_ent->port_flags[1] =3D ATA_FLAG_SATA;=0A=
+	=0A=
 	/* notice 4-port boards */=0A=
 	switch (board_idx) {=0A=
 	case board_20319:=0A=
@@ -615,9 +649,25 @@=0A=
 =0A=
 		probe_ent->port[2].scr_addr =3D base + 0x600;=0A=
 		probe_ent->port[3].scr_addr =3D base + 0x700;=0A=
+	=0A=
+		probe_ent->port_flags[2] =3D ATA_FLAG_SATA;=0A=
+		probe_ent->port_flags[3] =3D ATA_FLAG_SATA;=0A=
 		break;=0A=
 	case board_2037x:=0A=
-       		probe_ent->n_ports =3D 2;=0A=
+		/* Some boards have also PATA port */=0A=
+		tmp =3D readb(base + PDC_FLASH_CTL+1);=0A=
+		if (!(tmp & 0x80))=0A=
+		{=0A=
+			probe_ent->n_ports =3D 3;=0A=
+			=0A=
+			pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);=0A=
+			=0A=
+			probe_ent->port_flags[2] =3D ATA_FLAG_SLAVE_POSS;=0A=
+			=0A=
+			printk(KERN_INFO DRV_NAME " PATA port found\n");=0A=
+		}=0A=
+		else=0A=
+       			probe_ent->n_ports =3D 2;=0A=
 		break;=0A=
 	default:=0A=
 		BUG();=0A=
diff -Nru a/include/linux/libata.h b/include/linux/libata.h=0A=
--- a/include/linux/libata.h	2004-10-18 19:10:23 -04:00=0A=
+++ b/include/linux/libata.h	2004-10-18 19:10:23 -04:00=0A=
@@ -197,6 +197,7 @@=0A=
 	unsigned long		irq;=0A=
 	unsigned int		irq_flags;=0A=
 	unsigned long		host_flags;=0A=
+	unsigned long		port_flags[ATA_MAX_PORTS];=0A=
 	void __iomem		*mmio_base;=0A=
 	void			*private_data;=0A=
 };=0A=

------=_NextPart_000_0195_01C4BA14.987E68F0--

