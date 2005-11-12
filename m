From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata-passthrough problem.
Date: Sat, 12 Nov 2005 18:19:11 -0500
Message-ID: <4376786F.2090503@pobox.com>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8594 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964855AbVKLXTX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 18:19:23 -0500
In-Reply-To: <43764853.5050306@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>>
>> Just download 2.6.15-rc1.
>>
> 
> Okay, got it.
> 
> Jeff:  I cannot find anywhere in libata code,
> where the ATA unit number gets ORed into tf->device.
> 
> If this is not done, then no PATA slave devices will
> be addressed correctly, even for regular I/O.
> 
> Where is setting that bit done?
> I'm sure it must be in there, I just don't see it.

ata_tf_init() in include/linux/libata.h.

I admit with guilt that I had to search around a bit for it, too :)

	Jeff


