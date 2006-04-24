From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: sata_via and SATA DVD drive (PX-712SA)
Date: Mon, 24 Apr 2006 17:48:29 +0800
Message-ID: <444C9EED.3000306@tw.ibm.com>
References: <200604202020.22010.r.brandstaedter@gmx.at> <444888AE.8000706@tw.ibm.com> <200604212320.30854.r.brandstaedter@gmx.at>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:6808 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750702AbWDXJsv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Apr 2006 05:48:51 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3O9mo77001091
	for <linux-ide@vger.kernel.org>; Mon, 24 Apr 2006 05:48:50 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3O9qHGe175212
	for <linux-ide@vger.kernel.org>; Mon, 24 Apr 2006 03:52:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3O9mnpD000439
	for <linux-ide@vger.kernel.org>; Mon, 24 Apr 2006 03:48:50 -0600
In-Reply-To: <200604212320.30854.r.brandstaedter@gmx.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>
Cc: linux-ide@vger.kernel.org

Reinhard Brandst=E4dter wrote:
> On Friday 21 April 2006 09:24, Albert Lee wrote:
>=20
>>From the dmesg, PX-712SA looks like a PATA drive bridged to SATA.
>>Could you try the atapi_dmadir=3D1 module parameter and check if it h=
elps?
>>(For older kernels, please #define ATAPI_ENABLE_DMADIR
>>in include/linux/libata.h and recompile the kernel.)
>=20
>=20
> Indeed the PX-712SA is a bridged PATA drive. In the POST message it's=
 even=20
> reported as PX-712A (the ATAPI model).
> I've tried to pass libata.atapi_dmadir=3D1 to the kernel but looking =
at dmesg=20
> nothing changed (using kernel 2.6.16). I even changed libata.h and de=
fined=20
> ATAPI_ENABLE_DMADIR - same result.
>=20
> What else could I try?
>=20

So, it is not the DMADIR problem...

According to the Plextor website
(http://www.plextor.com/English/support/media_712SA.htm),
the PX-712SA works with VIA SATA only in PIO mode.
(The website doesn't say why.)

Maybe updating the firmware of PX-712SA can help?
Otherwise, please try the attached patch to blacklist
PX-712SX DMA for sata_via.

--
albert

--- upstream0/drivers/scsi/sata_via.c	2006-04-24 17:36:23.000000000 +08=
00
+++ upstream1/drivers/scsi/sata_via.c	2006-04-24 17:37:06.000000000 +08=
00
@@ -72,6 +72,7 @@ enum {
 };
=20
 static int svia_init_one (struct pci_dev *pdev, const struct pci_devic=
e_id *ent);
+static void svia_dev_config(struct ata_port *ap, struct ata_device *de=
v);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, =
u32 val);
=20
@@ -82,6 +83,14 @@ static const struct pci_device_id svia_p
 	{ }	/* terminate list */
 };
=20
+static const struct svia_drivelist {
+	const char *product;
+	const char *revision;
+} svia_blacklist [] =3D {
+	{ "DVDR PX-712A", NULL },
+	{ }
+};
+
 static struct pci_driver svia_pci_driver =3D {
 	.name			=3D DRV_NAME,
 	.id_table		=3D svia_pci_tbl,
@@ -108,6 +117,7 @@ static struct scsi_host_template svia_sh
=20
 static const struct ata_port_operations svia_sata_ops =3D {
 	.port_disable		=3D ata_port_disable,
+	.dev_config		=3D svia_dev_config,
=20
 	.tf_load		=3D ata_tf_load,
 	.tf_read		=3D ata_tf_read,
@@ -153,6 +163,50 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, svia_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
=20
+/**
+ *	svia_dev_config - Apply device/host-specific errata fixups
+ *	@ap: Port containing device to be examined
+ *	@dev: Device to be examined
+ *
+ *	After the IDENTIFY [PACKET] DEVICE step is complete, and a
+ *	device is known to be present, this function is called.
+ *
+ *	According to=20
+ *	http://www.plextor.com/English/support/media_712SA.htm,
+ *	the Plextor PX-712SA drive works with VIA SATA
+ *	in PIO mode only. Root cause unknown yet.
+ *	The bad thing is, PX-712SA is actually a PX-712A bridged
+ *	to SATA and it report itself as PX-712A. Maybe PX-712A
+ *	works ok with VIA SATA + external (non-on-device) bridges?
+ */
+static void svia_dev_config(struct ata_port *ap, struct ata_device *de=
v)
+{
+	unsigned char model_num[41];
+	unsigned char model_rev[9];
+	int i, blacklisted =3D 0;
+
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD_OFS, sizeof(model_num=
));
+	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV_OFS, sizeof(model_r=
ev));
+
+	/* check whether the drive is blacklisted */
+	for (i =3D 0; svia_blacklist[i].product; i++)
+		if (!strcmp(svia_blacklist[i].product, model_num))
+			if (svia_blacklist[i].revision =3D=3D NULL ||
+			    !strcmp(svia_blacklist[i].revision, model_rev)) {
+				blacklisted =3D 1;
+				break;
+			}
+
+	if (blacklisted) {
+		/* limit to PIO */
+		printk(KERN_INFO "ata%u(%u): applying PIO limit to %s\n",
+		       ap->id, dev->devno, model_num);
+		dev->mwdma_mask =3D 0;
+		dev->udma_mask =3D 0;
+		return;
+	}
+}
+
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)


