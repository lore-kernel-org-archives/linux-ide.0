From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/n] libata-core.c conversion to new debugging scheme, part 1 (25% done)
Date: Wed, 31 May 2006 02:39:57 -0400
Message-ID: <20060531063957.GD14179@havoc.gtf.org>
References: <20060531054633.GA4875@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:50054 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964826AbWEaGj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 May 2006 02:39:59 -0400
Content-Disposition: inline
In-Reply-To: <20060531054633.GA4875@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org

On Wed, May 31, 2006 at 07:46:33AM +0200, Borislav Petkov wrote:
> This patch converts the first 25% of libata-core.c to the new debugging scheme.
> 
> Signed-off-by: <petkov@uni-muenster.de>

Looks good at first glance, though I'll hold off on apply until I return
from the Red Hat Summit in Nashville.

It made me remember another point, though:  in order to avoid
regressions, after applying your patch, I would think that you would
want to create a patch which did something like

#ifndef ATA_VERBOSE_DEBUG
	ap->msg_enable = xxx
#else ATA_DEBUG
	ap->msg_enable = yyy
#else
	ap->msg_enable = ...
#endif

Thus, we are assured that applying your patch will not change the
behavior(much?) when ATA_VERBOSE_DEBUG is enabled.

Regards,

	Jeff



