From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [RFC] Disk shock protection (revisited)
Date: Tue, 26 Feb 2008 01:30:33 +0100
Message-ID: <87ejb0d0eu.fsf@denkblock.local>
References: <87skzgd1zk.fsf@denkblock.local> <47C35714.4090604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:47007 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757582AbYBZAbD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 19:31:03 -0500
In-Reply-To: <47C35714.4090604@garzik.org> (Jeff Garzik's message of "Mon, 25
	Feb 2008 19:02:28 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Jeff Garzik <jeff@garzik.org> wrote:
> Elias Oltmanns wrote:
>> The general idea: A daemon running in user space monitors input data
>> from an accelerometer. When the daemon detects a critical condition,
>> i.e., a sudden acceleration (for instance, laptop slides off the desk),
>> it signals the kernel so the hard disk may be put into a (more) safe
>> state. To this end, the kernel has to issue an idle immediate command
>> with unload feature and stop the block layer queue afterwards. Once the
>> daemon tells us that the imminent danger is over, the most important
>> task for the kernel is to restart the block layer queue. See below for
>> more details.
>
> Speaking specifically to that problem, it seems to me that you either
> want an mlock'd daemon, or just simply to keep everything in the
> kernel, for this specific solution.

Yes, the daemon is mlock'd.

>
> You don't want, for example, to swap out other apps, swap in the
> daemon, in order to handle a sudden acceleration.

Quite. But with mlock this particular problem can be handled in user
space just fine. The only reason I can see right now for putting this
logic into the kernel as well is to keep the functionality around even
after task freeze during suspend / resume. On the other hand, I don't
know whether this is really worth the effort even though the time when
the suspend operation is in progress can arguably be one of the most
accident-prone moments (think of users packing their things in a hurry).

Regards,

Elias
