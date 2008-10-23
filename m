From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 2/2] libata: switch to using block layer tagging support
Date: Thu, 23 Oct 2008 08:33:49 +0200
Message-ID: <20081023063349.GR22217@kernel.dk>
References: <1224661243-7929-1-git-send-email-jens.axboe@oracle.com> <1224661243-7929-3-git-send-email-jens.axboe@oracle.com> <48FFC96E.5060604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:35762 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbYJWGer (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 02:34:47 -0400
Content-Disposition: inline
In-Reply-To: <48FFC96E.5060604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org

On Wed, Oct 22 2008, Jeff Garzik wrote:
> Jens Axboe wrote:
> >libata currently has a pretty dumb ATA_MAX_QUEUE loop for finding
> >a free tag to use. Instead of fixing that up, convert libata to
> >using block layer tagging - gets rid of code in libata, and is also
> >much faster.
> >
> >Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> >---
> > drivers/ata/libata-core.c |   66 
> > ++++----------------------------------------
> > drivers/ata/libata-scsi.c |   10 +++++-
> > drivers/ata/libata.h      |   19 +++++++++++-
> > include/linux/libata.h    |    1 -
> > 4 files changed, 31 insertions(+), 65 deletions(-)
> 
> Just to be sure, I take it this patch series is for 2.6.29?

Sure yes, it was written and tested just the other day :-)

> Seems nice to have, but since it wasn't ready for the merge window 
> opening...

Indeed, but it can certainly wait for 2.6.29.

-- 
Jens Axboe

