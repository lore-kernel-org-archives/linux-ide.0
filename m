From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH #upstream-fixes] sata_nv: disable hardreset
	for generic
Date: Thu, 2 Oct 2008 12:57:31 -0700
Message-ID: <20081002195731.GA20902@kroah.com>
References: <4895407B.5030602@kernel.org> <48B803F8.8000306@kernel.org> <48C57A4A.2050303@kernel.org> <20081001232211.GA31609@kroah.com> <48E41447.6000103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60556 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754263AbYJBUDr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Oct 2008 16:03:47 -0400
Content-Disposition: inline
In-Reply-To: <48E41447.6000103@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux@sun7.cn, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>, stable@kernel.org

On Thu, Oct 02, 2008 at 09:22:31AM +0900, Tejun Heo wrote:
> Greg KH wrote:
> > On Mon, Sep 08, 2008 at 09:17:30PM +0200, Tejun Heo wrote:
> >> Tejun Heo wrote:
> >>> From 2.6.26, libata is defaulting to hardreset for various reasons one
> >>> of them being unifying probing, hotplug and EH reset paths uniform.
> >>> Previously, broken hardreset could go unnoticed as it wasn't used
> >>> during probing but when something goes wrong or after hotplug the
> >>> problem will surface and bite hard.
> >>>
> >>> OSDL bug 11195 reports that sata_nv generic flavor falls into this
> >>> category.  Hardreset itself succeeds but PHY stays offline after
> >>> hardreset.  I tried longer debounce timing but the result was the
> >>> same.
> >>>
> >>>   http://bugzilla.kernel.org/show_bug.cgi?id=11195
> >>>
> >>> So, it seems we'll have to drop hardreset from the generic flavor.
> >>>
> >>> Signed-off-by: Tejun Heo <tj@kernel.org>
> >>> Cc: Peer Chen <pchen@nvidia.com>
> >> This one definitely should go into -stable too.  The original patch is...
> >>
> >> http://article.gmane.org/gmane.linux.ide/34077/raw
> > 
> > Now applied, thanks.
> 
> Greg, can you please hold a bit before releasing this?  This patch
> accidentally disables hardreset for all flavors of nv controllers which
> causes problems for ck804.  A later patch to only apply it to generic
> went in but it then broke nf2 flavor, so it seems generic and nf2
> require this workaround but ck804 doesn't like the workaround.  I've
> asked a reporter to test to apply the workaround only to generic and nf2
> and will forward the third patch as soon as it's confirmed.  So, please
> wait till the third one is ready.

Ok, I've dropped:
	sata_nv-disable-hardreset-for-generic.patch
from the 2.6.26-stable queue for now.

If you get it all working, please resend all of the patches that you
wish me to pick up for a -stable release (well send them to
stable@kernel.org, not me directly.)

thanks,

greg k-h
