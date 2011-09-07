From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Bug#590327: linux-image-2.6.32-5-amd64: Unbalanced enable for
 IRQ 19
Date: Wed, 07 Sep 2011 05:58:33 +0100
Message-ID: <1315371519.3092.457.camel@deadeye>
References: <20110729151848.GA24689@pisco.westfalen.local>
	 <20110731184933.GA2442@goneko.de> <1315368967.3092.430.camel@deadeye>
	 <20110907.003931.1112417911793078586.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-sO7n163mjsEScvfNSG33"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47614 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751770Ab1IGE6q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2011 00:58:46 -0400
In-Reply-To: <20110907.003931.1112417911793078586.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, 590327@bugs.debian.org, jan@goneko.de


--=-sO7n163mjsEScvfNSG33
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-09-07 at 00:39 -0400, David Miller wrote:
> From: Ben Hutchings <ben@decadent.org.uk>
> Date: Wed, 07 Sep 2011 05:16:01 +0100
>=20
> > This is somewhat unusual in that the IDE controller will be sharing its
> > IRQ, but that's supposed to work.
> >=20
> > However, the IDE core attempts to disable and enable the IRQ *before* i=
t
> > allocates it.  If the UHCI driver then allocates the IRQ in the middle
> > of this, the IRQ manager will reset the disable count since the IRQ is
> > not yet shared!
> >=20
> > This might be fixable by changing the IDE core to allocate the IRQ with
> > a dummy interrupt handler while probing.
> >=20
> > Aside from that, maybe pata_it8213 is ready as a replacement for it8213
> > now?  (Kconfig still labels it as EXPERIMENTAL.)
>=20
> I've known about this IDE layer problem for at least a year and any
> fix is too risky to consider seriously.

I had a suspicion that was the case.

> Use the PATA drivers on modern systems, don't use the deprecated IDE
> layer.

Well, I'm concerned with what to do in distro configurations which
aren't just for 'modern systems'.  We already swapped over all the
drivers not labelled as experimental.  With the rest, I worry that we'd
be exchanging obscure IDE drivers that mostly work for obscure libata
drivers that have had little if any testing.  That strikes me as being
even more risky for the users with the old controllers.

I suppose that for those controllers where the libata driver is
experimental we could build both drivers, blacklist the IDE drivers and
let people override that if necessary.  (And hope that most of the bugs
get shaken out of the libata drivers before we do a stable release,
because that is too ugly to keep doing for long.)

Ben.


--=-sO7n163mjsEScvfNSG33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATmb5+ee/yOyVhhEJAQoeSw/+NveAGL67ixqbIEskAOoBP58F6DJrZJzv
du1T44K9VRsPK4e88N5hDXc4+UqywFXyCnVmkAn0UXux4aySzdfMeGP00Z5M36rA
oUq3LiyP971gQLcglfamxjzoUmNkshPPAbKpJOoDCYIaSNjIK3TUmKmbxVZpkzBH
GFKVLfSmaAcSY19EwcjnhZGx20VnduIrizPlRhk2GEJgQLIXxwVkKff/WVJF3Rbm
1pTc2WrXVlEnaDVUtLprQCj8Ku8TZ6QI5MajKn80PfdyiJzoLyL+ul8AzYhMwIPH
GDXQ748GPaF/nzHxUfD60nnCW7V5d8LVL41DOyD6ZGz50GaZlkWoemAWr133PnxM
Op//v8PPdI+MlBpdxdfhmO1iuJkFEom4cglAM/h1+EZ0yvnqDgKR20qQeHkhjptb
RgLUZ6WpNYsux9kyiM7HvOnX/Mbvu2+k8flpasJubX2LTSr0Nbcs0Q7qs/GHJLwR
PYgqlqgt6U9nRJYfgpQa687dEzfx8vkScDe5DbOXNXN/udl9yLXF9IRiqsZBEY/s
MCJvLT14ZSIAE+syuvn+oxB47VwsD9m5jj/z8Y2qpueD+hYS+VHx+l3yldA09xDH
qVGwVWOpiP/c7BIy0tf9AxNuAU9hVVs8d9ReF31QqnkOJFxjhi7M9EZzoRdsg+79
SLt//5OcQ7Y=
=Hq9b
-----END PGP SIGNATURE-----

--=-sO7n163mjsEScvfNSG33--
