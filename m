From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 10 Jun 2009 11:11:41 -0400
Message-ID: <4A2FCD2D.3040205@garzik.org>
References: <20090520065942.GD11363@kernel.dk> <20090520070038.GE11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55411 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755976AbZFJPLl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 11:11:41 -0400
In-Reply-To: <20090520070038.GE11363@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

Jens Axboe wrote:
> libata currently has a pretty dumb ATA_MAX_QUEUE loop for finding
> a free tag to use. Instead of fixing that up, convert libata to
> using block layer tagging - gets rid of code in libata, and is also
> much faster.
> 
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> ---
>  drivers/ata/libata-core.c |   65 ++++----------------------------------------
>  drivers/ata/libata-scsi.c |   23 ++++++++++++++-
>  drivers/ata/libata.h      |   19 ++++++++++++-
>  include/linux/libata.h    |    1 -
>  4 files changed, 44 insertions(+), 64 deletions(-)

Patch looks good to me, with regards (a) simplex, (b) master/slave, (c) 
non-queued and (d) NCQ.  I'm not confident about the PMP case, but if 
Tejun is happy, I guess I can go ahead and queue these...

	Jeff




