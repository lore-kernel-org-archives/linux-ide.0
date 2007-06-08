From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: claim ctl port for legacy SFF ports
Date: Fri, 8 Jun 2007 11:36:38 -0400
Message-ID: <20070608153638.GF25649@havoc.gtf.org>
References: <20070604235157.GD31462@havoc.gtf.org> <20070608114119.GE29122@htj.dyndns.org> <20070608135517.GA24346@havoc.gtf.org> <466963B1.4070208@gmail.com> <20070608142437.GA25649@havoc.gtf.org> <20070608163337.33f2f13e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:57427 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969148AbXFHPgj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jun 2007 11:36:39 -0400
Content-Disposition: inline
In-Reply-To: <20070608163337.33f2f13e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Fri, Jun 08, 2007 at 04:33:37PM +0100, Alan Cox wrote:
> > > Allowing legacy to be used on non-PCI systems was your idea!  Alright,
> > > then we can drop a lot of junk from legacy SFF code.  Will prep another
> > > patch.  Please ignore two patches in this thread.
> > 
> > Alan seems to be ignoring that idea, so it turned out to be useless...  :/
> 
> For the init code stuff it turns out to be useless, for the rest of the
> general chip kicking it turns out to be very useful indeed.

Unless I've completely lost the thread, it's the only init code that
is being discussed and patched...

	Jeff



