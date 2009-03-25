From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/03] sata_mv  cosmetic preparations for IRQ coalescing
Date: Tue, 24 Mar 2009 22:36:49 -0400
Message-ID: <49C998C1.7040100@pobox.com>
References: <49B6EE95.1010808@rtr.ca> <49B6EED8.8060205@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45855 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbZCYCgy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 22:36:54 -0400
In-Reply-To: <49B6EED8.8060205@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Various cosmetic changes in preparation for the IRQ coalescing feature.
> 
> Note that the various MV_IRQ_COAL_* definitions are restored/renamed
> in the folloup patch which adds IRQ coalescing to the driver.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied 2-5

patch #1 was already applied -- in general, I will merge #upstream-fixes 
patches into #upstream immediately.  Don't worry about sending me 
duplicates for each branch, unless the branches are wildly divergent.


