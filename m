From: Andy Warner <andyw@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Wed, 16 Feb 2005 17:49:54 -0600
Message-ID: <20050216174954.K10699@florence.linkmargin.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <4213CD9E.9040703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:13796 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262140AbVBPXuB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 18:50:01 -0500
Content-Disposition: inline
In-Reply-To: <4213CD9E.9040703@pobox.com>; from jgarzik@pobox.com on Wed, Feb 16, 2005 at 05:47:58PM -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Warner <andyw@pobox.com>, Brad Campbell <brad@wasp.net.au>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> Does the PIO code deviate from the ATA/ATAPI-[4567] host state machine 
> somehow?

That I can't say (the ata/atapi docs make me want to put my
head under the wheel of a bus), but: on SMP machines the
implementation would turn into busy-waiting for every sector;
I have my suspicions about the ata_busy_wait() calls in
ata_pio_block(); I also looked at implementing ATA_PROT_PIO_MULT
with interrupt support, but then  ran out of time on the
project - what's there doesn't (didn't) use interrupts.

> Or is it just that newer SATA-emulating-PATA chips have trouble with it?

Could be, I for sure saw arbitration/starvation issues that
resulted in geological-grade delays getting status at the end
of some PIO transfers. The result was timeout errors under
heavy load. I believe that the SMP-machine-becomes-busy-wait-
monster bug probably caused the majority of these errors (I
could generate them after a few minutes testing), because I had
4 (fast-ish) cores conspiring to beat the crap out of 1 register
on a PCI card.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
