From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-passthrough problem.
Date: Sat, 12 Nov 2005 14:53:55 -0500
Message-ID: <43764853.5050306@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:50345 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932484AbVKLTyA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 14:54:00 -0500
In-Reply-To: <43762CEF.2070704@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>
> Just download 2.6.15-rc1.
>

Okay, got it.

Jeff:  I cannot find anywhere in libata code,
where the ATA unit number gets ORed into tf->device.

If this is not done, then no PATA slave devices will
be addressed correctly, even for regular I/O.

Where is setting that bit done?
I'm sure it must be in there, I just don't see it.

Cheers
