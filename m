From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Wed, 28 Sep 2011 12:58:25 +0800
Message-ID: <CACVXFVPR2qA-N2wi6c2ranOLuhRVuQQ5nhdE=4m1hxjW-Z=Ohw@mail.gmail.com>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
	<20110924015859.GZ29319@htj.dyndns.org>
	<DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
	<CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
	<20110925000345.GD29319@htj.dyndns.org>
	<CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com>
	<CACVXFVMWn4o3WKznydUqdhfZK2xTQ-+=SFqYtP0J4DzagWphcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49496 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab1I1E61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Sep 2011 00:58:27 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1R8mDx-0002pE-Su
	for linux-ide@vger.kernel.org; Wed, 28 Sep 2011 04:58:25 +0000
Received: by wwf22 with SMTP id 22so8307859wwf.1
        for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2011 21:58:25 -0700 (PDT)
In-Reply-To: <CACVXFVMWn4o3WKznydUqdhfZK2xTQ-+=SFqYtP0J4DzagWphcQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Heasley, Seth" <seth.heasley@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi Tejun,

On Mon, Sep 26, 2011 at 3:23 PM, Ming Lei <ming.lei@canonical.com> wrot=
e:

> How about this one below?
>
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 43107e9..b35086b 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -147,6 +147,7 @@ enum piix_controller_ids {
> =A0 =A0 =A0 =A0ich8m_apple_sata, =A0 =A0 =A0 /* locks up on second po=
rt enable */
> =A0 =A0 =A0 =A0tolapai_sata,
> =A0 =A0 =A0 =A0piix_pata_vmw, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* P=
IIX4 for VMware, spurious DMA_ERR */
> + =A0 =A0 =A0 ich8_sata_snb,
> =A0};
>
> =A0struct piix_map_db {
> @@ -298,7 +299,7 @@ static const struct pci_device_id piix_pci_tbl[] =
=3D {
> =A0 =A0 =A0 =A0/* SATA Controller IDE (PCH) */
> =A0 =A0 =A0 =A0{ 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_s=
ata },
> =A0 =A0 =A0 =A0/* SATA Controller IDE (CPT) */
> - =A0 =A0 =A0 { 0x8086, 0x1c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sa=
ta },
> + =A0 =A0 =A0 { 0x8086, 0x1c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sa=
ta_snb },
> =A0 =A0 =A0 =A0/* SATA Controller IDE (CPT) */
> =A0 =A0 =A0 =A0{ 0x8086, 0x1c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_s=
ata },
> =A0 =A0 =A0 =A0/* SATA Controller IDE (CPT) */
> @@ -335,6 +336,11 @@ static struct scsi_host_template piix_sht =3D {
> =A0 =A0 =A0 =A0ATA_BMDMA_SHT(DRV_NAME),
> =A0};
>
> +static struct ata_port_operations piix_sata_snb_ops =3D {
> + =A0 =A0 =A0 .inherits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &ata_bmdma_po=
rt_ops,
> + =A0 =A0 =A0 .sff_irq_check =A0 =A0 =A0 =A0 =A0=3D piix_irq_check,
> +};
> +
> =A0static struct ata_port_operations piix_sata_ops =3D {
> =A0 =A0 =A0 =A0.inherits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &ata_bmdma32=
_port_ops,
> =A0 =A0 =A0 =A0.sff_irq_check =A0 =A0 =A0 =A0 =A0=3D piix_irq_check,
> @@ -478,6 +484,7 @@ static const struct piix_map_db *piix_map_db_tabl=
e[] =3D {
> =A0 =A0 =A0 =A0[ich8_2port_sata] =A0 =A0 =A0 =3D &ich8_2port_map_db,
> =A0 =A0 =A0 =A0[ich8m_apple_sata] =A0 =A0 =A0=3D &ich8m_apple_map_db,
> =A0 =A0 =A0 =A0[tolapai_sata] =A0 =A0 =A0 =A0 =A0=3D &tolapai_map_db,
> + =A0 =A0 =A0 [ich8_sata_snb] =A0 =A0 =A0 =A0 =3D &ich8_map_db,
> =A0};
>
> =A0static struct ata_port_info piix_port_info[] =3D {
> @@ -606,6 +613,15 @@ static struct ata_port_info piix_port_info[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.port_ops =A0 =A0 =A0 =3D &piix_vmw_op=
s,
> =A0 =A0 =A0 =A0},
>
> + =A0 =A0 =A0 [ich8_sata_snb] =3D
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D PIIX_SATA=
_FLAGS | PIIX_FLAG_SIDPR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pio_mask =A0 =A0 =A0 =3D ATA_PIO4,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =A0 =A0 =3D ATA_MWDMA2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .udma_mask =A0 =A0 =A0=3D ATA_UDMA6,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .port_ops =A0 =A0 =A0 =3D &piix_sata_sn=
b_ops,
> + =A0 =A0 =A0 },
> +
> =A0};
>
> =A0static struct pci_bits piix_enable_bits[] =3D {

After testing, I found the patch above does not make DVD drive work.
But plus the below[1], dvd drive starts to working. Since piix_sidpr_sa=
ta_ops
is hardcode in ata_piix.c, looks like it is a bit difficult to figure
out a clean fix.

Tejun, could you give some comments about it?

thanks,
--
Ming Lei

[1],
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 150d286..3b3785d 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -376,7 +376,7 @@ static struct scsi_host_template piix_sidpr_sht =3D=
 {
 };

 static struct ata_port_operations piix_sidpr_sata_ops =3D {
-	.inherits		=3D &piix_sata_ops,
+	.inherits		=3D &piix_sata_snb_ops,
 	.hardreset		=3D sata_std_hardreset,
 	.scr_read		=3D piix_sidpr_scr_read,
 	.scr_write		=3D piix_sidpr_scr_write,
