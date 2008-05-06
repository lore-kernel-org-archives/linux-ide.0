From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/12] sata_mv more cosmetic changes
Date: Tue, 06 May 2008 10:17:21 -0400
Message-ID: <48206871.8060209@pobox.com>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39331 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127AbYEFORY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 10:17:24 -0400
In-Reply-To: <481AAFB7.4090708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> More cosmetic changes; no code changes.
> 
> -- try and improve consistency of naming.
> -- add missing _OFS to tails of register offset definitions.
> -- rename mv_setup_ifctl() to mv_setup_ifcfg(), since that's what it 
> really does.
> -- remove/move some dead comments
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied 1-13


