From: linux-ide-owner@vger.kernel.org
Subject: [chrisc@terminalarrogance.com: RE: Bug#258500: Installer fails to recognise SiI3112 hw RAID array]
Date: Sun, 18 Jul 2004 14:04:53 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040718210453.GO26350@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oYAXToTM8kn9Ra/9"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:32110 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264524AbUGRVFa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jul 2004 17:05:30 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, benh@kernel.crashing.org
Cc: chrisc@terminalarrogance.com


--oYAXToTM8kn9Ra/9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello SATA people,

Here's a message from Chris Carr who tried to get his Silicon Image
"RAID" adapter working during his test of the Debian Installer. Is
there any chance of being able to enumerate the adapter's RAID
configuration in Linux-space? Is the support already implemented
(excuse my ignorance if it already is)? Are there plans to do so
at all in the future?

The Debian Installer currently uses kernel version 2.6.7 and 2.4.26 with
SATA support patches.

Thanks a lot!

-Josh

----- Forwarded message from Chris Carr <chrisc@terminalarrogance.com> -----

X-Original-To: joshk@triplehelix.org
=46rom: Chris Carr <chrisc@terminalarrogance.com>
To: 'Joshua Kwan' <joshk@triplehelix.org>, 258500-quiet@bugs.debian.org
Subject: RE: Bug#258500: Installer fails to recognise SiI3112 hw RAID array
Date: Sun, 18 Jul 2004 20:22:34 +0100
Organization: Terminal Arrogance Productions
Importance: Normal
X-CRM114-Version: 20040419-BlameEasterBunny-auto.1 MF-CF620E29=20
X-CRM114-Status: Good  ( pR: 23.6269 )

> On Tue, Jul 13, 2004 at 10:12:16PM +0100, Chris Carr wrote:
> > Neither .... I see sda and sdb ... same two drives, but called
something
> > different by the different driver. Still no RAID array.
=20
> OK, here's the situation. I just experienced this problem in the lab
> this afternoon.

Ah!
=20
> It is true: SiImage "RAID" arrays are really supposed to be handled by
> the driver in a software RAID fashion. This is outside the realm of
> kernel space at least for now because sata_sil doesn't understand the
> formation of those arrays and can't enumerate just the single logical
> drive to the kernel yet.
>=20
> Therefore, you can't use this properly until the kernel supports it.
> Sorry. :(

Ok. I'm keen to lend my support to whoever is writing this. Could you
tell me whom to contact? The siimage maintainer, or the sata_sil one, or
someone else?=20

> On the other hand, you can nuke Windows and set up Linux software RAID
> across the two drives, leaving a little chunk for Windows on one of
> them.

I assume that the controller must count for something, ie. This must be
at least slightly faster than pure software RAID. I'm all for nuking
Windows - but then the driver might not get written. I'll stay like this
a while and see if I can encourage or help the right maintainer ....

Thanks again,

CC


----- End forwarded message -----

--=20
Joshua Kwan

--oYAXToTM8kn9Ra/9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQPrl9KOILr94RG8mAQJorxAAgeXqsqk+KmxoqylO8tS1cjJ5ZCZc2pUL
b/BSEeALdmY0kD5VVflG88tgyB0Mqmyp7jS6NG5G2cHCEAGI1CngVgAo3eD+s0uh
utOIOgoRGfFGbSk96pIdSifQQAE32JJcbGcG6NPSOg89Xj5oEgULgUGtbJcRpOpc
gmo2knmK3l29nlL6neKeuztrBTzBems83OiU7+V+yOM5+XyVAdhwndeE8r6OFcwt
AfMUJkIDSU0FM1X9AMITpYB9rQkvL4s6JvQ31eCK5loSd3cN9ibxbnRSsvlsIzSQ
sj9UPb4fvf4iiosTwHjlvlyXqHKeWbFfp/E+VzwYxyF56Fk4Y+blKISbsEL5GQCF
M6gmZe44jnVD8VL+e3uG5MobnY1Dw+00FNWemKjW6UCi1wYyQNpx7/wwr9q8o2JC
3MRINTu+CvAmsfbnkB7oWQ41fhyG1GxPrvL4btk9rkQgzJF4wr5VNaPEor9iPJnj
Bzs0Uv8iKeE3CdhmRGBor0JClQZYeu2MvUqatia2iAbU3SyiXyqzquZOmGWe/a+d
AnAoqA5xr9Lm98oM2JzPFE6Y7TMjv3iJzTk7G4HxOwjlL/5iSGfS2KKLu2ahUWTe
ALEdsXNgWhDf9NDd6sHReEm31vbWTeZkbTTBAYEfTMIyPlLwREHsu6zZ3WQCEqP2
xxB43oZqO0Y=
=V/8H
-----END PGP SIGNATURE-----

--oYAXToTM8kn9Ra/9--
