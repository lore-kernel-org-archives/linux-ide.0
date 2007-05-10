From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add human-readable error value decoding
Date: Thu, 10 May 2007 12:40:05 -0400
Message-ID: <46434AE5.8060605@garzik.org>
References: <46428103.3040003@shaw.ca> <4642E92D.5010509@gmail.com> <46431D19.1070308@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57594 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233AbXEJQkK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 May 2007 12:40:10 -0400
In-Reply-To: <46431D19.1070308@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Mark Lord wrote:
> Same here, but I would like to see it in there under a CONFIG_DEBUG_LIBATA
> kernel build option or something.  Kind of like the "FANCY_STATUS_DUMPS" 
> flag
> that drivers/ide used to have for this kind of stuff.


The long term goal is to enable verbose output with a module option 
and/or sysfs knob, rather than a compile-time switch.

That's what ata_msg_xxx is for.  We just don't have the knob yet. 
Patches welcome...

	Jeff



