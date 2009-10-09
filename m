From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH #upstream-fixes] ahci: disable 64bit DMA by
 default on SB600s
Date: Fri, 9 Oct 2009 15:02:48 -0700
Message-ID: <20091009220248.GA28123@kroah.com>
References: <4AC71901.6010005@kernel.org>
 <4ACAC646.9050606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:58859 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934424AbZJIWWi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Oct 2009 18:22:38 -0400
Content-Disposition: inline
In-Reply-To: <4ACAC646.9050606@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, balducci@units.it, Shane Huang <Shane.Huang@amd.com>, stable@kernel.org, maierp@informatik.tu-muenchen.de

On Tue, Oct 06, 2009 at 12:23:34AM -0400, Jeff Garzik wrote:
> On 10/03/2009 05:27 AM, Tejun Heo wrote:
> > Till now only one board, ASUS M2A-VM, can do 64bit dma with recent
> > BIOSen.  Enabling 64bit DMA by default already broke three boards.
> > Enabling 64bit DMA isn't worth these regressions.  Disable 64bit DMA
> > by default and enable it only on boards which are known to work.
> >
> > Signed-off-by: Tejun Heo<tj@kernel.org>
> > Reported-by: Gabriele Balducci<balducci@units.it>
> > Reported-by: maierp@informatik.tu-muenchen.de
> > Cc: Shane Huang<shane.huang@amd.com>
> > Cc: stable@kernel.org
> > ---
> >   drivers/ata/ahci.c |   60 +++++++++++++++++------------------------------------
> >   1 file changed, 20 insertions(+), 40 deletions(-)
> 
> applied

This doesn't apply to the 2.6.31-stable tree.

Tejun, could you respin this for the stable release, if you feel it
needs to be there?

thanks,

greg k-h
