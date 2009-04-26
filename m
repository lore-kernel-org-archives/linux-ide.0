From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/3] mg_disk: use defines from <linux/ata.h>
Date: Sun, 26 Apr 2009 00:05:08 -0400
Message-ID: <49F3DD74.9030609@garzik.org>
References: <200904251510.03924.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50382 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbZDZEFM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Apr 2009 00:05:12 -0400
In-Reply-To: <200904251510.03924.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: unsik Kim <donari75@gmail.com>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Bartlomiej Zolnierkiewicz wrote:
> While at it:
> - remove MG_REG_HEAD_MUST_BE_ON define
> - remove MG_REG_CTRL_INTR_ENABLE define
> - remove MG_REG_HEAD_LBA_MODE define
> - remove unused defines
> 
> Cc: unsik Kim <donari75@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/block/mg_disk.c |  143 ++++++++++++++----------------------------------
>  1 file changed, 43 insertions(+), 100 deletions(-)

ACK

