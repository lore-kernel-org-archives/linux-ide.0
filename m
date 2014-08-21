From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ata: ahci: tegra: fix build error
Date: Thu, 21 Aug 2014 14:18:06 -0500
Message-ID: <20140821191806.GN11146@saruman.home>
References: <20140821190824.GM11146@saruman.home>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JfVplkuTfB13Rsg5"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140821190824.GM11146-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

--JfVplkuTfB13Rsg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2014 at 02:08:24PM -0500, Felipe Balbi wrote:
> Currently, ahci_tegra doesn't build because it includes a file that
> doesn't exist.
>=20
> The problem is that first commit 306a7f9 (ARM: tegra: Move includes to
> include/soc/tegra) renamed include/linux/tegra-powergate.h to
> include/soc/tegra/powergate.h.
>=20
> Later commit 7232398 (ARM: tegra: Convert PMC to a driver) renamed
> include/soc/tegra/powergate.h to include/soc/tegra/pmc.h and neither
> commits fixed drivers/ata/ahci_tegra.c.
>=20
> Fix that so the driver has a chance of building. With current kernels.
                                                 ^
						 this period shouldn't
						 exist :-p
>=20
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.16
> Signed-of-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/ata/ahci_tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index fc3df47..7194835 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -24,7 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> -#include <linux/tegra-powergate.h>
> +#include <soc/tegra/pmc.h>
>  #include <linux/regulator/consumer.h>
>  #include "ahci.h"
> =20
> --
> 2.0.1.563.g66f467c
>=20
> --=20
> balbi



--=20
balbi

--JfVplkuTfB13Rsg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT9kXuAAoJEIaOsuA1yqRE0xAQAKnEQcNJcNru3tT0r/rPGS7U
Oddv2UqxtqGwhgPnSy7y7xcGAdYySlf/wepB4Jvh41NB9O7Vk1VWtJ+oZO8imV1r
gBm1QbzBDHxn2FcHXFTm9hfb49/HOOKV49rP30PJF9EHB+qpWxoYu+uVk+/CWMu1
aNDvOxWEIo5fqwkqJUQZj0U2tU9F054Yj1GLadZxDhqZpZm9l1/0KdmAYcC3Wrqy
gKbsSYNj+gYMj4bsogMjud+IHk0Of/aWSyIETxEoUjzhQkla3Bx/rkNic1KGnn5r
OA1zVEgMSkboj/6pKI28+CnMyqHLbnslIXxFWkxPaHpCaAjm74T0iGHXXlsQk+ai
kGFRhXh5lI2xLv8RCFUyVy3lc6ldbQ/9tYAJ7faDTExdHQMSBWgoE5iLC+052Sn8
1r9udkLJv7uiNLU+UT5Ze3dDLfE0/pZJouyPMTBjz33R6K13PIrCktuHN3B6/ka0
iPi9RmWbkF/9P5komeYgWufrcRQBARnjBBJSG4a1zQPkztzb2b/1NiePnKudki8Q
cOpP4F26jYixLkyAlieGhvSIHHPImBAAF6kI0A3wdKwlw8JtoTtfQAtQ0cHTy0bb
mFcYm1ZWDXKUWYdVB84Wt3SvksabJFb7OKZ18cGSAClFfpHcRCX2ykMW7ngBTHcM
oZzKlhUBF3C89llbuijX
=CyeL
-----END PGP SIGNATURE-----

--JfVplkuTfB13Rsg5--
