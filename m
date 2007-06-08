From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: claim ctl port for legacy SFF ports
Date: Fri, 8 Jun 2007 10:24:37 -0400
Message-ID: <20070608142437.GA25649@havoc.gtf.org>
References: <20070604235157.GD31462@havoc.gtf.org> <20070608114119.GE29122@htj.dyndns.org> <20070608135517.GA24346@havoc.gtf.org> <466963B1.4070208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:57241 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968710AbXFHOYi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jun 2007 10:24:38 -0400
Content-Disposition: inline
In-Reply-To: <466963B1.4070208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Fri, Jun 08, 2007 at 11:12:01PM +0900, Tejun Heo wrote:
> Jeff Garzik wrote:
> > On Fri, Jun 08, 2007 at 08:41:19PM +0900, Tejun Heo wrote:
> >> libata used to claim only cmd ports for legacy SFF ports.  Claim ctl
> >> ports too.
> >>
> >> Signed-off-by: Tejun Heo <htejun@gmail.com>
> >> ---
> >> This has been this way as long as I can remember.  It's almost
> >> pleasant to see that it survived through all the devres/init rework.
> >> I guess it's time for a change.
> > 
> > pci_request_regions() should claims everything, if Alan did his job :)
> > 
> > All this goes through ata_pci_init_one(), which guarantees it's PCI IDE.
> 
> Allowing legacy to be used on non-PCI systems was your idea!  Alright,
> then we can drop a lot of junk from legacy SFF code.  Will prep another
> patch.  Please ignore two patches in this thread.

Alan seems to be ignoring that idea, so it turned out to be useless...  :/

	Jeff



