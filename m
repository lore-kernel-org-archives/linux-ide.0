From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: How to determine performance bottleneck?
Date: Mon, 13 Oct 2008 20:28:36 +0200
Message-ID: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-28170-1223922526-0001-2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:41354 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758072AbYJMS2r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 14:28:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-28170-1223922526-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I'm playing around with performance tuning my disk access, but there is
something limiting my bandwidth to the disks. I was hoping you could
help me determine what.

My setup is a sil3132 controller, connected to a PMP with five disks
behind it. I'm using iostat to measure disk traffic and I'm using reads
via dd for testing.

When I'm accessing a single disk, the bandwidth is 70 - 80 MiB/s. When
I access a second disk, the bandwidth is about 50 MiB/s/disk, and all
five results in 25 MiB/s/disk. In other words, something is limiting
things to about 100 MiB/s. Now the question is what that limiting
factor is.

The PCIe bus can sustain 250 MiB/s, so even with overhead that should
be plenty. The SATA links are in theory 300 MiB/s, so that can't be it
either. The remaining factors are the controller and the multiplier
chip, and/or the way we access them.

Tejun, what kind of throughput have you seen when you have been testing
the sil3132 and multipliers?

Rgds
--=20
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-28170-1223922526-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkjzk1oACgkQ7b8eESbyJLiXJACgrnyvOD1wjZUvQPSYAKQzKnfi
Oo8An39Urz1qogRx5xY6LZOpqyAF55Sg
=PO6F
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-28170-1223922526-0001-2--
