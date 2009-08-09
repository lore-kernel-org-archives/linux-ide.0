From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sun, 9 Aug 2009 09:28:23 +0200
Message-ID: <20090809072823.GA2130@liondog.tnic>
References: <h5kn9c$51r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54051 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZHIH22 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 03:28:28 -0400
Received: by bwz19 with SMTP id 19so2098863bwz.37
        for <linux-ide@vger.kernel.org>; Sun, 09 Aug 2009 00:28:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <h5kn9c$51r$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Duda <jim@duda.tzo.com>
Cc: linux-ide@vger.kernel.org

Hi,

On Sat, Aug 08, 2009 at 04:30:35PM -0400, Jim Duda wrote:
> I'm having trouble using my STT2000A ATAPE TAPE drive after
> upgrading to at least kernel 2.6.30.  I use the tape drive solely
> for tape backup using simple tar commands.
> 
> In previous kernels, I was able to access the tape drive using the
> ide-scsi adaptation layer with /dev/st0
> 
> I realize that in transitioning through 2.6.30 the kernel has
> abandoned the use of ide-scsi.  As I understand it, ide-tape
> interacts directly with the tape drive and I am supposed to now use
> /dev/ht0.

Bartlomiej and I were working on cleaning up IDE but were interrupted
prematurely and IDE is now in deep maintenance mode. Concerning
ide-tape, the driver wasn't being used for ages and was even about to be
removed at a certain point but we decided to wait. Anyways, the driver
lost a lot of fat in the process. I even bought an STT8000A tape off
ebay just to test it here and fix it up so that it can be usable.

If you'd like to test patches you can get Dave's linux-next git repo at
http://git.kernel.org/?p=linux/kernel/git/davem/ide-next-2.6.git;a=summary

apply the patch below and catch all boot output from your machine and
send it to me.

Thanks.

--
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 7b2032b..81181cd 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -48,7 +48,7 @@
 #include <linux/mtio.h>
 
 /* define to see debug info */
-#undef IDETAPE_DEBUG_LOG
+#define IDETAPE_DEBUG_LOG
 
 #ifdef IDETAPE_DEBUG_LOG
 #define ide_debug_log(lvl, fmt, args...) __ide_debug_log(lvl, fmt, ## args)
@@ -1727,6 +1727,8 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 	int buffer_size;
 	u16 *ctl = (u16 *)&tape->caps[12];
 
+	drive->debug_mask = 0xffffffff;
+
 	ide_debug_log(IDE_DBG_FUNC, "minor: %d", minor);
 
 	drive->pc_callback = ide_tape_callback;


-- 
Regards/Gruss,
    Boris.
