From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Wed, 16 Feb 2005 18:58:48 -0500
Message-ID: <4213DE38.70309@pobox.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <4213CD9E.9040703@pobox.com> <20050216174954.K10699@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22441 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262146AbVBPX7E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 18:59:04 -0500
In-Reply-To: <20050216174954.K10699@florence.linkmargin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: Brad Campbell <brad@wasp.net.au>, linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>Does the PIO code deviate from the ATA/ATAPI-[4567] host state machine 
>>somehow?
> 
> 
> That I can't say (the ata/atapi docs make me want to put my
> head under the wheel of a bus), but: on SMP machines the
> implementation would turn into busy-waiting for every sector;
> I have my suspicions about the ata_busy_wait() calls in
> ata_pio_block(); I also looked at implementing ATA_PROT_PIO_MULT
> with interrupt support, but then  ran out of time on the
> project - what's there doesn't (didn't) use interrupts.
> 
> 
>>Or is it just that newer SATA-emulating-PATA chips have trouble with it?
> 
> 
> Could be, I for sure saw arbitration/starvation issues that
> resulted in geological-grade delays getting status at the end
> of some PIO transfers. The result was timeout errors under
> heavy load. I believe that the SMP-machine-becomes-busy-wait-
> monster bug probably caused the majority of these errors (I
> could generate them after a few minutes testing), because I had
> 4 (fast-ish) cores conspiring to beat the crap out of 1 register
> on a PCI card.

Unfortunately, that's what you're _supposed_ to do, busy-wait for every 
"block" (where block == 1 sector for PIO, and <n> sectors for PIO-Mult).

Wasn't it you that had a patch that used ata_altstatus() to mitigate 
this somewhat?

It's entirely possible that I'm one of the first to punish SATA 
controllers with PIO polling data transfer, rather than interrupt-driven 
xfer.  The SMP aspect makes me suspicious that something else might be 
involved, as well.  Ever since the 2.6.10-bkN kernel updated ACPI, the 
one SMP machine I had that failed on libata started working.

Any chance you could debug this further?

	Jeff


