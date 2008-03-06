From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Thu, 06 Mar 2008 11:35:23 -0500
Message-ID: <47D01D4B.8000506@pobox.com>
References: <47D01232.1000106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52849 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbYCFQfa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 11:35:30 -0500
In-Reply-To: <47D01232.1000106@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff / Tejun / Alan,
> 
> I'm trying to sort out the spinlocks in sata_mv.
> 
> In some places, the existing code uses ap->lock.
> But in others, notably the interrupt handling, it uses ap->host->lock.
> 
> This looks buggy to me, and I'm wondering how to make it bulletproof.

Look closely, there is only one lock.  ata_port does not have a 
spinlock, just a pointer...

	Jeff


