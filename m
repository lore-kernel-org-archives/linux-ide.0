From: Mark Lord <liml@rtr.ca>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Sat, 29 Sep 2007 08:32:14 -0400
Message-ID: <46FE45CE.1050007@rtr.ca>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3655 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbXI2McQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Sep 2007 08:32:16 -0400
In-Reply-To: <46FDADD9.9050007@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>
> I certainly deserve plenty of blame for not catching this fact earlier, 
> much to my chagrin.  But there are real technical issues at hand:
> 
> Polling ALREADY makes the job of fixing SAS/SATA exception handling 
> difficult.  Expanding polling to something SAS/SATA controllers treat as 
> fundamentally irq-driven and integrated with the rest of the command 
> flow is moving in the wrong direction.

Fine.  But the exising PMP patchset has already taken close to a year
to become mature and safe enough to pass "Jeff review".  Tons of us are
awaiting it in mainline, and to rework it to meet your latest concerns
will delay it until 2.6.25 at least --> mid 2008.  Not Acceptable.

It doesn't *break* anything (we know of).
It doesn't affect existing SAS functionality.

It *does* add working, critical functionality to libata.

And.. Tejun isn't just going to lay down and be happy
with it in 2.6.24.  He's fully committed to the rework you're demanding,
but in a more timely and correct fashion.

Linux kernel development is supposed to happen incrementally nowadays.
Get a nice working solution in place, and then enhance/tune it.

The current implementation is certainly kernel-worthy,
and will be reworked over time as is the rest of libata.

The barrier to entry for new libata functionality is way too high.
Yes, we want readable, *reliable* code, because screwing people's
filesystems is not an option.  Fine.

Tejun's current code is more than "good enough",
and "perfect" code doesn't exist.
But we're all striving for it anyway.

Cheers
