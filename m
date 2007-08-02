From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ST340823A disk size issue
Date: Fri, 3 Aug 2007 00:34:13 +0200
Message-ID: <200708030034.13193.bzolnier@gmail.com>
References: <20070801092903.GA1199@nalle> <20070802200357.GA1178@nalle> <20070802214246.63a54fe6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:16177 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756473AbXHBWsn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 18:48:43 -0400
Received: by nf-out-0910.google.com with SMTP id g13so172603nfb
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 15:48:42 -0700 (PDT)
In-Reply-To: <20070802214246.63a54fe6@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, linux-ide@vger.kernel.org


On Thursday 02 August 2007, Alan Cox wrote:
> > hdd: reading: block=3D78165360, sectors=3D1, buffer=3D0xc1e63000
> > hdd: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > hdd: dma_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D7816536=
0,
>=20
> Ok this one does look like its actually a specific drive firmware err=
or
>=20
> > ide1: reset: master: error (0x00?)
> > ide1: start_request: current=3D0xc1e0b408
>=20
> and the drive then shits itself in style. Bart's right - this drive d=
oes
> need a blacklisting. Presumably thats why it shipped with a default H=
PA
> to clip the non-sector=20

Mikko, please verify that the following patch fixes the issue.

[PATCH] ide-disk: workaround for buggy HPA support on ST340823A (take 2=
)

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
hdd: reading: block=3D78165360, sectors=3D1, buffer=3D0xc1e63000
hdd: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=3D0x10 { SectorIdNotFound }, LBAsect=3D78165360, s=
ector=3D78165360
=2E..

Add hpa_list[] table and workaround the issue in idedisk_check_hpa().

=46ixes kernel bugzilla bug #8816.

Thanks to Mikko for investigating the issue and testing this patch.

v2:
* Add missing export and improve patch description a bit.

Cc: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
This patch depends on CONFIG_BLK_DEV_IDEDMA=3Dy but for testing purpose=
s
it is OK.  Final version wouldn't depend on CONFIG_BLK_DEV_IDEDMA,
"[PATCH] ide: add cable detection for early UDMA66 devices (take 3)"
which is in IDE quilt tree moves ide_in_drive_list() out of ide-dma.c.

 drivers/ide/ide-disk.c |   17 +++++++++++++++++
 drivers/ide/ide-dma.c  |    2 ++
 2 files changed, 19 insertions(+)

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
Index: b/drivers/ide/ide-dma.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -153,6 +153,8 @@ int ide_in_drive_list(struct hd_driveid=20
 	return 0;
 }
=20
+EXPORT_SYMBOL_GPL(ide_in_drive_list);
+
 /**
  *	ide_dma_intr	-	IDE DMA interrupt handler
  *	@drive: the drive the interrupt is for
