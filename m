From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Fri, 30 Sep 2011 16:39:27 +0800
Message-ID: <CACVXFVPf2opHpR=03iWo4-fOn-UTswUPEqY=v8pbu8hdQY8Y6Q@mail.gmail.com>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
	<20110924015859.GZ29319@htj.dyndns.org>
	<DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
	<CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
	<20110925000345.GD29319@htj.dyndns.org>
	<CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com>
	<CACVXFVMWn4o3WKznydUqdhfZK2xTQ-+=SFqYtP0J4DzagWphcQ@mail.gmail.com>
	<CACVXFVPR2qA-N2wi6c2ranOLuhRVuQQ5nhdE=4m1hxjW-Z=Ohw@mail.gmail.com>
	<20110930030913.GE10425@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55810 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab1I3Ij2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2011 04:39:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1R9Ycy-0003gd-14
	for linux-ide@vger.kernel.org; Fri, 30 Sep 2011 08:39:28 +0000
Received: by wyg34 with SMTP id 34so842266wyg.19
        for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2011 01:39:27 -0700 (PDT)
In-Reply-To: <20110930030913.GE10425@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, "Heasley, Seth" <seth.heasley@intel.com>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi,

On Fri, Sep 30, 2011 at 11:09 AM, Tejun Heo <htejun@gmail.com> wrote:

>
> * define PIIX_FLAG_PIO16 and set it in the port_info for SNBs.
>
> * define piix_port_start() which sets PFLAG_PIO32 iff !PIIX_FLAG_PIO1=
6
> =A0and then call ata_bmdma_port_start() and use it in piix_sata_ops.

Looks It is really a nice and clean idea to fix the problem, follows
the patch, which
has been tested OK to recognize DVD in machine with device ID 0x1c00
chipset.

Seth, could you help to test the patch on your machines with other pci =
device
IDs(0x1c01, 0x1d00, 0x1e00, 0x1e01)?

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 43107e9..70095be 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -113,6 +113,8 @@ enum {
 	PIIX_PATA_FLAGS		=3D ATA_FLAG_SLAVE_POSS,
 	PIIX_SATA_FLAGS		=3D ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,

+	PIIX_FLAG_PIO16		=3D ATA_FLAG_PIO16,
+
 	PIIX_80C_PRI		=3D (1 << 5) | (1 << 4),
 	PIIX_80C_SEC		=3D (1 << 7) | (1 << 6),

@@ -147,6 +149,7 @@ enum piix_controller_ids {
 	ich8m_apple_sata,	/* locks up on second port enable */
 	tolapai_sata,
 	piix_pata_vmw,			/* PIIX4 for VMware, spurious DMA_ERR */
+	ich8_sata_snb,
 };

 struct piix_map_db {
@@ -177,6 +180,7 @@ static int piix_sidpr_scr_write(struct ata_link *li=
nk,
 static int piix_sidpr_set_lpm(struct ata_link *link, enum
ata_lpm_policy policy,
 			      unsigned hints);
 static bool piix_irq_check(struct ata_port *ap);
+static int piix_port_start(struct ata_port *ap);
 #ifdef CONFIG_PM
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t =
mesg);
 static int piix_pci_device_resume(struct pci_dev *pdev);
@@ -298,21 +302,21 @@ static const struct pci_device_id piix_pci_tbl[] =
=3D {
 	/* SATA Controller IDE (PCH) */
 	{ 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (CPT) */
-	{ 0x8086, 0x1c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	{ 0x8086, 0x1c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
 	/* SATA Controller IDE (CPT) */
-	{ 0x8086, 0x1c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	{ 0x8086, 0x1c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
 	/* SATA Controller IDE (CPT) */
 	{ 0x8086, 0x1c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (CPT) */
 	{ 0x8086, 0x1c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (PBG) */
-	{ 0x8086, 0x1d00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	{ 0x8086, 0x1d00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
 	/* SATA Controller IDE (PBG) */
 	{ 0x8086, 0x1d08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (Panther Point) */
-	{ 0x8086, 0x1e00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	{ 0x8086, 0x1e00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
 	/* SATA Controller IDE (Panther Point) */
-	{ 0x8086, 0x1e01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	{ 0x8086, 0x1e01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
 	/* SATA Controller IDE (Panther Point) */
 	{ 0x8086, 0x1e08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (Panther Point) */
@@ -338,6 +342,7 @@ static struct scsi_host_template piix_sht =3D {
 static struct ata_port_operations piix_sata_ops =3D {
 	.inherits		=3D &ata_bmdma32_port_ops,
 	.sff_irq_check		=3D piix_irq_check,
+	.port_start		=3D piix_port_start,
 };

 static struct ata_port_operations piix_pata_ops =3D {
@@ -478,6 +483,7 @@ static const struct piix_map_db *piix_map_db_table[=
] =3D {
 	[ich8_2port_sata]	=3D &ich8_2port_map_db,
 	[ich8m_apple_sata]	=3D &ich8m_apple_map_db,
 	[tolapai_sata]		=3D &tolapai_map_db,
+	[ich8_sata_snb]		=3D &ich8_map_db,
 };

 static struct ata_port_info piix_port_info[] =3D {
@@ -606,6 +612,19 @@ static struct ata_port_info piix_port_info[] =3D {
 		.port_ops	=3D &piix_vmw_ops,
 	},

+	/*
+	 * some Sandybridge chipsets have broken 32 mode up to now,
+	 * see https://bugzilla.kernel.org/show_bug.cgi?id=3D40592
+	 */
+	[ich8_sata_snb] =3D
+	{
+		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR | PIIX_FLAG_PIO16,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA6,
+		.port_ops	=3D &piix_sata_ops,
+	},
+
 };

 static struct pci_bits piix_enable_bits[] =3D {
@@ -649,6 +668,14 @@ static const struct ich_laptop ich_laptop[] =3D {
 	{ 0, }
 };

+static int piix_port_start(struct ata_port *ap)
+{
+	if (!(ap->flags & PIIX_FLAG_PIO16))
+		ap->pflags |=3D ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE;
+
+	return ata_bmdma_port_start(ap);
+}
+
 /**
  *	ich_pata_cable_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
diff --git a/include/linux/libata.h b/include/linux/libata.h
index efd6f98..dc68de5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -207,6 +207,7 @@ enum {
 	ATA_FLAG_SW_ACTIVITY	=3D (1 << 22), /* driver supports sw activity
 					      * led */
 	ATA_FLAG_NO_DIPM	=3D (1 << 23), /* host not happy with DIPM */
+	ATA_FLAG_PIO16		=3D (1 << 24),  /*16bit PIO */

 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */

--
Ming Lei
