From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Thu, 06 Mar 2008 13:12:05 -0500
Message-ID: <47D033F5.9090303@garzik.org>
References: <47D01232.1000106@rtr.ca> <47D01D4B.8000506@pobox.com> <47D02642.8040907@rtr.ca> <47D028C5.9070509@rtr.ca> <47D02CC0.6080609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48904 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935469AbYCFSMa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 13:12:30 -0500
In-Reply-To: <47D02CC0.6080609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> You need to perform your own LLD-specific locking analysis to see if it 
> is safe to do, e.g. __mv_stop_dma() rather than mv_stop_dma().

And speaking as the probable author of some of the code that takes a 
lock during EH in sata_mv....   reinforcing that the above quoted 
statement is true.

Generally I would put in a lock during EH around register or data 
manipulations that were locked elsewhere in the driver, thus 
guaranteeing such code is safe.

However, it may also be the case that such a lock during EH is 
unnecessary because command submission machinery is disabled.  I chose a 
path that potentially added more locking, but was much easier to verify 
correct.

	Jeff



