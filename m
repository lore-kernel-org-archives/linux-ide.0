From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Working around bogus HPAs in libata
Date: Fri, 02 Apr 2010 22:57:30 +0100
Message-ID: <1270245450.12516.187.camel@localhost>
References: <1269192318.18314.218.camel@localhost>
	 <4BB5637E.4050604@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-TciLRN3TJbS0Zw6kLohX"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38966 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755401Ab0DBV5f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Apr 2010 17:57:35 -0400
In-Reply-To: <4BB5637E.4050604@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, debian-kernel@lists.debian.org


--=-TciLRN3TJbS0Zw6kLohX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-04-02 at 12:24 +0900, Tejun Heo wrote:
> On 03/22/2010 02:25 AM, Ben Hutchings wrote:
> > Since SCSI has no concept of the Host Protected Area (HPA) supported by
> > ATA, ATA disks handled by libata have no set_capacity() operation and i=
t
> > appears to be impossible to override an HPA except through the libata
> > module parameter.
> >=20
> > In particular, this means that the workaround for bogus HPAs in
> > rescan_partitions() does not work:
> >=20
> > 			if (bdops->set_capacity &&
> > 			    (disk->flags & GENHD_FL_NATIVE_CAPACITY) =3D=3D 0) {
> > 				printk(KERN_CONT "enabling native capacity\n");
> > 				capacity =3D bdops->set_capacity(disk, ~0ULL);
> > 				disk->flags |=3D GENHD_FL_NATIVE_CAPACITY;
> > 				if (capacity > get_capacity(disk)) {
> > 					set_capacity(disk, capacity);
> > 					check_disk_size_change(disk, bdev);
> > 					bdev->bd_invalidated =3D 0;
> > 				}
>=20
> Hmmm, yeah, this is much better than the dumb switch we have now.  I
> wonder why nobody pointed it out before.

Several distributions have turned on the switch by default.  As I said
previously, this turned out to be a bad idea.

> Does the following patch work as expected?

Without the patch:

[    2.853930] sd 0:0:1:0: [sdb] 150000000 512-byte logical blocks: (76.8 G=
B/71.5 GiB)
[    2.854220] sd 0:0:1:0: [sdb] Write Protect is off
[    2.856273] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.856786]  sdb: sdb1 sdb2 < >
[    2.914459] sdb: p1 size 150866352 exceeds device capacity, limited to e=
nd of disk
[    2.914631] sdb: p2 ignored, start 150866415 is behind the end of the di=
sk
[    2.938499] sd 0:0:1:0: [sdb] Attached SCSI disk

With the patch:

[    2.871114] sd 0:0:1:0: [sdb] 150000000 512-byte logical blocks: (76.8 G=
B/71.5 GiB)
[    2.871395] sd 0:0:1:0: [sdb] Write Protect is off
[    2.871601] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.872177]  sdb: sdb1 sdb2 < >
[    2.914556] sdb: p1 size 150866352 exceeds device capacity, enabling nat=
ive capacity
[    2.914753] ata1: soft resetting link
[    3.116372] ata1.01: n_sectors mismatch 150000000 !=3D 156301488
[    3.116433] ata1.01: new n_sectors matches native, probably late HPA unl=
ock, n_sectors adjusted
[    3.164409] ata1.01: configured for UDMA/100
[    3.164471] ata1: EH complete
[    3.164723] sdb: detected capacity change from 76800000000 to 8002636185=
6
[    3.179393] sd 0:0:1:0: [sdb] 156301488 512-byte logical blocks: (80.0 G=
B/74.5 GiB)
[    3.179842] sd 0:0:1:0: [sdb] Attached SCSI disk
[    3.213602] sdb: detected capacity change from 0 to 80026361856
[    3.214000] sdb: detected capacity change from 0 to 80026361856

For comparison, using an IDE driver:

[    4.172438] hdb: max request size: 128KiB
[    4.173740] hdb: Host Protected Area detected.
[    4.173743] 	current capacity is 150000000 sectors (76800 MB)
[    4.173745] 	native  capacity is 156301488 sectors (80026 MB)
[    4.173922] hdb: 150000000 sectors (76800 MB) w/8192KiB Cache, CHS=3D655=
35/16/63
[    4.177393] hdb: cache flushes supported
[    4.177549]  hdb: hdb1 hdb2 < >
[    4.183025] hdb: p1 size 150866352 exceeds device capacity, enabling nat=
ive capacity
[    4.183842] hdb: detected capacity change from 76800000000 to 8002636185=
6

So, this looks good, but I'm slightly disturbed by the multiple
'capacity change' messages when using libata.  Also, the warnings in
ata_dev_revalidate() should not be shown when we are deliberately
changing capacity.

My test case also revealed a bug in the partition scanning retry:
partition 2 is an extended partition and wholly within the HPA, so the
extended partition table is not accessible until the HPA is disabled.
But it is not rescanned after the HPA is disabled.  However, this is is
consistent between IDE and libata drivers and will not be a regression
when making the transition.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-TciLRN3TJbS0Zw6kLohX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUAS7ZoRee/yOyVhhEJAQInXQ//awSjnOJDppERK0YYWp6G4XlI7iJWktUk
DtL3bL3Kqcj9fQb7r1YbernWPXale16fEnIDl32YvK2A3ld8pQvBnWZInubfsplz
NYnRjMt0E+mFyO9zYrhlXko4t8t7tEhgvq+yPzieZip8MSIyoevHRcYgyMY+1fmM
ulI97wAXirzbDQ/EI1sgPGCOX7NQSKoUyohNoVtE9QW+vK0Mcc80dQE57MIIkULb
6e2d977N95xOxO87ygZfeRaIwStlTTzsyoHqbiQirKxm+RMOZOZPbzhGytSWDxOZ
Mrw87yursJjK6EeYrtp5tpx324H1kWXrXu04cCnINZdUkkJfzDS5/eypMI21pi38
lW0UrDzfRJygtoAGiEcKNW6EBWfhzwEVcikPpCT7u4T8RG6Wqyh0QnmUXLqWKvhd
ZFv0TIM+ZOWStuuQ4StHRQXDIhmHmAkRkyfWoUJr2GPHJF5XA4g8OpTV0YRJ4O9a
by8tzIUjLy2akJXYzjuRw7YCXEuhAYFNDN6qi5HwJaJ79yy0iRSGUys7+3hcmQA0
AjtgyjbPUc1cX0BxpKQzf3aTYCPpB2MwwLN7N9cnw0v2V29n9+DVI65EFSIovM/+
PAbFP1VI/Z88QKiwv52Kam3HAiBptn7BRTBe6XgpSUE51q891PuJuYMMrPOm8QVp
tWnqMsNIlys=
=A2YE
-----END PGP SIGNATURE-----

--=-TciLRN3TJbS0Zw6kLohX--
