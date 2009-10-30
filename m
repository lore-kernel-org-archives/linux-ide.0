From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [PATCH] ide: update Kconfig text to mark as deprecated
Date: Fri, 30 Oct 2009 09:18:39 +0100
Message-ID: <200910300918.39261.Martin@lichtvoll.de>
References: <4AE64FCC.4030102@gmail.com> <20091029.173028.248393897.davem@davemloft.net> <200910300915.51836.Martin@lichtvoll.de> (sfid-20091030_091707_632352_07360635)
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2747328.58xuxTDsLv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755984AbZJ3ISh@vger.kernel.org>
In-Reply-To: <200910300915.51836.Martin@lichtvoll.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, hancockrwd@gmail.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--nextPart2747328.58xuxTDsLv
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Am Freitag 30 Oktober 2009 schrieb Martin Steigerwald:
> Am Freitag 30 Oktober 2009 schrieb David Miller:
> > And yes I absolutely do consider it too onerous to change my fstab
> > because I have to (or want to be able to) go back to older kernels
> > which will only have the IDE stack enabled.  I refuse to have to
> > monkey around with my fstab every time I want to go back and forth.
>=20
> You don't need to when you used UUID or LABEL - I prefer the later
>  cause  its more readable. Actually I never quite understood while one
>  would want to use dynamic things like /dev/hdd or /dev/sdb in the
>  first place. Thats for me not that much better than C: or D:. Connect
>  your harddisks differently and you are screwed.

One thing to add: If you use a InitRD, you can use UUID or LABEL in GRUB 1=
=20
as well. I believe GRUB 2 at leasts supports UUID out of the box, but=20
better check this, before relying on my word.

=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart2747328.58xuxTDsLv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkrqoV8ACgkQmRvqrKWZhMftzACcCPbwpx6uhUY1rA0kjQPygVS/
NdgAoLMOzbX6tmZ2EPbZiD0yA8mXOu+f
=Dvuo
-----END PGP SIGNATURE-----

--nextPart2747328.58xuxTDsLv--
