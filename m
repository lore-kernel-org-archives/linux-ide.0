From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: pata_ali exceptions (timeout)
Date: Sat, 11 Aug 2007 14:34:40 +0400
Message-ID: <200708111434.45994.arvidjaar@mail.ru>
References: <200708111203.34965.fhimpe@telenet.be>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1269618.6DQK0hVEaI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback.mail.ru ([194.67.57.14]:32177 "EHLO mx4.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754407AbXHKKgx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Aug 2007 06:36:53 -0400
In-Reply-To: <200708111203.34965.fhimpe@telenet.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frederik Himpe <fhimpe@telenet.be>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

--nextPart1269618.6DQK0hVEaI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 11 August 2007, Frederik Himpe wrote:
> I'm using a Linux 2.6.22.2 kernel. When the pata_ali driver loads and dis=
ks
> are detected, the system appears to hang for some time, and there are
> exceptions/timeouts in the dmesg log.
>
> The hardware is a Compaq Evo N1020v laptop computer.
>
> I attach the output of dmesg and lspci -vvxx
>
> I suppose this is the same problem as discussed earlier in these threads?
> http://lkml.org/lkml/2006/6/20/309
> http://www.opensubscriber.com/message/linux-ide%40vger.kernel.org/7326463=
=2Eh
>tml

yes very much looks like it. At least it rules out specific ATAPI device is=
sue=20
which I suspected at some point

--nextPart1269618.6DQK0hVEaI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGvZDBR6LMutpd94wRAtYHAJwK0d+87QTftlhYugDJFHFO/nYX4gCgr1Cf
Ekl7B6ABDcEBwbbpYlFJQmg=
=SPPu
-----END PGP SIGNATURE-----

--nextPart1269618.6DQK0hVEaI--
