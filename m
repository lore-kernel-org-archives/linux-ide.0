From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Mon, 22 Feb 2010 20:05:22 +0100
Message-ID: <20100222190522.GD1025@kernel.dk>
References: <20100220142826.62dd5989@pluto-lenny.milky.way> <4B802B54.1080009@gmail.com> <20100221022613.1096fd12@uranus> <51f3faa71002210922i542c37f0j9e0e4a84d0977f90@mail.gmail.com> <20100221225544.5a9ded51@pluto-lenny.milky.way> <51f3faa71002211400u2177660ei1c0dc3d9306b146e@mail.gmail.com> <20100222141802.2bcbf607@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 0122700014.0.fullrate.dk ([95.166.99.235]:50143 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446Ab0BVTFX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Feb 2010 14:05:23 -0500
Content-Disposition: inline
In-Reply-To: <20100222141802.2bcbf607@pluto-lenny.milky.way>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, Feb 22 2010, Benjamin S. wrote:
> 
> On Sun, 21 Feb 2010 16:00:35 -0600
> Robert Hancock <hancockrwd@gmail.com> wrote:
> 
> > Hmm.. Well, that's not it then.. I suspect a bisection is likely the
> > easiest route at this point..
> 
> fb1e75389bd06fd5987e9cda1b4e0305c782f854 is the first bad commit
> commit fb1e75389bd06fd5987e9cda1b4e0305c782f854
> Author: Jens Axboe <jens.axboe@oracle.com>
> Date:   Thu Jul 30 08:18:24 2009 +0200
> 
>     block: improve queue_should_plug() by looking at IO depths
>     
>     Instead of just checking whether this device uses block layer
>     tagging, we can improve the detection by looking at the maximum
>     queue depth it has reached. If that crosses 4, then deem it a
>     queuing device.
>     
>     This is important on high IOPS devices, since plugging hurts
>     the performance there (it can be as much as 10-15% of the sys
>     time).
>     
>     Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> 
> 
> 
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=fb1e75389bd06fd5987e9cda1b4e0305c782f854
> 
> 
> Without that patch my SSD (Super Talent Ultradrive GX MLC 64GB)
> reaches about 200MB/s sequentiell read. After applying the patch it
> reaches only 70MB/s.

That's not good. Can you send me the dmesg snippet that includes the
drive detection?

-- 
Jens Axboe

