From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Thu, 17 Feb 2005 14:13:45 -0500
Message-ID: <4214ECE9.7070502@pobox.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <4213CD9E.9040703@pobox.com> <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com> <20050216182040.L10699@florence.linkmargin.com> <421426DB.2000308@pobox.com> <20050217085934.M10699@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47791 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262356AbVBQTOB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 14:14:01 -0500
In-Reply-To: <20050217085934.M10699@florence.linkmargin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>I'm starting to wonder if polling isn't just a dismal failure on SATA, 
>>since the status register/etc. is all emulated.  Thinking further along 
>>those lines (how an ATA shadow register set is faked by the host 
>>controller using FIS data), I wonder if polling -- per ATA spec -- 
>>exposes a race between FIS reception and processing, and the update of 
>>the ATA shadow register block.
> 
> 
> Quite possibly - though the register set has been fake one way or
> another most of the time. This time it's a different fake, with two
> vendors getting to put the bits back together in a different order

heh


> instead of one vendor's firmware team. The second generation
> controllers mostly seem to support/require using DMA to accomplish
> the operations named "PIO *" in the ATA/ATAPI spec. This will be
> a good thing(tm). I'm still trying to wrap my brain around what
> (if any) changes this will impose on libata - my hunch is that
> we will require a set of pio_xxx methods in ata_port_operations
> with suitable defaults that fall back to the tf_load/tf_read
> methods currently specified.

You are behind the times ;-)

Both you and a hardware vendor I just spoke with both seem to have 
missed that ahci.c already does a couple key things:

* all operations, including PIO data xfer and SRST, must be accomplished 
via DMA.  (ata_adma in libata-dev is similar)

* zero access to the taskfile registers.  100% FIS-based.

The SiI 311x supports "virtual DMA", which is PIO via DMA, but it's not 
useful as implemented:  311x requires a separate DMA transaction for 
_each_ DRQ block, AFAICS.

AHCI is the first scenario where PIO-via-DMA could be utilized in an 
efficient manner.  The upcoming SiI 3124 is another.  A few others 
(ADMA, Marvell) are PIO-via-DMA controllers as well.  I agree this is a 
good thing.


> Obviously, there will still be millions of first generation
> SATA controllers roaming the earth, and for stuff like SMART
> we need to make it play nicely with the other children. Damn.

hehe :)

Anyway, getting back to the thread of "problems with PIO polling", I am 
wondering if -- due to SATA's nature -- PIO polling should be avoided, 
and interrupt-driven methodology used instead.

One reason why PIO polling was chosen (for controllers that support it; 
AHCI does not) is that the entire command submission/processing code can 
be written inline:  just submit-command, wait-for-busy-clear, etc. 
Makes the code less complex.

	Jeff


