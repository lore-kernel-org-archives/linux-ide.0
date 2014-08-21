From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: ahci_tegra build failure in Linus' tree
Date: Thu, 21 Aug 2014 13:53:52 -0500
Message-ID: <20140821185352.GP24407@sirena.org.uk>
References: <E1XKRXZ-0000vL-4b@cassiel.sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="flW39HxDycSWn0NJ"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1XKRXZ-0000vL-4b-AwNWNkNSnF8YV1p1LO3TTN73F7V6hmMc@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--flW39HxDycSWn0NJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 01:32:29PM +0100, Build bot for Mark Brown wrote:

> ../drivers/ata/ahci_tegra.c:27:35: fatal error: linux/tegra-powergate.h: No such file or directory

ARM allmodconfig currently fails to build in mainline due to the above
error.  It has been fixed in -next by Mikko Perttunen in commit
0e5740770f34381b (ata: ahci_tegra: Change include to fix compilation)
but it's not clear to me if that's on it's way to Linus - it'd be great
if it could be.

--flW39HxDycSWn0NJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9kA9AAoJELSic+t+oim9LYIP/17T/hLr7VLmU5DoKQA/vVo8
hEc40GZExvs3WDxHiFJreGeOyz/0KhC3xP1Y5TtsMINVJXVBqUhev030xhp1uAu0
/XeoMFamW/gQ+f4yPBy0uiNwGt6g3/gLeP1hwEytYK9HeDEHhCl5WqVyi7dM99uw
IiQqRv8LErW2Ypv8/CTE1ge3RceuJNhJxv53tIAfRhy5NLSR0xOGsZPIn5G9Mtch
1gW/+eOfWV9dUnHDEZEQrYzcMWwSpDxre607Dz8KEpfWGy15CxoLplpi3nIgH/X0
OVRyhLXKyXyyXHFZ/pp5PqSNCipimKQJhnoUZf8sbtPIZ67yPc1uIaCVCrWTx80j
vuBVVNzubrkR5VHkljFuvG+9yn3cDzAtN11psSzRhNDAGz91Bh3rc7/5ena40Xq3
QydcRt3s65lm/h+IQQnfCUUshYd/gXru0jPD4cBX5W52E2x8LSsCQWAyPYz/VAqZ
UqhU/5ltzHEtgQdHqVObdLBeZuHuMZEYolYBk/BTO9bDBmSg5zyfqOjmeqnUzktz
2rfD8lBTH2sNmYMp7at561EGDT7nsgB6OTrbvdNpXlF9wMFiY4JJ2t1+wePtCT3X
rlGQaTEB4u/vLIL2vY1vX/haHDIBK9bbbS7WxeqasuRKwfPQROGQ0b0qC3Ku8dTL
tCLf+zj8iAWvvieOQOnz
=I9Bb
-----END PGP SIGNATURE-----

--flW39HxDycSWn0NJ--
