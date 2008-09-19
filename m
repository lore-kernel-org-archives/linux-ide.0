From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4 v2] libata: Implement disk shock protection support
Date: Fri, 19 Sep 2008 07:15:10 -0700
Message-ID: <48D3B3EE.70702@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local>	<20080917163144.9870.97008.stgit@denkblock.local>	<48D147E2.3020601@gmail.com> <87skrwmpng.fsf@denkblock.local>	<48D3979F.10305@gmail.com> <87ljxokz67.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:57829 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYISOQu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Sep 2008 10:16:50 -0400
Received: by wa-out-1112.google.com with SMTP id j37so345599waf.23
        for <linux-ide@vger.kernel.org>; Fri, 19 Sep 2008 07:16:49 -0700 (PDT)
In-Reply-To: <87ljxokz67.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns wrote:
>> This should basically work but completion isn't really designed for
>> this type of continuous events where single consumption should clear
>> all pending events.  INIT_COMPLETION comes close but it doesn't lock,
>> so can't guarantee anything.  What's necessary is the counterpart for
>> complete_all() for the wait.
> 
> You are right that it isn't designed for this use case and my approach
> is somewhat hackish. Still, it really does exactly what we want. Please
> note that ap->park_req_pending is protected by the host lock; the call
> to complete() is atomic wrt the setting of ATA_EH_PARK for one of the
> devices on the port and so is the call to INIT_COMPLETION() wrt clearing
> ATA_EH_PARK requests for *all* devices on the port.
> 
>> Well, anyways, I think the issue is slightly out of scope for this
>> patch and the only side effect is possibly looping over the do {}
>> while () block several times unnecessarily on certain cases, so I
>> think just noting about it should be enough for now.
>>
>> Can you please add explanation above wait_for_complete_timeout() that
>> all done counts should be cleared here but aren't and as a result the
>> loop might repeat determinate number of times unnecessarily and resend
>> as proper patch?
> 
> Well, we don't really care about the done count after
> wait_for_completion_timeout() has returned. All that matters is that the
> done counter is cleared when all ATA_EH_PARK actions have been pulled in
> which happens at the start of each cycle over the loop.
> 
> Perhaps I should add comments to this effect before
> wait_for_completion_timeout() as well as INIT_COMPLETION()?

Ah... I missed the pull_park_action part.  Yes, in that case, it's
correct now but I would really appreciate you explain amply what's
going on inside the pull function and why it's needed.

Thanks.

-- 
tejun
