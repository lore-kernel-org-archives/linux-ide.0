From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Thu, 17 Feb 2005 00:08:43 -0500
Message-ID: <421426DB.2000308@pobox.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <4213CD9E.9040703@pobox.com> <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com> <20050216182040.L10699@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63437 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262216AbVBQFJC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 00:09:02 -0500
In-Reply-To: <20050216182040.L10699@florence.linkmargin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>Unfortunately, that's what you're _supposed_ to do, busy-wait for every 
>>"block" (where block == 1 sector for PIO, and <n> sectors for PIO-Mult).
> 
> 
> The logic surrounding PIO-multi in PATA-land looked markedly different.

Not surprising, as the path when interrupts are enabled looks different.

I'm starting to wonder if polling isn't just a dismal failure on SATA, 
since the status register/etc. is all emulated.  Thinking further along 
those lines (how an ATA shadow register set is faked by the host 
controller using FIS data), I wonder if polling -- per ATA spec -- 
exposes a race between FIS reception and processing, and the update of 
the ATA shadow register block.


>>Wasn't it you that had a patch that used ata_altstatus() to mitigate 
>>this somewhat?
> 
> 
> Yeah - and to not call queue_work() to accomplish the polling
> (which could start the next poll immediately on an SMP machine),
> I suppose that _could_ just as easily point to a locking problem,
> as a state machine logic flaw. My proof-of-concept kludge was to
> call queue_delayed_work() instead.
> 
> 
>>It's entirely possible that I'm one of the first to punish SATA 
>>controllers with PIO polling data transfer, rather than interrupt-driven 
>>xfer.  The SMP aspect makes me suspicious that something else might be 
>>involved, as well.  Ever since the 2.6.10-bkN kernel updated ACPI, the 
>>one SMP machine I had that failed on libata started working.
> 
> 
> I saw errors on both SiI (3114) and Promise (20319) cards, so
> I'm not convinced that (these) problems are at the chip-level
> (not that there aren't plenty of those to go around.)
> 
> 
>>Any chance you could debug this further?
> 
> 
> I'll see what I can do.

Thanks,

	Jeff


