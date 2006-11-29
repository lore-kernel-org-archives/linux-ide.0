From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Wed, 29 Nov 2006 08:19:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611290814160.3395@woody.osdl.org>
References: <456CB72A.3010004@local.se> <456CDB06.40806@gmail.com>
 <456D3370.5050003@local.se> <456D36BF.1060809@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:50818 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967457AbWK2QTS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Nov 2006 11:19:18 -0500
In-Reply-To: <456D36BF.1060809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jonas@local.se, linux-ide@vger.kernel.org



On Wed, 29 Nov 2006, Tejun Heo wrote:
> 
> You pushed your box really hard and the kernel can't get the memory it wants.
> Not really relevant to SATA problem.

And it's not even really a bug - the caller is supposed to be ok with it. 
It's a warning message that the kernel spits out just because we've had 
problems in the past with callers that did _not_ handle an allocation 
error gracefully, so the warnign is spit out to (a) let us know something 
happened and (b) if there's a subsequent oops due to dereferencing a NULL 
pointer, it becomes easier to pinpoint what the sequence of events was.

So it's an atomic allocation that happens on the receive path in the 
network when you've run out of pages (because you're getting enough 
network traffic that earlier receives have used up all buffers, and so 
much disk IO that we haven't had time to clean any new pages yet), and 
getting an allocation failure there really is "normal", it's just "very 
unusual".

So that particular dump _looks_ scary, but it happens to be totally a 
non-issue unless something else happens afterwards to imply that the 
caller had trouble with the allocation failure.

It's also a sign of trouble if you can trigger it _easily_. It should be 
something that only triggers under very high load and under unusual 
circumstances.

		Linus
