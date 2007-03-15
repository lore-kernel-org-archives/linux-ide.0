From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Thu, 15 Mar 2007 16:16:00 -0400
Message-ID: <45F9A980.1090107@garzik.org>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com> <45F9851E.8000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52412 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933790AbXCOUQF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Mar 2007 16:16:05 -0400
In-Reply-To: <45F9851E.8000709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bob Stewart <bob@evoria.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> Bob Stewart wrote:
>> Is there an easy way to tell whether the command was sent as 
>> LBA48, say, in the driver's bmdma_start function or even in the 
>> hardreset function after the fact?  One of my tests was using a 64 
>> sector limit, with pretty much the same results.  I always test against 
>> the same file, and the results, including the number of timeouts, are 
>> different from test to test.
> 
> The driver is seriously broken regarding LBA48 support.  The timeout
> goes away if max_sectors is decreased to ATA_MAX_SECTORS - 1, doh.  But
> both the reading and writing are seriously broken.  I can't tell whether
> they end up in the wrong sectors or garbage is transferred to/from the
> right sectors.
> 
> I'm really close to marking this device broken or we'll need to
> implement a mechanism to veto LBA48 device from LLD (may be negative
> return from ->dev_config).

AFAICS you just need to use the ADMA-like DMA engine, to achieve LBA48.

It's just a guess that the HOB bit is supported by the Device Control 
shadow register on the INIC chips.  The only actual mention in the 
datasheets is in the ADMA CPB data structure definition.

BTW, all my infos came off their public website, let me know if anybody 
is missing these docs:
INIC1622.PDF
Initio INIC-1620TA2_1622TA2_1623TA2 Databook v1.4.pdf
Initio INIC-1623 Databook v1.3.pdf

Regards,

	Jeff



