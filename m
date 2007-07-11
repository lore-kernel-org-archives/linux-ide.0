From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc7 1/3] libata: clean up horkage handling
Date: Tue, 10 Jul 2007 21:38:19 -0400
Message-ID: <4694348B.5020408@garzik.org>
References: <20070705043127.GX29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37650 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506AbXGKBiU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:38:20 -0400
In-Reply-To: <20070705043127.GX29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Horkage handling had the following problems.
> 
> * dev->horkage was positioned after ATA_DEVICE_CLEAR_OFFSET, so it was
>   cleared before the device is configured.  This broke
>   HORKAGE_DIAGNOSTIC.
> 
> * Some used dev->horkage while others called ata_device_blacklisted()
>   directly.  This was at best confusing.
> 
> This patch moves dev->horkage right after dev->flags and set the field
> according to the blacklist during device configuration.  All users
> test against dev->horkage.  ata_device_blacklisted() now has only one
> user, make it static.  While at it, rename it to ata_dev_blacklisted()
> for consistency.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   13 ++++++++-----
>  include/linux/libata.h    |    3 +--
>  2 files changed, 9 insertions(+), 7 deletions(-)

applied


