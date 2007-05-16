From: Scott James Remnant <scott@ubuntu.com>
Subject: Re: Serial ATA (SATA) shutdown info
Date: Wed, 16 May 2007 13:16:46 +0100
Message-ID: <1179317806.16527.73.camel@quest.netsplit.com>
References: <1179232945.16527.25.camel@quest.netsplit.com>
	 <711b967b0705150834sdd14538x459119386c19a7ac@mail.gmail.com>
	 <1179243992.16527.56.camel@quest.netsplit.com> <464AE0EB.9080300@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sS3wsTUmCji5LZp05N/a"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from paperboy.netsplit.com ([82.108.80.242]:60112 "EHLO
	paperboy.netsplit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761130AbXEPMQc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 08:16:32 -0400
In-Reply-To: <464AE0EB.9080300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, 114683@bugs.launchpad.net


--=-sS3wsTUmCji5LZp05N/a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-16 at 12:46 +0200, Tejun Heo wrote:

> > I'll keep an eye on the thread you linked to, if we don't even need to
> > write any zeros, we're definitely happy people :-)
>=20
> Me happy too.  :-)
>=20
Out of interest, do you know there is a hysterical need to sync() before
one calls reboot()?

I would have thought the kernel takes care of making sure it's own data
structures are flushed to disk anyway, but I can't see the reference in
the kernel code for where it might do this.

Scott
--=20
Scott James Remnant
Ubuntu Development Manager
scott@ubuntu.com

--=-sS3wsTUmCji5LZp05N/a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGSvYuSnQiFMl4yK4RAmg3AJ975EIJBqeQ4WuX4PRQtgxaLx8mgACfdoF+
jbnKSwJUdqThJAbIhOFn0hI=
=gb1T
-----END PGP SIGNATURE-----

--=-sS3wsTUmCji5LZp05N/a--

