From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 1/5] ide-cd: respect REQ_QUIET for fs requests in
	cdrom_decode_status()
Date: Sun, 5 Apr 2009 07:13:42 +0200
Message-ID: <20090405051342.GB4189@liondog.tnic>
References: <20090403195757.31438.16866.sendpatchset@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50570 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbZDEFNu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Apr 2009 01:13:50 -0400
Content-Disposition: inline
In-Reply-To: <20090403195757.31438.16866.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 03, 2009 at 09:57:57PM +0200, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide-cd: respect REQ_QUIET for fs requests in cdrom_decode_status()
> 
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-cd.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> Index: b/drivers/ide/ide-cd.c
> ===================================================================
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -382,7 +382,8 @@ static int cdrom_decode_status(ide_drive
>  				cdrom_saw_media_change(drive);
>  
>  				/* fail the request */
> -				printk(KERN_ERR PFX "%s: tray open\n",
> +				if ((rq->cmd_flags & REQ_QUIET) == 0)
> +					printk(KERN_ERR PFX "%s: tray open\n",
>  						drive->name);
>  			} else {
>  				if (ide_cd_breathe(drive, rq))
> @@ -405,19 +406,23 @@ static int cdrom_decode_status(ide_drive
>  			 * No point in retrying after an illegal request or data
>  			 * protect error.
>  			 */
> -			ide_dump_status(drive, "command error", stat);
> +			if ((rq->cmd_flags & REQ_QUIET) == 0)
> +				ide_dump_status(drive, "command error", stat);
>  			do_end_request = 1;
>  		} else if (sense_key == MEDIUM_ERROR) {
>  			/*
>  			 * No point in re-trying a zillion times on a bad
>  			 * sector. If we got here the error is not correctable.
>  			 */
> -			ide_dump_status(drive, "media error (bad sector)",
> -					stat);
> +			if ((rq->cmd_flags & REQ_QUIET) == 0)
> +				ide_dump_status(drive, "media error "
> +						"(bad sector)", stat);
>  			do_end_request = 1;
>  		} else if (sense_key == BLANK_CHECK) {
>  			/* disk appears blank ?? */
> -			ide_dump_status(drive, "media error (blank)", stat);
> +			if ((rq->cmd_flags & REQ_QUIET) == 0)
> +				ide_dump_status(drive, "media error (blank)",
> +						stat);
>  			do_end_request = 1;
>  		} else if ((err & ~ATA_ABORTED) != 0) {
>  			/* go to the default handler for other errors */


Let's cache the REQ_QUIET value instead, for slightly better readability:

---
From: Borislav Petkov <petkovbb@gmail.com>
Date: Sun, 5 Apr 2009 06:40:50 +0200
Subject: [PATCH] ide-cd: respect REQ_QUIET for fs requests in cdrom_decode_status()

There should be no functional change resulting from this patch.

Suggested-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index a4afd90..6cf2916 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -276,6 +276,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->rq;
 	int err, sense_key;
+	u8 quiet = rq->cmd_flags & REQ_QUIET;
 
 	/* get the IDE error register */
 	err = ide_read_error(drive);
@@ -318,7 +319,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 			 * drive doesn't have that capability.
 			 * cdrom_log_sense() knows this!
 			 */
-		} else if (!(rq->cmd_flags & REQ_QUIET)) {
+		} else if (!quiet) {
 			/* otherwise, print an error */
 			ide_dump_status(drive, "packet command error", stat);
 		}
@@ -346,7 +347,8 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 				cdrom_saw_media_change(drive);
 
 				/* fail the request */
-				printk(KERN_ERR PFX "%s: tray open\n",
+				if (!quiet)
+					printk(KERN_ERR PFX "%s: tray open\n",
 						drive->name);
 				do_end_request = 1;
 			} else {
@@ -394,19 +396,23 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 			 * No point in retrying after an illegal request or data
 			 * protect error.
 			 */
-			ide_dump_status(drive, "command error", stat);
+			if (!quiet)
+				ide_dump_status(drive, "command error", stat);
 			do_end_request = 1;
 		} else if (sense_key == MEDIUM_ERROR) {
 			/*
 			 * No point in re-trying a zillion times on a bad
 			 * sector. If we got here the error is not correctable.
 			 */
-			ide_dump_status(drive, "media error (bad sector)",
-					stat);
+			if (!quiet)
+				ide_dump_status(drive, "media error "
+						"(bad sector)",	stat);
 			do_end_request = 1;
 		} else if (sense_key == BLANK_CHECK) {
 			/* disk appears blank ?? */
-			ide_dump_status(drive, "media error (blank)", stat);
+			if (!quiet)
+				ide_dump_status(drive, "media error (blank)",
+						stat);
 			do_end_request = 1;
 		} else if ((err & ~ATA_ABORTED) != 0) {
 			/* go to the default handler for other errors */
-- 
1.6.2.1


-- 
Regards/Gruss,
    Boris.
