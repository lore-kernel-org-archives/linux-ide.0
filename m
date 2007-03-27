From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Tue, 27 Mar 2007 00:57:17 -0400
Message-ID: <4608A42D.6080403@garzik.org>
References: <20070324064814.38720.qmail@web802.biz.mail.mud.yahoo.com> <4604D564.9010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60801 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964826AbXC0E5V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Mar 2007 00:57:21 -0400
In-Reply-To: <4604D564.9010806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bob Stewart <bob@evoria.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Bob Stewart wrote:
>> I wonder if this card of mine is what's bad.  I loaded Sarge 2.4 and the
>> Sunix driver and a new disk onto my test whore.  I got essentially the 
>> same sort of errors as with your driver (see below) but in this case,
>> abolutely nothing was ever reliable, including the partition table.  I'm
>> not sure I want to buy another card to test this out, though.  Maybe 
>> I'll put the card in my other machine just to verify it's not a mobo 
>> issue, though.   crapcrapcrap!
>>
>> Sample errors:
>>
>> drive not ready for command
>> status timeout: status = 0x80 { busy }
>>
>> error = 0x00 { }
>> dma_intr: status = 0x51 {drive ready SeekComplete error}
> 
> My bet is on broken driver.  sunix driver doesn't seem like it was 
> written carefully.  Anyways, thanks for testing.  It seems we'll either 
> have to implement adma mode.  I'll mark the driver broken for 2.6.21. 


Broken, or LBA28-only?

I would think that we have other controllers that need an LBA28-only 
flag.  (note: don't be fooled by ATA_FLAG_PIO_LBA48, that doesn't quite 
do what we want)

Alan, Mark, surely some ancient controller simply can't do LBA48 at all, 
even in PIO mode?

	Jeff


