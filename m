From: Chris Studholme <cvs@cs.utoronto.ca>
Subject: Re: BUG: spinlock recursion on CPU#0, scsi_eh_3/737
Date: Mon, 7 Nov 2005 14:11:51 -0500
Message-ID: <20051107191151.GA24154@cs.utoronto.ca>
References: <20051107025428.GA2611@cs.utoronto.ca> <436F0F45.5010907@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cliff.cs.toronto.edu ([128.100.3.120]:23710 "EHLO
	cliff.cs.toronto.edu") by vger.kernel.org with ESMTP
	id S965318AbVKGTLx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Nov 2005 14:11:53 -0500
Content-Disposition: inline
In-Reply-To: <436F0F45.5010907@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

With 2.6.14-git5, the BUG doesn't happen, but I still have errors that=20
are equally bad.  First I get:

ATA: abnormal status 0xFF on port 0xF880239C
ata4: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata4: status=3D0xff { Busy }

followed by a series of messages:

ata4: command timeout
ATA: abnormal status 0xFF on port 0xF880239C
ata4: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata4: status=3D0xff { Busy }
sd 3:0:0:0: SCSI error: return code =3D 0x8000002
sda: Current: sense key=3D0xb
    ASC=3D0x47 ASCQ=3D0x0
end_request: I/O error, dev sda, sector 9523967

continuing for sectors: 9523967 9523975 9523983 9523991 9523999 9524007
   9524015 9524023 9524031 ... (every 8th sector)

At this point the machine is pretty much useless.  I cannot login.  I
can get a shell from a mutt process that was running before I started
the test, but I can't su to root and cat /proc/mdstat hangs.  All I
could do is reboot from my serial console using break-s (emergency sync)
followed by break-b.

And here's another datapoint.  Sometimes when I boot, my second
processor fails to initialize and I just reboot again to get it started.=20
This happened today but I left the machine up with just a single
processor running.  The tar|gzip test completed without any failures in
this case (tried it twice).

Chris.


On Monday, November  7, Jeff Garzik wrote:
> Chris Studholme wrote:
> >Hi,
> >
> >I'm having the fillowing problem.
> >
> >
> >[1.] One line summary of the problem:
> >
> >BUG: spinlock recursion on CPU#0, scsi_eh_3/737
>=20
> Can you verify that 2.6.14-git5+ fixes it?
>=20
> 	Jeff
>=20
>=20

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDb6b3wTYpZrwvqLQRAvA/AJ0dO4LGI4rmiykWG7x4nXIXEwH/eQCg4+tJ
HQsWblXojpqGeeBD/M1dLtk=
=Gk+u
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
