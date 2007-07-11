From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported modes
Date: Wed, 11 Jul 2007 23:21:41 +0200
Message-ID: <200707112321.41597.bzolnier@gmail.com>
References: <200707110200.37607.bzolnier@gmail.com> <46952A87.6010005@ru.mvista.com> <20070711195641.GA2301@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:8220 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934347AbXGKVHO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 17:07:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so203768ugf
        for <linux-ide@vger.kernel.org>; Wed, 11 Jul 2007 14:07:11 -0700 (PDT)
In-Reply-To: <20070711195641.GA2301@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org


Hi,

On Wednesday 11 July 2007, Russell King wrote:
> On Wed, Jul 11, 2007 at 11:07:51PM +0400, Sergei Shtylyov wrote:
> > Hello.
> > 
> > Bartlomiej Zolnierkiewicz wrote:
> > 
> > >icside_set_speed() happily accepts unsupported transfer modes which
> > >results in drive->drive_data being set to the maximum value (480)
> > >and drive->current_speed being set to the unsupported transfer mode.
> > 
> > >Fix it.
> > 
> > >Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > 
> > Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> I wonder why Sergei's acking this patch - do you have the hardware to
> test it on?  Are you somehow involved in this driver?  I think the
> answer to both is most likely no.

It is a _friendly_ ACK == "I have reviewed the patch and it is OK".

Sergei has proven that he has both the knowledge and the good code taste
to _friendly_ ACK IDE patches.  Extra review from him is valuable thing.

I don't think that he had any intentions in overriding your _final_
judgement wrt icside host driver. :)

> Moreover, I think the patch is quite broken.  If an invalid DMA mode
> is passed, currently the driver sets the cycle time to 480ns (stored
> in drive_data) since both cycle_time and use_dma_info will be zero.
> Moreover, 'on' will be zero, causing icside_set_speed() to return zero
> which means the DMA setting was not successful (iow, use PIO).

Thanks for spotting this.  The patch in the current form is indeed broken
as I haven't noticed that icside_set_speed() returns zero on failure.

However all other implementations of ->speedproc return zero on success
and non-zero on failure.  Currently it doesn't matter for icside host
driver and isn't a bug per se since:

- ide_set_xfer_rate() return value is ignored by all IDE core users

- icside doesn't (yet!) use ide_tune_dma() in icside_dma_check()

but sooner or later we will need to fix anyway - so lets do it now.

It also seems to cleanup icside_dma_check() a bit since return value
invertion is no longer needed.

> This causes icside_dma_check() to return -1 to the IDE layer which
> should fail the setting.
> 
> With your patch, you make icside_set_speed() return '1' meaning DMA
> was succesfully configured.  That then causes icside_dma_check() to
> return success to the IDE layer, so we now allow invalid speeds.

Yep, you are right.

> Ergo, what wasn't broken before is now broken.  So the patch is
> completely wrong and was trying to fix a problem which didn't exist in
> the first place.

The problem exists - currently host driver's ->speedproc can be fed with
the unsupported transfer mode both from user space requests and from internal
IDE subsystem error handling (when dropping to PIO mode).  My other patches
are heavily fixing the problem in the IDE core but still a few cases remain to
be fixed thus this patch.

> BIG NAK.

Are you OK with "take 2"?

[PATCH] icside: fix ->speedproc to return on unsupported modes (take 2)

* All other implementations of ->speedproc return zero on success
  and non-zero on failure.  Currently it doesn't matter for icside host
  driver and isn't a bug per se since:

  - ide_set_xfer_rate() return value is ignored by all IDE core users

  - icside doesn't (yet!) use ide_tune_dma() in icside_dma_check()

  but sooner or later we will need to fix anyway - so lets do it now.

* icside_set_speed() happily accepts unsupported transfer modes which
  results in drive->drive_data being set to the maximum value (480)
  and drive->current_speed being set to the unsupported transfer mode.

  Fix it.

v2:
- The initial version of the patch was broken because it didn't take into
  the account (the different from usual) return values of icside_set_speed().
  (Noticed by Russell).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/ide/arm/icside.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -250,7 +250,7 @@ static void icside_build_sglist(ide_driv
  */
 static int icside_set_speed(ide_drive_t *drive, const u8 xfer_mode)
 {
-	int on = 0, cycle_time = 0, use_dma_info = 0;
+	int on = -1, cycle_time = 0, use_dma_info = 0;
 
 	switch (xfer_mode) {
 	case XFER_MW_DMA_2:
@@ -272,6 +272,8 @@ static int icside_set_speed(ide_drive_t 
 	case XFER_SW_DMA_0:
 		cycle_time = 480;
 		break;
+	default:
+		return 1;
 	}
 
 	/*
@@ -284,7 +286,7 @@ static int icside_set_speed(ide_drive_t 
 	drive->drive_data = cycle_time;
 
 	if (cycle_time && ide_config_drive_speed(drive, xfer_mode) == 0)
-		on = 1;
+		on = 0;
 	else
 		drive->drive_data = 480;
 
@@ -321,7 +323,6 @@ static int icside_dma_check(ide_drive_t 
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = HWIF(drive);
 	int xfer_mode = XFER_PIO_2;
-	int on;
 
 	if (!(id->capability & 1) || !hwif->autodma)
 		goto out;
@@ -350,9 +351,7 @@ static int icside_dma_check(ide_drive_t 
 	}
 
 out:
-	on = icside_set_speed(drive, xfer_mode);
-
-	return on ? 0 : -1;
+	return icside_set_speed(drive, xfer_mode);
 }
 
 static int icside_dma_end(ide_drive_t *drive)
