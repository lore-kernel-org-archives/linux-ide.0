From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Thu, 17 Feb 2005 17:36:53 -0500
Message-ID: <42151C85.4000304@pobox.com>
References: <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <4213CD9E.9040703@pobox.com> <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com> <20050216182040.L10699@florence.linkmargin.com> <421426DB.2000308@pobox.com> <20050217085934.M10699@florence.linkmargin.com> <4214ECE9.7070502@pobox.com> <20050217132500.N10699@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56532 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261208AbVBQWhK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 17:37:10 -0500
In-Reply-To: <20050217132500.N10699@florence.linkmargin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>AHCI is the first scenario where PIO-via-DMA could be utilized in an 
>>efficient manner.  The upcoming SiI 3124 is another.  A few others 
>>(ADMA, Marvell) are PIO-via-DMA controllers as well.  I agree this is a 
>>good thing.
> 
> 
> I _think_ the SATA-II stuff from Promise (20579) does this too.

I don't see it in the docs.  The only possibility is that the "none 
data" bit in the Packet format now implies that ATA (rather than just 
ATAPI) PIO packets are accepted.

It's probably a side effect of Promise having avoided doing a strictly 
FIS-based engine like AHCI.

More likely you're still stuck with the error-prone method of submitting 
an outrageously long packet containing 256 writes to the Data register, 
followed by a microcoded check for BSY and DRQ.


>>Anyway, getting back to the thread of "problems with PIO polling", I am 
>>wondering if -- due to SATA's nature -- PIO polling should be avoided, 
>>and interrupt-driven methodology used instead.
>>
>>One reason why PIO polling was chosen (for controllers that support it; 
>>AHCI does not) is that the entire command submission/processing code can 
>>be written inline:  just submit-command, wait-for-busy-clear, etc. 
>>Makes the code less complex.
> 
> 
> I think going interrupt driven would be a good idea. Of course
> when I tried it one chip didn't serve up the interrupt as expected
> (can't remember is it was the 3114 or the 20319 - would have to
> check my notes.) I don't think it is massively more complex than
> what we currently have, and quite possibly might be simpler.

Yeah, I'm leaning towards ditching polling in favor of interrupts.  If 
we did that, it would probably be easier to do PIO-Mult.

But... no time right now.  Anyone reading this message is welcome to 
take up the challenge.  libata API supports this change seamlessly, it's 
just a matter of changing the internals.

	Jeff


