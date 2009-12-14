From: Sascha Silbe <sascha-ml-linux-kernel-ide@silbe.org>
Subject: Re: SiI3811 PATA->SATA bridge not working on OpenRD-Base
Date: Mon, 14 Dec 2009 20:59:09 +0100
Message-ID: <20091214195909.GB29549@twin.sascha.silbe.org>
References: <20091113212332.GD1965@twin.sascha.silbe.org> <4B14B2C8.6080002@kernel.org>
Reply-To: Sascha Silbe <sascha-ml-reply-to-2009-4@silbe.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from setoy.chost.de ([217.160.209.225]:56822 "EHLO smtp.chost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758169AbZLNUAx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Dec 2009 15:00:53 -0500
Content-Disposition: inline
In-Reply-To: <4B14B2C8.6080002@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2009 at 03:08:08PM +0900, Tejun Heo wrote:
> In libata-sff.c there are several places which set AC_ERR_HSM.  They
> store the reason why they're setting it using ata_eh_push_desc() but
> for EH commands those messages aren't printed out (we probably need to
> fix that).  Anyways, can you please conver those to printk's and see
> which one is setting HSM error?
OK, this got me going, thanks! I couldn't find where AC_ERR_HSM is set,=20
but sata_mv now told me about the IORDY timeout. It seems the IDE<->SATA=20
converter is slower than the internal native SATA HD, but probably (see=20
below) still within spec.

mv_soc_reset_hc_port() sets EDMA_IORDY_TMOUT to the default value of=20
0xBC which assumes a 150MHz clock. After setting it to 0xFA (which=20
assumes a 200MHz clock) the device works fine (at least with hdparm=20
-tT).

Clock description for the 88F6281 (the SoC on the OpenRD-Base) is=20
incomplete and/or messy in the published documents (Functional=20
Specifications and Hardware Specifications), so I'm not quite sure what=20
the right value is:
- Hardware Specifications defines TCLK/Core clock as 200MHz and SATA=20
clock as 150MHz
- stock UBoot (i.e. Marvell version) prints 400MHz for "SysClock" and=20
200MHz for "TClock"
- Functional Specifications says eIORdyTimeout is the "number of system=20
cycles", giving 0xBC for "SysClock =3D=3D 150MHz"

So depending on what exactly the clock source for the IORDY timeout is,=20
the correct value should be one of:
- 0x00BC (150MHz, SATA clock from Hardware Specifications; implying the=20
device is too slow so unlikely as it works fine with other hosts)
- 0x00FA (200MHz, TCLK from Hardware Specifications)
- 0x01F4 (400MHz, SysClock from UBoot)

CU Sascha

--=20
http://sascha.silbe.org/
http://www.infra-silbe.de/
--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEcBAEBAgAGBQJLJpkJAAoJELpz82VMF3DanacH/AjJsaJf6BAt6a3uo8cBIncl
6kHanTorNpfN3rdDkj85G0EI4xDYWMXT1+WqHtbcZNbYVp0HI6cbc9HCIvqgiyhU
7Iz/iMgDI1t4/kaOB50GLJg603PTbws71KIXYcivM/qT/GgFUTv3jYxSndP7sZlO
fR0GE3ec2qgvEgVCjXYo5Pn3WEeo3c+o/WG9IffFGq0IVirI8pKCUt4jbHkbr4fS
a6oh1/L1i690i9XoPEgM1blc/Tst9iCUK4CvEAG2lPKWsMU7dmLXvy0cdXhP+f/d
bwdk62p3UMtd0RukmRjUOWoQd1wVHsAJn+dgqdhWsu+IGUWEmJ3Gb9YfzFv+Dok=
=2ABw
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
