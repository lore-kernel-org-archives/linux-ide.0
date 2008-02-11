From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Forcing PIO0 mode on reset must not freeze
	system
Date: Mon, 11 Feb 2008 11:29:07 +0100
Message-ID: <20080211102907.GC4646@homac.suse.de>
References: <20080210195556.GA5261@homac> <47AFB4DB.1000204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:36055 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbYBKK2S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 05:28:18 -0500
Content-Disposition: inline
In-Reply-To: <47AFB4DB.1000204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@redhat.com, jeff@garzik.org

On Mon 11. Feb - 11:37:15, Tejun Heo wrote:
> Hello,
> 
> Holger Macht wrote:
> > Calling ap->ops->set_piomode(ap, dev) on a device/controller which got
> > already removed, locks the system hard. Reproducibly on an X60 attached to
> > a dock station containing a cdrom device with doing
> > 
> >   $ echo 1 > /sys/devices/platform/dock.0/undock && echo 123 > /dev/sr0
> > 
> > This calls ata_eh_reset(...) which in turn tries to force PIO mode 0. But
> > the device is already gone.
> > 
> > Bisecting revealed the following commit as culprit:
> > 
> >   commit cdeab1140799f09c5f728a5ff85e0bdfa5679cd2
> >   Author: Tejun Heo <htejun@gmail.com>
> >   Date:   Mon Oct 29 16:41:09 2007 +0900
> >   
> >       libata: relocate forcing PIO0 on reset
> >       
> >       Forcing PIO0 on reset was done inside ata_bus_softreset(), which is a
> >       bit out of place as it should be applied to all resets - hard, soft
> >       and implementation which don't use ata_bus_softreset().  Relocate it
> >       such that...
> >       
> >       * For new EH, it's done in ata_eh_reset() before calling prereset.
> >       
> >       * For old EH, it's done before calling ap->ops->phy_reset() in
> >         ata_bus_probe().
> >       
> >       This makes PIO0 forced after all resets.  Another difference is that
> >       reset itself is done after PIO0 is forced.
> >       
> >       Signed-off-by: Tejun Heo <htejun@gmail.com>
> >       Acked-by: Alan Cox <alan@redhat.com>
> >       Signed-off-by: Jeff Garzik <jeff@garzik.org>
> > 
> > 
> > ATTENTION! The following patch solves the problem on my system, but please
> > be aware that I don't really know what I'm doing because I don't have the
> > big picture. There's surely a better way to check if the device/controller
> > is still functional than calling ata_link_{online,offline}.
> 
> In the above example, even the reset sequence itself can cause hang if
> the hardware is implemented slightly differently.  The reason why
> set_piomode() locks up but reset sequence doesn't is simple dumb luck.

Another thing, whether it's poor luck or not, it worked like this than at
least 2.6.22. And it was _heavily_ tested. The above commit broke it
between 2.6.24-rc1 and 2.6.24-rc2, which is at least a regression.

Regards,
	Holger
