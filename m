From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Mon, 26 Sep 2011 15:23:30 +0800
Message-ID: <CACVXFVMWn4o3WKznydUqdhfZK2xTQ-+=SFqYtP0J4DzagWphcQ@mail.gmail.com>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
	<20110924015859.GZ29319@htj.dyndns.org>
	<DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
	<CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
	<20110925000345.GD29319@htj.dyndns.org>
	<CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55685 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab1IZHXb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2011 03:23:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1R85XG-000233-Sq
	for linux-ide@vger.kernel.org; Mon, 26 Sep 2011 07:23:30 +0000
Received: by wyg34 with SMTP id 34so5617746wyg.19
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2011 00:23:30 -0700 (PDT)
In-Reply-To: <CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Heasley, Seth" <seth.heasley@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi Tejun,

On Mon, Sep 26, 2011 at 2:51 PM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> Hi,
>
> On Sun, Sep 25, 2011 at 8:03 AM, Tejun Heo <htejun@gmail.com> wrote:
>> Sure I can do that but it would be better if you can revise your
>> patch. =C2=A0Please take a look at how different ops are mapped to
>> different device IDs. =C2=A0You just need to create another variant =
to be
>> mapped to the problematic device IDs.
>
> OK=EF=BC=8C I will do it.

How about this one below?

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 43107e9..b35086b 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -147,6 +147,7 @@ enum piix_controller_ids {
 	ich8m_apple_sata,	/* locks up on second port enable */
 	tolapai_sata,
 	piix_pata_vmw,			/* PIIX4 for VMware, spurious DMA_ERR */
+	ich8_sata_snb,
 };

 struct piix_map_db {
@@ -298,7 +299,7 @@ static const struct pci_device_id piix_pci_tbl[] =3D=
 {
 	/* SATA Controller IDE (PCH) */
 	{ 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (CPT) */
-	{ 0x8086, 0x1c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	{ 0x8086, 0x1c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
 	/* SATA Controller IDE (CPT) */
 	{ 0x8086, 0x1c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (CPT) */
@@ -335,6 +336,11 @@ static struct scsi_host_template piix_sht =3D {
 	ATA_BMDMA_SHT(DRV_NAME),
 };

+static struct ata_port_operations piix_sata_snb_ops =3D {
+	.inherits		=3D &ata_bmdma_port_ops,
+	.sff_irq_check		=3D piix_irq_check,
+};
+
 static struct ata_port_operations piix_sata_ops =3D {
 	.inherits		=3D &ata_bmdma32_port_ops,
 	.sff_irq_check		=3D piix_irq_check,
@@ -478,6 +484,7 @@ static const struct piix_map_db *piix_map_db_table[=
] =3D {
 	[ich8_2port_sata]	=3D &ich8_2port_map_db,
 	[ich8m_apple_sata]	=3D &ich8m_apple_map_db,
 	[tolapai_sata]		=3D &tolapai_map_db,
+	[ich8_sata_snb]		=3D &ich8_map_db,
 };

 static struct ata_port_info piix_port_info[] =3D {
@@ -606,6 +613,15 @@ static struct ata_port_info piix_port_info[] =3D {
 		.port_ops	=3D &piix_vmw_ops,
 	},

+	[ich8_sata_snb] =3D
+	{
+		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA6,
+		.port_ops	=3D &piix_sata_snb_ops,
+	},
+
 };

 static struct pci_bits piix_enable_bits[] =3D {


thanks,
--
Ming Lei
