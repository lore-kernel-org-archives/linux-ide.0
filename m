From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Sat, 13 Aug 2005 11:56:24 -0400
Message-ID: <42FE1828.4000104@pobox.com>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>	 <42FBB33D.8050003@pobox.com>	 <1123932640.4378.10.camel@localhost.localdomain>	 <42FE12D6.1070600@pobox.com> <1123948250.11048.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28592 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751339AbVHMP4b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Aug 2005 11:56:31 -0400
In-Reply-To: <1123948250.11048.9.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Erik Slagter wrote:
> On Sat, 2005-08-13 at 11:33 -0400, Jeff Garzik wrote:
> 
>>Erik Slagter wrote:
>>
>>>result: the pata harddisk is recognised by libata_piix and
>>>assigned /dev/sda, the dvd drive is found by the generic ide driver.
>>>(dmesg output attached)
> 
> 
>>Great!  That's precisely what's supposed to happen.  Except, the hard 
>>drive appears to be SATA, not PATA:
>>
>>
>>>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
>>>ata1: dev 0 cfg 49:2b00 82:346b 83:5b29 84:4003 85:3469 86:1a09 87:4003 88:203f
>>>ata1: dev 0 ATA, max UDMA/100, 156301488 sectors:
>>>ata1: dev 0 configured for UDMA/100
>>
>>Everything appears to be working just fine.  DVD appears via IDE driver, 
>>SATA drive appears via libata.
> 
> 
> Nope. The harddisk is not SATA, it's PATA. See the links I posted
> earlier. That's the whole point.

The controller thinks its a SATA device, so there is probably a bridge 
installed.

	Jeff

