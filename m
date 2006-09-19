From: Tejun Heo <htejun@gmail.com>
Subject: Continuing ata_piix PCS saga...
Date: Tue, 19 Sep 2006 13:16:33 +0900
Message-ID: <450F6F21.7080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:5089 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751665AbWISEQl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Sep 2006 00:16:41 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1757178nzf
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 21:16:40 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nabiki@teleline.es, Keith Owens <kaos@ocs.com.au>, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, all.

As far as I can remember, the people in To: are all the ones who have 
reported ata_piix PCS related device misdetection problem.  This goes 
way back to Nov, 2005 and, sorry, hasn't been resolved yet.  Each time I 
and other libata developers come up with a solution, it either doesn't 
fix all the cases or creates a new case.

The following is my recollection of ata_piix PCS problem.  It's from the 
top of my head so might be inaccurate.  Don't hesitate to correct me.

The first reports are from jfs@keytradebank.com and 0602@eq.cz.  IIRC, 
both cases were on I6300 ESB (ICH5 variant).  This was solved by adding 
PIIX_FLAG_IGNORE_PCS to the entry.  The intel doc also states that PCS 
present bits on this controller cannot be used for device detection. 
Note that this is before new EH was implemented.

Then, June this year, stevenm@umd.edu filed bug #6724 on kernel v2.6.17. 
  It was regular ICH5 which curiously clears PCS to zero between probing 
of the first port and the second.  It didn't matter whether the PCS 
register itself was written to or not.  It just clears to zero while 
libata is probing the first port.

http://bugzilla.kernel.org/show_bug.cgi?id=6724

There were two proposed solutions.  One was to cache PCS during 
initialization, the other to ignore PCS on all ICH5s.  Both fixed 
stevenm@umd.edu's case.  Note that this was before Jeff's 
fix-over-zealous-PCS-update patch.

I think there were a few similar reports.  ICH8 came into the scene 
which used different PCS layout and had ghost device detection problem 
which can delay boot process a lot - ICH7 also has the same issue.  So, 
at the time, PCS seemed unreliable while standard ATA device detection 
procedure worked okay on ICH5 while the opposite was true for ICH7 and 
later.  So, we added IGNORE_PCS to ICH5 while honoring PCS strictly on 
other controllers.

As we were seeing multiple problems across different controllers, 
several attempts were made to alleviate the situation.  W/ IGNORE_PCS 
added to ICH5 and other PCS related updates, it seemed that we had 
everything right, which wasn't the case, unfortunately.

kaos@ocs.com.au reported v2.6.18-rc5 sometimes failed to detect devices 
on ICH7 after soft reboots - PCS reported 0.  I thought this was related 
to fix-overzealous-PCS-update patch and proposed a fix but it didn't 
work.  Then, nabiki@teleline.es filed bug #7166.

http://bugzilla.kernel.org/show_bug.cgi?id=7166

The bug report says that 2.6.17.13 failed to probe the secondary port. 
2.6.17.13 does not have either of honor-PCS or 
fix-overzealous-PCS-update, but has new EH and some other PCS related 
updates.  But, I'm not sure whether those changes cause the problem or 
it's just getting reported now as it occurs intermittently.

Another interesting input is that, IIRC, more than one people including 
Keith, reported that the problem seems to be related to timing issue - 
whether i386 or x86_64 kernel was used, whether kdb was compiled in or not.

So, that the current situation according to my not-so-accurate memory. 
At this point, I'm curious how intel does it in their Windows driver.  I 
think we should replicate its behavior if possible.  Any other ideas?

Thanks.

-- 
tejun
