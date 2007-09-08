From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 5/13] ide: add IDE_HFLAG_ERROR_STOPS_FIFO host flag
Date: Sat, 08 Sep 2007 11:15:52 -0400
Message-ID: <46E2BCA8.30402@garzik.org>
References: <200709052352.57848.bzolnier@gmail.com>	<20070906081356.GA20007@havoc.gtf.org> <20070908161755.10902b54@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50667 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbXIHPP6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Sep 2007 11:15:58 -0400
In-Reply-To: <20070908161755.10902b54@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
> On Thu, 6 Sep 2007 04:13:56 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> On Wed, Sep 05, 2007 at 11:52:57PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>> Add IDE_HFLAG_ERROR_STOPS_FIFO host flag and use it instead
>>> of hwif->err_stops_fifo.  As a side-effect this change fixes
>>> hwif->err_stops_fifo not being restored by ide_hwif_restore().
>>>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>> ---
>>>  drivers/ide/ide-io.c           |    3 ++-
>>>  drivers/ide/pci/pdc202xx_new.c |    3 +--
>>>  drivers/ide/pci/pdc202xx_old.c |    8 ++++----
>>>  include/linux/ide.h            |    3 ++-
>>>  4 files changed, 9 insertions(+), 8 deletions(-)
>> Hum, I wonder if libata needs something like this.
> 
> You'd have to add the drain data on error hack first, right now we will
> reset in that case (which for one or two devices has another problem in
> that it won't clear a stuck FIFO)

Nod.  There was nothing ever wrong with Mark's drain patch, I just never 
saw a solid justification for it outside of root 
accidentally/intentionally misprogramming things -- a situation whereall 
sorts of lockups and hangs and explosions can occur, even with the 
fifo-drain change.  We could fill the kernel with code protecting root 
from himself.

But I was thinking for ATAPI it would be useful to report how much data 
was drained from the FIFO, for improved diagnostics.  And if there are 
other conditions that imply draining would be useful, by all means lets 
merge it.

	Jeff



