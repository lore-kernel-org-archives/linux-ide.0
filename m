From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] ata: ahci_tegra: Read calibration fuse
Date: Tue, 26 Aug 2014 13:11:08 +0200
Message-ID: <20140826111107.GB31350@ulmo>
References: <1409043630-9674-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409043630-9674-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: tj@kernel.org, swarren@wwwdotorg.org, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 12:00:30PM +0300, Mikko Perttunen wrote:
> The original version of the driver did not read the SATA calibration
> fuse to remove the dependency to the fuse driver. The fuse driver
> is now merged, so add this functionality.
>=20
> The calibration fuse contains a 2-bit value used to pick a set
> of calibration values for the SATA pad.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2: reordered and separated includes
>=20
>  drivers/ata/ahci_tegra.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/GtLAAoJEN0jrNd/PrOh89cP/R9q31XB0bPVjOC4VkztVCaX
IkeMUIX9mGiYRjgtluMAO1wzwXKu09b9ugoSEObxX6/1XzSFa2+Rtop1U9M/x2Kc
E9Ucj8/BHVvHYftaP0VJqkJqdDox6AxBKqn11mDUyWhz7mDlNJD8ehlUppVOKMHJ
+xH8FByYOaguryDWmZ0BWHFUJZXmpJrZGGbAm+e8mEDgSoeb9x9qY0NgYAWE+MJ0
wEeT2pZe9YyWxvViHiipBeG3iw216MGQwu2KEkVkLP7pnbg6bxmrob3AcqJEbP+D
KrU1Gsb5unTV3NeGRP9t72PAU3Lt/xh5E79ezheZ+S6zLnRcswoEcB3XaMjgk20+
9johSLjemt6cqzWkOpU2UUlARBXem0QcmoyI45vNJG7suRi2zLKyfOLH2EXfv6h5
/+Z/EhV+Nm/DI7fCDABhegkF/6mugzNFMAwrbgIt0pnbrVjgNVbuMf8rSFSMkplr
mRkR1BGX60M8lLeGEivd86va4QuylQoZBYLApTWDVC2BptNf1mO/8XoPGioivyB4
MlE78V2Uk8QFFcPkeIbjK5D7oRnKYmUd/LFZNv8eqV+w7wdYD0i5R5zDY8REzAJd
ZzKkbIUHRRFGMf0AZHUE8BnWJ2mZpph62BqIkO5zEh554xgiNbZppd+YcyyaPBNK
2su8qkRB1nTI0c08wLv5
=Hqcb
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
