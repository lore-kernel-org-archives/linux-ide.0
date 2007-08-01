From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ST340823A disk size issue
Date: Wed, 1 Aug 2007 22:34:03 +0200
Message-ID: <200708012234.03375.bzolnier@gmail.com>
References: <20070801092903.GA1199@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:36163 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbXHAUgF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 16:36:05 -0400
Received: by nf-out-0910.google.com with SMTP id g13so82572nfb
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 13:36:03 -0700 (PDT)
In-Reply-To: <20070801092903.GA1199@nalle>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: linux-ide@vger.kernel.org


Hi,

On Wednesday 01 August 2007, Mikko Rapeli wrote:
> Hello,=20
>=20
> (More details at http://bugzilla.kernel.org/show_bug.cgi?id=3D8816 )
>=20
> My home server disk doesn't work with latest kernels since its size i=
s
> reported or probed correctly. With 2.6.22.1 I get:
>=20
> Probing IDE interface ide1...
> hdd: ST340823A, ATA DISK drive
> hdd: selected mode 0x42
> ...
> hdd: max request size: 128KiB
> hdd: Host Protected Area detected.
>         current capacity is 78165360 sectors (40020 MB)
>         native  capacity is 78165361 sectors (40020 MB)
> hdd: Host Protected Area disabled.
> hdd: 78165361 sectors (40020 MB) w/1024KiB Cache, CHS=3D65535/16/63,
> UDMA(33)
> hdd: cache flushes not supported
>  hdd: hdd1 hdd2 hdd3
> hdd: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hdd: dma_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D78165360,=
=20
> sector=3D78165360
> ide: failed opcode was: unknown
> hdd: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hdd: dma_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D78165360,
> sector=3D78165360
> ide: failed opcode was: unknown
> hdd: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hdd: dma_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D78165360,
> sector=3D78165360
> ...
>=20
> And as said shows in bugzilla, badblocks, fsck and smartctl think the
> drive is not broken or going to die too soon.
>=20
> What's the difference between the size formats of
> WIN_READ_NATIVE_MAX_EXT read by
> ide-disk.c/idedisk_read_native_max_address_ext() and (hdreg.h)=20
> hd_driveid->lba_capacity_2 read by, if I read drivers/ide/* code
> correctly, ide-probe.c/do_identify()?
>=20
> If this disk is reporting one of these wrong, which fix could be
> applied?=20
>=20
> Both disabling 'stroke' and removing addr++ in
> ide-disk.c/idedisk_read_native_max_address*() fix the problem, but if
> kernel code is correct and standard compliant, these fixes are out of
> the question.
>=20
> Perhaps a boot parameter to kernel could force the disk sector count =
to
> some value for buggy drives?

Could you try attached patch?

[PATCH] ide-disk: workaround for buggy HPA support on ST340823A

This disk reports total number of sectors instead of maximum sector add=
ress
in response to READ_NATIVE_MAX_ADDRESS command and also happily accepts
SET_MAX_ADDRESS command with the bogus value.  This results in +1 secto=
r
capacity being used and errors on attempts to use the last sector.

=2E..
hdd: Host Protected Area detected.
=A0 =A0 =A0 =A0 current capacity is 78165360 sectors (40020 MB)
=A0 =A0 =A0 =A0 native =A0capacity is 78165361 sectors (40020 MB)
hdd: Host Protected Area disabled.
=2E..
hdd: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D78165360, s=
ector=3D78165360
=2E..

Add hpa_list[] table and workaround the issue in idedisk_check_hpa().

=46ixes kernel bugzilla bug #8816.

Thanks to Mikko for investigating the issue and testing this patch.

Cc: Mikko Rapeli <mikko.rapeli@iki.fi>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: b/drivers/ide/ide-disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -481,6 +481,14 @@ static inline int idedisk_supports_lba48
 	       && id->lba_capacity_2;
 }
=20
+/*
+ * Some disks report total number of sectors instead of
+ * maximum sector address.  We list them here.
+ */
+static const struct drive_list_entry hpa_list[] =3D {
+	{ "ST340823A",	NULL },
+};
+
 static void idedisk_check_hpa(ide_drive_t *drive)
 {
 	unsigned long long capacity, set_max;
@@ -492,6 +500,15 @@ static void idedisk_check_hpa(ide_drive_
 	else
 		set_max =3D idedisk_read_native_max_address(drive);
=20
+	if (ide_in_drive_list(drive->id, hpa_list)) {
+		/*
+		 * Since we are inclusive wrt to firmware revisions do this
+		 * extra check and apply the workaround only when needed.
+		 */
+		if (set_max =3D=3D capacity + 1)
+			set_max--;
+	}
+
 	if (set_max <=3D capacity)
 		return;
=20
