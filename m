From: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 15:05:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1080565536.3570.4.camel@laptop.fenrus.com>
References: <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com>
	 <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com>
	 <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org>
	 <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com>
	 <20040329080943.GR24370@suse.de> <20040329124147.GC4984@mail.shareable.org>
	 <20040329124421.GB24370@suse.de>
Reply-To: arjanv@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cYoVA754xhfK+5m8VQcf"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040329124421.GB24370@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org


--=-cYoVA754xhfK+5m8VQcf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-03-29 at 14:44, Jens Axboe wrote:
> On Mon, Mar 29 2004, Jamie Lokier wrote:
> > Jens Axboe wrote:
> > > Could be used to limit tcq depth, not just request sizes solving two
> > > problems at once. I already have a tiny bit of keeping this
> > > accounting to do proper unplugs (right now it just looks at missing
> > > requests from the pool, doesn't work on tcq).
> >=20
> > Does it make sense to allow different numbers of outstanding TCQ-reads
> > and TCQ-writes?
>=20
> Might not be a silly thing to experiment with, definitely something that
> should be tested (added to list...)

I wonder if the max read size could/should be correlated with the
readahead size for such devices... it sounds like a related property at
least.


--=-cYoVA754xhfK+5m8VQcf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAaB8gxULwo51rQBIRAgMVAJ4jkvXMA4+8AkWhOYybId0Tc38SwACdHbwO
HVQEyycBOfSJwbjIAPmnXgc=
=jQbt
-----END PGP SIGNATURE-----

--=-cYoVA754xhfK+5m8VQcf--
