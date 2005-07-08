From: Erik Slagter <erik@slagter.name>
Subject: Re: Readahead with softraid1
Date: Fri, 08 Jul 2005 15:16:32 +0200
Message-ID: <1120828592.23681.24.camel@localhost.localdomain>
References: <1120824029.23681.18.camel@localhost.localdomain>
	 <1120824984.3415.233.camel@vom>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lfEJBRXo9KJ7Bmco9/7h"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:1216 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S262661AbVGHNRH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jul 2005 09:17:07 -0400
In-Reply-To: <1120824984.3415.233.camel@vom>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: DCox@icc.net
Cc: Linux IDE List <linux-ide@vger.kernel.org>


--=-lfEJBRXo9KJ7Bmco9/7h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-08 at 08:16 -0400, Danny Cox wrote:

> > What am I doing wrong here???
>=20
> 	Nothing.  I'll take a shot at answering this one instead of lurking
> this time.  Then, I'll crawl back under my rock.
>=20
> 	The raid1 driver keeps a "last visited block" for each drive.  This is
> the block number that was most recently read or written by that drive.
> When a read request arrives, the driver examines each drive for the
> nearest last visited block to the one requested.  Guess what?  If the
> read starts with drive sda, then it will *always* be the one chosen to
> service the read in the future, because the last visited block number is
> only one off.  This would only change if there are multiple processes
> performing I/O on the md device.  Then, it may switch to another drive.
> In any case, it will *tend* to stick with the same drive.
>=20
> 	Did I explain that well, or only muddy the waters?

perfect explanation, thanks (and also Jens!).

Is this a design decision or is it fundamentaly impossible to split the
work amongst several drives?  I guess the md driver at least do a
prefetch of the next block/chunk on the "other" drive(s)?

Now I am still wondering about the readahead issue. What would be a sane
setting? I guess having both the drives and md doing readahead is not
optimal?

Also I noticed that the default readahead value changed significantly
from 2.4 to 2.6, is there a particular reason for that?

--=-lfEJBRXo9KJ7Bmco9/7h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCznywJgD/6j32wUYRAtdMAJkBnmdCxaTwsaQ+HF1vn6yZBpuupACfQyFd
JPz+pwBuA74Qlpwb7UCXInI=
=3+fX
-----END PGP SIGNATURE-----

--=-lfEJBRXo9KJ7Bmco9/7h--
