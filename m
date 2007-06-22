From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFT] hpt366: reset DMA state machine on timeouts
Date: Fri, 22 Jun 2007 19:32:44 +0400
Message-ID: <467BEB9C.1070407@ru.mvista.com>
References: <200706212154.47398.sshtylyov@ru.mvista.com> <20070622151359.GD8840@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:9083 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757395AbXFVPbD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jun 2007 11:31:03 -0400
In-Reply-To: <20070622151359.GD8840@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-ide@vger.kernel.org

Hello.

Linas Vepstas wrote:

>>Reset HPT36x's DMA state machine on a DMA timeout the way it's done for HPT370.

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>>Linas, here's what I've come up with -- this should apply against 2.6.21.y.
>>Compile-tested only, not for merging.

>> drivers/ide/pci/hpt366.c |   24 +++++++++++++++++++++++-

> This worked great!  The patch is good. But it raises another interesting
> issue, one of those akpm ZFS "voilates boundaries" isses.

> However.. When raid goes to reconstruct the partition, I get one
> of the Drive Ready Seek Complete etc. messages.  Your handler recovers 

    I hope you meant those messages were preceeded by DMA timeouts (otherwise 
this code wouldn't come into action).

> from it (I put in a printk to verify this).

    You mean into my ide_dma_timeout() method?

> And so these printk's
> try to get logged into /var/log/messages ... which trigger more 
> errors. At a very high rate ... sometimes hundreds a second, sometimes
> less.  The system remains usable, but at one point, it hit 60% cpu usage
> spewing these messages to the screen.  

    Hm...

> I'd like to see several things.

> 1) This patch should go in.  It converts a system that hangs into
>    one that doesn't hang.

    What's strange is that it never seemed to be necessary before your great 
new drive... ;-)
    So, providing its data certainly wouldn't hurt -- perhaps we just should 
blacklist it instead -- maybe there's a UDMA speed at which this wouldn't 
happen, and we could just limit the drive to it.

> 2) There needs to be a way of failing the disk when there's a high
>    number of errors. e.g. if there are more than 100 errors per minute
>    then the disk needs to be marked "failed" in the raid array.

>    Note it should be stopped only if the rate is high: if there is 
>    only 1 error per minte, this might be very annoying, but acceptable,
>    esp. if one is just trying to copy data off the disk.

>    I'm not sure what to do if this had been the only disk in the system.
>    Maybe if the eror reate exceed 100/minute, then dma is turned off 
>    permanently?

    In fact, it should be turned off after 3 DMA errors (causing PIO retries).

> --linas

MBR, Sergei
