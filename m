From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/5] sata_mv remove mv_phy_reset and mv_postreset
Date: Fri, 04 Apr 2008 04:02:00 -0400
Message-ID: <47F5E078.6040703@pobox.com>
References: <47F1736F.8020104@rtr.ca> <47F17592.8070002@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40285 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752707AbYDDICD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 04:02:03 -0400
In-Reply-To: <47F17592.8070002@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Remove the now unused mv_phy_reset() code,
> as well as the unnecessary mv_postreset() function.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

ACK patches 4-5

However, I would prefer to finish merging Tejun's honkin' huge 
modularize patchsets, and then request that you rediff&resend sata_mv 
patches 4 and 5

Having already ack'd it, I'll push Tejun's resync as soon as I receive it.

