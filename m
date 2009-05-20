From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/2] libata: switch to block layer tagging
Date: Wed, 20 May 2009 03:53:23 -0400
Message-ID: <4A13B6F3.2000001@garzik.org>
References: <20090520065942.GD11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52496 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbZETHxY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 03:53:24 -0400
In-Reply-To: <20090520065942.GD11363@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

Jens Axboe wrote:
> Hi,
> 
> This patchset switches libata to block layer tagging. It gets rid of yet
> another O(N) command loop.
> 
>  block/blk-tag.c           |   99 +++++++++++++++++++++++++++-----------
>  drivers/ata/libata-core.c |   94 ++++++++++--------------------------
>  drivers/ata/libata-scsi.c |   23 ++++++++
>  drivers/ata/libata.h      |   19 ++++++-
>  include/linux/blkdev.h    |    3 +
>  include/linux/libata.h    |    1 
>  6 files changed, 139 insertions(+), 100 deletions(-)

Will take a look post-sleep...  mainly it's a question of possibly 
interfering with SCSI's use of block layer tagging.  Though for the 
moment I will simply assume you verified that ;)

	Jeff


