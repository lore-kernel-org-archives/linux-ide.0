From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: 2.9.29.2: ide-tape: panic when probing device at boot
Date: Mon, 4 Jan 2010 06:47:40 +0100
Message-ID: <20100104054740.GA10094@liondog.tnic>
References: <4A062702.8020404@kernel.org>
 <201001040115.o041FCEA025051@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62108 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab0ADFrp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 00:47:45 -0500
Content-Disposition: inline
In-Reply-To: <201001040115.o041FCEA025051@turbo.physics.adelaide.edu.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Jan 04, 2010 at 11:45:12AM +1030, Jonathan Woithe wrote:
> Has there been any movement on this in recent months?  I gave 2.6.30 a whirl
> on the machine when that was released but it still gave major problems with
> the ide-tape driver.  Is 2.6.32 likely to be improved?  If so I'll make
> arrangements to test that version.

Yes, please do test 2.6.32 to see whether it fixes your problem. If you still
get that oops, please apply the following patch and send me the _whole_ dmesg
output of the machine.

Thanks.

--
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 6a0e625..e4c3ffd 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -49,7 +49,7 @@
 #include <linux/mtio.h>
 
 /* define to see debug info */
-#undef IDETAPE_DEBUG_LOG
+#define IDETAPE_DEBUG_LOG
 
 #ifdef IDETAPE_DEBUG_LOG
 #define ide_debug_log(lvl, fmt, args...) __ide_debug_log(lvl, fmt, ## args)
@@ -1737,6 +1737,8 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 	int buffer_size;
 	u16 *ctl = (u16 *)&tape->caps[12];
 
+	drive->debug_mask = 0xffffffff;
+
 	ide_debug_log(IDE_DBG_FUNC, "minor: %d", minor);
 
 	drive->pc_callback = ide_tape_callback;


-- 
Regards/Gruss,
    Boris.
