From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA SATA not recognizing drives
Date: Tue, 11 May 2004 02:54:27 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A078A3.50102@pobox.com>
References: <20040508193100.GA31122@buici.com> <409D5126.2060205@pobox.com> <20040509073914.GA4881@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263062AbUEKGyj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 May 2004 02:54:39 -0400
In-Reply-To: <20040509073914.GA4881@buici.com>
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: linux-ide@vger.kernel.org

Marc Singer wrote:
> On Sat, May 08, 2004 at 05:29:10PM -0400, Jeff Garzik wrote:
> 
>>Marc Singer wrote:
>>
>>> libata version 1.02 loaded.
>>> sata_via version 0.20
>>> sata_via(0000:00:0f.0): routed to hard irq line 10
>>> ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 10
>>> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10
>>> ata1: no device found (phy stat 00000000)
>>> ata1: thread exiting
>>> scsi0 : sata_via
>>> ata2: no device found (phy stat 00000000)
>>> ata2: thread exiting
>>> scsi1 : sata_via
>>
>>
>>Those "phy stat 00000000" are the hardware saying there is no SATA 
>>device attached.
>>
>>Are you sure you plugged them into the VIA SATA ports?  Maybe you have a 
>>Promise chip on-board too, or something like that?  Or SATA is disabled 
>>in BIOS?
> 
> 
> I'm embarassed to say, though not too proud to admit, that the power
> cables weren't properly seated.  It's working just fine.
> 
> I have another question, though.  I've patched the ide driver to
> permit an IDE interface to operate without an IRQ.  It needs a little
> bit of tweaking before it will be accepted by that IDE maintainer.
> Are you planning to subsume all of the IDE functionality into libata
> that is handled by the other IDE driver?  If so, have you considered
> adding polling mode?


PIO code in libata operates exclusively in polling mode.

I'm not too confident of polling DMA being a good idea.

	Jeff



