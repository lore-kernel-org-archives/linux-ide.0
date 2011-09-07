From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Bug#590327: linux-image-2.6.32-5-amd64: Unbalanced enable for
 IRQ 19
Date: Wed, 07 Sep 2011 05:16:01 +0100
Message-ID: <1315368967.3092.430.camel@deadeye>
References: <20100725223004.5262.16774.reportbug@localhost>
	 <1280422961.13192.287.camel@localhost> <20100730000715.GA6666@goneko.de>
	 <20110729151848.GA24689@pisco.westfalen.local>
	 <20110731184933.GA2442@goneko.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-T9CGpTU9WloUjkoz4ea7"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47312 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761Ab1IGEQP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2011 00:16:15 -0400
In-Reply-To: <20110731184933.GA2442@goneko.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: 590327@bugs.debian.org, Jan Echternach <jan@goneko.de>


--=-T9CGpTU9WloUjkoz4ea7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Echternach reported that on his system it8213 provokes the warning
"Unbalanced enable for IRQ 19" when probed at boot time.

The previous messages are logged at <http://bugs.debian.org/590327>.

On Sun, 2011-07-31 at 20:49 +0200, Jan Echternach wrote:
> On Fri, Jul 29, 2011 at 05:18:48PM +0200, Moritz M=C3=BChlenhoff wrote:
> > Does this still occur with current kernels?
>=20
> Yes.  Here's a warning from kernel version 3.0.0-1:
>=20
> [    1.984004] ------------[ cut here ]------------
> [    1.984009] WARNING: at /build/buildd-linux-2.6_3.0.0-1-i386-ML66CU/li=
nux-2.6-3.0.0/debian/build/source_i386_none/kernel/irq/manage.c:421 enable_=
irq+0x50/0x69()
> [    1.984011] Hardware name: EP45T-EXTREME
> [    1.984012] Unbalanced enable for IRQ 19
[...]

In the the list of PCI devices in the original report, I see:

> 00:1d.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) U=
SB UHCI Controller #2 [8086:3a35] (prog-if 00 [UHCI])
[...]
> 	Interrupt: pin B routed to IRQ 19
[...]
> 05:07.0 IDE interface [0101]: Integrated Technology Express, Inc. IT8213 =
IDE Controller [1283:8213] (prog-if 85 [Master SecO PriO])
[...]
> 	Interrupt: pin A routed to IRQ 19

This is somewhat unusual in that the IDE controller will be sharing its
IRQ, but that's supposed to work.

However, the IDE core attempts to disable and enable the IRQ *before* it
allocates it.  If the UHCI driver then allocates the IRQ in the middle
of this, the IRQ manager will reset the disable count since the IRQ is
not yet shared!

This might be fixable by changing the IDE core to allocate the IRQ with
a dummy interrupt handler while probing.

Aside from that, maybe pata_it8213 is ready as a replacement for it8213
now?  (Kconfig still labels it as EXPERIMENTAL.)

Ben.


--=-T9CGpTU9WloUjkoz4ea7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATmbwAee/yOyVhhEJAQrTHA/+Jn1OFf4raVbqlId3T2/U+yBsvegzD309
DTIGqitp0KJS5fxq/zZjd6sFHr6aFjD4q8LktxMpwMzu4y+xesxTJGTCUUcvpepb
xUOdorY9fC7Fcziw7Y7YTfj41z48kCYxOTzQAuaZNFXR6bU+R8nLC5FZAubhkSlJ
c6y4GaIN6l75IpAjUzDXDTQnJ+iW2acO9h2ghNGpZ/hBecVPmX2atLtzpb84bBJV
hgtBoCWUy1u3NQblUiIDbpdlbet32y/LcGSNKi1Wlkm54NUe2TkA3K6SlLbfIgks
Fwl7NXjjClhEZi3xsddjnfm8iyamiRQ++kWR5p22Y9e+iDmj+3LmOagcIfYfadIw
9ccuZXdTjYIKzvCnpOo7BpRzPoq2z57a1NxDc8vMb7izspnXU2qjzXTl6y0mAxnt
FaCdb3VoG3HDMXiUvabGalmzGdprpIRJLWOjLWU+V8CXbFw6cQxMX0tDnz5zdORa
PxDJbo1QwBA102i+wfgh8uqBhdIEsKairRE2wuQbWYLuc+mMiVTMRWofA7x293sD
ISCxSCO1C7GL1nAogaXLTImSIRYii2yiLBoo9yEu1yaRlLvr2mlBw/MR3Gyy6/wG
EbmI9oLVWYXphu9II1eQXP6oK6DaK6pFWu3TDj1B5eO3vbEshsDlOdMqpG3gXV1A
Hvm91EgQV20=
=K1YA
-----END PGP SIGNATURE-----

--=-T9CGpTU9WloUjkoz4ea7--
