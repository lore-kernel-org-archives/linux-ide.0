From: Ben Hutchings <ben@decadent.org.uk>
Subject: Working around bogus HPAs in libata
Date: Sun, 21 Mar 2010 17:25:18 +0000
Message-ID: <1269192318.18314.218.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ydH4LdQCjsT4LA+h5pbN"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35480 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752272Ab0CURZX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Mar 2010 13:25:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: debian-kernel@lists.debian.org


--=-ydH4LdQCjsT4LA+h5pbN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Since SCSI has no concept of the Host Protected Area (HPA) supported by
ATA, ATA disks handled by libata have no set_capacity() operation and it
appears to be impossible to override an HPA except through the libata
module parameter.

In particular, this means that the workaround for bogus HPAs in
rescan_partitions() does not work:

			if (bdops->set_capacity &&
			    (disk->flags & GENHD_FL_NATIVE_CAPACITY) =3D=3D 0) {
				printk(KERN_CONT "enabling native capacity\n");
				capacity =3D bdops->set_capacity(disk, ~0ULL);
				disk->flags |=3D GENHD_FL_NATIVE_CAPACITY;
				if (capacity > get_capacity(disk)) {
					set_capacity(disk, capacity);
					check_disk_size_change(disk, bdev);
					bdev->bd_invalidated =3D 0;
				}
				...

This creates a serious problem when transitioning from IDE drivers to
libata-based drivers: partitions may disappear or be truncated.  For
example, see <http://bugs.debian.org/574795>.

One workaround is to ignore the HPA by default, but this can result in
data loss:
<https://bugs.launchpad.net/ubuntu/+source/linux/+bug/380138>.

I think that sd should implement set_capacity() and somehow pass through
requests to libata.  This could perhaps be done using the new ATA
PASS-THROUGH commands in the SATL, but I regret that I do not know
enough about either ATA or SCSI to produce a patch.

Ben.

--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.

--=-ydH4LdQCjsT4LA+h5pbN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUAS6ZWdOe/yOyVhhEJAQLLhRAAkm9SLLocOH0BGMTzOFlvvfNEOP5iJmZc
JKrpNp23qCYGzrMmdD8IcKlVDyHisUCpGvyzvQgunPwi311us8HPheNXYT1nlUsS
d8r1RlITVSaBjhd2RtQW13wSYOFG9Jceg/OqdjJU30oL5cBFZq/0WcJu2DVXx/Fg
C44C5g63H1Z80BHKYniyEuJ5lFtk1WidKsp0R567GeL8gWMWjiAgD3kt4Mk04eyj
bOCrpG7KZmAIdroNIY5MSF20PoSVQLRtGRKQygA3KdUVxjiymDvQXzt/YaDQP0b/
tQ9aqx3pEeAAC9vDfEO/z8pFocddd4TaE6qPnqCI6rxjjG37SB/kpEDl4IJhMr/Q
xBtqOaNJCXOxrWfREvS9sLsFYzDBOvzAvllMoZNRCORmRLr39B4ZanJvyrrsUpNf
I/9ufNuf+CCZVXZp9cXRtSRlHbQf5Ww5zywveC2G7mLUAWIZsViEeFp4jSrAp4BS
wMhhgIbp1napiYI0IIttzOx8IhiPUpmkvKVsEDXsKIWLP+zLwfWZ9+w+4CINOqoU
xi3lqkyah4OlaSgfTL05d7KN5YN8/lwOjZDJBge8XA+ZZSbxRFu1xFk/8Wbb0Nb9
IAKC8WvKi776mCcehYbhELWW7wCn6f27rHnstQq5HENWxfzl1bKQV/dAgrUMBE2c
mfl9iwInFeE=
=EkGZ
-----END PGP SIGNATURE-----

--=-ydH4LdQCjsT4LA+h5pbN--
