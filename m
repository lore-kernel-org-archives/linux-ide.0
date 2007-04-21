From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Correct way to enable port multiplier support in kernel
	2.6.20-1?
Date: Fri, 20 Apr 2007 20:36:00 -0700
Message-ID: <20070421033600.GA14976@curie-int.orbis-terrarum.net>
References: <d03b6e70704202019gfd7a20atbd9035daacfa9e48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:36395 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754094AbXDUDfs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2007 23:35:48 -0400
Content-Disposition: inline
In-Reply-To: <d03b6e70704202019gfd7a20atbd9035daacfa9e48@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Lebel <lebel@lebel.org>, linux-ide@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2007 at 11:19:55PM -0400, David Lebel wrote:
>  I have a Fusion 500P device (which uses a 3726 chipset), plus a
>  3132-based controller.
"Does it work?" For me - yes. I have the Fusion 500P, and a 3132
controller (I also have a sata_mv, but that's nowhere near PMP ready
codewise :-( ).

There is also still the weird issue of the 1.5Gb speed limit on the 3132
somewhere (when the path hardware-wise is all 3Gb).

>  Any easy-to-use, non-developper oriented patch that could allow me to
>  build a kernel package that would enable PMP so I can see all 5 drives
>  in my library, and not only the first one?
Nope.

However now is probably a good time to start on a plan for this stuff.

Tejun Heo did the initial stuff, and I used his Git tree to update some
patches to a 2.6.20rc2+libata-upstream level.

Those patches I published here:
http://dev.gentoo.org/~robbat2/libata-development/
The sign-off lines esp for the hp_poll should probably reference Tejun,
unless he just picked them up somewhere else.

They really don't apply on top of current kernels, and hopefully some of
the local ata.gods around here can report on the status of the major
portions of them for integration maybe during the 2.6.23 timeframe (and
perhaps 2.6.22-mm).

hp_poll series:
This implemented SATA hotplug-by-polling for cases where
hotplug-by-interrupt was not available.

ata_link:
I'll just include Tejun's description from 4/18
"Introduce ata_link.  It abstracts PHY and sits between ata_port and
ata_device.  This new level of abstraction is necessary to support SATA
Port Multiplier, which basically adds a bunch of links (PHYs) to a ATA
host port.  Fields related to command execution, spd_limit and EH are
per-link and thus moved to ata_link."

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGKYagPpIsIjIzwiwRAgrdAJ9B9Xeiy/4OyrLbeBzxbvQoTXrc9ACeP/yg
gRP1uq5FYQxcvP/NCF4YDwg=
=GrdZ
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
