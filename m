From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Mon, 15 Jun 2009 08:27:55 +0200
Message-ID: <20090615062755.GA17774@liondog.tnic>
References: <bug-13399-11633@http.bugzilla.kernel.org/> <200906131859.54080.bzolnier@gmail.com> <20090614100606.GA25379@liondog.tnic> <200906141432.11139.bzolnier@gmail.com> <20090614130238.GA1892@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:41066 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZFOG17 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jun 2009 02:27:59 -0400
Received: by bwz9 with SMTP id 9so3108279bwz.37
        for <linux-ide@vger.kernel.org>; Sun, 14 Jun 2009 23:27:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090614130238.GA1892@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, bruinjm@xs4all.nl
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org

Hi,

here's a yet another analysis:


issue GPCMD_READ_DISC_INFO

ide-cd: ide_cd_queue_pc: cmd[0]: 0x51, write: 0x0, timeout: 1750, cmd_flags: 0x8000
ide-cd: ide_cd_do_request: cmd: 0x51, block: 18446744073709551615
ide_cd_do_request: dev hda: type=a, flags=108a640
  sector 18446744073709551615, nr/cnr 0/0
  bio (null), biotail (null), buffer (null), data ffff88011b849ba0, len 32
ide-cd: cdrom_do_block_pc: rq->cmd[0]: 0x51, rq->cmd_type: 0xa
ide-cd: cdrom_newpc_intr: cmd: 0x51, write: 0x0

DRQ set, read 30 bytes

ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 30
ide-cd: ide_cd_check_ireason: ireason: 0x2, rw: 0x0
ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0xa, ireason: 0x2

xfer 30 bytes and rearm IRQ handler with a timeout

ide-cd: cdrom_newpc_intr: cmd: 0x51, write: 0x0

second IRQ, DRQ is cleared, read 2 bytes

ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 2
ide-cd: ide_cd_request_sense_fixup: rq->cmd[0]: 0x51
#3

here we do "goto out_end" instead of xferring the remaining 2 bytes
out of the drive. So how about something like the workaround below, I
haven't tested it on the real drive. Wrt to the ide_cd_error_cmd(), I
guess the proper fix is to check the rq->bio thing because the rq is
going to be ended anyways.

@Hans: can you please test applying it ontop of the debugging patch and
sending the output again, thanks.


---

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 6f728da..716a576 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -680,10 +680,19 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 			}
 		} else if (!blk_pc_request(rq)) {
 			ide_cd_request_sense_fixup(drive, cmd);
+
 			/* complain if we still have data left to transfer */
 			uptodate = cmd->nleft ? 0 : 1;
-			if (uptodate == 0)
-				rq->cmd_flags |= REQ_FAILED;
+			if (uptodate == 0) {
+				if (drive->atapi_flags & IDE_AFLAG_FRAG_CMD) {
+					ide_pio_bytes(drive, cmd, write,
+						      cmd->nleft);
+					uptodate = (cmd->nleft - thislen) ? 0
+									  : 1;
+				}
+				if (!uptodate)
+					rq->cmd_flags |= REQ_FAILED;
+			}
 		}
 		pr_err("#3\n");
 		goto out_end;
@@ -764,7 +773,7 @@ out_end:
 				rq->errors = -EIO;
 		}
 
-		if (uptodate == 0)
+		if (uptodate == 0 && rq->bio)
 			ide_cd_error_cmd(drive, cmd);
 
 		/* make sure it's fully ended */
@@ -1554,6 +1563,11 @@ static const struct cd_list_entry ide_cd_quirks_list[] = {
 	{ "Optiarc DVD RW AD-7200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
 	{ "Optiarc DVD RW AD-7543A", NULL,   IDE_AFLAG_NO_AUTOCLOSE	     },
 	{ "TEAC CD-ROM CD-224E",     NULL,   IDE_AFLAG_NO_AUTOCLOSE	     },
+	/*
+	 * some drives clear the DRQ bit on the last word of a packet command
+	 * and therefore need some special handling in the IRQ handler
+	 */
+	{ "SONY DVD-ROM DDU1615",    NULL,   IDE_AFLAG_FRAG_CMD		     },
 	{ NULL, NULL, 0 }
 };
 
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 9fed365..e18b455 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -456,6 +456,9 @@ enum {
 	IDE_AFLAG_MEDIUM_PRESENT	= (1 << 23),
 
 	IDE_AFLAG_NO_AUTOCLOSE		= (1 << 24),
+
+	/* ide-cd quirk */
+	IDE_AFLAG_FRAG_CMD		= (1 << 25),
 };
 
 /* device flags */

-- 
Regards/Gruss,
    Boris.
