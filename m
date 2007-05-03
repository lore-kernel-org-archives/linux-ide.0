From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Fwd: Re: PATCH: libata: add support for ATA_16 on ATAPI]
Date: Thu, 03 May 2007 08:18:44 -0400
Message-ID: <4639D324.5090908@pobox.com>
References: <46394ADA.1020400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39226 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031188AbXECMSs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 May 2007 08:18:48 -0400
In-Reply-To: <46394ADA.1020400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Mark Lord wrote:
> Jeff?
> This has been pending for a very long time now.
> 
> This patch brings libata up to similar standards as Linux IDE
> with support for things like hdparm -I (identify) and -C (check power)
> among others on ATAPI drives.
> 
> Andrew, can you pick this up for -mm ??
> 
> ???

My reluctance stems mainly from the modifications to the hot path.  ATA 
and ATAPI need wholly different command simulations, so I don't like 
your modification of sending both ATA and ATAPI devices to the same 
simulation function -- only to have to disambiguate with an ATA-or-ATAPI 
test.

I would rather keep the branch in the queuecommand hook the same.  That 
should keep the ATA device callpath unchanged, while enabling what you 
want on the ATAPI callpath.

	Jeff





