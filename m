From: Mark Lord <liml@rtr.ca>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 15:29:27 -0500
Message-ID: <479E3B27.9030402@rtr.ca>
References: <200801272122.21823.gene.heskett@gmail.com> <18333.36746.819935.641383@harpo.it.uu.se> <1201521783.6149.33.camel@lappy> <200801280754.53768.gene.heskett@gmail.com> <479E2130.5020208@rtr.ca> <20080128200105.GA20201@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2576 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757879AbYA1U33 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 15:29:29 -0500
In-Reply-To: <20080128200105.GA20201@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Gene Heskett <gene.heskett@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux ide Mailing list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Mon, Jan 28, 2008 at 01:38:40PM -0500, Mark Lord wrote:
>>> [   31.195305] ata2.00: ATAPI: LITE-ON DVDRW SHM-165H6S, HS06, max UDMA/66
>>> [   31.243813] ata2.01: ATA-7: MAXTOR STM3320620A, 3.AAE, max UDMA/100
>>> [   31.243816] ata2.01: 625142448 sectors, multi 16: LBA48 
>>> [   31.243825] ata2.00: limited to UDMA/33 due to 40-wire cable
>>> [   31.417074] ata2.00: configured for UDMA/33
>>> [   31.451769] ata2.01: configured for UDMA/100
>> ..
>>
>> That looks like an unrelated bug to me: the driver says "40-wire cable"
>> but then goes and chooses UDMA/100 on one of the drives.
> 
> We currently assume that
> - If we have host side detecting 40 that we use 40
> - If we have drive side detecting 40 use 40
> - If we have drive side detecting 80 and host thinks 80 use 80
> 
> The case where the drives disagree isn't currently considered.
..

Ahh.  Tricky mess, that stuff.
I believe that if we have a drive that only sees 40W,
then it is probably best to restrict the other drive as well.

Just in case the drive that reports 40W cannot actually keep up
with the 80W timings, even when they're for the other drive.

That's my 2p.

Cheers
