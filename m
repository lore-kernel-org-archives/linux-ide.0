From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Wed, 10 Aug 2005 23:57:28 -0400
Message-ID: <42FACCA8.6050408@pobox.com>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org> <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:17059 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932233AbVHKD5c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2005 23:57:32 -0400
In-Reply-To: <42F8B41C.4040408@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Erik Slagter wrote:
> 
>>
>> Is there a possibility that dell attaches PATA harddisks using a
>> SATA/PATA converter to the SATA connection of the ICH6M?
> 
> 
> That chipset is used in virtually all modern laptops,
> and includes a PATA interface as well as SATA.
> 
> Most current laptops ship with a PATA hard drive, and a PATA
> ATAPI drive.  The easiest way to make them usable under Linux-2.6
> is to patch libata and turn on ATAPI support, using ata_piix.

No, the best thing to do is use the IDE driver for PATA.  That is the 
most stable, most well-tested path to ATAPI support at present.


> This REALLY ought to be on by default now, Jeff.
> Especially since the default is to NOT work at all..

Correct, because currently no one should be using libata for PATA support.

Turning on ATAPI and PATA support by default will break existing setups.


> The libata code is taking forever to catch up to modern reality,
> mostly because so much of it lives eternally in Jeff's private
> git repository, where only a few people ever exercise the code.

Exaggeration.  We're talking about a single #define here, to enable ATAPI.

	Jeff


