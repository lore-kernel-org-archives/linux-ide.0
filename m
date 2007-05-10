From: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] libata: add human-readable error value decoding
Date: Thu, 10 May 2007 09:24:41 -0400
Message-ID: <46431D19.1070308@rtr.ca>
References: <46428103.3040003@shaw.ca> <4642E92D.5010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3024 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755742AbXEJNYn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 May 2007 09:24:43 -0400
In-Reply-To: <4642E92D.5010509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> Robert Hancock wrote:
>> This adds human-readable decoding of the ATA status and error registers
>> (similar
>> to what drivers/ide does) as well as the SATA Serror register to libata
...
> I'm not really convinced whether this is necessary.  The human readable
> form is also a bit cryptic and can get quite long.  So, mild NACK from me.

Same here, but I would like to see it in there under a CONFIG_DEBUG_LIBATA
kernel build option or something.  Kind of like the "FANCY_STATUS_DUMPS" flag
that drivers/ide used to have for this kind of stuff.

Cheers

