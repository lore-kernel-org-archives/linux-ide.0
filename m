From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv errata function
Date: Mon, 21 Apr 2008 09:41:49 -0400
Message-ID: <480C999D.9040202@rtr.ca>
References: <3908ea640804210542s4e1e8403tfec4a99816b5d148@mail.gmail.com> <BD261180E6D35F4D9D32F3E44FD3D9010CA88A84@EMPBEDEX.empirix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1655 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755171AbYDUNls (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 09:41:48 -0400
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010CA88A84@EMPBEDEX.empirix.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: Sylver Bruneau <sylver.bruneau@googlemail.com>, linux-ide@vger.kernel.org, jeff@garzik.org

Morrison, Tom wrote:
> Interesting - I was just looking at this code this morning - and
> comparing with the reference driver Marvell has given us - this was
> one of the differences I was looking at because with this new driver
> and the old reference driver we were having performance problems
> due to vibrations or something that is causing the disk write
> performance
> to go very low (<5Mbytes/second)...
> 
> I'd be very interested what Mark has to say about this - he just 
> made some update to the driver - perhaps he has updated these values...
..

I've replied separately to Sylver's original post,
but just to keep me on all branches of this thread I'm
replying again now to you.  :)

Most errata fixes are on my menu here for the next few weeks,
so the ones pointed out by Sylver will get fixed as part of that.

As to the current state of sata_mv, it is *still* deservedly marked
as "HIGHLY EXPERIMENTAL".  I would not trust my own data to it yet.

In practice, I believe it is actually working well now,
on non-PCIX systems at least.

But, as you see, there are still missing workarounds for various errata,
and I am not yet totally finished with the error-handling logic.
That still needs just a little more TLC to be reliable/correct with NCQ.

So the "HIGHLY EXPERIMENTAL" label remains, for now, but I do plan to 
strip it away entirely within a few weeks of now.

Cheers
