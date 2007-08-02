From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ST340823A disk size issue
Date: Fri, 3 Aug 2007 01:35:16 +0200
Message-ID: <200708030135.16910.bzolnier@gmail.com>
References: <20070801092903.GA1199@nalle> <200708030034.13193.bzolnier@gmail.com> <20070802231100.GA1861@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:56721 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989AbXHBXgt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 19:36:49 -0400
Received: by mu-out-0910.google.com with SMTP id i10so816811mue
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 16:36:47 -0700 (PDT)
In-Reply-To: <20070802231100.GA1861@nalle>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Friday 03 August 2007, Mikko Rapeli wrote:
> On Fri, Aug 03, 2007 at 12:34:13AM +0200, Bartlomiej Zolnierkiewicz w=
rote:
> > Mikko, please verify that the following patch fixes the issue.
>=20
> A few oopses later and this actually works with vanilla 2.6.22.1 and =
Debian
> 2.6.18 (2.6.18.dfsg.1-12etch2), latter without EXPORT_SYMBOL_GPL sinc=
e
> it's there already.
>=20
> diff -X linux-2.6.22.1/Documentation/dontdiff -upr linux-2.6.22.1.ori=
g/drivers/ide/ide-disk.c linux-2.6.22.1/drivers/ide/ide-disk.c
> --- linux-2.6.22.1.orig/drivers/ide/ide-disk.c	2007-07-10 21:56:30.00=
0000000 +0300
> +++ linux-2.6.22.1/drivers/ide/ide-disk.c	2007-08-03 00:22:46.0000000=
00 +0300
> @@ -481,6 +481,15 @@ static inline int idedisk_supports_lba48
>  	       && id->lba_capacity_2;
>  }
> =20
> +/*
> + * Some disks report total number of sectors instead of
> + * maximum sector address.  We list them here.
> + */
> +static const struct drive_list_entry hpa_list[] =3D {
> +	{ "ST340823A",	"ALL" },

Doh, I forgot that the patch to change "ALL" to NULL was merged after 2=
=2E6.22.
I should have asked you from the beginning to test against 2.6.23-rc1 b=
ut it
is not that bad since now you have also working patches for 2.6.18 / 2.=
6.22.

;-)

> +	{ NULL       ,  NULL  }

Thanks, added this to the patch.

=46inal version (for completness) below.

[PATCH] ide-disk: workaround for buggy HPA support on ST340823A (take 3=
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

v2:
* Add missing export and improve patch description a bit.

v3:
* Add list termination.  (From Mikko)

=46ixes kernel bugzilla bug #8816.

Thanks to Mikko for investigating the issue and helping with this patch=
=2E

Cc: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
This patch depends on CONFIG_BLK_DEV_IDEDMA=3Dy but for testing purpose=
s
it is OK.  Final version wouldn't depend on CONFIG_BLK_DEV_IDEDMA,
"[PATCH] ide: add cable detection for early UDMA66 devices (take 3)"
which is in IDE quilt tree moves ide_in_drive_list() out of ide-dma.c.

 drivers/ide/ide-disk.c |   18 ++++++++++++++++++
 drivers/ide/ide-dma.c  |    2 ++
 2 files changed, 20 insertions(+)

Index: b/drivers/ide/ide-disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -481,6 +481,15 @@ static inline int idedisk_supports_lba48
 	       && id->lba_capacity_2;
 }
=20
+/*
+ * Some disks report total number of sectors instead of
+ * maximum sector address.  We list them here.
+ */
+static const struct drive_list_entry hpa_list[] =3D {
+	{ "ST340823A",	NULL },
+	{ NULL,		NULL }
+};
+
 static void idedisk_check_hpa(ide_drive_t *drive)
 {
 	unsigned long long capacity, set_max;
@@ -492,6 +501,15 @@ static void idedisk_check_hpa(ide_drive_
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
