From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [Bugme-new] [Bug 14518] New: I/O appears to get stuck on certain rsync backup job and system clock halts then
Date: Sat, 31 Oct 2009 13:22:00 +0100
Message-ID: <200910311322.10242.Martin@lichtvoll.de>
References: <bug-14518-10286@http.bugzilla.kernel.org/> <20091031001711.0d3a8238.akpm@linux-foundation.org> <20091031114804.75ca5835@lxorguk.ukuu.org.uk> (sfid-20091031_131226_671401_491E2701)
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2686539.0heZgOtCdH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:36816 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757698AbZJaMcV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Oct 2009 08:32:21 -0400
In-Reply-To: <20091031114804.75ca5835@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>

--nextPart2686539.0heZgOtCdH
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Samstag 31 Oktober 2009 schrieb Alan Cox:

[...]
> > > the machine suddenly reacted again. Later I found out that the time
> > > got stuck. The clock was going several hours to late.
>=20
> If the clock gets stuck for some reason then the block layer and ATA
> timeouts are not going to work so the clock is probably the root cause.
> Clock stopped sounds like an IRQ jam, and given removing the card fixed
> it then possibly the drive jammed the IRQ on.
>=20
> > > This brought some more UDMA CRC errors into the SMART LOG of my 500
> > > GB eSATA drive. Good that this is only an old age attribute.
> > > Anyway, both drives are
>=20
> CRC errors are just logs of messages failing to get across uncorrupted
>  - its a sign of bad cables/power/adapters/ using SATA devices with
>  eSATA and not eSATA devices and the like. It's not really a sign of
>  drive problems.
>=20
> I would say you had two problems
>=20
> #1 Your eSATA cabling/power is flaky

I easily believe that for the first two occurences. As I said that eSATA=20
case / cabling turned out to be quite flaky later on.

But on the third try I completely replaced it. Only thing that is=20
unchanged is the 1 GB eSATA drive. But then on the third case I did not=20
see *any* errors in the log at all until I disconnected both drives and=20
removed the PCMCIA eSATA controller.

As of my knowing it should all be eSATA cables. I used the cables that=20
where delivered with the eSATA cases.

> #2 the Cardbus Sil3512 controller somehow got stuck asserting an
> interrupt that wasn't cleared.

What could be the reason for that one? Could it be that the PCMCIA card=20
had to many plug / unplug cycles. Contacts look fine tough.

> Needs the Sil3512 person to look at it. Even with flaky cabling it
>  should have either recovered cleanly or dropped the device.

Yes, thats my main concern. Why did it stuck the machine for so long?

Ok, if I can help with some test I try my best to take to time for it. I=20
will wait for further instructions / questions.

=46or now I just assume that the data in the backup is okay and just use=20
rsync periodically to update the backup - that seems to work. The data is=20
a bit less important than the one on the internal drive so I hope I get=20
away with this ;)

Ciao,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart2686539.0heZgOtCdH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkrsK+gACgkQmRvqrKWZhMdOFQCbBGuMFhQ4neeTtDLv85FIhwDz
p9UAn1aS1gtBT4cTz9Z/XeMWhpx5Xi5n
=DlVn
-----END PGP SIGNATURE-----

--nextPart2686539.0heZgOtCdH--
