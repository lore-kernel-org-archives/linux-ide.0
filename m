From: <Stuart_Hayes@Dell.com>
Subject: RE: ide-cd question
Date: Thu, 3 Mar 2005 11:34:09 -0600
Message-ID: <7A8F92187EF7A249BF847F1BF4903C040AFC6D@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:28287 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262547AbVCCReL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2005 12:34:11 -0500
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: axboe@suse.de, stuarthayes@austin.rr.com
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Jens Axboe wrote:
> On Thu, Mar 03 2005, Stuart Hayes wrote:
>> I sent in this patch a few weeks ago, and never saw a response... I
>> was wondering if there was a problem with it, or if I need to supply
>> more info...?  This patch is against 2.6.11-rc3.  It makes sure that
>> when
>> ide_atapi_error() tries to end a failing ATAPI request after 2 reset
>> attempts by calling drive->driver->end_request(), it will really be
>> ended. Right now, a request that has a non-null rq->bio will not get
>> ended, 
>> nor will rq->errors get cleared, so it will get retried forever with
>> no more reset attempts.
> 
> Indeed a problem. Would be nice to switch the ->end_request() to be
> byte based like SCSI, would make it cleaner. 
> 
> But do you really need the !nsectors check? If ->data_len is 0, there
> should not be a need to pass a non-zero sector count. 
> 

I wondered about the !nsectors check myself.  I copied that code from
the cdrom_end_request() function, and I assumed that it must have been
there for some reason that wasn't immediately clear to me, so I didn't
take it out.  I figured performance in that code path wasn't critical.

I can take it out if that's the only problem!

>> My fingers are crossed that this patch won't be mangled... I seem to
>> have a problem with that...
> 
> No such luck, it's mangled :). Looks like tabs turned to a single
> space. 
> Maybe you have better luck with attaching the file.

Here's another try at the patch.  This time it is against 2.6.11, and I
shortened the comments so I could send it from this email address 
without it getting mangled...



--- ide-io.c.orig	2005-03-03 10:57:05.468669136 -0500
+++ ide-io.c	2005-03-03 11:01:33.982848776 -0500
@@ -486,9 +486,21 @@ static ide_startstop_t ide_ata_error(ide
 		/* force an abort */
 		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
 
-	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq))
-		drive->driver->end_request(drive, 0, 0);
-	else {
+	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq)) {
+		/* 
+		 * make sure request is fully ended--otherwise bio might
get
+		 * updated and the command will be retried without
+		 * rq->errors getting reset to zero, which could cause
us to
+		 * get stuckin a loop with infinite retries without any
more
+		 * reset attempts (borrowed from cdrom_end_request)
+		 */
+		int nsectors;
+		if (blk_pc_request(rq))
+			nsectors = (rq->data_len + 511) >> 9;
+		if (!nsectors)
+			nsectors = 1;
+		drive->driver->end_request(drive, 0, nsectors);
+	} else {
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
 			++rq->errors;
 			return ide_do_reset(drive);



