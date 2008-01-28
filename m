From: Alan Cox <alan@redhat.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 15:01:05 -0500
Message-ID: <20080128200105.GA20201@devserv.devel.redhat.com>
References: <200801272122.21823.gene.heskett@gmail.com> <18333.36746.819935.641383@harpo.it.uu.se> <1201521783.6149.33.camel@lappy> <200801280754.53768.gene.heskett@gmail.com> <479E2130.5020208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37008 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756077AbYA1UBR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 15:01:17 -0500
Content-Disposition: inline
In-Reply-To: <479E2130.5020208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Gene Heskett <gene.heskett@gmail.com>, Alan Cox <alan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux ide Mailing list <linux-ide@vger.kernel.org>

On Mon, Jan 28, 2008 at 01:38:40PM -0500, Mark Lord wrote:
> >[   31.195305] ata2.00: ATAPI: LITE-ON DVDRW SHM-165H6S, HS06, max UDMA/66
> >[   31.243813] ata2.01: ATA-7: MAXTOR STM3320620A, 3.AAE, max UDMA/100
> >[   31.243816] ata2.01: 625142448 sectors, multi 16: LBA48 
> >[   31.243825] ata2.00: limited to UDMA/33 due to 40-wire cable
> >[   31.417074] ata2.00: configured for UDMA/33
> >[   31.451769] ata2.01: configured for UDMA/100
> ..
> 
> That looks like an unrelated bug to me: the driver says "40-wire cable"
> but then goes and chooses UDMA/100 on one of the drives.

We currently assume that
- If we have host side detecting 40 that we use 40
- If we have drive side detecting 40 use 40
- If we have drive side detecting 80 and host thinks 80 use 80

The case where the drives disagree isn't currently considered.

