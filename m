From: Tyler <pml@dtbb.net>
Subject: Re: libata and PATA devices
Date: Sat, 13 Aug 2005 08:56:14 -0700
Message-ID: <42FE181E.10003@dtbb.net>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>	 <42FBB33D.8050003@pobox.com> <1123932640.4378.10.camel@localhost.localdomain> <42FE12D6.1070600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tor.primus.ca ([216.254.136.21]:38529 "EHLO
	smtp-03.primus.ca") by vger.kernel.org with ESMTP id S1751345AbVHMPyV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Aug 2005 11:54:21 -0400
In-Reply-To: <42FE12D6.1070600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Slagter <erik@slagter.name>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Jeff, I think he stated in an earlier post to the list, the model number 
of the drive, and it is in fact a PATA drive... verified by checking 
fujitsu's website.  Or are you just saying that it "shows up as sata" by 
coming up as /dev/sda since its connected to a PATA port on a sata 
combined controller?

Tyler.

Jeff Garzik wrote:

> Erik Slagter wrote:
>
>> result: the pata harddisk is recognised by libata_piix and
>> assigned /dev/sda, the dvd drive is found by the generic ide driver.
>> (dmesg output attached)
>
>
>
> Great!  That's precisely what's supposed to happen.  Except, the hard 
> drive appears to be SATA, not PATA:
>
>> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
>> ata1: dev 0 cfg 49:2b00 82:346b 83:5b29 84:4003 85:3469 86:1a09 
>> 87:4003 88:203f
>> ata1: dev 0 ATA, max UDMA/100, 156301488 sectors:
>> ata1: dev 0 configured for UDMA/100
>
>
> Everything appears to be working just fine.  DVD appears via IDE 
> driver, SATA drive appears via libata.
>
>     Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
