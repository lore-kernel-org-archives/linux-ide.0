From: Andy Warner <andyw@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Wed, 16 Feb 2005 18:20:40 -0600
Message-ID: <20050216182040.L10699@florence.linkmargin.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <4213CD9E.9040703@pobox.com> <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:53972 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262164AbVBQAUq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 19:20:46 -0500
Content-Disposition: inline
In-Reply-To: <4213DE38.70309@pobox.com>; from jgarzik@pobox.com on Wed, Feb 16, 2005 at 06:58:48PM -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Warner <andyw@pobox.com>, Brad Campbell <brad@wasp.net.au>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> Unfortunately, that's what you're _supposed_ to do, busy-wait for every 
> "block" (where block == 1 sector for PIO, and <n> sectors for PIO-Mult).

The logic surrounding PIO-multi in PATA-land looked markedly different.

> Wasn't it you that had a patch that used ata_altstatus() to mitigate 
> this somewhat?

Yeah - and to not call queue_work() to accomplish the polling
(which could start the next poll immediately on an SMP machine),
I suppose that _could_ just as easily point to a locking problem,
as a state machine logic flaw. My proof-of-concept kludge was to
call queue_delayed_work() instead.

> It's entirely possible that I'm one of the first to punish SATA 
> controllers with PIO polling data transfer, rather than interrupt-driven 
> xfer.  The SMP aspect makes me suspicious that something else might be 
> involved, as well.  Ever since the 2.6.10-bkN kernel updated ACPI, the 
> one SMP machine I had that failed on libata started working.

I saw errors on both SiI (3114) and Promise (20319) cards, so
I'm not convinced that (these) problems are at the chip-level
(not that there aren't plenty of those to go around.)

> Any chance you could debug this further?

I'll see what I can do.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
