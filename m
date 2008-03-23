From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.25-rc6] sata_promise: fix hardreset hotplug quirk
Date: Sun, 23 Mar 2008 21:07:30 +0900
Message-ID: <47E64802.4040507@gmail.com>
References: <200803221421.m2MEL1oY021558@harpo.it.uu.se>	<47E5CCC3.3000301@gmail.com> <18406.12612.194477.944676@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:29376 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759091AbYCWMHg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 08:07:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2806866wah.23
        for <linux-ide@vger.kernel.org>; Sun, 23 Mar 2008 05:07:35 -0700 (PDT)
In-Reply-To: <18406.12612.194477.944676@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, kurt@roeckx.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
>  > Actually, this is common to many SATA controllers.  Lots of them raise
>  > PHY event or hotplug interrupt during COMRESET and they all plug PHY
>  > events from ->freeze.
> 
> Hmm, no I didn't know that. It's still undocumented, but perhaps
> shouldn't be called a "quirk" if it's as common as you say.

Yeap, it's common behavior.  "quirk" would be a bit unfair to promise. :-)

>  > > Although SATA hotplug status and control is per-port, it resides in
>  > > a single register shared by all ports. Therefore accesses to it must
>  > > be serialised: the controller's host->lock is used for that. The
>  > > interrupt handler is also adjusted so its hotplug register accesses
>  > > are inside the region protected by host->lock.
>  > 
>  > Hmmm... This is supposed to be handled by setting ap->lock appropriately
>  > and ap->lock already is initialized to &host->lock, so sticking with
>  > ap->lock is the right thing to do.
> 
> I'll check this. The code relies on the lock being shared by all ports,
> so at a minimum it will need a comment stating that requirement.

That's the default assumption all other LLDs depend on.  I agree it
needs documentation.

>  > ->freeze() is called with ap->lock held, trying to lock host->lock
>  > inside pdc_sata_enable/disable_hotplug() will result in deadlock.  Have
>  > you tested w/ SMP configuration or spinlock debugging turned on?
> 
> No, I'll do that and fix whatever damage occurs.

Thanks.

-- 
tejun
