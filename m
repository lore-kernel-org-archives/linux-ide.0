From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/12] sata_mv more cosmetic changes
Date: Tue, 06 May 2008 10:10:35 -0400
Message-ID: <482066DB.7000609@pobox.com>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45405 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbYEFOKm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 10:10:42 -0400
In-Reply-To: <481AAFB7.4090708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> -- add missing _OFS to tails of register offset definitions.


bleh.  from the department of redundant redundancies :)  Those types of 
constants are usually either register bits or register offsets, and from 
  reading the code it is always clear which is which.  IMO, _OFS is 
redundant.

That's in the realm of maintainer discretion, though, so I applied the 
patch and merely request that you take my comment under advisement

