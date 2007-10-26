From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 1/2] libata: backport ATA_FLAG_NO_SRST and
	ATA_FLAG_ASSUME_ATA
Date: Thu, 25 Oct 2007 21:36:28 -0700
Message-ID: <20071026043628.GB22548@kroah.com>
References: <20071025065157.GH11853@htj.dyndns.org> <47204446.7070609@garzik.org> <47204761.3030500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:46642 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXJZErA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 00:47:00 -0400
Content-Disposition: inline
In-Reply-To: <47204761.3030500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

On Thu, Oct 25, 2007 at 04:36:01PM +0900, Tejun Heo wrote:
> Jeff Garzik wrote:
> > Tejun Heo wrote:
> >> Backport ATA_FLAG_NO_SRST and ATA_FLAG_ASSUME_ATA.  These are
> >> originally link flags (ATA_LFLAG_*) but link abstraction doesn't exist
> >> on 2.6.23, so make it port flags.
> >>
> >> This is for the following workaround for ASUS P5W DH Deluxe.
> >>
> >> These new flags don't introduce any behavior change unless set and
> >> nobody sets them yet.
> >>
> >> Signed-off-by: Tejun Heo <htejun@gmail.com>
> >> ---
> >> This and the next patch are a bit large for -stable but they don't
> >> change anything for machines other than P5W DH and P5W DH users have
> >> been suffering long enough, so I think it'll be nice to include these
> >> patches in the next -stable release.  However, feel free to NACK if
> >> you can see some danger in these patches.
> >>
> >> Jeff, what do you think?
> >>
> >>  drivers/ata/libata-eh.c |   32 ++++++++++++++++++++++++--------
> >>  include/linux/libata.h  |    2 ++
> >>  2 files changed, 26 insertions(+), 8 deletions(-)
> > 
> > ACK from me, though I wonder if we shouldn't wait and get feedback once 
> > this hits upstream (my next push to Andrew and Linus), before applying 
> > to stable.  No special reason, just being conservative...
> 
> Agreed.  Let's give the upstream changes a few weeks before updating 
> -stable.  I'll ping this thread after a few weeks.

Ok, thanks, I'll hold off until you respond.

greg k-h
