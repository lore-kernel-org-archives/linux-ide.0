From: Mark Lord <liml@rtr.ca>
Subject: Re: libata and PATA devices
Date: Tue, 09 Aug 2005 09:48:12 -0400
Message-ID: <42F8B41C.4040408@rtr.ca>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org> <1123495856.22328.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:36617 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964772AbVHINsL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 09:48:11 -0400
In-Reply-To: <1123495856.22328.62.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Erik Slagter wrote:
>
> Is there a possibility that dell attaches PATA harddisks using a
> SATA/PATA converter to the SATA connection of the ICH6M?

That chipset is used in virtually all modern laptops,
and includes a PATA interface as well as SATA.

Most current laptops ship with a PATA hard drive, and a PATA
ATAPI drive.  The easiest way to make them usable under Linux-2.6
is to patch libata and turn on ATAPI support, using ata_piix.

This REALLY ought to be on by default now, Jeff.
Especially since the default is to NOT work at all..

The libata code is taking forever to catch up to modern reality,
mostly because so much of it lives eternally in Jeff's private
git repository, where only a few people ever exercise the code.

The best way to get any remaining kinks out of it would be to
release it to a much wider audience.

As is, it's pretty good, except for the broken libata error handling
that (by default) locks up machines every hour or two.  But there's
also a fix for that, again floating around only in private repositories.

Let's get more of this code out where it can be used, guys!

Cheers
