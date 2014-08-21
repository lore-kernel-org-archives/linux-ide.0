From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ata: ahci: tegra: fix build error
Date: Thu, 21 Aug 2014 14:21:34 -0500
Message-ID: <20140821192134.GO11146@saruman.home>
References: <20140821190824.GM11146@saruman.home>
 <53F645BA.4000402@wwwdotorg.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nLMor0SRtNCuLS/8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53F645BA.4000402-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

--nLMor0SRtNCuLS/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2014 at 01:17:14PM -0600, Stephen Warren wrote:
> On 08/21/2014 01:08 PM, Felipe Balbi wrote:
> >Currently, ahci_tegra doesn't build because it includes a file that
> >doesn't exist.
> >
> >The problem is that first commit 306a7f9 (ARM: tegra: Move includes to
> >include/soc/tegra) renamed include/linux/tegra-powergate.h to
> >include/soc/tegra/powergate.h.
> >
> >Later commit 7232398 (ARM: tegra: Convert PMC to a driver) renamed
> >include/soc/tegra/powergate.h to include/soc/tegra/pmc.h and neither
> >commits fixed drivers/ata/ahci_tegra.c.
> >
> >Fix that so the driver has a chance of building. With current kernels.
> >
> >Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.16
>=20
> This driver first appeared in v3.17-rc1.

hmm... weird, git describe told v3.16-rc1 :-s

> This patch has already been sent, and apparently applied:
>=20
> https://lkml.org/lkml/2014/8/16/36

aha, thanks.

> I wonder if libata/for-3.17-fixes isn't in linux-next?

it is, it's just that I was build testing my branch which is based off
of v3.17-rc1 as of now.

--=20
balbi

--nLMor0SRtNCuLS/8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT9ka+AAoJEIaOsuA1yqREQBAP/jQXcse3UFDEv0rNPXj8Ly+u
wwWKgy7ULlslpnLRVgUieKE2BZjn0zj5wy5CYksE8rRocgdfy6nmdvPOjkhD4zlm
dFJ1Phwc1/btCWMIYDTmkvO03HKIxeM4S7PQ+qblYGVuwgR4/gpwMKPj/jx3XRvF
pKfXA7pkhsxQPNdC1/TtPrSfVQYDJdQVmbBZMAohcFxj1zC/Tu1rKB78DYgvJrhb
FBREv1lPH8SCGxOzRGfBfM2ZgNBMa+mDflCMbhDxpkTIbJk9a12lXqa+6LFtPO5o
thIEqyVw1uMhlPBb97oKqATfwUGpqqCkjbRtBfPQ5Kl9BHMtHyChYWJt8eKoTeST
FNMImlC27e69Se5K5kRIdnR4SfqKK94ChN6t3ZdHqeriR0nweYVI2nmhQWGdW25K
apmcMUWZnda1sAj2XCFI6C70EdyMjN0kBhXlsFgZdRemEmc5eaYvGOUkwm4uDpi/
q7Xmr4PSAiBQWeq/mtMFhVI1owXp1kUt26M4zuwZR6SGc7ri3MDWpDFnYPAhljj/
+AC+6pQrb5hrIGZXCKZqkhod/mJt1yyll1SpchyaN1YasX7kUN5iXGO8JiVadg5D
4PamhaaQrUtPrR0odM4Ug+/izG9uZx4o9JL4LNhJ+On/gOT3TWj9xEWadwqiqjkg
8rYV4sZdD9ZytgVOhOYT
=V1g7
-----END PGP SIGNATURE-----

--nLMor0SRtNCuLS/8--
