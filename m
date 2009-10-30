From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [PATCH] ide: update Kconfig text to mark as deprecated
Date: Fri, 30 Oct 2009 09:15:51 +0100
Message-ID: <200910300915.51836.Martin@lichtvoll.de>
References: <4AE64FCC.4030102@gmail.com> <51f3faa70910291719kecb5edcp3b8812981b69acb1@mail.gmail.com> <20091029.173028.248393897.davem@davemloft.net> (sfid-20091030_084126_843316_FFA89DBC)
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1930772.Lympb3PX7R";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755474AbZJ3IPv@vger.kernel.org>
In-Reply-To: <20091029.173028.248393897.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, hancockrwd@gmail.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--nextPart1930772.Lympb3PX7R
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Freitag 30 Oktober 2009 schrieb David Miller:
> And yes I absolutely do consider it too onerous to change my fstab
> because I have to (or want to be able to) go back to older kernels
> which will only have the IDE stack enabled.  I refuse to have to
> monkey around with my fstab every time I want to go back and forth.

You don't need to when you used UUID or LABEL - I prefer the later cause=20
its more readable. Actually I never quite understood while one would want=20
to use dynamic things like /dev/hdd or /dev/sdb in the first place. Thats=20
for me not that much better than C: or D:. Connect your harddisks=20
differently and you are screwed.

On AmigaOS partitions were refered by names since the beginning. When I=20
copied my OS to a different harddisk I gave the new partition the same=20
name, copied all files over, removed the old harddisk or renamed the old=20
partition and reduced its boot priority and be done with it. (Not that=20
AmigaOS had a fstab that I could have edited anyway.) This way I could=20
connect an IDE disk with the IDE controller on board, an IDE controller=20
card like FastATA or via bridge to the UWSCSI controller on the CyberStorm=
=20
PPC turbo board without having to change any configuration in order to be=20
able to boot.

(Another thing to copy would be how removable storage devices are handled.=
=20
If you remove a disk or usb stick prematurely while the OS is still=20
writing to it you get a "You MUST insert volume xyz again!" requester and=20
if you do, the writes will be completed. I never have seen any other OS=20
that does it this sane way as a standard. Other OS either disallow device=20
removal where possible or loose data.)

Ciao,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart1930772.Lympb3PX7R
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkrqoLcACgkQmRvqrKWZhMfkmgCgiKSFTacVvgxyN97P8Wk2c05w
U/4AnibEcqjw/Htgrug3P0WPSIQukp3a
=2ObX
-----END PGP SIGNATURE-----

--nextPart1930772.Lympb3PX7R--
