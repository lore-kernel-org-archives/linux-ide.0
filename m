From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 19:00:45 -0400
Message-ID: <4469081D.7080608@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515230256.GB4699@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45777 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750726AbWEOXAr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 19:00:47 -0400
In-Reply-To: <20060515230256.GB4699@animx.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Wakko Warner wrote:
> Jeff Garzik wrote:
>> After much development and review, I merged a massive pile of libata
>> patches from Tejun Heo and Albert Lee.  This update contains the
>> following major libata
>>
>> CHANGES:
>> * Rewritten error handling. This is a major piece of work, even
>>   though it will be rarely seen.  The new libata EH provides the
>>   foundation for not only improved error handling, but also new features
>>   such as device hotplug or command queueing. (Tejun Heo)
>>
>> * PIO-based I/O is now IRQ-driven by default, rather than polled
>>   in a kernel thread.  The polling path will continue to exist for
>>   controllers that need it, and other special cases. (Albert Lee)
>>
>> * Core support for command queueing (Jens Axboe, Tejun Heo)
>>
>> * Support for NCQ-style command queueing (Jens Axboe, Tejun Heo)
>>
>> * Increase max-sectors dramatically, for LBA48 devices (Tejun Heo?)
>>
>> * Other minor changes, from myself and others.
> 
> How about PATA?  Specifically intel's IDE chip.  I have a machine that I can
> blow the hard drive away if I want to.

Always helpful.  ata_piix should support Intel PATA controllers, modulo 
some bugs that Alan is fixing / has fixed.  If your PCI ID isn't listed, 
you will have to add it, and an associated info entry.  Again, take a 
look at Alan's libata PATA patches for guidance.

	Jeff



