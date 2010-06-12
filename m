From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: More ata_piix spurious IRQs
Date: Sat, 12 Jun 2010 21:38:46 +0100
Message-ID: <1276375126.14011.199.camel@localhost>
References: <20100611222746.37b5efa6@server.gazypan.dyndns.org>
	 <1276298006.14011.149.camel@localhost> <4C13C4D5.5080300@kernel.org>
	 <20100612194944.750682d7@server.gazypan.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-lyRJZ4Sn2CQw5JTPbupw"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57835 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752326Ab0FLUjB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jun 2010 16:39:01 -0400
In-Reply-To: <20100612194944.750682d7@server.gazypan.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeanseb <jeanseb.valette@free.fr>, Tejun Heo <tj@kernel.org>
Cc: 585556@bugs.debian.org, linux-ide@vger.kernel.org


--=-lyRJZ4Sn2CQw5JTPbupw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le Sat, 12 Jun 2010 19:33:09 +0200,
Tejun Heo <tj@kernel.org> a =C3=A9crit :

> Hello, Ben.
>=20
> On 06/12/2010 01:13 AM, Ben Hutchings wrote:
> > (more details at <http://bugs.debian.org/585556>).
> >=20
> > This is in Debian kernel version 2.6.32-15 which is based on stable
> > version 2.6.32.14 but has your backported spurious IRQ handling
> > patch taken from SLE11 (References: bnc#445872, bnc#589449).  Any
> > idea what's going wrong here?  Is there a piece missing from that
> > fix?
>=20
> One great thing about traditional IDE is that the IRQ line is not
> really under the control of the controller so the device can assert
> the IRQ whether the controller want or not and there's nothing much
> the driver can do to prevent runaway IRQs if the device is crazy
> enough (some devices seem to have problem with toggling nIEN for
> example).  Ain't it just great?  :-)

I didn't realise that.  Of course it should be obvious, given that PATA
is based on extension of the ISA bus.

> As the spurious interrupt handling kicked in, the spurious interrupts
> itself shouldn't cause problem.  It would be polling now, so it's
> likely that the device is asserting interrupt and not responding to
> commands properly.  Does the drive work in other environments?
> e.g. Can the BIOS d  it and boot from it?

On Sat, 2010-06-12 at 19:49 +0200, jeanseb wrote:
> Hi,
> the Drive is recognizes by bios and works (fine enough to install
> debian).
=20
But you originally complained that it was responding slowly.

It seems like this is really a hardware bug.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-lyRJZ4Sn2CQw5JTPbupw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUATBPwVOe/yOyVhhEJAQIHFw//QFLaneF2wFEVKje8oWLpt/8fYcYuqjjI
H1FnWS7wlACp5q43YP0XqdMulcrnh60GWdgzMf3agI6ge5iRt96Xf2FNzhoxRdYG
kiVbHL7khmn1Sn3uk5CGO7JdolSLzebBFWHUVPBD/Q/jy5yZBcaeOp57LMUY4Ddg
9spLFns4hpz4ZRU11Aw4KkEBXcYqsxKnkzX1dHQF4SFJAMiJ8QJHQvCBTeKVTenV
s3ABjVGd2IOrIgVeThM98Gy3l5XUfxGVnHIsfz3Z1a4402JHlknNVw/ddPssqbQI
xN4T+ZtoJdDFGzjQ9yTaTexwi24+uoJWWkuztdWfDf8eObwmivQUtMLyNVY+I4zd
NjCBH4v/PXCKgFNs2U8JZnlXhYmtkLGdROu9gxVr54xbtabzwa90gHYIlXfDkoi1
80LIqJldXfOHvhM7YM1Ymj5+rW5u3vgkgGyNGZGuBsoqbTPCGTEM0ZkfBV5h/OCV
0thqQfrwikGwcf38ES3mYJvZe7i1Pc9COosGdaJZows/2rehX5Oz1zHwLasYBmGs
PWHmL9NwY3kWhgiNOMkwW/lenJiUq9PUWWBHneqgu6GnhIQJkQCG27AtyP5Gm1rb
iuBz242PidwfQBnXqqXpeLZNE5X1klIEDsQiG/xwaXGG27TD1ElGyheYXbrx0kR5
RZUJeqlOxH4=
=YvqH
-----END PGP SIGNATURE-----

--=-lyRJZ4Sn2CQw5JTPbupw--
