From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 16:56:52 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40667734.8090203@yahoo.com.au>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <20040328044029.GB1984@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:13993 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262088AbUC1G5A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 01:57:00 -0500
In-Reply-To: <20040328044029.GB1984@bounceswoosh.org>
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Eric D. Mudama wrote:
> On Sun, Mar 28 at  9:37, Nick Piggin wrote:
> 
>> I think 32MB is too much. You incur latency and lose
>> scheduling grainularity. I bet returns start diminishing
>> pretty quickly after 1MB or so.
> 
> 
> 32-MB requests are the best for raw throughput.
> 
> ~15ms to land at your target location, then pure 50-60MB/sec for the .5
> seconds it takes to finish the operation. (media limited at that point)
> 
> Sure, there's more latency, but I guess that is application dependant.
> 

What about a queue depth of 2, and writing that 32MB in 1MB requests?
