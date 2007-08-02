From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 14:27:44 +0200
Message-ID: <200708021427.44368.bzolnier@gmail.com>
References: <20070801092903.GA1199@nalle> <200708020117.58916.bzolnier@gmail.com> <20070802123359.1e731c35@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:36624 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbXHBM2n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 08:28:43 -0400
Received: by nf-out-0910.google.com with SMTP id g13so136629nfb
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 05:28:42 -0700 (PDT)
In-Reply-To: <20070802123359.1e731c35@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, linux-ide@vger.kernel.org

On Thursday 02 August 2007, Alan Cox wrote:
> > Additionally fs/partitions/check.c:rescan_partitions() should warn =
if the
> > partition exceeds device size and we are not seeing any such warnin=
g.
>=20
> Why would it if there isn't anything wrong ?

Look at the __generic_make_requests() snippet (which was in my original=
 mail).

=2E..
 =A0 =A0 =A0 /* Test device or partition size, when known. */
=A0 =A0 =A0 =A0 maxsector =3D bio->bi_bdev->bd_inode->i_size >> 9;
=A0 =A0 =A0 =A0 if (maxsector) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sector_t sector =3D bio->bi_sector;

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (maxsector < nr_sectors || maxsector=
 - nr_sectors < sector) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This may well happ=
en - the kernel calls bread()
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* without checking t=
he size of the device, e.g., when
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* mounting a device.
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_bad_sector(bio);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_io;
=2E..

This check prevents requests exceeding device/partition size to ever hi=
t LLD.

Device size is set by LLD itself so we can be sure that it is OK and fo=
r
the partition size the code in rescan_partitions() would warn if the si=
ze
of partition exceeds size of the device.

> The same disks just work in libata even with the hpa being disabled. =
It
> closed a pile of long standing bugzillas about such problems with odd

Logs / bug numbers please.

> sized disks. This therefore (and instrumenting the requests being iss=
ued
> when I first looked at it) made me fairly sure its not the drive. I w=
as
> seeing 1K requests for the last 512 byte sector.

We should never ever see 1K requests for the last 512 bytes sector comi=
ng
from the block layer.  If we make driver handle such cases we may be ju=
st
papering over some other issue.

Bart
