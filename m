From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: libata, devm_*, and MSI ?
Date: Wed, 21 Jan 2009 15:16:18 +1100
Message-ID: <1232511378.11241.64.camel@localhost>
References: <4975F5C1.8090107@rtr.ca>
	 <alpine.LNX.1.00.0901201626090.19665@iabervon.org>
	 <497698E2.7090807@rtr.ca>
	 <da824cf30901202002g52fb73f9v8229fb702dcd033d@mail.gmail.com>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-6hFOVLbQUuoGpdJZCFxO"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:57589 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756782AbZAUEQV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 23:16:21 -0500
In-Reply-To: <da824cf30901202002g52fb73f9v8229fb702dcd033d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Mark Lord <liml@rtr.ca>, Daniel Barkalow <barkalow@iabervon.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-pci@vger.kernel.org


--=-6hFOVLbQUuoGpdJZCFxO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-01-20 at 20:02 -0800, Grant Grundler wrote:
> On Tue, Jan 20, 2009 at 7:39 PM, Mark Lord <liml@rtr.ca> wrote:
> ...
> > Next.. who knows something about debugging MSI across PCI bridges ?
> > I've got a 64-bit box here, PCIe near the core, but with full PCI-X
> > slots on the far side of two bridges.
> >
> > The kernel happily allows my driver to setup MSI, but the interrupts
> > never arrive.  So something somewhere in between is either
> >
> > (1) not set up or quirked quite right, or
> > (2) one of the bridges won't pass MSI and we don't detect that.
> >
> > I'll poke more at it later and post some info, if somebody out there
> > knows enough about this kind of thing to provide some basic hints.
>=20
>=20
> Basic Hints:
> 1) post lspci -v output to verify device (and bridges) is programmed corr=
ectly.
> 2) look for chipset quirks that disable global msi

The kernel shouldn't let you enable MSI if that's the case, ie.
pci_enable_msi() should fail.

It might still be worth looking at the quirks though, in case there's
one for a previous revision of your bridge or something.

> 3) Make sure MMIO ranges for 0xfee00000 are routed to local APIC
>    ie each bridge needs to route that address somehow (negative decode
> is common for upstream).
> 4) manually trigger the MSI by doing a MMIO write to the correct
> 0xfee00000 address with the assigned vector in order to see if your
> interrupt handler gets called.

And can you plug something directly into the PCIe bus? If so does MSI
work on that?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6hFOVLbQUuoGpdJZCFxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl2oZIACgkQdSjSd0sB4dJaEACcCACK7vKL8nNO9nqngcgS/NF8
U1YAnRJiI54ZAV+aLuha7HtHSyxzZBGm
=DiPW
-----END PGP SIGNATURE-----

--=-6hFOVLbQUuoGpdJZCFxO--

