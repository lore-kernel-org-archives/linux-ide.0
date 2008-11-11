From: Tejun Heo <tj@kernel.org>
Subject: Re: Fwd: [PATCH #upstream-fixes 1/4] libata: fix device iteration
 bugs
Date: Tue, 11 Nov 2008 11:45:16 +0900
Message-ID: <4918F1BC.2070602@kernel.org>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34383 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446AbYKKCpk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 21:45:40 -0500
In-Reply-To: <49184E1A.3010508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Michael Guntsche <mike@it-loops.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Mark Lord wrote:
>> On Michael's real old ata_piix, somehow the ERR bit is set on phantom
>> device defeating our phantom device detection logic.  We can relax
>> phantom device condition but that increases the risk of misdetection on
>> actual IDENTIFY errors.  Any ideas how we can nicely work around this
>> one?
> ..
> 
> Mmm.. I'm way out of the loop on this now,
> so please pardon me suggesting things known not to work, but..
> 
> 1. Pay attention to ATA status register on this chipset?
>   Eg. if it has BUSY, or reads 0x7f, then don't IDENTIFY?
> 2. Check for device signature before trying IDENTIFY?
> 3. Try a r/w test on the data register first, to see if there's
>   really hardware attached to it?

We already do 1, 2 and 3.  The problem with phantom device is that the
existent device on the channel replies to acesses to the other
non-existent device and the NODEV_HINT detection is the last line of
defense which successfully evades all the other mechanisms.  And now
we have this controller/device combination which successfully tricks
it too.  :-(

-- 
tejun
