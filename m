From: Nathaniel Dube <njdube@gmail.com>
Subject: sata_sis driver may be broken in openSUSE 10.3
Date: Mon, 8 Oct 2007 21:27:53 -0500
Message-ID: <200710082128.00883.njdube@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1297727.4lGTVg2C9D";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:56166 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbXJIC2K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 22:28:10 -0400
Received: by py-out-1112.google.com with SMTP id u77so2762024pyb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 19:28:08 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <linux-ide@vger.kernel.org>

--nextPart1297727.4lGTVg2C9D
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I found your contact information in the file..

/usr/src/linux-2.6.18.8-0.5/drivers/ata/sata_sis.c

And figured you might be the one to talk to.  I, as well as many others hav=
e=20
had issus with openSUSE 10.3 not detecting SATA hard drives.  I don't know =
if=20
the fault is with the kernel developers or openSUSE.  But I do know the iss=
ue=20
is with the sata_sis driver that's being provided with 10.3.

I'm not a programer.  I wouldn't know where to begin to fix this issue.

Here are some links of people having the same problem.

This is one from the openSUSE mailing list.
http://lists.opensuse.org/opensuse/2007-10/msg00496.html

This is one of the web forums.
http://www.suseforums.net/index.php?showtopic=3D39625

And here's some from Newsgroups.  To many to post here.  You could look for=
=20
them here.

news://support-forums.novell.com/opensuse.org.suse-linux.support.install-co=
nfigure-administration
news://support-forums.novell.com/opensuse.org.suse-linux.support.general-ap=
plications
Or on Usenet.
news:alt.os.linux.suse

Search for "sata".

There's also a Novell bug report here.
https://bugzilla.novell.com/show_bug.cgi?id=3D331610

--nextPart1297727.4lGTVg2C9D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHCucwvsn/sQCIOqQRAupWAJ0bxfkK/XTPxBvioRSk8HPthvEOQQCeLFkH
+R0DifMAgdr+JGMP+JxUVUY=
=zerH
-----END PGP SIGNATURE-----

--nextPart1297727.4lGTVg2C9D--
