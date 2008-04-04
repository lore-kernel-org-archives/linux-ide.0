From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/5] sata_mv clean up mv_stop_edma usage
Date: Fri, 04 Apr 2008 03:59:52 -0400
Message-ID: <47F5DFF8.804@pobox.com>
References: <47F1736F.8020104@rtr.ca> <47F17510.7060902@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40275 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbYDDH75 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:59:57 -0400
In-Reply-To: <47F17510.7060902@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> Clean up uses of mv_stop_edma{_engine}() to match datasheet requirements.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied 2-3


