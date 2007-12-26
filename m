From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH] ide-cd: move the remaining cdrom.c ioctl handling code to
	ide-cd_ioctl.c
Date: Wed, 26 Dec 2007 21:50:14 +0100
Message-ID: <20071226205014.GA7228@gollum.tnic>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp116.plus.mail.re1.yahoo.com ([69.147.102.79]:47725 "HELO
	smtp116.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751611AbXLZUwZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Dec 2007 15:52:25 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Bart,

the following moves the remaining cdrom.c ioctl-related pieces to their=
 proper
location. It applies on top of your 63 redux patches and shouldn't be c=
hanging
anything in the current functionality of the driver.

--
=46rom: Borislav Petkov <bbpetkov@yahoo.de>

There should be no functional changes caused by this patch.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-cd.c       |  186 +-----------------------------------=
--------
 drivers/ide/ide-cd.h       |    7 ++-
 drivers/ide/ide-cd_ioctl.c |  179 ++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 186 insertions(+), 186 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 23d4987..b19e713 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1396,7 +1396,7 @@ void msf_from_bcd (struct atapi_msf *msf)
 	msf->frame  =3D BCD2BIN(msf->frame);
 }
=20
-static int cdrom_check_status(ide_drive_t *drive, struct request_sense=
 *sense)
+int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense=
)
 {
 	struct request req;
 	struct cdrom_info *info =3D drive->driver_data;
@@ -1417,85 +1417,6 @@ static int cdrom_check_status(ide_drive_t *drive=
, struct request_sense *sense)
 	return ide_cd_queue_pc(drive, &req);
 }
=20
-/* Lock the door if LOCKFLAG is nonzero; unlock it otherwise. */
-int ide_cd_lockdoor(ide_drive_t *drive, int lockflag,
-		    struct request_sense *sense)
-{
-	struct cdrom_info *cd =3D drive->driver_data;
-	struct request_sense my_sense;
-	struct request req;
-	int stat;
-
-	if (sense =3D=3D NULL)
-		sense =3D &my_sense;
-
-	/* If the drive cannot lock the door, just pretend. */
-	if (cd->cd_flags & IDE_CD_FLAG_NO_DOORLOCK) {
-		stat =3D 0;
-	} else {
-		ide_cd_init_rq(drive, &req);
-		req.sense =3D sense;
-		req.cmd[0] =3D GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
-		req.cmd[4] =3D lockflag ? 1 : 0;
-		stat =3D ide_cd_queue_pc(drive, &req);
-	}
-
-	/* If we got an illegal field error, the drive
-	   probably cannot lock the door. */
-	if (stat !=3D 0 &&
-	    sense->sense_key =3D=3D ILLEGAL_REQUEST &&
-	    (sense->asc =3D=3D 0x24 || sense->asc =3D=3D 0x20)) {
-		printk (KERN_ERR "%s: door locking not supported\n",
-			drive->name);
-		cd->cd_flags |=3D IDE_CD_FLAG_NO_DOORLOCK;
-		stat =3D 0;
-	}
-=09
-	/* no medium, that's alright. */
-	if (stat !=3D 0 && sense->sense_key =3D=3D NOT_READY && sense->asc =3D=
=3D 0x3a)
-		stat =3D 0;
-
-	if (stat =3D=3D 0) {
-		if (lockflag)
-			cd->cd_flags |=3D IDE_CD_FLAG_DOOR_LOCKED;
-		else
-			cd->cd_flags &=3D ~IDE_CD_FLAG_DOOR_LOCKED;
-	}
-
-	return stat;
-}
-
-
-/* Eject the disk if EJECTFLAG is 0.
-   If EJECTFLAG is 1, try to reload the disk. */
-static int cdrom_eject(ide_drive_t *drive, int ejectflag,
-		       struct request_sense *sense)
-{
-	struct cdrom_info *cd =3D drive->driver_data;
-	struct cdrom_device_info *cdi =3D &cd->devinfo;
-	struct request req;
-	char loej =3D 0x02;
-
-	if ((cd->cd_flags & IDE_CD_FLAG_NO_EJECT) && !ejectflag)
-		return -EDRIVE_CANT_DO_THIS;
-
-	/* reload fails on some drives, if the tray is locked */
-	if ((cd->cd_flags & IDE_CD_FLAG_DOOR_LOCKED) && ejectflag)
-		return 0;
-
-	ide_cd_init_rq(drive, &req);
-
-	/* only tell drive to close tray if open, if it can do that */
-	if (ejectflag && (cdi->mask & CDC_CLOSE_TRAY))
-		loej =3D 0;
-
-	req.sense =3D sense;
-	req.cmd[0] =3D GPCMD_START_STOP_UNIT;
-	req.cmd[4] =3D loej | (ejectflag !=3D 0);
-
-	return ide_cd_queue_pc(drive, &req);
-}
-
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capa=
city,
 			       unsigned long *sectors_per_frame,
 			       struct request_sense *sense)
@@ -1742,22 +1663,6 @@ static int ide_cdrom_packet(struct cdrom_device_=
info *cdi,
 	return cgc->stat;
 }
=20
-static
-int ide_cdrom_tray_move (struct cdrom_device_info *cdi, int position)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	struct request_sense sense;
-
-	if (position) {
-		int stat =3D ide_cd_lockdoor(drive, 0, &sense);
-
-		if (stat)
-			return stat;
-	}
-
-	return cdrom_eject(drive, !position, &sense);
-}
-
 int ide_cdrom_get_capabilities(ide_drive_t *drive, u8 *buf)
 {
 	struct cdrom_info *info =3D drive->driver_data;
@@ -1797,95 +1702,6 @@ void ide_cdrom_update_speed(ide_drive_t *drive, =
u8 *buf)
 	cd->max_speed =3D (maxspeed + (176/2)) / 176;
 }
=20
-/*
- * add logic to try GET_EVENT command first to check for media and tra=
y
- * status. this should be supported by newer cd-r/w and all DVD etc
- * drives
- */
-static
-int ide_cdrom_drive_status (struct cdrom_device_info *cdi, int slot_nr=
)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	struct media_event_desc med;
-	struct request_sense sense;
-	int stat;
-
-	if (slot_nr !=3D CDSL_CURRENT)
-		return -EINVAL;
-
-	stat =3D cdrom_check_status(drive, &sense);
-	if (!stat || sense.sense_key =3D=3D UNIT_ATTENTION)
-		return CDS_DISC_OK;
-
-	if (!cdrom_get_media_event(cdi, &med)) {
-		if (med.media_present)
-			return CDS_DISC_OK;
-		else if (med.door_open)
-			return CDS_TRAY_OPEN;
-		else
-			return CDS_NO_DISC;
-	}
-
-	if (sense.sense_key =3D=3D NOT_READY && sense.asc =3D=3D 0x04 && sens=
e.ascq =3D=3D 0x04)
-		return CDS_DISC_OK;
-
-	/*
-	 * If not using Mt Fuji extended media tray reports,
-	 * just return TRAY_OPEN since ATAPI doesn't provide
-	 * any other way to detect this...
-	 */
-	if (sense.sense_key =3D=3D NOT_READY) {
-		if (sense.asc =3D=3D 0x3a && sense.ascq =3D=3D 1)
-			return CDS_NO_DISC;
-		else
-			return CDS_TRAY_OPEN;
-	}
-	return CDS_DRIVE_NOT_READY;
-}
-
-/*********************************************************************=
*******
- * Other driver requests (open, close, check media change).
- */
-
-static
-int ide_cdrom_check_media_change_real (struct cdrom_device_info *cdi,
-				       int slot_nr)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	struct cdrom_info *cd =3D drive->driver_data;
-	int retval;
-
-	if (slot_nr =3D=3D CDSL_CURRENT) {
-		(void) cdrom_check_status(drive, NULL);
-		retval =3D (cd->cd_flags & IDE_CD_FLAG_MEDIA_CHANGED) ? 1 : 0;
-		cd->cd_flags &=3D ~IDE_CD_FLAG_MEDIA_CHANGED;
-		return retval;
-	} else {
-		return -EINVAL;
-	}
-}
-
-
-static
-int ide_cdrom_open_real (struct cdrom_device_info *cdi, int purpose)
-{
-	return 0;
-}
-
-/*
- * Close down the device.  Invalidate all cached blocks.
- */
-
-static
-void ide_cdrom_release_real (struct cdrom_device_info *cdi)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	struct cdrom_info *cd =3D drive->driver_data;
-
-	if (!cdi->use_count)
-		cd->cd_flags &=3D ~IDE_CD_FLAG_TOC_VALID;
-}
-
 #define IDE_CD_CAPABILITIES \
 	(CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK | CDC_SELECT_SPEED | \
 	 CDC_SELECT_DISC | CDC_MULTI_SESSION | CDC_MCN | CDC_MEDIA_CHANGED | =
\
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 5343063..fd7625f 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -151,12 +151,17 @@ void ide_cd_log_error(const char *, struct reques=
t *, struct request_sense *);
 /* ide-cd.c functions used by ide-cd_ioctl.c */
 void ide_cd_init_rq(ide_drive_t *, struct request *);
 int ide_cd_queue_pc(ide_drive_t *, struct request *);
-int ide_cd_lockdoor(ide_drive_t *, int, struct request_sense *);
 int ide_cd_read_toc(ide_drive_t *, struct request_sense *);
 int ide_cdrom_get_capabilities(ide_drive_t *, u8 *);
 void ide_cdrom_update_speed(ide_drive_t *, u8 *);
+int cdrom_check_status(ide_drive_t *, struct request_sense *);
=20
 /* ide-cd_ioctl.c */
+int ide_cdrom_open_real(struct cdrom_device_info *, int);
+void ide_cdrom_release_real(struct cdrom_device_info *);
+int ide_cdrom_drive_status(struct cdrom_device_info *, int);
+int ide_cdrom_check_media_change_real(struct cdrom_device_info *, int)=
;
+int ide_cdrom_tray_move(struct cdrom_device_info *, int);
 int ide_cdrom_lock_door(struct cdrom_device_info *, int);
 int ide_cdrom_select_speed(struct cdrom_device_info *, int);
 int ide_cdrom_get_last_session(struct cdrom_device_info *,
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index ec698c4..5eeb70d 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -9,9 +9,188 @@
 #include <linux/kernel.h>
 #include <linux/cdrom.h>
 #include <linux/ide.h>
+#include <scsi/scsi.h>
=20
 #include "ide-cd.h"
=20
+/*********************************************************************=
*******
+ * Other driver requests (open, close, check media change).
+ */
+int ide_cdrom_open_real(struct cdrom_device_info *cdi, int purpose)
+{
+	return 0;
+}
+
+/*
+ * Close down the device.  Invalidate all cached blocks.
+ */
+void ide_cdrom_release_real(struct cdrom_device_info *cdi)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct cdrom_info *cd =3D drive->driver_data;
+
+	if (!cdi->use_count)
+		cd->cd_flags &=3D ~IDE_CD_FLAG_TOC_VALID;
+}
+
+/*
+ * add logic to try GET_EVENT command first to check for media and tra=
y
+ * status. this should be supported by newer cd-r/w and all DVD etc
+ * drives
+ */
+int ide_cdrom_drive_status(struct cdrom_device_info *cdi, int slot_nr)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct media_event_desc med;
+	struct request_sense sense;
+	int stat;
+
+	if (slot_nr !=3D CDSL_CURRENT)
+		return -EINVAL;
+
+	stat =3D cdrom_check_status(drive, &sense);
+	if (!stat || sense.sense_key =3D=3D UNIT_ATTENTION)
+		return CDS_DISC_OK;
+
+	if (!cdrom_get_media_event(cdi, &med)) {
+		if (med.media_present)
+			return CDS_DISC_OK;
+		else if (med.door_open)
+			return CDS_TRAY_OPEN;
+		else
+			return CDS_NO_DISC;
+	}
+
+	if (sense.sense_key =3D=3D NOT_READY && sense.asc =3D=3D 0x04
+			&& sense.ascq =3D=3D 0x04)
+		return CDS_DISC_OK;
+
+	/*
+	 * If not using Mt Fuji extended media tray reports,
+	 * just return TRAY_OPEN since ATAPI doesn't provide
+	 * any other way to detect this...
+	 */
+	if (sense.sense_key =3D=3D NOT_READY) {
+		if (sense.asc =3D=3D 0x3a && sense.ascq =3D=3D 1)
+			return CDS_NO_DISC;
+		else
+			return CDS_TRAY_OPEN;
+	}
+	return CDS_DRIVE_NOT_READY;
+}
+
+int ide_cdrom_check_media_change_real(struct cdrom_device_info *cdi,
+				       int slot_nr)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct cdrom_info *cd =3D drive->driver_data;
+	int retval;
+
+	if (slot_nr =3D=3D CDSL_CURRENT) {
+		(void) cdrom_check_status(drive, NULL);
+		retval =3D (cd->cd_flags & IDE_CD_FLAG_MEDIA_CHANGED) ? 1 : 0;
+		cd->cd_flags &=3D ~IDE_CD_FLAG_MEDIA_CHANGED;
+		return retval;
+	} else {
+		return -EINVAL;
+	}
+}
+
+/* Eject the disk if EJECTFLAG is 0.
+   If EJECTFLAG is 1, try to reload the disk. */
+static
+int cdrom_eject(ide_drive_t *drive, int ejectflag,
+		struct request_sense *sense)
+{
+	struct cdrom_info *cd =3D drive->driver_data;
+	struct cdrom_device_info *cdi =3D &cd->devinfo;
+	struct request req;
+	char loej =3D 0x02;
+
+	if ((cd->cd_flags & IDE_CD_FLAG_NO_EJECT) && !ejectflag)
+		return -EDRIVE_CANT_DO_THIS;
+
+	/* reload fails on some drives, if the tray is locked */
+	if ((cd->cd_flags & IDE_CD_FLAG_DOOR_LOCKED) && ejectflag)
+		return 0;
+
+	ide_cd_init_rq(drive, &req);
+
+	/* only tell drive to close tray if open, if it can do that */
+	if (ejectflag && (cdi->mask & CDC_CLOSE_TRAY))
+		loej =3D 0;
+
+	req.sense =3D sense;
+	req.cmd[0] =3D GPCMD_START_STOP_UNIT;
+	req.cmd[4] =3D loej | (ejectflag !=3D 0);
+
+	return ide_cd_queue_pc(drive, &req);
+}
+
+/* Lock the door if LOCKFLAG is nonzero; unlock it otherwise. */
+static
+int ide_cd_lockdoor(ide_drive_t *drive, int lockflag,
+		    struct request_sense *sense)
+{
+	struct cdrom_info *cd =3D drive->driver_data;
+	struct request_sense my_sense;
+	struct request req;
+	int stat;
+
+	if (sense =3D=3D NULL)
+		sense =3D &my_sense;
+
+	/* If the drive cannot lock the door, just pretend. */
+	if (cd->cd_flags & IDE_CD_FLAG_NO_DOORLOCK) {
+		stat =3D 0;
+	} else {
+		ide_cd_init_rq(drive, &req);
+		req.sense =3D sense;
+		req.cmd[0] =3D GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
+		req.cmd[4] =3D lockflag ? 1 : 0;
+		stat =3D ide_cd_queue_pc(drive, &req);
+	}
+
+	/* If we got an illegal field error, the drive
+	   probably cannot lock the door. */
+	if (stat !=3D 0 &&
+	    sense->sense_key =3D=3D ILLEGAL_REQUEST &&
+	    (sense->asc =3D=3D 0x24 || sense->asc =3D=3D 0x20)) {
+		printk(KERN_ERR "%s: door locking not supported\n",
+			drive->name);
+		cd->cd_flags |=3D IDE_CD_FLAG_NO_DOORLOCK;
+		stat =3D 0;
+	}
+
+	/* no medium, that's alright. */
+	if (stat !=3D 0 && sense->sense_key =3D=3D NOT_READY && sense->asc =3D=
=3D 0x3a)
+		stat =3D 0;
+
+	if (stat =3D=3D 0) {
+		if (lockflag)
+			cd->cd_flags |=3D IDE_CD_FLAG_DOOR_LOCKED;
+		else
+			cd->cd_flags &=3D ~IDE_CD_FLAG_DOOR_LOCKED;
+	}
+
+	return stat;
+}
+
+int ide_cdrom_tray_move(struct cdrom_device_info *cdi, int position)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct request_sense sense;
+
+	if (position) {
+		int stat =3D ide_cd_lockdoor(drive, 0, &sense);
+
+		if (stat)
+			return stat;
+	}
+
+	return cdrom_eject(drive, !position, &sense);
+}
+
 int ide_cdrom_lock_door(struct cdrom_device_info *cdi, int lock)
 {
 	ide_drive_t *drive =3D cdi->handle;
--=20
Regards/Gru=DF,
    Boris.
