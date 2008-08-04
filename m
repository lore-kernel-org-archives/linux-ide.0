From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Mon, 04 Aug 2008 15:48:17 -0600
Message-ID: <48977921.5040403@shaw.ca>
References: <fa.OGeO7gZvBG4obEzRbVltjSebgTQ@ifi.uio.no> <fa.KtvYE2B2yrJqUleolhtMPN9ljAQ@ifi.uio.no> <fa.AqEKTvguYFAzDFHy/We/8MpOqmo@ifi.uio.no> <48976168.3020804@shaw.ca> <20080804205508.20a3f917@lxorguk.ukuu.org.uk> <48977200.3050307@shaw.ca> <20080804220619.76b94ceb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:18545 "EHLO
	pd2mo1so-dmz.prod.shaw.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754019AbYHDVsT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 17:48:19 -0400
In-Reply-To: <20080804220619.76b94ceb@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Alan Cox wrote:
>> You mentioned in the thread for Willy's patch that "some
>> controllers have quirky rules for 32bit xfers" - any details anywhere?
> 
> There are two main ones
> 
> - Some controllers only support 32bit I/O for a multiple of 32bit values
> [sometimes 'unless the fifo is disabled']. I'd have to go back over the
> docs but I think the AMD may be one of those

The AMD-766 doc I have says that when the Secondary Posted Write Buffer 
or Primary Posted Write Buffer are enabled, only 32-bit writes are 
allowed to the data port. It doesn't say anything about a restriction 
with the read prefetch buffer though.

I guess it depends if any other controllers could potentially have this 
restriction. I suspect non-multiple-of-32-bit transfers are rare enough 
we could just fall back to 16-bit IO always for them, but maybe not.

> - Some controllers (VLB generally) require a magic sequence before the
> transfer. You'll see that in the pata_legacy bits.
> 
> Alan
> 
