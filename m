From: Ben Hutchings <ben@decadent.org.uk>
Subject: Data corruption when using INIC-1623TA2 controller
Date: Sun, 30 Jun 2013 15:49:24 +0100
Message-ID: <1372603764.5155.17.camel@deadeye.wl.decadent.org.uk>
References: <20130627160606.3447.9939.reportbug@storm.xmen.local>
	 <20130627165114.GK4752@decadent.org.uk> <1372353297.24346.4.camel@phoenix>
	 <20130627173142.GM4752@decadent.org.uk> <1372375714.330.17.camel@phoenix>
	 <1372383087.23847.35.camel@deadeye.wl.decadent.org.uk>
	 <1372427725.23094.17.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-oapRy7Oj+2cEVd241k9m"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44731 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638Ab3F3Oth (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Jun 2013 10:49:37 -0400
In-Reply-To: <1372427725.23094.17.camel@phoenix>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: 714295@bugs.debian.org, Martin Braure de Calignon <braurede@free.fr>, linux-ide@vger.kernel.org


--=-oapRy7Oj+2cEVd241k9m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Martin Braure de Calignon wrote:
> I'm experiencing frequent data corruption on my raid1 ext4 fs.
> The error is not always the same.
>=20
> I first thought it was due to a previous resize of the FS I've done.
> I had multiple times some message about huge amount of multiply claimed b=
locks in inode xxxx.
> fsck.ext4 was not working fully and was always ending with a message like=
 "FS still have error".
> I was unable to copy all the files to another FS to save it.
> So I end up checking the badblocks (that's where I've been dumb, I choose=
 a non data conservative way).
> However, badblock was succesful without errors.
> So in the end I lost some data, however, I don't know if it's due to the =
bug or the the badblocks check. So feel free to readjust severity.
>=20
> Since theni, I have bought two brand new disks, created a completly new e=
xt4 FS, and copied the files that I had succesfully recovered.
> Then I run fsck.ext4 on the FS... it seems it is almost working.
> I'm remounting the /dev/md0... And each time I start using the system ser=
iously, I have new errors, like the one I had today:
> (I was just copying files on it)
[...]
> [1436849.120036] EXT4-fs (md0): error count: 6
> [1436849.120044] EXT4-fs (md0): initial error at 1371763084: htree_dirblo=
ck_to_tree:587: inode 20971803: block 83894316
> [1436849.120054] EXT4-fs (md0): last error at 1371765809: htree_dirblock_=
to_tree:587: inode 41813096: block 167256110
> [1446656.923648] EXT4-fs error (device md0): htree_dirblock_to_tree:587: =
inode #52698372: block 210773049: comm smbd: bad entry in directory: direct=
ory entry across blocks - offset=3D1052(9244), inode=3D1949184565, rec_len=
=3D29816, name_len=3D24
[...]

The kernel log also showed the CPU was reaching its temperature limit,
but after he cleaned out the CPU cooler and corrected the CPU frequency
the problem persisted.  I suggested swapping disks between controllers:

On Fri, 2013-06-28 at 15:55 +0200, Martin Braure de Calignon wrote:
[...]
> So as planned I unplugged the working non RAID1 disk from their
> controller, and connect the ext4 RAID1 and the ext3 RAID1 disk to it
> (yeah these are 2 powerful RAID1 with 1 device only ;) for testing
> purposes).
> I also tried to re-plug each PCI card, and connect the video card fan
> that was not connected (yeah it was a bad idea to limit the noise level
> few years ago).
>=20
> I did all the tests I could to try to overheat the system (same as
> yesterday):
> * 4 running dd if=3D/dev/urandom | gzip >/dev/null for the cpu
> * massive copy from one disk to the other=20
> * delete of duplicates between two directories (with many duplicates)
>=20
> All that in parallel. Everything seems to work fine. No corruption nor
> CPU overheating message (yesterday I still had some even after remove
> the overclock of the CPU).
[...]
> Here's the lspci -vvvv for this card (if I'm not wrong):
>=20
>                 02:09.0 SATA controller: Initio Corporation INI-1623 PCI
>                 SATA-II Controller (rev 02) (prog-if 00 [Vendor
>                 specific])
>                         Subsystem: Initio Corporation Device 1626
>                         Control: I/O+ Mem+ BusMaster+ SpecCycle-
>                 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>                 DisINTx-
>                         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr-
>                 DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>                 INTx-
>                         Latency: 32, Cache Line Size: 32 bytes
>                         Interrupt: pin A routed to IRQ 17
>                         Region 0: I/O ports at 9000 [size=3D256]
>                         Region 1: Memory at ef022000 (32-bit,
>                 non-prefetchable) [size=3D4K]
>                         [virtual] Expansion ROM at 80000000 [disabled]
>                 [size=3D128K]
>                         Capabilities: [dc] Power Management version 2
>                                 Flags: PMEClk+ DSI- D1+ D2+
>                 AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
>                                 Status: D0 NoSoftRst- PME-Enable- DSel=3D=
0
>                 DScale=3D0 PME-
>                         Kernel driver in use: sata_inic162x
[...]

So this does seem to be a fault in either this card or the driver.  Can
you suggest any further tests that Martin could do?

Ben.

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.

--=-oapRy7Oj+2cEVd241k9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUdBFdOe/yOyVhhEJAQrQgQ//UORhmy8VzH436AYHYiPPBQbjGKXBvHlO
fMxhwE5RlFL6hSLEXQscwYcO2Js0QZFqF/EqJfh2IeaMqdME1Sc/80/Dq59EI/te
tatH/2ZsZFJqNr+1MaAYyjEl8GIY795xSnbNxSM2YilriMnmWKCorBd37npPnWTB
TG/rpeMEG7hKoBfrAEvo5xNkFtHJt0hTRYaHzeodi/sfQojQ/aaEHfAiL8fL+rzm
nOdXAZ/pTRTG8eD/iZeDyhaPrESBkpDup20aRNOPiJdMx7w+4e04wXEuq2K4XSLi
GRwlND3LtgHA9oo6wr7QtbRfULbAVhyuPc2/rWPNpRZIBmAjvUD/FBkYbQyqFqvT
nf87+2WTvZWAgaVvJ+xg45QKfsd7hsJ+tnOSrzTM5jAPSnx72RQD6L2UQ3vi5aSh
YX0JWIpv81kQBDUSujYPCLJnAKnecbibd4RQyCK1SRfGErcTnPhIrCHJyDRea2Sb
/izquuS8sS9FvSfa5GtKiAtOwybGNiaHQJZy3E94t6nn3DBFASu1MlGLLAFSJ01P
vSD/avwi6YdTlDOLljJIIq7BXkDGDRAFjsSWaoxEW3lZ8wNANBA6b9mbZwwHG9j/
U8iQZWts9VXe26ntnXunLo2ZV5OrDs5wczF2H+hjsH34uUVcoAEd+6VFgarL11Jo
f1engCLlPbQ=
=XwkO
-----END PGP SIGNATURE-----

--=-oapRy7Oj+2cEVd241k9m--
