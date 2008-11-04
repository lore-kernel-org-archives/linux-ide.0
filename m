From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] pata-rb532-cf: read and write data in 4-byte blocks
Date: Tue, 4 Nov 2008 13:35:04 +0100
Message-ID: <20081104123504.GA14551@nuty>
References: <490E1A63.3040507@ru.mvista.com> <1225718954-8307-1-git-send-email-n0-1@freewrt.org> <490FE535.8080109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:49091 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbYKDMdp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 07:33:45 -0500
Content-Disposition: inline
In-Reply-To: <490FE535.8080109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hi,

On Tue, Nov 04, 2008 at 01:01:25AM -0500, Jeff Garzik wrote:
> Phil Sutter wrote:
> >* rename the offset definition to avoid abiguity with the standard ATA
> >  IO address
> >* read and write four bytes at once
> >* use writesl() and readsl() which implicitly iterate over the data
> >* fix the signature of rb532_pata_data_xfer() to match the function
> >  pointer definition and return the number of bytes consumed
> >
> >Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> >Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>
> >---
> > drivers/ata/pata_rb532_cf.c |   21 ++++++++++-----------
> > 1 files changed, 10 insertions(+), 11 deletions(-)
> 
> None of this description says _why_ you wish to do this.  Also, maybe I 
> missed the response, what about ATAPI?

Well, Sergei Shtylyov pointed out that the original driver does transfer
data at 4-byte blocks, so I changed it accordingly and tested it.
Hopefully this will provide a performance gain, though I did not do any
performance tests and therefore can't tell if that's really the case.

I had interpreted Sergei's response to my BUG_ON() statement for it to
be unnecessary, which may be wrong. I don't know if it's possible to
connect ATAPI devices to the on board CompactFlash slot, maybe you can
give me some hints on this. OTOH I see that the sector size is hard
coded in the original driver to 0x200, so I guess either ATAPI is not
possible or at least not with the original driver, right?

Greetings, Phil
