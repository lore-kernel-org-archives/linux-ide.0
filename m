From: Mark Lord <liml@rtr.ca>
Subject: Re: libata and PATA devices
Date: Tue, 09 Aug 2005 10:10:17 -0400
Message-ID: <42F8B949.6070004@rtr.ca>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org> <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:41737 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932544AbVHIOKQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 10:10:16 -0400
In-Reply-To: <42F8B41C.4040408@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Erik Slagter <erik@slagter.name>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
>
> Most current laptops ship with a PATA hard drive, and a PATA
> ATAPI drive.  The easiest way to make them usable under Linux-2.6
> is to patch libata and turn on ATAPI support, using ata_piix.
> 
> This REALLY ought to be on by default now, Jeff.
> Especially since the default is to NOT work at all..

Note:  I'm refering to the existing PATA ATAPI support in libata here,
not the forthcoming SATA ATAPI support!

The PATA ATAPI works now -- perhaps it could be turned on by default
while efforts continue to implement support for SATA ATAPI devices.

Cheers
