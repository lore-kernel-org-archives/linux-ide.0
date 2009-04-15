From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt37x: fix HPT370 DMA timeouts
Date: Wed, 15 Apr 2009 10:30:56 +0100
Message-ID: <20090415103056.695bb82c@lxorguk.ukuu.org.uk>
References: <200904141839.14755.sshtylyov@ru.mvista.com>
	<20090414173507.136ac439@lxorguk.ukuu.org.uk>
	<49E4BDBE.7070903@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43876 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758389AbZDOJav (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Apr 2009 05:30:51 -0400
In-Reply-To: <49E4BDBE.7070903@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

On Tue, 14 Apr 2009 20:45:50 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Alan Cox wrote:
> 
> 
> >>The libata driver has copied the code from the IDE driver which caused a post
> >>2.4.18 regression on many HPT370[A] chips -- DMA stopped to work completely,
> >>only causing timeouts.  Now remove hpt370_bmdma_start() for good...
> 
> > Do we need to move it rather than remove it though. I need to look at
> > that a bit with my HPT370 and see what happens. I suspect that if we get
> > a failed transfer we need to do the reset somewhere -
> 
>     Well, the driver does the reset in hpt370_bmdma_stop(), and even twice.
> 
> > perhaps qc_issue before anything hits the chip for the command ?
> 
>     No idea. I think it's just not needed.

Works for me Jeff on what testing I've done - although my controller is
happy either way
