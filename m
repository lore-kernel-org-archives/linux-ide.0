From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 1/2] ide: ide-tape.c sparse annotations and unaligned
	access removal
Date: Wed, 16 Jul 2008 12:28:58 -0700
Message-ID: <1216236538.28841.12.camel@brick>
References: <1216152845.6610.18.camel@brick>
	 <200807161943.54033.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:56426 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbYGPT3A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2008 15:29:00 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5782419wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 16 Jul 2008 12:28:59 -0700 (PDT)
In-Reply-To: <200807161943.54033.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>

On Wed, 2008-07-16 at 19:43 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 15 July 2008, Harvey Harrison wrote:
> > If this is actually unaligned the access of speed/max_speed above
> > is already broken and needs a get_unaligned.  Otherwise it is
> > aligned and they can be removed.
> > 
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > ---
> > Bart, if this truly should be unaligned, let me know and I'll send you
> > a patch fixing the speed/maxspeed issue.
> 
> I applied the patch as it is for now as I don't see a reason to
> use unaligned access there but I could have forgotten some details
> (added Borislav to cc:).
> 
> I've also noticed that there are some put_unaligned()-s left in
> idetape_get_mode_sense_results(), is this intended?

I just fixed the immediate ones I saw right below the aligned access to 
speed/max_speed.  I can't be sure about tape->caps being aligned or not,
but at least the following incremental patch is ok if caps is 2-byte
aligned.  Feel free to fold it into my original or put my signed-off by on
a new commit.

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 40b09b2..9c3ce71 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2392,12 +2392,12 @@ static void idetape_get_mode_sense_results(ide_drive_t *drive)
 	if (!speed) {
 		printk(KERN_INFO "ide-tape: %s: invalid tape speed "
 				"(assuming 650KB/sec)\n", drive->name);
-		put_unaligned(650, (u16 *)&caps[14]);
+		*(u16 *)&caps[14] = 650;
 	}
 	if (!max_speed) {
 		printk(KERN_INFO "ide-tape: %s: invalid max_speed "
 				"(assuming 650KB/sec)\n", drive->name);
-		put_unaligned(650, (u16 *)&caps[8]);
+		*(u16 *)&caps[8] = 650;
 	}
 
 	memcpy(&tape->caps, caps, 20);


