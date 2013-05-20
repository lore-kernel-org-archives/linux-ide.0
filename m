From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Tue, 21 May 2013 03:59:29 +0900
Message-ID: <20130520185929.GA28226@mtj.dyndns.org>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
 <201305200820.05239.plr.vincent@gmail.com>
 <20130520073012.GA24222@mtj.dyndns.org>
 <201305201251.20920.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:39544 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab3ETTH4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 May 2013 15:07:56 -0400
Received: by mail-we0-f176.google.com with SMTP id p58so2293489wes.21
        for <linux-ide@vger.kernel.org>; Mon, 20 May 2013 12:07:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201305201251.20920.plr.vincent@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?Q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hello,

On Mon, May 20, 2013 at 12:51:20PM +0200, Vincent Pelletier wrote:
> Putting the knob on the port is just a way I thought about to hold the 
> configuration before the drive is plugged into the system (because so far I 
> was focussed on host-side being hot-pluggable, I indeed didn't consider the 
> opposite situation) so it can be used before libata tries to access the 
> device.

Right, we don't even have the sysfs node before probing.  I forgot
about that.

> So it would be something like:
> - plug device (or boot up)
>   -> detection times out, device "half" configured (sysfs node present, drive
>      not usable)
> - cd $DEVICE_IN_SYSFS
> - echo 1 > atapi_dmadir
> - echo 1 > (rescan|reinit|...)
> 
> If it's ok, I'll write a patch to add a rescan write-only file (will also be 
> independent from the 2 other patches).

Ugh... so, this is inherently racy between the probing code and admin.
Maybe we should just implement a new libata.force param and forget
about dynamic configuration?

One more thing.  In the ata_exec_internal_sg(), DMADIR should be set
iff DMA is being used, right?  So, it should also check tf->protocol.
It prolly should test tf->protocol == ATAPI_PROT_DMA instead of cdb.

Thanks.

-- 
tejun
