From: "Stuart Hayes" <stuarthayes@austin.rr.com>
Subject: Re: ide-cd question
Date: Thu, 3 Mar 2005 08:27:08 -0600
Message-ID: <001901c51ffd$1518a210$aeb91942@400sc>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:39852 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261755AbVCCO3U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Mar 2005 09:29:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@gmail.com
Cc: Stuart_Hayes@Dell.com

I sent in this patch a few weeks ago, and never saw a response... I was 
wondering if there was a problem with it, or if I need to supply more 
info...?  This patch is against 2.6.11-rc3.  It makes sure that when 
ide_atapi_error() tries to end a failing ATAPI request after 2 reset 
attempts by calling drive->driver->end_request(), it will really be ended.  
Right now, a request that has a non-null rq->bio will not get ended, nor 
will rq->errors get cleared, so it will get retried forever with no more 
reset attempts.

My fingers are crossed that this patch won't be mangled... I seem to have 
a problem with that...

Thanks,
Stuart


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


