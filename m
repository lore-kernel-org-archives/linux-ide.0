From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada
 38x
Date: Thu, 20 Sep 2018 09:26:35 +0200
Message-ID: <20180920072635.GB20392@amd>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-3-git-send-email-aditya@kobol.io>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537328730-9156-3-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Prayoga <aditya@kobol.io>
Cc: linux-ide@vger.kernel.org, linux-leds@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Daniel Golle <daniel@makrotopia.org>
List-Id: linux-ide@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-09-19 11:45:30, Aditya Prayoga wrote:
> Enable hidden symbol ARCH_WANT_LIBATA_LEDS so CONFIG_ATA_LEDS can be
> used in kernel configuration.

Should that be hidden symbol and should that be architecture specific?

For a notebook, I may want scrolllock LED to indicate ATA activity
(because I'm using USB keyboard and can't see the disk led).

Hmm. And while at it... it would be nice to have option to watch all
ATA ports combined, as well.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlujS6sACgkQMOfwapXb+vJ8dQCdE9X5r1O9YnzTYdBJ3yXuY6RA
qE4AnA51Hs2yMwmlxrKvUAeyZsL7icqA
=JC5/
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
