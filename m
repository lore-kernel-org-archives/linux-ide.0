From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/2 #upstream] ahci: honor PORTS_IMPL on ICH8s
Date: Sun, 5 Nov 2006 17:05:05 -0800
Message-ID: <20061106010505.GJ15897@curie-int.orbis-terrarum.net>
References: <20061102031723.GV13677@htj.dyndns.org> <20061102032059.GW13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7Ke/meiCZutM6I/"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.isohunt.com ([69.64.61.20]:31127 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1422957AbWKFBFP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Nov 2006 20:05:15 -0500
Content-Disposition: inline
In-Reply-To: <20061102032059.GW13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, robbat2@gentoo.org, linux-ide@vger.kernel.org


--C7Ke/meiCZutM6I/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2006 at 12:20:59PM +0900, Tejun Heo wrote:
> @@ -1439,7 +1453,7 @@ static int ahci_host_init(struct ata_pro
>  	struct ahci_host_priv *hpriv =3D probe_ent->private_data;
>  	struct pci_dev *pdev =3D to_pci_dev(probe_ent->dev);
>  	void __iomem *mmio =3D probe_ent->mmio_base;
> -	unsigned int i, using_dac;
> +	unsigned int i, cap_n_ports, using_dac;
>  	int rc;
> =20
>  	rc =3D ahci_reset_controller(mmio, pdev);
> @@ -1448,10 +1462,34 @@ static int ahci_host_init(struct ata_pro
> =20
>  	hpriv->cap =3D readl(mmio + HOST_CAP);
>  	hpriv->port_map =3D readl(mmio + HOST_PORTS_IMPL);
> -	probe_ent->n_ports =3D ahci_nr_ports(hpriv->cap);
> +	cap_n_ports =3D ahci_nr_ports(hpriv->cap);
> =20
>  	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
> -		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
> +		hpriv->cap, hpriv->port_map, n_ports);
n_ports is undefined here. Should be cap_n_ports instead.

Other than that, the two patches work perfectly.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--C7Ke/meiCZutM6I/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFTopBPpIsIjIzwiwRAm+RAKDOoI57UhdZLlK6eL1p6k5nMGAvxACg4Y3k
TkEiyn/1lTds35ogm+Ac3Sg=
=0PH/
-----END PGP SIGNATURE-----

--C7Ke/meiCZutM6I/--
