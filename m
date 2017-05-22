From: Vagrant Cascadian <vagrant@debian.org>
Subject: Re: [V3,1/3] ata: ahci_tegra: Add AHCI support for tegra210
Date: Mon, 22 May 2017 11:30:46 -0700
Message-ID: <87h90cwxpl.fsf@aikidev.net>
References: <1494581650-11115-2-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cascadia.aikidev.net ([173.255.214.101]:39819 "EHLO
        cascadia.aikidev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbdEVShp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2017 14:37:45 -0400
In-Reply-To: <1494581650-11115-2-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thierry.reding@gmail.com, tj@kernel.org
Cc: tegra@vger.kernel.org, linux-ide@vger.kernel.org, ldewangan@nvidia.com, preetham260@gmail.com, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Chandru R <pchandru@nvidia.com>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-12, PREETHAM RAMACHANDRA wrote:
> From: Preetham Chandru R <pchandru@nvidia.com>
>
> 1. Move tegra124 specifics to tegra124_ahci_init.
> 2. Separate the regulators needed for tegra124 and tegra210.
> 3. Disable DIPM and Devslp for t210 and t124 as there are known issues

When building with this patch applied on 4.11, I got the following
warnings/errors:

../../../drivers/ata/ahci_tegra.c: In function
=E2=80=98tegra_ahci_controller_init=E2=80=99:
../../../drivers/ata/ahci_tegra.c:433:2: error: implicit declaration of
function =E2=80=98tegra_ahci_handle_quirks=E2=80=99 [-Werror=3Di\
mplicit-function-declaration]
  tegra_ahci_handle_quirks(hpriv);
  ^~~~~~~~~~~~~~~~~~~~~~~~
../../../drivers/ata/ahci_tegra.c: At top level:
../../../drivers/ata/ahci_tegra.c:483:13: warning: conflicting types for
=E2=80=98tegra_ahci_handle_quirks=E2=80=99
 static void tegra_ahci_handle_quirks(struct ahci_host_priv *hpriv)
             ^~~~~~~~~~~~~~~~~~~~~~~~
../../../drivers/ata/ahci_tegra.c:483:13: error: static declaration of
=E2=80=98tegra_ahci_handle_quirks=E2=80=99 follows non-static d\
eclaration
../../../drivers/ata/ahci_tegra.c:433:2: note: previous implicit
declaration of =E2=80=98tegra_ahci_handle_quirks=E2=80=99 was here
  tegra_ahci_handle_quirks(hpriv);
  ^~~~~~~~~~~~~~~~~~~~~~~~
../../../drivers/ata/ahci_tegra.c:483:13: warning:
=E2=80=98tegra_ahci_handle_quirks=E2=80=99 defined but not used [-Wunused-f=
unction]
 static void tegra_ahci_handle_quirks(struct ahci_host_priv *hpriv)
             ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
/<<PKGBUILDDIR>>/scripts/Makefile.build:305: recipe for target
'drivers/ata/ahci_tegra.o' failed
make[7]: *** [drivers/ata/ahci_tegra.o] Error 1


Full build log:

  https://www.aikidev.net/~vagrant/jetson-tx1/linux_4.11-1~exp3~20170522~1_=
arm64-2017-05-22T17:54:19Z.build


live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEcDardHbDotegGFCHt4uC1IFLkbYFAlkjLlYACgkQt4uC1IFL
kbaJXg/9Hy5UWcrJ62pPHy36sAWKpatqTeN14UusnJiycto1SzWkTT5TjExCVV5c
01r1s3JzGCC8Unq4Ei6DHDsLbr8tgOH0zwqvl7R5t+/WnZl7g71m71PcTNDR38dC
h8dvZY3ApJForvdQNt4Yf7Q4/lBmynjJGFV1S/B89hBMhoEmpszcybYbj82go9pa
//rShMXB/sKHksmBQJwC59cM3RHgi3sq+Oskw7f3jKVIAdEvk1SbSz8x/0u54Q5W
6auzVWnPa/DskRPhUEjRDIZFdvuxUQd3+gNlasCrP8dj+icOqVocYygal6e3Eyr+
7MTFKAkw0wYi0Jnt6dPcK/b5qP2uPa0q7b5tSrMlJRwP+evzI3ZXZGInI0lLrypG
ieKwRlNX5Z2Nx3mhQzmxPsm/fKEaJaTUkMLtEEecI5Psb1bydObuyrFIguo/o6A4
+NZop/9d7A1k9UFLWRATbtP+ySAh+3Ix7dVGHCZnMtRq6+jvPNzHGSS2Rv4SiwDD
1/L+HRR2BQgMzDj0oWAFOK1zQ07o/0PnWrZ8l5OsAn6D99lt3Y5kMu46V2ZWNGB4
oY7+cR5b3A3CKijnsinpch+E0i3zougLjKbUiytjlbMYiva8LLKclVHNLS+Wkfgs
UOJ4iU/u265e2DZ3f0TBEbmPAo/zrPPr8VY9KAVBQ3aQKuq/2VE=
=Knpu
-----END PGP SIGNATURE-----
--=-=-=--
