From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sat, 27 Mar 2004 18:59:43 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4066156F.1000805@pobox.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261907AbUC0X75
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 18:59:57 -0500
In-Reply-To: <406612AA.1090406@yahoo.com.au>
List-Id: linux-ide@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Nick Piggin wrote:
> Jeff Garzik wrote:
> 
>> Nick Piggin wrote:
>>
>>> I think 32MB is too much. You incur latency and lose
>>> scheduling grainularity. I bet returns start diminishing
>>> pretty quickly after 1MB or so.
>>
>>
>>
>> See my reply to Bart.
>>
>> Also, it is not the driver's responsibility to do anything but export 
>> the hardware maximums.
>>
>> It's up to the sysadmin to choose a disk scheduling policy they like, 
>> which implies that a _scheduler_, not each individual driver, should 
>> place policy limitations on max_sectors.
>>
> 
> Yeah I suppose you're right there. In practice it doesn't
> work that way though, does it?

Not my problem  <grin>

People shouldn't be tuning max_sectors at the source code level: that 
just embeds the policy decisions in the source code, and leads to 
constant fiddling with the driver to get things "just right". Over time, 
disks get faster and latency falls naturally.  Thus the definition of 
"just right" must be constantly tuned in the driver source code as time 
passes.

I also wouldn't want to lock out any users who wanted to use SATA at 
full speed ;-)

	Jeff



