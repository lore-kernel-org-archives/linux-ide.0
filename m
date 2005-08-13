From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Sat, 13 Aug 2005 12:42:46 -0400
Message-ID: <42FE2306.4090905@pobox.com>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>	 <42FBB33D.8050003@pobox.com>	 <1123932640.4378.10.camel@localhost.localdomain>	 <42FE12D6.1070600@pobox.com> <42FE181E.10003@dtbb.net>	 <42FE1869.2030800@pobox.com> <1123949123.11048.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:40112 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932194AbVHMQmv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Aug 2005 12:42:51 -0400
In-Reply-To: <1123949123.11048.19.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Tyler <pml@dtbb.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Erik Slagter wrote:
> On Sat, 2005-08-13 at 11:57 -0400, Jeff Garzik wrote:
> 
>>Tyler wrote:
>>
>>>Jeff, I think he stated in an earlier post to the list, the model number 
>>>of the drive, and it is in fact a PATA drive... verified by checking 
>>>fujitsu's website.  Or are you just saying that it "shows up as sata" by 
>>>coming up as /dev/sda since its connected to a PATA port on a sata 
>>>combined controller?
>>
>>The SATA controller thinks its SATA.
> 
> 
> That, I already noticed a long time ago. The question is, is libata
> correct in thinking this?

libata just reports what the controller reports.  If the controller says 
its SATA, that what I have to run with.

A lot of devices are bridged, so seeing a PATA device connected via SATA 
bus to a SATA controller is not uncommon.

	Jeff


