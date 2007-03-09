From: vandrove@vc.cvut.cz
Subject: Re: [PATCH] Fix simplex adapters with libata
Date: Fri,  9 Mar 2007 02:47:31 +0100
Message-ID: <1173404851.45f0bcb38d69d@imap.vc.cvut.cz>
References: <20070308091211.GA7257@vana.vc.cvut.cz> <20070308130250.5647ce5c@lxorguk.ukuu.org.uk> <45F0227D.5010905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.vc.cvut.cz ([147.32.240.222]:59662 "EHLO imap.vc.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992888AbXCICQG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Mar 2007 21:16:06 -0500
In-Reply-To: <45F0227D.5010905@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Petr Vandrovec <petr@vandrovec.name>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Quoting Mark Lord <liml@rtr.ca>:

> Alan Cox wrote:
> >
> >> diff -uprdN linux/drivers/ata/libata-core.c
> linux/drivers/ata/libata-core.c
> >> --- linux/drivers/ata/libata-core.c	2007-03-07 22:13:24.000000000 -0800
> >> +++ linux/drivers/ata/libata-core.c	2007-03-08 00:15:37.000000000 -0800
> >> @@ -3455,7 +3455,8 @@ static void ata_dev_xfermask(struct ata_
> >>  			       "device is on DMA blacklist, disabling DMA\n");
> >>  	}
> >>  
> >> -	if ((host->flags & ATA_HOST_SIMPLEX) && host->simplex_claimed != ap) {
> >> +	if ((host->flags & ATA_HOST_SIMPLEX) &&
> >> +            host->simplex_claimed && host->simplex_claimed != ap) {
> 
> A different version of this fix just went upstream for 2.6.21 via Jeff.
> Which of the two is correct?
> 
> I believe the other one looks like this:
> 
> >> -	if ((host->flags & ATA_HOST_SIMPLEX) && host->simplex_claimed != ap) {
> >> +	if ((host->flags & ATA_HOST_SIMPLEX) && host->simplex_claimed == ap) {

This one does not look correct to me.  It will not disable DMA for anything, as
simplex_claimed will be NULL on first pass, and either NULL or first port on
second pass, so it will never match currently tested port, and so it will leave
DMA enabled for both channels, which is deadly for real simplex controllers.

Petr



