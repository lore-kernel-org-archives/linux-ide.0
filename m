From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH/RFC] ahci: add support for VIA VT8251
Date: Tue, 11 Apr 2006 21:41:18 +0400
Message-ID: <20060411214118.12653818.vsu@altlinux.ru>
References: <200604111915.45564.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__11_Apr_2006_21_41_18_+0400_BUgw0Dt5+bKNFWQi"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from master.altlinux.org ([62.118.250.235]:56079 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750814AbWDKRmA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Apr 2006 13:42:00 -0400
In-Reply-To: <200604111915.45564.b.jacques@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bastiaan Jacques <b.jacques@planet.nl>
Cc: linux-ide@vger.kernel.org

--Signature=_Tue__11_Apr_2006_21_41_18_+0400_BUgw0Dt5+bKNFWQi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Apr 2006 19:15:45 +0200 Bastiaan Jacques wrote:

> This patch adds AHCI support for the VIA VT8251 chipset. The patch does s=
o by:
> 	1) Adding the PCI device ID.
> 	2) Adding a workaround in ahci_probe_reset() for a VIA hardware bug.
>=20
> Signed-off-by: Bastiaan Jacques <b.jacques@planet.nl>
> ---
>=20
> The patch is based upon the patch[1] provided by VIA. With the softreset =
and=20
> probing work that has been merged, this patch has become much simpler.
>=20
> I am happy to report that without the workaround in ahci_probe_reset(), t=
he=20
> chipset works quite well; both my SATA drives are recognised. However,=20
> softreset does not work (but hardreset does), and ata_std_probeinit delay=
s,=20
> for my primary SATA drive/port,  due to the "busy" bug. A Command List=20
> Override will unbusy the drive/port.
>=20
> Since the CLO sequence also appears in ahci_softreset(), I have moved tha=
t=20
> code into a new ahci_clo() function.
>=20
> This patch is against 2.6.17-rc1 (and -mm2).
>=20
> This patch has only been tested by yours truly. Whilst I am waiting for=20
> feedback from other people, I am sending this patch to solicit comments.
>=20
> NOTE: My email client cuts off some lines (of context) in my patch becaus=
e=20
> they are longer than 78 characters. Therefore, I am making the patch=20
> available from my web server [2], as well.
>=20
> Bastiaan
>=20
> [1] http://lkml.org/lkml/2005/12/11/204
> [2] http://mirrors.pagefault.net/linux-via-ahci-latest.patch
>=20
> --- drivers/scsi/ahci.c.orig	2006-04-11 18:58:32.000000000 +0200
> +++ drivers/scsi/ahci.c	2006-04-11 12:44:41.000000000 +0200
> @@ -297,6 +297,8 @@
>  	  board_ahci }, /* ATI SB600 non-raid */
>  	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_ahci }, /* ATI SB600 raid */
> +	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_ahci }, /* VT8251 */

You can add a separate host type (e.g., board_via_vt8251_ahci), and then
add an entry for this type to ahci_port_info[].  The entry would have a
special flag in .host_flags, but the same .port_ops, so there will not
be excessive duplication like in the original vendor patch.

Look like other drivers which need workarounds for hardware bugs (e.g.,
sata_sil) do this.

>  	{ }	/* terminate list */
>  };
>=20
> @@ -535,6 +537,17 @@
>  	return -1;
>  }
>=20
> +static void ahci_clo(struct ata_port *ap)
> +{
> +	void __iomem *port_mmio =3D (void __iomem *) ap->ioaddr.cmd_addr;
> +	u32 tmp;
> +
> +	tmp =3D readl(port_mmio + PORT_CMD);
> +	tmp |=3D PORT_CMD_CLO;
> +	writel(tmp, port_mmio + PORT_CMD);
> +	readl(port_mmio + PORT_CMD); /* flush */
> +}
> +
>  static int ahci_softreset(struct ata_port *ap, int verbose, unsigned int=
=20
> *class)
>  {
>  	struct ahci_host_priv *hpriv =3D ap->host_set->private_data;
> @@ -565,7 +578,6 @@
>  	/* check BUSY/DRQ, perform Command List Override if necessary */
>  	ahci_tf_read(ap, &tf);
>  	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
> -		u32 tmp;
>=20

The following empty line should probably be deleted too.

>  		if (!(hpriv->cap & HOST_CAP_CLO)) {
>  			rc =3D -EIO;
> @@ -573,10 +585,7 @@
>  			goto fail_restart;
>  		}
>=20
> -		tmp =3D readl(port_mmio + PORT_CMD);
> -		tmp |=3D PORT_CMD_CLO;
> -		writel(tmp, port_mmio + PORT_CMD);
> -		readl(port_mmio + PORT_CMD); /* flush */
> +		ahci_clo(ap);
>=20
>  		if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0,
>  				       1, 500)) {
> @@ -695,6 +704,16 @@
>=20
>  static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
>  {
> +	struct pci_dev *pdev =3D to_pci_dev(ap->host_set->dev);
> +
> +	/* Workaround for VIA VT8251 "busy" bug */
> +	if (pdev->device =3D=3D 0x3349) {

After adding a separate host type and a host flag this will be:

	if (ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) {

> +		if (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY) {
> +			/* ATA_BUSY hasn't cleared, so send a CLO */
> +			ahci_clo(ap);
> +		}
> +	}
> +
>  	return ata_drive_probe_reset(ap, ata_std_probeinit,
>  				     ahci_softreset, ahci_hardreset,
>  				     ahci_postreset, classes);

--Signature=_Tue__11_Apr_2006_21_41_18_+0400_BUgw0Dt5+bKNFWQi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEO+pBW82GfkQfsqIRAoYmAKCGYbX/VGrSm1wEpo3Zg6v4i5domQCcC4FH
I039H2F7Yql/pKb9g3iI69c=
=oxJh
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Apr_2006_21_41_18_+0400_BUgw0Dt5+bKNFWQi--
