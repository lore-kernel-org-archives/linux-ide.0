From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 12:48:11 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40670FDB.6080409@pobox.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9173 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262271AbUC1RsZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 12:48:25 -0500
In-Reply-To: <20040328173508.GI24370@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jens Axboe wrote:
> On Sun, Mar 28 2004, Jeff Garzik wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Sat, Mar 27 2004, Jeff Garzik wrote:
>>>
>>>
>>>>I also wouldn't want to lock out any users who wanted to use SATA at 
>>>>full speed ;-)
>>>
>>>
>>>And full speed requires 32MB requests?
>>
>>
>>Full speed is the SATA driver supporting the hardware maximum.  The 
> 
> 
> Come on Jeff, don't be such a slave to the hardware specifications. Just
> because it's possible to send down 32MB requests doesn't necessarily
> mean it's a super thing to do, nor that it automagically makes 'things
> go faster'. The claim is that back-to-back 1MB requests are every bit as
> fast as a 32MB request (especially if you have a small queue depth, in
> that case there truly should be zero benefit to doing the bigger ones).
> The cut-off point is likely even lower than 1MB, I'm just using that
> figure as a value that is 'pretty big' yet doesn't incur too large
> latencies just because of its size.


For me this is a policy issue.

I agree that huge requst hurt latency.  I just disagree that the 
_driver_ should artificially lower its maximums to fit a guess about 
what the best request size should be.

If there needs to be an overall limit on per-size size, do it at the 
block layer.  It's not scalable to hardcode that limit into every 
driver.  That's not the driver's job.  The driver just exports the 
hardware limits, nothing more.

A limit is fine.  I support that.  An artificial limit in the driver is not.

	Jeff



