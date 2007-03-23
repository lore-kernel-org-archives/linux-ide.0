From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] Use correct IDE error recovery
Date: Sat, 24 Mar 2007 00:53:42 +0100
Message-ID: <200703240053.42845.bzolnier@gmail.com>
References: <20070221012304.GC1777@freefall.freebsd.org> <200703072216.08295.bzolnier@gmail.com> <B2D4536E-D449-4D10-B745-30D25CAC40A4@freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753437AbXCWXrh@vger.kernel.org>
In-Reply-To: <B2D4536E-D449-4D10-B745-30D25CAC40A4@freebsd.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
List-Id: linux-ide@vger.kernel.org


Hi,

On Thursday 08 March 2007, Suleiman Souhlal wrote:
>=20
> On Mar 7, 2007, at 1:16 PM, Bartlomiej Zolnierkiewicz wrote:

> > Please respin the patch so I could merge it.
>=20
> Ok.

Since I think that it's worth to have it in 2.6.21-final and respin did=
n't
happen I did the required changes myself (it also turned out that I mis=
sed
few things during initial review), then applied the patch...

Please let my know whether you are fine with my changes, thanks.

[PATCH] ide: use correct IDE error recovery

=46rom: Suleiman Souhlal <suleiman@google.com>

IDE error recovery is using IDLE IMMEDIATE if the drive is busy or has =
DRQ set.
This violates the ATA spec (can only send IDLE=A0IMMEDIATE when drive i=
s not
busy) and really hoses up some drives (modern drives will not be able t=
o
recover using this error handling).  The correct thing to do is issue a=
 SRST
followed by a SET FEATURES command.  This is what Western Digital recom=
mends
for error recovery and what Western Digital says Windows does. =A0It=A0=
also does
not violate the ATA spec as far as I can tell.

Bart:
* port the patch over the current tree
* undo the recalibration code removal
* send SET FEATURES command after checking for good drive status
* don't check whether the current request is of REQ_TYPE_ATA_{CMD,TASK}
  type because we need to send SET FEATURES before handling any request=
s
* some pre-ATA4 drives require INITIALIZE DEVICE PARAMETERS command bef=
ore
  other commands (except IDENTIFY) so send SET FEATURES only if there a=
re
  no pending drive->special requests
* update comments and patch description
* any bugs introduced by this patch are mine and not Suleiman's :-)

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-io.c   |   32 +++++++++++++++++++++-----------
 drivers/ide/ide-iops.c |    3 +++
 include/linux/ide.h    |    1 +
 3 files changed, 25 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-io.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -519,21 +519,24 @@ static ide_startstop_t ide_ata_error(ide
 	if ((stat & DRQ_STAT) && rq_data_dir(rq) =3D=3D READ && hwif->err_sto=
ps_fifo =3D=3D 0)
 		try_to_flush_leftover_data(drive);
=20
+	if (rq->errors >=3D ERROR_MAX || blk_noretry_request(rq)) {
+		ide_kill_rq(drive, rq);
+		return ide_stopped;
+	}
+
 	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
-		/* force an abort */
-		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
+		rq->errors |=3D ERROR_RESET;
=20
-	if (rq->errors >=3D ERROR_MAX || blk_noretry_request(rq))
-		ide_kill_rq(drive, rq);
-	else {
-		if ((rq->errors & ERROR_RESET) =3D=3D ERROR_RESET) {
-			++rq->errors;
-			return ide_do_reset(drive);
-		}
-		if ((rq->errors & ERROR_RECAL) =3D=3D ERROR_RECAL)
-			drive->special.b.recalibrate =3D 1;
+	if ((rq->errors & ERROR_RESET) =3D=3D ERROR_RESET) {
 		++rq->errors;
+		return ide_do_reset(drive);
 	}
+
+	if ((rq->errors & ERROR_RECAL) =3D=3D ERROR_RECAL)
+		drive->special.b.recalibrate =3D 1;
+
+	++rq->errors;
+
 	return ide_stopped;
 }
=20
@@ -1025,6 +1028,13 @@ static ide_startstop_t start_request (id
 	if (!drive->special.all) {
 		ide_driver_t *drv;
=20
+		/*
+		 * We reset the drive so we need to issue a SETFEATURES.
+		 * Do it _after_ do_special() restored device parameters.
+		 */
+		if (drive->current_speed =3D=3D 0xff)
+			ide_config_drive_speed(drive, drive->desired_speed);
+
 		if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD ||
 		    rq->cmd_type =3D=3D REQ_TYPE_ATA_TASK ||
 		    rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE)
Index: b/drivers/ide/ide-iops.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -1094,6 +1094,9 @@ static void pre_reset(ide_drive_t *drive
 	if (HWIF(drive)->pre_reset !=3D NULL)
 		HWIF(drive)->pre_reset(drive);
=20
+	if (drive->current_speed !=3D 0xff)
+		drive->desired_speed =3D drive->current_speed;
+	drive->current_speed =3D 0xff;
 }
=20
 /*
Index: b/include/linux/ide.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -615,6 +615,7 @@ typedef struct ide_drive_s {
         u8	init_speed;	/* transfer rate set at boot */
         u8	pio_speed;      /* unused by core, used by some drivers for=
 fallback from DMA */
         u8	current_speed;	/* current transfer rate set */
+	u8	desired_speed;	/* desired transfer rate set */
         u8	dn;		/* now wide spread use */
         u8	wcache;		/* status of write cache */
 	u8	acoustic;	/* acoustic management */
