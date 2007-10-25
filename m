From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: backport ATA_FLAG_NO_SRST and	ATA_FLAG_ASSUME_ATA
Date: Thu, 25 Oct 2007 03:22:46 -0400
Message-ID: <47204446.7070609@garzik.org>
References: <20071025065157.GH11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42369 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754992AbXJYHWt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 03:22:49 -0400
In-Reply-To: <20071025065157.GH11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: stable@kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Backport ATA_FLAG_NO_SRST and ATA_FLAG_ASSUME_ATA.  These are
> originally link flags (ATA_LFLAG_*) but link abstraction doesn't exist
> on 2.6.23, so make it port flags.
> 
> This is for the following workaround for ASUS P5W DH Deluxe.
> 
> These new flags don't introduce any behavior change unless set and
> nobody sets them yet.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This and the next patch are a bit large for -stable but they don't
> change anything for machines other than P5W DH and P5W DH users have
> been suffering long enough, so I think it'll be nice to include these
> patches in the next -stable release.  However, feel free to NACK if
> you can see some danger in these patches.
> 
> Jeff, what do you think?
> 
>  drivers/ata/libata-eh.c |   32 ++++++++++++++++++++++++--------
>  include/linux/libata.h  |    2 ++
>  2 files changed, 26 insertions(+), 8 deletions(-)

ACK from me, though I wonder if we shouldn't wait and get feedback once 
this hits upstream (my next push to Andrew and Linus), before applying 
to stable.  No special reason, just being conservative...

	Jeff



