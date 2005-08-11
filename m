From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 16:21:17 -0400
Message-ID: <42FBB33D.8050003@pobox.com>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:36264 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932423AbVHKUVU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 16:21:20 -0400
In-Reply-To: <1123789132.4422.30.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Erik Slagter wrote:
> On Thu, 2005-08-11 at 13:19 -0400, Jeff Garzik wrote:
> 
>>Mark Lord wrote:
>>
>>>Jeff Garzik wrote:
>>>
>>>>currently no one should be using libata for PATA support.
>>>
>>>We emailed back and forth extensively about how this has
>>>not been true since early this year.  Modern laptops are
>>>using libata for the ICH6M support, simply because libata
>>>claims that chipset, and the IDE driver does not.
>>>These laptops are using PATA drives (eg. "FUJITSU MHV2100AH").
>>
>>This sounds like a misconfigured kernel.  The IDE driver should pick up 
>>the PATA port, and libata should pick up the SATA port.  Anything else 
>>is a bug, and should be addressed by me or Bart.
> 
> 
> See my and Marks posts now and two times in the past.
> 
> My PATA harddisk connected to ICH6M is NOT claimed by IDE but by libata
> indeed.
> 
> If you think that is an error, that is okay with me, but it rather
> puzzles me that when I post the patch that actually accomplishes this, I
> only get a barking intel engineer and no other reply whatsoever.
> 
> BTW we're still talking plain vanilla kernel here.
> 
> So, please, make up your mind and at least don't simply deny or ignore
> the situation.

Your patch was wrong because the SATA device should always be claimed by 
libata.

The system is thus:

1) drivers/pci/quirks.c reserves SATA ports (only!) for libata
2) Legacy IDE driver claims the unreserved PATA port
3) libata loads and uses the ports reserved in #1

This requires a specific kernel configuration:
(a) CONFIG_IDE_GENERIC be set, and
(b) IDE driver is built into the kernel.

This also requires that your SATA device is listed in drivers/pci/quirks.c.

Both (a) and (b) are kernel configuration issues.  I never saw anything 
in any email thread indicating that (a) and (b) were verified and 
eliminated as problem sources.


>>>And Passthru is much bigger than a pair of #defines.
>>
>>That is a separate $thread.
> 
> 
> Also note that without passthrough libata is not half as useful as it
> could be (no smart monitoring, ouch..)

SMART monitoring is implemented externally.  Passthru simply lets 
anybody submit random ATA commands.  There is no additional capability 
to be implemented in libata, besides passthru.


> Indeed I saw the passthrough code pass, but I don't remember having seen
> any atapi patches.

That's because all ATAPI stuff that exists is in the upstream kernel.

	Jeff


