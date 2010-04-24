From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Working around bogus HPAs in libata
Date: Sat, 24 Apr 2010 03:26:35 +0100
Message-ID: <1272075995.11697.41.camel@localhost>
References: <1269192318.18314.218.camel@localhost>
	 <4BB5637E.4050604@kernel.org> <1270245450.12516.187.camel@localhost>
	 <4BBA95F8.7070909@kernel.org> <1270520930.24287.102.camel@localhost>
	 <4BBA9D83.2040909@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-bgF7UjuCPnb/9KKcgNwS"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46141 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754868Ab0DXC1E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2010 22:27:04 -0400
In-Reply-To: <4BBA9D83.2040909@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, debian-kernel@lists.debian.org


--=-bgF7UjuCPnb/9KKcgNwS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-04-06 at 11:33 +0900, Tejun Heo wrote:
> Hello,
>=20
> On 04/06/2010 11:28 AM, Ben Hutchings wrote:
> > If a system vendor puts its own name or model numbers on the disks it
> > ships then I think the BIOS or other platform firmware can reasonably
> > assume that it 'owns' and can write to the HPA on a disk with the
> > vendor's identification.  (I wouldn't be at all surprised to find that
> > some vendors take shortcuts though.)
>=20
> I would be very surprised if no vendor took shortcuts.  :-)
>=20
> >> Ah... I see, but let's fix that up too.  It could be worse to have
> >> half working workaround than not working around at all.  I'll update
> >> the patch once the currently pending HPA updates are in.
> >=20
> > Oh, what are those?
>=20
> The patch I posted is rolled up version which contained currently
> pending HPA unlock on shrink patch.
>=20
>   http://article.gmane.org/gmane.linux.ide/45662

It sounds like that should go to stable as well.

> > I want to apply some version of this fix in Debian soon so we can
> > complete the transition to libata.  I would very much appreciate it if
> > you could answer whether or not the multiple 'capacity change' messages
> > may indicate a problem.
>=20
> Multiple messages are probably sd doing revalidation of the device.  I
> don't think it will cause any problem but I'll look into it later
> today and let you know.

What did you find?

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-bgF7UjuCPnb/9KKcgNwS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUAS9JW1ue/yOyVhhEJAQJnAA/9EtcwG9GY1QD/SIL6BpD54yH0pjRorpbD
WZm5ExJGr9YO+GJE2fUSIeTL810G2ic73LjxcrfoEVvxzc7DyltbteWhGtymyadz
1BBthVY1AgRGV4D29zkzWi12cnRTyyxjlKNsYMxldI689Gk+jDiJ+rJJzpO9UjIW
Et/gx8HSpTs4D/c+6WP/jJUoHT5mtMPQkxOVooMupGI8sD1qczqI6dibtEKLVciC
Loh1A2kcGBfLoD7H8abN+/9dzDMWiVIRz9/Gj+DfGaiftTT+59GcHY22+ODA6X9U
Pt027+RTPIzHRECOCLzhnkeoC0lecV9rbqLWT8vdyMpqdiqAoYSvkeXSn7nrL7G9
seqgIr1qk+LCj3ILpEh87u6q2NxAMm6xMFDMHp17ue2atZ5HGZktNCAlP82m/mJW
+SNGqGHT6Bng7WzNc6aJ4cbXJ9XI2X7oTnJXG0qg2BosKVIVS9hJ3TGzZFrsvxS/
D0K0FmOMnUnjvXqCAR1Ep85eSTvHhfAiWsadOIFVIf5qXmqwY8ywPYaOiyB0+sae
FN5dErIZuLMlFTcAqHcoRFNx4cSNB9vlcAL2Q/GhTuqzggHslStkeaFlUAYtRuZJ
6addlJGYsAnDmVkMCP5rHLwPQuU84EavwyfDf2wNryN9xwZTXi2qE6+9Jcfw+ueL
p1QhVyjyV10=
=kWY1
-----END PGP SIGNATURE-----

--=-bgF7UjuCPnb/9KKcgNwS--
