From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Forcing PIO0 mode on reset must not freeze system
Date: Mon, 11 Feb 2008 11:37:15 +0900
Message-ID: <47AFB4DB.1000204@gmail.com>
References: <20080210195556.GA5261@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:32019 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbYBKChZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 21:37:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3235127rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 18:37:24 -0800 (PST)
In-Reply-To: <20080210195556.GA5261@homac>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com, alan@redhat.com, jeff@garzik.org

Hello,

Holger Macht wrote:
> Calling ap->ops->set_piomode(ap, dev) on a device/controller which got
> already removed, locks the system hard. Reproducibly on an X60 attached to
> a dock station containing a cdrom device with doing
> 
>   $ echo 1 > /sys/devices/platform/dock.0/undock && echo 123 > /dev/sr0
> 
> This calls ata_eh_reset(...) which in turn tries to force PIO mode 0. But
> the device is already gone.
> 
> Bisecting revealed the following commit as culprit:
> 
>   commit cdeab1140799f09c5f728a5ff85e0bdfa5679cd2
>   Author: Tejun Heo <htejun@gmail.com>
>   Date:   Mon Oct 29 16:41:09 2007 +0900
>   
>       libata: relocate forcing PIO0 on reset
>       
>       Forcing PIO0 on reset was done inside ata_bus_softreset(), which is a
>       bit out of place as it should be applied to all resets - hard, soft
>       and implementation which don't use ata_bus_softreset().  Relocate it
>       such that...
>       
>       * For new EH, it's done in ata_eh_reset() before calling prereset.
>       
>       * For old EH, it's done before calling ap->ops->phy_reset() in
>         ata_bus_probe().
>       
>       This makes PIO0 forced after all resets.  Another difference is that
>       reset itself is done after PIO0 is forced.
>       
>       Signed-off-by: Tejun Heo <htejun@gmail.com>
>       Acked-by: Alan Cox <alan@redhat.com>
>       Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> 
> ATTENTION! The following patch solves the problem on my system, but please
> be aware that I don't really know what I'm doing because I don't have the
> big picture. There's surely a better way to check if the device/controller
> is still functional than calling ata_link_{online,offline}.

In the above example, even the reset sequence itself can cause hang if
the hardware is implemented slightly differently.  The reason why
set_piomode() locks up but reset sequence doesn't is simple dumb luck.
I think the proper fix is to tell libata to detach the cdrom before
undocking.

> Signed-off-by: Holger Macht <hmacht@suse.de>

NACK.

-- 
tejun
