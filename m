From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 4/4] libata sata_qstor conversion to new error handling
 (EH).
Date: Wed, 07 Nov 2007 18:32:29 -0500
Message-ID: <47324B0D.9060706@rtr.ca>
References: <4731DF06.3050202@rtr.ca> <4731DFA7.8010202@rtr.ca> <20071107232721.GB26706@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1947 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757283AbXKGXca (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 18:32:30 -0500
In-Reply-To: <20071107232721.GB26706@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> On Wed, Nov 07, 2007 at 10:54:15AM -0500, Mark Lord wrote:
>> sata_qstor conversion to new error handling (EH).
>>
>> Convert sata_qstor to use the newer libata EH mechanisms.
>> Based on earlier work by Jeff Garzik.
>>
>> This belongs in 2.6.24.
>>
>> Signed-off-by:  Mark Lord <mlord@pobox.com>
> 
> Did you test this with both device probe ("it works") and at least
> one device error?

Yes, all four patches tested and working here.
I think there's two of us on the planet using that board with Linux. :)

The EH still isn't perfect -- never recovers from stuck-DRQ,
and SG_IO WRITEs don't work.  That's really no different from
the existing 2.6.24 version.  Regular I/O looks fine.

And this way it stops spamming the syslogs with the new WARN_ON()
calls in libata every time it noticed we didn't have the new EH hooks.

