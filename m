From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [BK PATCH] 2.6.x libata bug fix
Date: Tue, 26 Oct 2004 13:45:47 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <417E8D4B.8030203@pobox.com>
References: <20041026160247.GA23459@havoc.gtf.org> <20041026173025.GA15290@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44955 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261366AbUJZRqG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Oct 2004 13:46:06 -0400
In-Reply-To: <20041026173025.GA15290@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Tue, Oct 26 2004, Jeff Garzik wrote:
>>So, we return the proper return code, and ioctls we don't handle
>>start to work again.  Overall, though, this is a fragile way to do
>>things in the block layer, IMHO.
> 
> 
> Well, it's pretty much the universally accepted way of signalling this
> information, I'm not sure I agree. The crappy part is that EINVAL is so
> wide spread as well.


My point is that most Linux APIs don't apply default behavior by means 
of a magic return code.

Each block/scsi/etc. driver should provide their own ioctl handler as 
the highest-level callback.  Then, each individual driver decides its 
fallback strategy for unknown ioctls -- in most cases, by calling 
"libata_ioctl" or "scsi_ioctl" or "block_ioctl".

In this manner, ioctl handling cascades naturally up through the layers, 
without magic return codes.

The current "top-down" ioctl handling implementation leads to the 
current situation:  a bunch of ->ioctl() callsites scattered through the 
generic block ioctl handling code.

	Jeff


