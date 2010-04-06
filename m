From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Working around bogus HPAs in libata
Date: Tue, 06 Apr 2010 03:28:50 +0100
Message-ID: <1270520930.24287.102.camel@localhost>
References: <1269192318.18314.218.camel@localhost>
	 <4BB5637E.4050604@kernel.org> <1270245450.12516.187.camel@localhost>
	 <4BBA95F8.7070909@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QuYe2SrkBMDHmLzNpIWo"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42945 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757082Ab0DFC24 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Apr 2010 22:28:56 -0400
In-Reply-To: <4BBA95F8.7070909@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, debian-kernel@lists.debian.org


--=-QuYe2SrkBMDHmLzNpIWo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-04-06 at 11:01 +0900, Tejun Heo wrote:
> Hello,
>=20
> On 04/03/2010 06:57 AM, Ben Hutchings wrote:
> > Several distributions have turned on the switch by default.  As I said
> > previously, this turned out to be a bad idea.
>=20
> Heh, yeah, I did that on openSUSE which was mandatory for backward
> compatibility because ide unlocked HPA by default (at least on
> openSUSE).  Do you know how common are these problem cases w/ default
> HPA unlocking?

No idea, but they look serious enough to worry about.

> Diddling with HPAs and writing stuff to disks from
> BIOS is generally a very bad idea because it means that switching BIOS
> options or attaching a hard drive to a different motherboard can lead
> to data corruption.

If a system vendor puts its own name or model numbers on the disks it
ships then I think the BIOS or other platform firmware can reasonably
assume that it 'owns' and can write to the HPA on a disk with the
vendor's identification.  (I wouldn't be at all surprised to find that
some vendors take shortcuts though.)

[...]
> > My test case also revealed a bug in the partition scanning retry:
> > partition 2 is an extended partition and wholly within the HPA, so the
> > extended partition table is not accessible until the HPA is disabled.
> > But it is not rescanned after the HPA is disabled.  However, this is is
> > consistent between IDE and libata drivers and will not be a regression
> > when making the transition.
>=20
> Ah... I see, but let's fix that up too.  It could be worse to have
> half working workaround than not working around at all.  I'll update
> the patch once the currently pending HPA updates are in.

Oh, what are those?

I want to apply some version of this fix in Debian soon so we can
complete the transition to libata.  I would very much appreciate it if
you could answer whether or not the multiple 'capacity change' messages
may indicate a problem.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-QuYe2SrkBMDHmLzNpIWo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUAS7qcWOe/yOyVhhEJAQI5RA/9E3ukXQvHgiX6n+SW5VJak2Jo4bgf53or
TC2nIEQmx8ASPu871EEk2XUbPV7x5wfIUUeZ1SCbKXSnFV2B+PRp5K/xzSJjoAfi
GdcC7z3phYIRyidJxhMi74o+LXcyOaPsvHH3fj3JVanSoGBxrwhadI92ZUvKUfaW
83SEnM3Uzdk1iofTdtZuG5DI1abTToGcIAgyEz9S4UPf4xqhFi7ajsXn566QZYz5
KYgFZjymTKv5QY8FRfl3FwxApAEDOdE+lGTW7sIegY8fSt+oV57jx1BCzckBwF49
Y2k9YoUAnoQfBhc4p+NcosmzKMoJrPavhL4gtZjeAv97SZSSef62+eEW9wtgpPL0
BfU29qihvzFdGxzkQSA8gPQPJbbI2DIeTCDiJVwuqCcjqQXoMLhl5tNLDYM+BuJH
7AZ7truM5LAcIzEBk+BrAQfa4CvUqcLVYEoUEcNH83EswheFqTSyPMwgOrwDw9sx
nZ7KfzpUAJo/2GfH5zXWoeerB0dDz1cGQPPYAdnOXUxesH6MgO/xX53Z6Lkft7rx
grRKHs2uzs/s1MqaF6MHvtHTmeu8qiirBPqTNwbhC0499P98bCn9wVi3Opq0pOyB
bnmXM+ax4YAAMgDeLzy0xXlMPjG1cUp7VHUQ2ZBe7bTB3mxAf+u//g2/Pw/aFLp4
EFvdE/j9fKU=
=PYEC
-----END PGP SIGNATURE-----

--=-QuYe2SrkBMDHmLzNpIWo--
