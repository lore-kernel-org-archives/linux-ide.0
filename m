From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Mon, 10 Dec 2007 17:59:39 -0600
Message-ID: <475DD2EB.8030606@shaw.ca>
References: <fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no>
 <fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no>
 <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no>
 <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no> <475C2C02.70001@shaw.ca>
 <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org>
 <20071209190913.GB13382@kernel.dk> <475C48EE.8020701@pianoinflames.de>
 <20071209200440.GC13382@kernel.dk> <475C536B.5070409@pianoinflames.de>
 <20071209210137.GD13382@kernel.dk> <475D7F03.7050100@pianoinflames.de>
 <alpine.LFD.0.9999.0712101009410.28293@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:62855 "EHLO
	pd3mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbXLKAA0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 19:00:26 -0500
Received: from pd3mr6so.prod.shaw.ca (pd3mr6so-qfe3.prod.shaw.ca [10.0.141.21])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JSU00CZ8YNIX970@l-daemon> for linux-ide@vger.kernel.org; Mon,
 10 Dec 2007 16:59:42 -0700 (MST)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
 by pd3mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JSU00KFYYNIKF40@pd3mr6so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 10 Dec 2007 16:59:43 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JSU00AANYNGU820@l-daemon> for linux-ide@vger.kernel.org; Mon,
 10 Dec 2007 16:59:41 -0700 (MST)
In-reply-to: <alpine.LFD.0.9999.0712101009410.28293@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marco Gatti <marco@pianoinflames.de>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>

Linus Torvalds wrote:
> 
> On Mon, 10 Dec 2007, Marco Gatti wrote:
>> I didn't compile completly.
>>
>> drivers/scsi/scsi_lib.c:1565:1: error: unterminated #else
> 
> Heh. That #else should be an #endif, of course.
> 
> It is a bit strange that it still tries to do IO to high memory. Either 
> the whole "64 bit capability" thing in AHCI is broken, or the bounce 
> buffering doesn't work right. Or maybe you tried the "iommu=off" without 
> the original patch that tried to turn off 64-bit DMA?
> 
> 		Linus
> 

 From what I can see, it appears that iommu=off disables the IOMMU but 
doesn't actually do anything to prevent attempts to DMA above 4GB. If 
you try to map something over 4GB it just chokes with that mask overflow 
(in arch/x86/kernel/pci-nommu_64.c).

The iommu=off option actually seems rather useless, as it's the default 
in the only case where it will actually work (no memory above 4GB)..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

