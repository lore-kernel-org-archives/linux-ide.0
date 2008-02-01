From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH RESEND] libata: implement drain buffers
Date: Fri, 01 Feb 2008 15:08:59 -0600
Message-ID: <1201900139.3134.65.camel@localhost.localdomain>
References: <1201895635.3134.62.camel@localhost.localdomain>
	 <47A37ADD.6070408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:57887 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753058AbYBAVJE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 16:09:04 -0500
In-Reply-To: <47A37ADD.6070408@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide <linux-ide@vger.kernel.org>


On Fri, 2008-02-01 at 15:02 -0500, Jeff Garzik wrote:
> James Bottomley wrote:
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Date: Thu, 10 Jan 2008 11:42:50 -0600
> > Subject: libata: implement drain buffers
> > 
> > This just updates the libata slave configure routine to take advantage
> > of the block layer drain buffers.
> > 
> > I suspect I should also be checking for AHCI as well as ATA_DEV_ATAPI,
> > but I couldn't see how to do that easily.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > ---
> >  drivers/ata/libata-scsi.c |   26 ++++++++++++++++++++++----
> >  1 files changed, 22 insertions(+), 4 deletions(-)
> 
> Tejun's persistent comment/objection with these works is that you need 
> two sizes, for ATAPI, the raw size and the buffered size.

This should be independent of the drain patch.  All this one does is
eliminate the unnecessary extra segment for alignment.  DMA drain for
ATAPI is something separate (and it's also something that isn't upstream
in any form).

James


