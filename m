From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] pcmcia: add CNF-CDROM-ID for ide/pata
Date: Thu, 6 Aug 2009 15:16:42 +0200
Message-ID: <20090806131642.GD3154@pengutronix.de>
References: <1248625649-7193-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42808 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbZHFNQs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2009 09:16:48 -0400
Content-Disposition: inline
In-Reply-To: <1248625649-7193-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org, jeff@garzik.org, David Miller <davem@davemloft.net>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

as Jeff already picked up the pata part of this patch, I wondered how to
proceed with the ide-cs-part. Will you pick it up for .31 or .32 or should =
it
go via the pcmcia-tree (which will make its next pull-request for .32)?

Kind regards,

   Wolfram

On Sun, Jul 26, 2009 at 06:27:29PM +0200, Wolfram Sang wrote:
> Fixes this report:
> http://article.gmane.org/gmane.linux.kernel.pcmcia.devel/2228/
>=20
> Reported-by: John McGrath <john@john-mcgrath.com>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/ata/pata_pcmcia.c |    1 +
>  drivers/ide/ide-cs.c      |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
> index f4d009e..dc99e26 100644
> --- a/drivers/ata/pata_pcmcia.c
> +++ b/drivers/ata/pata_pcmcia.c
> @@ -411,6 +411,7 @@ static struct pcmcia_device_id pcmcia_devices[] =3D {
>  	PCMCIA_DEVICE_PROD_ID123("PCMCIA", "IDE CARD", "F1", 0x281f1c5d, 0x1907=
960c, 0xf7fde8b9),
>  	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "CD-ROM", 0x78f308dc, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "PnPIDE", 0x78f308dc, 0x0c694728),
> +	PCMCIA_DEVICE_PROD_ID12("CNF   ", "CD-ROM", 0x46d7db81, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("CNF CD-M", "CD-ROM", 0x7d93b852, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("Creative Technology Ltd.", "PCMCIA CD-ROM Inte=
rface Card", 0xff8c8a45, 0xfe8020c4),
>  	PCMCIA_DEVICE_PROD_ID12("Digital Equipment Corporation.", "Digital Mobi=
le Media CD-ROM", 0x17692a66, 0xef1dcbde),
> diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
> index 527908f..063b933 100644
> --- a/drivers/ide/ide-cs.c
> +++ b/drivers/ide/ide-cs.c
> @@ -408,6 +408,7 @@ static struct pcmcia_device_id ide_ids[] =3D {
>  	PCMCIA_DEVICE_PROD_ID123("PCMCIA", "IDE CARD", "F1", 0x281f1c5d, 0x1907=
960c, 0xf7fde8b9),
>  	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "CD-ROM", 0x78f308dc, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "PnPIDE", 0x78f308dc, 0x0c694728),
> +	PCMCIA_DEVICE_PROD_ID12("CNF   ", "CD-ROM", 0x46d7db81, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("CNF CD-M", "CD-ROM", 0x7d93b852, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("Creative Technology Ltd.", "PCMCIA CD-ROM Inte=
rface Card", 0xff8c8a45, 0xfe8020c4),
>  	PCMCIA_DEVICE_PROD_ID12("Digital Equipment Corporation.", "Digital Mobi=
le Media CD-ROM", 0x17692a66, 0xef1dcbde),
> --=20
> 1.6.3.1
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkp617oACgkQD27XaX1/VRvlYQCfUdy7mMadBxm7Wq1/IeYIsOjw
cnIAoJ07NcToq9izwhVavBBz7X+JMjXW
=/fh0
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
