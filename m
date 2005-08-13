From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Sat, 13 Aug 2005 12:44:48 -0400
Message-ID: <42FE2380.5040508@pobox.com>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>	 <42FBB33D.8050003@pobox.com>	 <1123932640.4378.10.camel@localhost.localdomain>	 <42FE12D6.1070600@pobox.com>	 <1123948250.11048.9.camel@localhost.localdomain>	 <42FE1828.4000104@pobox.com> <1123949005.11048.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:41904 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932195AbVHMQow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Aug 2005 12:44:52 -0400
In-Reply-To: <1123949005.11048.16.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Erik Slagter wrote:
> On Sat, 2005-08-13 at 11:56 -0400, Jeff Garzik wrote:
> 
>>>Nope. The harddisk is not SATA, it's PATA. See the links I posted
>>>earlier. That's the whole point.
>>
>>The controller thinks its a SATA device, so there is probably a bridge 
>>installed.
> 
> 
> I suppose it's something like that.
> 
> It's all very confusing.
> 
> E.g. that would mean I must treat my PATA harddisk as if it's a SATA
> harddisk, but on the other hand, it's not really a SATA disk, so I
> cannot use SATA features.
> 
> Maybe an idea to spend a few words on the matter, including the way
> you're supposed to configure the kernel for this setup.

Sounds like you've hit on the configuration, in the previous email. 
Yes, it does mean no DMA for the DVD drive.


> BTW afaik you won't be able be able to control DMA on the dvd drive with
> this setup, so I'll stick to my patched kernel for the moment (= both
> disk&cdrom are assigned to ide).

That's normal for combined mode.  Until libata can do ATAPI (soon!), the 
lack of DMA is a necessary evil, since two drivers are trying to claim 
two halves of the same hardware.

	Jeff


