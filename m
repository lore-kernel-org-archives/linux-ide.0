From: "Stuart Hayes" <stuarthayes@austin.rr.com>
Subject: Re: ide-cd question
Date: Sat, 12 Feb 2005 11:26:25 -0600
Message-ID: <001d01c51127$fae007f0$aeb91942@400sc>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:45748 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261164AbVBLR0c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Feb 2005 12:26:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@gmail.com
Cc: Stuart_Hayes@Dell.com


>> Sorry--this patch is against 2.6.11-rc3.
>>
>> Also sorry for the mangled patch--I'll resend it from another email
>> address shortly.
>>
>> Thanks
>> Stuart
> 
> OK, here's that patch again--hopefully not mangled this time.
> Thanks,
> Stuart
> 
> 

This is frustrating.  Here it is again:


--- ide-io.c.orig 2005-02-10 15:23:52.000000000 -0500
+++ ide-io.c.new 2005-02-10 15:23:31.000000000 -0500
@@ -515,7 +515,18 @@ static ide_startstop_t ide_atapi_error(i
   hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
 
  if (rq->errors >= ERROR_MAX) {
-  drive->driver->end_request(drive, 0, 0);
+  /* 
+   * make sure request is fully ended--otherwise bio might get updated and the
+   * command will be retried without rq->errors getting reset to zero, which
+   * could cause us to get stuck in a loop with infinite retries without any 
+   * more reset attempts (borrowed from cdrom_end_request)
+   */
+  int nsectors;
+  if (blk_pc_request(rq))
+   nsectors = (rq->data_len + 511) >> 9;
+  if (!nsectors)
+   nsectors = 1;
+  drive->driver->end_request(drive, 0, nsectors);
  } else {
   if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
    ++rq->errors;

