From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ide: add dcache flushing after PIO
Date: Wed, 21 Dec 2005 23:43:09 +0900
Message-ID: <43A969FD.3090106@gmail.com>
References: <9DA102EC128AD511BED000306E0766C70180487A@WTCNT4GW> <43A7FE89.4040909@gmail.com> <58cb370e0512200823g50de6e14n148e27e4a4c267f7@mail.gmail.com> <20051221094847.GA12279@htj.dyndns.org> <20051221140022.GA25001@htj.dyndns.org> <20051221140344.GA1736@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:9222 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932435AbVLUOnP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2005 09:43:15 -0500
Received: by zproxy.gmail.com with SMTP id 13so173761nzn
        for <linux-ide@vger.kernel.org>; Wed, 21 Dec 2005 06:43:15 -0800 (PST)
In-Reply-To: <20051221140344.GA1736@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Steward <james.steward@dynamicratings.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Russell King wrote:
> On Wed, Dec 21, 2005 at 11:00:22PM +0900, Tejun Heo wrote:
> 
>>Block drivers are responsible for cache coherency before and after IO.
>>When using DMA, DMA API takes care of it but drivers should do manual
>>flushing with PIO.
> 
> 
> Are you sure you need the ones in the write path?  No other driver
> seems to do this.
> 

Unfortunately, I'm not.  I was trying to be on the safe side.

Are the page caches guaranteed to have no dirty alias on entry to block 
layer for write?  I can see that aliases are handled for read(2)s and 
write(2)s but I don't know much about mmap writebacks.

Another question is whether or not it's guaranteed that there's no 
user-mapped dirty cachelines on entry to block layer for read.  DMA API 
clears all cpu caches before IO and, as DMA IO doesn't touch any cpu 
caches, it doesn't do anything after IO.  The previous patch adds a 
flush_dcache_page after IO which makes sure that the kernel cache line 
is gone, but it doesn't do anything to make sure that there's no dirty 
user-mapped cachelines hanging around before IO.

I couldn't find an exemplary driver doing this kind of things with page 
caches.  Most other flush_dcache_page usages I looked at didn't deal 
with user mapped page caches.

-- 
tejun
