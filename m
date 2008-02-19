From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-cd: remove the internal 64k buffer
Date: Tue, 19 Feb 2008 15:32:47 +0100
Message-ID: <20080219143247.GA3980@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:20595 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075AbYBSOc6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 09:32:58 -0500
Received: by an-out-0708.google.com with SMTP id d31so502000and.103
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 06:32:57 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Bart,

here's one more item from my TODO list. The removal is straight forward=
, after
testing it with all my cdrom drives they all seem even to rotate quiete=
r due to
the automatic speed adjustment of the drive to the continuous data stre=
am
bandwidth in contrast to the buffer-mode in which recurring buffer-fill=
 speedups
caused the drive's read speeed to spike in order to keep the buffer fil=
led up
constantly.

Still, i'd keep this a bit longer in -mm to see whether there are some
other issues with it and with all the different workloads.


commit a855bd5d94ddac678cf90b4b8f20dbd3ac8ea29a
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Tue Feb 19 14:25:09 2008 +0100

    ide-cd: remove the internal 64k buffer
   =20
    This removes the internal ide-cd buffer and falls back to read-ahea=
d block layer
    capabilities. Thorough testing (cd burning, dvd read, raw read) giv=
es with the
    bufferless mode marginally better performance in addition to simpli=
fied code.
   =20
    bufferless:
   =20
    dd: reading `/dev/hdc': Input/output error
    6238+0 records in
    6238+0 records out
    204406784 bytes (204 MB) copied, 259.891 s, 787 kB/s
   =20
    real    4m21.598s
    user    0m0.014s
    sys     0m0.744s
   =20
    with the old buffer (2.6.25-rc1):
   =20
    dd: reading `/dev/hdc': Input/output error
    6238+0 records in
    6238+0 records out
    204406784 bytes (204 MB) copied, 262.893 s, 778 kB/s
   =20
    real    4m22.938s
    user    0m0.009s
    sys     0m0.771s
   =20
    Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index b21da31..f1cb85c 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -89,7 +89,6 @@ static void cdrom_saw_media_change (ide_drive_t *driv=
e)
=20
 	cd->cd_flags |=3D IDE_CD_FLAG_MEDIA_CHANGED;
 	cd->cd_flags &=3D ~IDE_CD_FLAG_TOC_VALID;
-	cd->nsectors_buffered =3D 0;
 }
=20
 static int cdrom_log_sense(ide_drive_t *drive, struct request *rq,
@@ -626,47 +625,6 @@ static void ide_cd_drain_data(ide_drive_t *drive, =
int nsects)
 }
=20
 /*
- * Buffer up to SECTORS_TO_TRANSFER sectors from the drive in our sect=
or
- * buffer.  Once the first sector is added, any subsequent sectors are
- * assumed to be continuous (until the buffer is cleared).  For the fi=
rst
- * sector added, SECTOR is its sector number.  (SECTOR is then ignored=
 until
- * the buffer is cleared.)
- */
-static void cdrom_buffer_sectors (ide_drive_t *drive, unsigned long se=
ctor,
-                                  int sectors_to_transfer)
-{
-	struct cdrom_info *info =3D drive->driver_data;
-
-	/* Number of sectors to read into the buffer. */
-	int sectors_to_buffer =3D min_t(int, sectors_to_transfer,
-				     (SECTOR_BUFFER_SIZE >> SECTOR_BITS) -
-				       info->nsectors_buffered);
-
-	char *dest;
-
-	/* If we couldn't get a buffer, don't try to buffer anything... */
-	if (info->buffer =3D=3D NULL)
-		sectors_to_buffer =3D 0;
-
-	/* If this is the first sector in the buffer, remember its number. */
-	if (info->nsectors_buffered =3D=3D 0)
-		info->sector_buffered =3D sector;
-
-	/* Read the data into the buffer. */
-	dest =3D info->buffer + info->nsectors_buffered * SECTOR_SIZE;
-	while (sectors_to_buffer > 0) {
-		HWIF(drive)->atapi_input_bytes(drive, dest, SECTOR_SIZE);
-		--sectors_to_buffer;
-		--sectors_to_transfer;
-		++info->nsectors_buffered;
-		dest +=3D SECTOR_SIZE;
-	}
-
-	/* Throw away any remaining data. */
-	ide_cd_drain_data(drive, sectors_to_transfer);
-}
-
-/*
  * Check the contents of the interrupt reason register from the cdrom
  * and attempt to recover if there are problems.  Returns  0 if everyt=
hing's
  * ok; nonzero if the request has been terminated.
@@ -731,65 +689,6 @@ static int ide_cd_check_transfer_size(ide_drive_t =
*drive, int len)
 	return 1;
 }
=20
-/*
- * Try to satisfy some of the current read request from our cached dat=
a.
- * Returns nonzero if the request has been completed, zero otherwise.
- */
-static int cdrom_read_from_buffer (ide_drive_t *drive)
-{
-	struct cdrom_info *info =3D drive->driver_data;
-	struct request *rq =3D HWGROUP(drive)->rq;
-	unsigned short sectors_per_frame;
-
-	sectors_per_frame =3D queue_hardsect_size(drive->queue) >> SECTOR_BIT=
S;
-
-	/* Can't do anything if there's no buffer. */
-	if (info->buffer =3D=3D NULL) return 0;
-
-	/* Loop while this request needs data and the next block is present
-	   in our cache. */
-	while (rq->nr_sectors > 0 &&
-	       rq->sector >=3D info->sector_buffered &&
-	       rq->sector < info->sector_buffered + info->nsectors_buffered) =
{
-		if (rq->current_nr_sectors =3D=3D 0)
-			cdrom_end_request(drive, 1);
-
-		memcpy (rq->buffer,
-			info->buffer +
-			(rq->sector - info->sector_buffered) * SECTOR_SIZE,
-			SECTOR_SIZE);
-		rq->buffer +=3D SECTOR_SIZE;
-		--rq->current_nr_sectors;
-		--rq->nr_sectors;
-		++rq->sector;
-	}
-
-	/* If we've satisfied the current request,
-	   terminate it successfully. */
-	if (rq->nr_sectors =3D=3D 0) {
-		cdrom_end_request(drive, 1);
-		return -1;
-	}
-
-	/* Move on to the next buffer if needed. */
-	if (rq->current_nr_sectors =3D=3D 0)
-		cdrom_end_request(drive, 1);
-
-	/* If this condition does not hold, then the kluge i use to
-	   represent the number of sectors to skip at the start of a transfer
-	   will fail.  I think that this will never happen, but let's be
-	   paranoid and check. */
-	if (rq->current_nr_sectors < bio_cur_sectors(rq->bio) &&
-	    (rq->sector & (sectors_per_frame - 1))) {
-		printk(KERN_ERR "%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
-			drive->name, (long)rq->sector);
-		cdrom_end_request(drive, 0);
-		return -1;
-	}
-
-	return 0;
-}
-
 static ide_startstop_t cdrom_newpc_intr(ide_drive_t *);
=20
 /*
@@ -1138,11 +1037,9 @@ static ide_startstop_t cdrom_newpc_intr(ide_driv=
e_t *drive)
 		if (!ptr) {
 			if (blk_fs_request(rq) && !write)
 				/*
-				 * If the buffers are full, cache the rest
-				 * of the data in our internal buffer.
-				 */
-				cdrom_buffer_sectors(drive, rq->sector,
-						     thislen >> 9);
+				 * If the buffers are full, pipe the rest into
+				 * oblivion. */
+				ide_cd_drain_data(drive, thislen >> 9);
 			else {
 				printk(KERN_ERR "%s: confused, missing data\n",
 						drive->name);
@@ -1248,10 +1145,6 @@ static ide_startstop_t cdrom_start_rw(ide_drive_=
t *drive, struct request *rq)
 		 * weirdness which might be present in the request packet.
 		 */
 		restore_request(rq);
-
-		/* Satisfy whatever we can of this request from our cache. */
-		if (cdrom_read_from_buffer(drive))
-			return ide_stopped;
 	}
=20
 	/*
@@ -1267,9 +1160,6 @@ static ide_startstop_t cdrom_start_rw(ide_drive_t=
 *drive, struct request *rq)
 	} else
 		cd->dma =3D drive->using_dma;
=20
-	/* Clear the local sector buffer. */
-	cd->nsectors_buffered =3D 0;
-
 	if (write)
 		cd->devinfo.media_written =3D 1;
=20
@@ -2034,7 +1924,6 @@ static void ide_cd_release(struct kref *kref)
 	ide_drive_t *drive =3D info->drive;
 	struct gendisk *g =3D info->disk;
=20
-	kfree(info->buffer);
 	kfree(info->toc);
 	if (devinfo->handle =3D=3D drive && unregister_cdrom(devinfo))
 		printk(KERN_ERR "%s: %s failed to unregister device from the cdrom "
@@ -2095,11 +1984,7 @@ static int idecd_open(struct inode * inode, stru=
ct file * file)
 	if (!(info =3D ide_cd_get(disk)))
 		return -ENXIO;
=20
-	if (!info->buffer)
-		info->buffer =3D kmalloc(SECTOR_BUFFER_SIZE, GFP_KERNEL|__GFP_REPEAT=
);
-
-	if (info->buffer)
-		rc =3D cdrom_open(&info->devinfo, inode, file);
+	rc =3D cdrom_open(&info->devinfo, inode, file);
=20
 	if (rc < 0)
 		ide_cd_put(info);
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 22e3751..a58801c 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -119,10 +119,6 @@ struct cdrom_info {
=20
 	struct atapi_toc *toc;
=20
-	unsigned long	sector_buffered;
-	unsigned long	nsectors_buffered;
-	unsigned char	*buffer;
-
 	/* The result of the last successful request sense command
 	   on this device. */
 	struct request_sense sense_data;
--=20
Regards/Gru=DF,
    Boris.
