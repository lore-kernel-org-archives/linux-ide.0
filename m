From: Mark Lord <liml@rtr.ca>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 13:38:40 -0500
Message-ID: <479E2130.5020208@rtr.ca>
References: <200801272122.21823.gene.heskett@gmail.com> <18333.36746.819935.641383@harpo.it.uu.se> <1201521783.6149.33.camel@lappy> <200801280754.53768.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2121 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415AbYA1Sim (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 13:38:42 -0500
In-Reply-To: <200801280754.53768.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>, Alan Cox <alan@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux ide Mailing list <linux-ide@vger.kernel.org>

Added Alan to CC: list.

> [   30.703188] scsi0 : pata_amd
> [   30.709313] scsi1 : pata_amd
> [   30.710076] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
> [   30.710079] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
> [   30.864753] ata1.00: ATA-6: WDC WD2000JB-00EVA0, 15.05R15, max UDMA/100
> [   30.864756] ata1.00: 390721968 sectors, multi 16: LBA48 
> [   30.871629] ata1.00: configured for UDMA/100
..

Gene, please confirm with us that your primary/master hard drive (above)
is connected with an 80-wire UDMA cable, as opposed to the older 40-wire cables.

> [   31.195305] ata2.00: ATAPI: LITE-ON DVDRW SHM-165H6S, HS06, max UDMA/66
> [   31.243813] ata2.01: ATA-7: MAXTOR STM3320620A, 3.AAE, max UDMA/100
> [   31.243816] ata2.01: 625142448 sectors, multi 16: LBA48 
> [   31.243825] ata2.00: limited to UDMA/33 due to 40-wire cable
> [   31.417074] ata2.00: configured for UDMA/33
> [   31.451769] ata2.01: configured for UDMA/100
..

That looks like an unrelated bug to me: the driver says "40-wire cable"
but then goes and chooses UDMA/100 on one of the drives.

Alan?


