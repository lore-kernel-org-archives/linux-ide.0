From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 01 Mar 2006 20:00:16 +0100
Message-ID: <1141239617.23202.5.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bd/DHLecUGJAzjJnvX5E"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932410AbWCATCb@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edmudama@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--=-bd/DHLecUGJAzjJnvX5E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> those drives should support all FUA opcodes properly, both queued and unq=
ueued
>=20
> On 2/28/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> > Mark Lord wrote:
> > > David Greaves wrote:
> > >
> > >>
> > >> scsi1 : sata_sil
> > >>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
> > >>   Type:   Direct-Access                      ANSI SCSI revision: 05
> > >>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
> > >>   Type:   Direct-Access                      ANSI SCSI revision: 05

How about the drives that got blacklisted following :
http://bugzilla.kernel.org/show_bug.cgi?id=3D5914 ?
and
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D177951 ?

Device Model:     Maxtor 6L300S0
Firmware Version: BANC1G10

on

Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev=
 02)

Regards,

--=20
Nicolas Mailhot

--=-bd/DHLecUGJAzjJnvX5E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iEYEABECAAYFAkQF70AACgkQI2bVKDsp8g1V2gCdHxLLMS7Dyt0YcZ4lVLS6TzH6
1/cAoMO3bnWEIDLPAzmWcg5b2HPTC2c4
=SwOE
-----END PGP SIGNATURE-----

--=-bd/DHLecUGJAzjJnvX5E--
