From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Again problems with PDC20268 and vol_id
Date: Fri, 9 Mar 2007 20:24:24 +0300
Message-ID: <20070309172424.GB15271@master.mivlgu.local>
References: <4964.131.211.80.61.1173446203.squirrel@hammerhead.dyndns.org> <20070309190856.c86efd73.vsu@altlinux.ru> <2144.131.211.80.61.1173459085.squirrel@hammerhead.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mivlgu.ru ([81.18.140.87]:35804 "EHLO master.mivlgu.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752682AbXCIRY0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 12:24:26 -0500
Content-Disposition: inline
In-Reply-To: <2144.131.211.80.61.1173459085.squirrel@hammerhead.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guido Diepen <guido@jcwodan.nl>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-ide@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2007 at 05:51:25PM +0100, Guido Diepen wrote:
[...]
> Probing IDE interface ide3...
> hdg: Maxtor 4G120J6, ATA DISK drive
> ...
> hdg: max request size: 512KiB
> hdg: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=3D16383/255/63,
> UDMA(100)
> hdg: cache flushes not supported
>  hdg: hdg1 hdg2
[...]
> cartman:/home/guido# fdisk -l -u /dev/hdg
>=20
> Disk /dev/hdg: 122.9 GB, 122942324736 bytes
> 16 heads, 63 sectors/track, 238216 cylinders, total 240121728 sectors
> Units =3D sectors of 1 * 512 =3D 512 bytes
>=20
>    Device Boot      Start         End      Blocks   Id  System
> /dev/hdg1   *          63   120060863    60030400+  83  Linux
> /dev/hdg2       120060896   240121759    60030432   83  Linux

Here is a problem: according to the partition table, the last sector of
hdg2 is 240121759, but the disk has only 240121728 sectors (the number of
last sector is 1 less - 240121727).  So you have a partition which extends
beyond the end of the disk by 240121727 - 240121759 =3D 32 sectors (16 KB).

How did you create these partitions?  Maybe you have changed disks and
used dd to copy the whole old disk, which happened to be slightly bigger?

> I don't know how to verify that the partition table is correct, hopefully
> you can extract this from the supplied data. (If partition table is not
> correct, would I be able to update that dynamically, or must I move all
> data to different disks, reset the partition table and copy data back?)

This depends on the filesystem used on the problematic partition (although
creating a backup copy would be wise in any case).

You need to determine what device size is assumed by the filesystem.  If
you use ext2/3, run "tune2fs -l /dev/hdg2" (this is safe even if the
filesystem is mounted - it only reads some information from the
superblock).  Then from the "Block count" and "Block size" fields you can
determine the size of the filesystem in sectors.

Then, if the filesystem data really does not extend beyond the end of
disk, you can just delete and recreate the hdg2 partition in Linux fdisk
with the proper size (be careful not to make it smaller than the
filesystem).  If the filesystem extends beyond the end of disk, the
situation is worse: there are resizing programs for ext2/3 and some other
filesystems, but they may behave badly when some parts of the filesystem
are not available.  And if you have used xfs, bad luck - xfs can be only
grown, not shrunk, so the only solution is to recreate the filesystem from
scratch.

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFF8ZhIW82GfkQfsqIRAphjAKCLckJtGEFfT9RJrz83j0h4mz35pACePp23
ZvzR8zIpIiODSjP2d5HgquU=
=LcDk
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
