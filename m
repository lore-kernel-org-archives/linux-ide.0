From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 09:47:54 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406612AA.1090406@yahoo.com.au>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:42594 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261931AbUC0Xr6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 18:47:58 -0500
In-Reply-To: <406611CA.3050804@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jeff Garzik wrote:
> Nick Piggin wrote:
> 
>> I think 32MB is too much. You incur latency and lose
>> scheduling grainularity. I bet returns start diminishing
>> pretty quickly after 1MB or so.
> 
> 
> See my reply to Bart.
> 
> Also, it is not the driver's responsibility to do anything but export 
> the hardware maximums.
> 
> It's up to the sysadmin to choose a disk scheduling policy they like, 
> which implies that a _scheduler_, not each individual driver, should 
> place policy limitations on max_sectors.
> 

Yeah I suppose you're right there. In practice it doesn't
work that way though, does it?
