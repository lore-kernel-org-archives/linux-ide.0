From: Volker Sauer <vsauer@dvs.tu-darmstadt.de>
Subject: Still having problems after sata_promise: ASIC PRD table bug workaround
Date: Sat, 5 Jan 2008 21:23:46 +0100
Message-ID: <20080105202346.GA23026@dvs.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lnx130.hrz.tu-darmstadt.de ([130.83.174.24]:38373 "EHLO
	lnx130.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753880AbYAEUoW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 15:44:22 -0500
Received: from paris.dvs.informatik.tu-darmstadt.de (paris2.dvs.informatik.tu-darmstadt.de [130.83.166.130])
	by lnx130.hrz.tu-darmstadt.de (8.13.4/8.12.10) with ESMTP id m05KNlfg021007
	for <linux-ide@vger.kernel.org>; Sat, 5 Jan 2008 21:23:47 +0100
Received: from cannes.localdomain (cannes [130.83.166.180])
	by paris.dvs.informatik.tu-darmstadt.de (Postfix) with ESMTP id 09A7B1704
	for <linux-ide@vger.kernel.org>; Sat,  5 Jan 2008 21:23:47 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm running a Promise Technology PDC20318 (SATA150 TX4) (rev 02)=20
controller in on of my servers and I gettig the following error from time
to time - espacially when there's high load on the disks:

ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata6.00: port_status 0x20200000
ata6.00: cmd 35/00:f8:95:6f:83/00:03:02:00:00/e0 tag 0 dma 520192 out
         res 51/84:00:8c:73:83/84:00:02:00:00/e2 Emask 0x10 (ATA bus error)
ata6.00: status: { DRDY ERR }
ata6.00: error: { ICRC ABRT }
ata6: soft resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:0:0:0: [sdd] Write Protect is off
sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA

During this, the system hangs for about 10 seconds.

First I thought that this was related to the ASIC bug in the TX4 and
upgraded to 2.6.24-rc6 - but still the error occurs.

Some more information:

/dev/sda: Seagate ST3250620AS
/dev/sdb: Hitachi HDS722525VLSA80
/dev/sdc: Seagate ST3250620AS
/dev/sdd: Hitachi HDS722525VLSA80
Alltogether in a RAID10 (md).

The both Hitachi disks use to live in my workstation before I put them
into the server. They are about three years old.=20
When these both Hitachis where in the workstation, I had no problems
before about kernel 2.6.16 (I'm not sure). It might be related to change
=66rom the old sata driver to the libata driver!?
In fact, in the workstation, *both* Hitachis produced errors with the
newer kernels, especially when I ran disk-indexing tools like beagle.

After moving them to the server together with the brand new Seagate
disks, only sdd makes problems. All the other disks never produced an
error like that.

NCQ Queue Depth is "1" for all disks.

Can someone tell me what to do?
Is the IBM disk "sdd" broken?
Could it be a cable problem?
Or is it the diver, though?

Regards
Volker

P.S.: please put me on cc:, I'm not on the list.

--=20
Databases and Distributed Systems Group=20
Computer Science Department, Darmstadt University of Technology
Hochschulstrasse 10, Room E118, D-64289 Darmstadt, Germany
Tel: 06151-166232 Fax: -166229 Email: vsauer@dvs.tu-darmstadt.de

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHf+dSfjVOTV3V0OARAv3KAKD+mWGW2H3ZSehhg2/MNvuqbsik7QCghLwd
p1tcvYj0yog58kwPPsmk58A=
=5D/p
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
