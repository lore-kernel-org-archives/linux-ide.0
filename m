From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: CONFIG_IDE_PROC_FS: /sys is not full replacement of /proc
Date: Wed, 18 Jul 2007 07:42:42 +0400
Message-ID: <200707180742.42651.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2005426.dapETvmZ8g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760023AbXGRDm4@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--nextPart2005426.dapETvmZ8g
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

May be I miss something obvious but most information that was available=20
in /proc/ide is missing under /sys. At the very least, Mandriva hardware=20
detection expects /proc/ide/hdX/model; nothing close is under /sys.

Are there any plans to extend IDE /sys interface to provide full range of=20
information from /proc? Alternatively I appreciate description (or pointer =
to=20
thereof) how to get information that was available under /proc/ide=20
without /proc/ide :)

Thank you

=2Dandrey

--nextPart2005426.dapETvmZ8g
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGnYwyR6LMutpd94wRAtYtAKCJRXb8rYaCKfBHEmrXwFJEHZsW8gCgk4Ml
srdU7JrSM6B5UzMG2AJqL0I=
=sog+
-----END PGP SIGNATURE-----

--nextPart2005426.dapETvmZ8g--
