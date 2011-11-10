From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-pmp: add schedule timeout to support some PMP
 cards
Date: Thu, 10 Nov 2011 07:20:36 -0800
Message-ID: <20111110152036.GB27258@google.com>
References: <1320033440-1106-1-git-send-email-r66093@freescale.com>
 <20111103160759.GI4417@google.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11617501@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63380 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab1KJPUm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2011 10:20:42 -0500
Received: by ggnb2 with SMTP id b2so3065264ggn.19
        for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2011 07:20:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F11617501@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Thu, Nov 10, 2011 at 08:07:47AM +0000, Huang Changming-R66093 wrote:
> > Ummm... We can't really issue commands after failure without going
> > through recovery.  For ahci, it probably works.  For other controllers,
> > it may not.  Where does this delay come from?  Is there any other way
> > to wait for device readiness?
> > 
> It is very bad.  I have two PMP cards, one (5 ports) can work well
> without the delay time before reading PMP SCR, but the other (15
> ports) must delay enough time before reading the PMP SCR.  It seems
> there is no other way to detect the device readiness.
> 
> Maybe I will just delay some time before send SCR command, if it
> failed, then we will report this error to driver?

Hmmm... I'm curious what's causing the problem.  Which port multiplier
are we talking about?  If it's specific to that PMP, we can add quirk
to support it.  Does the problem also happen when the PMP is connected
to a different controller?

Thanks.

-- 
tejun
