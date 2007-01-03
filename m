From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata use ATA_12 in HDIO_* ioctls for ATAPI compatibility
Date: Tue, 02 Jan 2007 19:23:44 -0500
Message-ID: <459AF790.1030401@rtr.ca>
References: <200701021724.39613.liml@rtr.ca> <200701021730.07356.liml@rtr.ca> <200701021732.35120.liml@rtr.ca> <200701021736.51465.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1325 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbXACAXm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 19:23:42 -0500
In-Reply-To: <200701021736.51465.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Existing ATAPI devices do not support 16-byte commands,
> so issuing ATA_16 against them gets rejected by the upper layers.
> 
> This patch updates the libata implementations of HDIO_DRIVE_CMD
> and HDIO_DRIVE_TASK to use ATA_12 (rather than ATA_16) so that
> they can now also be used for ATAPI devices.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>
> ---
> --- linux/drivers/ata/libata-scsi.c.1	2007-01-02 15:31:56.000000000 -0500
> +++ linux/drivers/ata/libata-scsi.c	2007-01-02 15:43:20.000000000 -0500
..

NUKE that one.   Due to the conflict between ATA_12 and "BLANK",
we have to leave it all as ATA_16.

I'll post a new ATAPI/ATA_16 patch shortly.

Mark
