From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] libata: switch to using block layer tagging support
Date: Wed, 22 Oct 2008 20:46:38 -0400
Message-ID: <48FFC96E.5060604@garzik.org>
References: <1224661243-7929-1-git-send-email-jens.axboe@oracle.com> <1224661243-7929-3-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38488 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbYJWAqm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 20:46:42 -0400
In-Reply-To: <1224661243-7929-3-git-send-email-jens.axboe@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org

Jens Axboe wrote:
> libata currently has a pretty dumb ATA_MAX_QUEUE loop for finding
> a free tag to use. Instead of fixing that up, convert libata to
> using block layer tagging - gets rid of code in libata, and is also
> much faster.
> 
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> ---
>  drivers/ata/libata-core.c |   66 ++++----------------------------------------
>  drivers/ata/libata-scsi.c |   10 +++++-
>  drivers/ata/libata.h      |   19 +++++++++++-
>  include/linux/libata.h    |    1 -
>  4 files changed, 31 insertions(+), 65 deletions(-)

Just to be sure, I take it this patch series is for 2.6.29?

Seems nice to have, but since it wasn't ready for the merge window 
opening...

	Jeff



