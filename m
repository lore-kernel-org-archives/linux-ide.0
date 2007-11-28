From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv fixes:  coding style preference?
Date: Wed, 28 Nov 2007 09:19:20 -0500
Message-ID: <474D78E8.8040806@rtr.ca>
References: <474CC20D.6010800@rtr.ca> <474D3D8E.7030207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3595 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972AbXK1OTV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2007 09:19:21 -0500
In-Reply-To: <474D3D8E.7030207@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

(adding linux-ide to CC:)

Jeff Garzik wrote:
> Mark Lord wrote:
>
>> Below, I used inline functions to calculate the correct reg offsets
>> so that the rest of the code doesn't need any special if-stmts.
>> But another way to do it would be to just store the correct offsets
>> as new fields within the mv_host_priv struct.  I suspect that method
>> would be better.
> 
> Yes, store the offsets, you shouldn't need to call a function to 
> calculate the same value over and over again.  Simple, no branches added 
> to the code, ...
..

Good, so we all agree on that!

And as it turns out, this patch (or the better version coming later)
fixes both of the Marvell 7042 problems reported here a couple of weeks ago:

1:  Tom Morrison "hang with large file operations".
2.  Hein-Pieter van Braam "PCI ERROR; PCI IRQ reason=0x00000000 highpoint rocketraid 2300 pci-e"

Tom has confirmed the fix, and I'm waiting to hear back from Hein-Pieter
even though I now have identical hardware here as what he has.

Jeff:  This fix (one I reissue it) should go upstream for 2.6.24, if possible.

Right now the driver is guaranteed to fail on 7042, since it is hitting
reserved PCI addresses instead of valid registers.

Not a regression though, so your call.
But it does fix reported bugs, and really cannot hurt anything.

Cheers
