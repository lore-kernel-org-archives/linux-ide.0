From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v2 3/3] ahci_platform: perform platform exit in host_stop()
 hook
Date: Thu, 1 Nov 2012 09:17:14 -0700
Message-ID: <20121101161714.GC9169@htj.dyndns.org>
References: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
 <1351368576-5264-4-git-send-email-computersforpeace@gmail.com>
 <20121029013709.GB5171@htj.dyndns.org>
 <CAN8TOE_RZtpnEnNuM2ZyODGGURUWDba57vVOHa0BEsh5h8wFPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37562 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415Ab2KAQRS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2012 12:17:18 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1824682pad.19
        for <linux-ide@vger.kernel.org>; Thu, 01 Nov 2012 09:17:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN8TOE_RZtpnEnNuM2ZyODGGURUWDba57vVOHa0BEsh5h8wFPQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kevin Cernekee <cernekee@gmail.com>

Hello, Brian.

On Wed, Oct 31, 2012 at 11:41:45PM -0700, Brian Norris wrote:
> > If you have some time, it would be nice to introduce
> > ata_platform_remove_one().  There's no reason to have that implemented
> > separately in each driver.
> 
> OK, I think I have a pretty good set of patches. I have about 8
> drivers switched over to a new ata_platform_remove_one(). Should I
> submit it with my resend of this series?

I think both ways should be fine.

> >  It would also be nice to move
> > remove_one()'s to some higher level port_ops so that individual
> > drivers don't have to specify them explicitly.
> 
> Hmm, which port op would you recommend? host_stop()? Or a new remove_one() op?

Heh, that was me being confused.  Please disregard.  I for some reason
thought .remove is an ata operation.  :)

Thanks.

-- 
tejun
