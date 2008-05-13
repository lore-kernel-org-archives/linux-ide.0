From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Port-Multiplier hotplug support: ATA_FLAG_AN
Date: Tue, 13 May 2008 19:25:56 -0400
Message-ID: <482A2384.8000306@pobox.com>
References: <482A1B41.50507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49214 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756594AbYEMX0E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 May 2008 19:26:04 -0400
In-Reply-To: <482A1B41.50507@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun,
> 
> Apparently the newer (GenIIe) sata_mv chips *can* support asynchronous
> notification without problems.  Some/all of the older ones cannot (errata).
> 
> So, I've done the one-liner change in sata_mv, to add ATA_FLAG_AN to
> the 7042 and 6042 chips, and it all seems to work rather nicely.
> 
> Am I missing something?  Is there any other local code to sata_mv
> that should be provided before setting ATA_FLAG_AN ?
> 
> Like I said, it works, but I just want to check whether any other
> pieces are expected to be present?

Did you check ATAPI or just PMP AN?

	Jeff



