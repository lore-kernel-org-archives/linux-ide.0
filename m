From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/10] sata_mv: ensure empty request queue for FBS-NCQ
 EH
Date: Mon, 19 May 2008 17:41:41 -0400
Message-ID: <4831F415.4080604@pobox.com>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca> <482F1732.6010109@rtr.ca> <482F1759.20905@rtr.ca> <482F179E.8020602@rtr.ca> <482F17C3.8020106@rtr.ca> <482F17F8.3010403@rtr.ca> <48317A24.4080003@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38558 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756742AbYESVl5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 17:41:57 -0400
In-Reply-To: <48317A24.4080003@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Check for an empty request queue before stopping EDMA after a FBS-NCQ 
> error,
> as per recommendation from the Marvell datasheet.
> 
> This ensures that the EDMA won't suddenly become active again
> just after our subsequent check of the empty/idle bits.
> 
> Also bump DRV_VERSION.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> 
> Is DRV_VERSION even useful now?
> I could do another patch to just nuke it.

It is standard practice to export all driver versions via dmesg and 
modinfo for all libata drivers, so I would prefer that it stay, for 
consistency.

Is it useful?

That depends on the maintainer's definition and upkeep of the version 
number.  If you never update it, of course its useless.  If you update 
it when the driver achieves certain milestones, i.e. "2.0" when all your 
changes are complete, then it may be relevant to you and your userbase.

Version numbers tend to be quite handy because drivers get backported 
all over the place, so you might not be able to assume that sata_mv 
version 1.21 implies kernel version 2.6.26, for example.

	Jeff



