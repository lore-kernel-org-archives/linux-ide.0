From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] ata: Fix DVD not dectected at some Haswell platforms
Date: Wed, 30 Jan 2013 15:32:52 +0800
Message-ID: <1359531172.15258.1.camel@linux-s257.site>
References: <1359566374-27286-1-git-send-email-youquan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53750 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab3A3Hgj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2013 02:36:39 -0500
In-Reply-To: <1359566374-27286-1-git-send-email-youquan.song@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: htejun@gmail.com, ming.lei@canonical.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com, james.d.ralston@intel.com, Youquan Song <youquan.song@linux.intel.com>

=E6=96=BC =E4=B8=89=EF=BC=8C2013-01-30 =E6=96=BC 12:19 -0500=EF=BC=8CYo=
uquan Song =E6=8F=90=E5=88=B0=EF=BC=9A
> There is a quirk patch 5e5a4f5d5a08c9c504fe956391ac3dae2c66556d fix t=
he 4 ports
> IDE controller 32bit PIO mode.=20
> Recently, the problem was showed at Haswell platform which includes 2=
 ports=20
> IDE controller.
>=20
> So introduce a qurik patch to disable 32bit PIO at this IDE controlle=
r.=20
>=20
> Signed-off-by: Youquan Song <youquan.song@intel.com>

Patch works to me for avoid DVD detection on Intel Shark Bay developmen=
t
machine.

Tested-by: Lee, Chun-Yi <jlee@suse.com>


Thanks a lot!
Joey Lee

> ---
>  drivers/ata/ata_piix.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index ef773e1..1993e52 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -150,6 +150,7 @@ enum piix_controller_ids {
>  	tolapai_sata,
>  	piix_pata_vmw,			/* PIIX4 for VMware, spurious DMA_ERR */
>  	ich8_sata_snb,
> +	ich8_2port_sata_snb,
>  };
> =20
>  struct piix_map_db {
> @@ -326,7 +327,7 @@ static const struct pci_device_id piix_pci_tbl[] =
=3D {
>  	/* SATA Controller IDE (Lynx Point) */
>  	{ 0x8086, 0x8c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
>  	/* SATA Controller IDE (Lynx Point) */
> -	{ 0x8086, 0x8c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> +	{ 0x8086, 0x8c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_snb=
 },
>  	/* SATA Controller IDE (Lynx Point) */
>  	{ 0x8086, 0x8c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>  	/* SATA Controller IDE (Lynx Point-LP) */
> @@ -502,6 +503,7 @@ static const struct piix_map_db *piix_map_db_tabl=
e[] =3D {
>  	[ich8m_apple_sata]	=3D &ich8m_apple_map_db,
>  	[tolapai_sata]		=3D &tolapai_map_db,
>  	[ich8_sata_snb]		=3D &ich8_map_db,
> +	[ich8_2port_sata_snb]	=3D &ich8_2port_map_db,
>  };
> =20
>  static struct ata_port_info piix_port_info[] =3D {
> @@ -643,6 +645,16 @@ static struct ata_port_info piix_port_info[] =3D=
 {
>  		.port_ops	=3D &piix_sata_ops,
>  	},
> =20
> +	[ich8_2port_sata_snb] =3D
> +	{
> +		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR | PIIX_FLAG_PIO16,
> +		.pio_mask	=3D ATA_PIO4,
> +		.mwdma_mask	=3D ATA_MWDMA2,
> +		.udma_mask	=3D ATA_UDMA6,
> +		.port_ops	=3D &piix_sata_ops,
> +	},
> +
> +
>  };
> =20
>  static struct pci_bits piix_enable_bits[] =3D {


