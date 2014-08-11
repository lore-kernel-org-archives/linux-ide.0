From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ata: ahci_tegra: Read calibration fuse
Date: Mon, 11 Aug 2014 15:42:29 +0200
Message-ID: <20140811134227.GB26128@ulmo.nvidia.com>
References: <1407755953-11785-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407755953-11785-1-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2014 at 02:19:13PM +0300, Mikko Perttunen wrote:
> The original version of the driver did not read the SATA calibration
> fuse to remove the dependency to the fuse driver. The fuse driver
> is now merged, so add this functionality.
>=20
> The calibration fuse contains a 2-bit value used to pick a set
> of calibration values for the SATA pad.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/ata/ahci_tegra.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index f1fef74..ad99e0f5 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <soc/tegra/pmc.h>
> +#include <soc/tegra/fuse.h>

The above should be sorted alphabetically. Also I personally prefer to
visually separate linux/ and soc/ (just like asm/) headers by separating
the lists with empty lines.

Thierry

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6MhDAAoJEN0jrNd/PrOhxZkP/AifezyrRCn2KumU98TC+fFQ
ZixiUsC/r7FSS/gqsyufVNXz691TR8GyuM/zF8iOarKwy4VTtqIWjNGO4XlbgTDz
uC5wkCEzTkSYIgjGj0jxxDI1Az6JkBkqtnWH+TYJ+Kwf2HEV54yDzQNQbK310Mhr
pEsMr1XgjfTSR/9r2FN48jKK6yaD+mImbr3Qsmje73mMxZqDz5DRC/RRZ/8YB00O
89OxHfHcU2CRtN2MRQqbdFZubb/LHyCdIEGzn3SHDw2RHCL6son+GNQYM7wqs4lo
W+1KClSg4wodRcBOjdkJ74+TKdgea4hGTFrg1IubBnv/M6RY1GmPicgwFj7lhzS+
1SvjEpo6mi4Mr7hDs/3vI4nwO4WrfXI5EJFAtj/4RB2SV3PKeZXOq4LnW3nZw3N6
Q+Au+Vo2Ff3vAeh6Hd0tw9DRKuZ7PcwjtOHF9Je+pBCiloPHkZLUcUa2l1bt3OR4
LIS7tgcsNIZViKYXYWGcmHttyfyGG+7ceuG8ZtEc/gLRaEX1deHCQNDNMfXYU3xn
xYZUCIwT71VNPqdtJ91NI6LZrySMaqKH2/FZ0hC2WaS9aFTpvvajJXrd5I/NDNcG
7PtIU3u+NX1dh5bWBmYevqDENwxJ3ELBn+NFdZYYUxoAA0twIH6lp1HZRyVp1eb6
xH4vJCZ99KQjqwdgpOyA
=yi1J
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
