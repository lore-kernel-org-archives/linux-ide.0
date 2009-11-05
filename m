From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH #stable] ahci: disable 64bit DMA by default on
 SB600s
Date: Thu, 5 Nov 2009 12:00:46 -0800
Message-ID: <20091105200046.GB31331@kroah.com>
References: <4AC71901.6010005@kernel.org>
 <4ACAC646.9050606@garzik.org>
 <20091009220248.GA28123@kroah.com>
 <4AD2DA9A.7080503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:53353 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758316AbZKEU1J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Nov 2009 15:27:09 -0500
Content-Disposition: inline
In-Reply-To: <4AD2DA9A.7080503@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: balducci@units.it, Shane Huang <Shane.Huang@amd.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, maierp@informatik.tu-muenchen.de, stable@kernel.org

On Mon, Oct 12, 2009 at 04:28:26PM +0900, Tejun Heo wrote:
> Till now only one board, ASUS M2A-VM, can do 64bit dma with recent
> BIOSen.  Enabling 64bit DMA by default already broke three boards.
> Enabling 64bit DMA isn't worth these regressions.  Disable 64bit DMA
> by default and enable it only on boards which are known to work.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Gabriele Balducci <balducci@units.it>
> Reported-by: maierp@informatik.tu-muenchen.de
> Cc: Shane Huang <shane.huang@amd.com>
> Cc: stable@kernel.org
> ---
> > This doesn't apply to the 2.6.31-stable tree.
> > 
> > Tejun, could you respin this for the stable release, if you feel it
> > needs to be there?
> 
> Yeap, here's minimal backport.

Thanks, but it looks like Chuck provided a "more complete" patch for
this, so I've taken his version as you acked it.

greg k-h
