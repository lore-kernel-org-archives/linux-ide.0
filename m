From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: disable port while unloading ATA controller driver
Date: Tue, 29 Nov 2016 17:29:41 -0500
Message-ID: <20161129222941.GA17732@htj.duckdns.org>
References: <20161127231856.11466-1-vz@mleia.com>
 <20161128183425.GA19096@htj.duckdns.org>
 <a498fb9f-822e-45aa-aac1-c7afae7a44e3@mleia.com>
 <09c7866c-ecd4-f48a-5112-6cf3c6786cd9@mleia.com>
 <20161129190025.GC22330@htj.duckdns.org>
 <cf257dae-7811-0338-3b59-050f34c1ae29@mleia.com>
 <20161129204413.GC4959@htj.duckdns.org>
 <b33224b4-0f20-9c8d-38e3-2e6b2e8882a9@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36598 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbcK2W3t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2016 17:29:49 -0500
Received: by mail-yw0-f193.google.com with SMTP id r204so13395760ywb.3
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2016 14:29:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b33224b4-0f20-9c8d-38e3-2e6b2e8882a9@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Rob Herring <robh@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

Hello,

On Wed, Nov 30, 2016 at 12:15:50AM +0200, Vladimir Zapolskiy wrote:
> in case if I haven't tired you out yet, I verified you solution and it
> works perfectly, there is no problem in ATA subsystem which I can point
> out:
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index d76cd97..a4feecf 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -384,6 +384,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	if (test_remove) {
>  		test_remove = false;
>  
> +		async_synchronize_full();
> +
>  		if (dev->bus->remove)
>  			dev->bus->remove(dev);
>  		else if (drv->remove)

Yeah, this should do it.

> In my understanding the code under "if (test_remove)" branch should be
> close to the code of __device_release_driver() function, but here it
> is slightly different on purpose --- driver_allows_async_probing(drv)
> returns false in case of the ATA controller driver(s), here async
> probing is not a functional part of a driver, but it is embedded into
> the ATA subsystem by means of generic async_port_probe(). Not sure if
> __device_release_driver() or driver_allows_async_probing() should be
> corrected respecting this case, and hence I'm not going to touch it.

Currently, we depend on the fact that there is guaranteed to be a
synchronization point before unloading, so adding that to test code
seems like the right thing to do to me.

Thanks.

-- 
tejun
