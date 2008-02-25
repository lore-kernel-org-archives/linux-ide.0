From: Mark Lord <liml@rtr.ca>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Sun, 24 Feb 2008 23:49:12 -0500
Message-ID: <47C248C8.9090409@rtr.ca>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BFAC06.5030805@rtr.ca> <47C116D4.1090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3005 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948AbYBYEqT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 23:46:19 -0500
In-Reply-To: <47C116D4.1090600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
> Hello, Mark.
> 
> Mark Lord wrote:
>> Mark Lord wrote:
>>> An alternative to all this, might be to expose the "select_pmp()"
>>> function shown in the sample code, and have libata-pmp.c call that,
>>> instead of having the new new .pmp_{read,write} functions. 
>> ..
>>
>> I wonder if this might be more viable than first thought.
>>
>> Say the LLD, be it ata_piix or sata_mv or sata_vw, were to provide
>> an option ata_operations method for "select_pmp_port(pmp)",
>> which the core could invoke prior to any direct manipulation
>> of the shadow registers.
> 
> I don't really think that's a good solution.  That's the quickest
> solution for sata_mv but it just works around more fundamental problem
> of assuming SFF behavior in core layer which we need to drop anyway.
...

No, the quickest solution for sata_mv, the one I apparently will now be using,
is to just clone about 250 lines of reset/debouce/probe code from libata-core
and change perhaps five lines of it to work around this issue plus some
chipset errata.

What I was thinking of, before, is the SATA specification which details
use of bits in the SCR to select a PMP port.  Pretty much exactly as
this chipset does it, except in the SCR rather than a proprieary port.

But no big deal.  I can clone code and not bother you any more.
In fact, some of the cloned code was already in sata_mv, and I removed
it this past week in my local working copy.  I'll just restore that,
along with another big blob so that we can select pm port where needed.

What a shame.

