From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH #upstream-fixes] sata_nv: disable hardreset
	for generic
Date: Wed, 1 Oct 2008 16:22:11 -0700
Message-ID: <20081001232211.GA31609@kroah.com>
References: <4895407B.5030602@kernel.org> <48B803F8.8000306@kernel.org> <48C57A4A.2050303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:40879 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750895AbYJAXnO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Oct 2008 19:43:14 -0400
Content-Disposition: inline
In-Reply-To: <48C57A4A.2050303@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux@sun7.cn, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>, stable@kernel.org

On Mon, Sep 08, 2008 at 09:17:30PM +0200, Tejun Heo wrote:
> Tejun Heo wrote:
> > From 2.6.26, libata is defaulting to hardreset for various reasons one
> > of them being unifying probing, hotplug and EH reset paths uniform.
> > Previously, broken hardreset could go unnoticed as it wasn't used
> > during probing but when something goes wrong or after hotplug the
> > problem will surface and bite hard.
> > 
> > OSDL bug 11195 reports that sata_nv generic flavor falls into this
> > category.  Hardreset itself succeeds but PHY stays offline after
> > hardreset.  I tried longer debounce timing but the result was the
> > same.
> > 
> >   http://bugzilla.kernel.org/show_bug.cgi?id=11195
> > 
> > So, it seems we'll have to drop hardreset from the generic flavor.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Cc: Peer Chen <pchen@nvidia.com>
> 
> This one definitely should go into -stable too.  The original patch is...
> 
> http://article.gmane.org/gmane.linux.ide/34077/raw

Now applied, thanks.

greg k-h
