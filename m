From: Andreas Bierfert <andreas.bierfert@lowlatency.de>
Subject: Problem with pata_amd/sata_nv on ASRock Penryn1600SLI-110dB board
Date: Sun, 24 Feb 2008 22:53:22 +0100
Message-ID: <20080224225322.061dc654@alkaid.a.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_cthulhu.zoidberg.org-29545-1203890006-0001-2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zoidberg.org ([213.133.99.5]:38981 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbYBXV6p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 16:58:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_cthulhu.zoidberg.org-29545-1203890006-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi there,

I got the above mentioned board [1] two weeks ago with a Q6600 cpu. I am ru=
nning
Fedora 8 x86_64. While using 2.6.23, the attached cdrom/dvd drives went all
crazy together with a nice error message of the hdd from time to time.

After switching to 2.6.24 the cd drives were useful again but the hdd error
still occurs, effectively in the worst case making the system fs unusable a=
nd
requiring a hard reset. The error seems to appear randomly and I cannot
reproduce it by causing e.g. high disk usage...

See http://lowlatency.de/kbug/{dmesg,error,lspci} for the 2.6.23 and
http://lowlatency.de/kbug/{dmesg,error,lspci}-2.6.24 for the corresponding =
logs.

I first thought the bug was related to the pata drives so I switched some d=
rives
around to only have sata hdds and only the cd/dvd drives on the pata contro=
ller
(see http://lowlatency.de/kbug/dmesg-newest). Still the same error (just ot=
her
ata numbers of course) for the hdd. Just to note =3D> it also is a different
hdd so I would rule out defective hardware. Current setup is with these
harddisks http://lowlatency.de/kbug/hdparamI and I am still seeing the erro=
r.

Also tried with noapic parameter set at boot time.

Would be cool if anyone has some clues. If more information or tests are ne=
eded
let me know.

Best Regards,
Andreas Bierfert

[1] - http://www.asrock.com/mb/overview.asp?Model=3DPenryn1600SLI-110dB

--=20
Andreas Bierfert, B.Sc.        | http://awbsworld.de      | GPG: C58CF1CB
andreas.bierfert@lowlatency.de | http://lowlatency.de     | signed/encrypted
phone: +49 2402 102373         | cell: +49 173 5803043    | mail preferred

--=_cthulhu.zoidberg.org-29545-1203890006-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHwedSQEQyPsWM8csRAuwhAKCs9CLWxP8LWrJ8+f8SGhOpo+QBzACgqgy+
u+df37xHew9buEajOXr8VXA=
=03DL
-----END PGP SIGNATURE-----

--=_cthulhu.zoidberg.org-29545-1203890006-0001-2--
