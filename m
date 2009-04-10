From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [bug#12874] Seagate STT20000A no longer works
Date: Fri, 10 Apr 2009 19:42:47 +0200
Message-ID: <20090410174247.GA12885@liondog.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:53231 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765188AbZDJRmy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2009 13:42:54 -0400
Received: by bwz17 with SMTP id 17so1155386bwz.37
        for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2009 10:42:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: bzolnier@gmail.com, koraq@xs4all.nl, linux-ide@vger.kernel.org

(moving discussion to mail and adding Bart to CC)

(In reply to comment #24)
> (In reply to comment #20)
> > Hmm, seems like the buffer is quite botched or the drive replies with some mode
> > parameter headers I cannot correlate.
> 
> If you mean this line:
> 
> [   42.272638] caps:  70 0 6 0 0 0 0 a 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0
> 
> 
> this is the extended sense data with its characteristic 1st byte of 0x70,
> 8-byte header with sense key UNIT ATTENTION, 10 bytes of additinal length and
> ASC of 0x29 meaning "reset hs occured".

Haa, thanks for catching that, although the QIC157d document I'm staring
at here states that the drive might return sense data instead of the
requested page, it seems that we don't get any CHECK CONDITION status
otherwise ide_pc_intr would've caught it (stat & ATA_ERR) and retried
the command.

Now, without having tested it since I don't have the hardware, would
something in the lines below be a sensible kludge for now? I guess we
should have similar error handling for the other MODE SENSE call sites
and propagate some error status from idetape_get_mode_sense_results()
upwards to idetape_setup()? Yeah, I know, the driver needs a lot of
massaging in order even to start looking ok... :)

__

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 70e7876..827485a 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2095,6 +2095,21 @@ static void idetape_get_mode_sense_results(ide_drive_t *drive)
 		put_unaligned(540,  (u16 *)&tape->caps[14]);
 		put_unaligned(6*52, (u16 *)&tape->caps[16]);
 		return;
+
+	} else if ((pc.buf[0] & 0x7f) == 0x70) {
+		/* unit attention: power on reset or device reset/not ready to
+		 * ready transition */
+		if ((pc.buf[2] & 0xf) == 0x6 &&
+		     (pc.buf[12] == 0x29 || pc.buf[12] == 0x28) &&
+		     pc.buf[13] == 0x0) {
+			tape->failed_pc = &pc;
+			ide_retry_pc(drive, tape->disk);
+		}
+		else {
+			printk(KERN_ERR "%s: error getting caps page\n",
+					drive->name);
+			return;
+		}
 	}
 	caps = pc.buf + 4 + pc.buf[3];
 


-- 
Regards/Gruss,
    Boris.
