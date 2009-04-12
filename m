From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Sun, 12 Apr 2009 16:18:12 +0100
Message-ID: <20090412161812.78e92948@lxorguk.ukuu.org.uk>
References: <49C1047D.4000008@rtr.ca>
	<49C11A0C.3070502@rtr.ca>
	<49C11ED4.2030307@rtr.ca>
	<49C19087.5000307@gmail.com>
	<49C190F1.7010202@kernel.org>
	<49C28133.8050401@rtr.ca>
	<49C281A5.5080404@rtr.ca>
	<49C2D642.90706@kernel.org>
	<49C39690.6090802@rtr.ca>
	<49E20475.1080409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48262 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754765AbZDLPSK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Apr 2009 11:18:10 -0400
In-Reply-To: <49E20475.1080409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> The limit for sata_mv chipsets seems to actually be 7-sectors or less
> for read/write multiple.  Which means a max of 4 in practice.
> 
> Similarly, we should also be preventing *any* PIO of more than one DRQ
> for sata_mv.  But I don't see a sensible way to do that either.

Ugghhh..

> In practice, that part does seem to work fine with the PIO polling
> that sata_mv uses.
> 
> But what to do about the read/write multiple issue ?

I think the field has to go in but it can default to 255 (unlimited) and
the it821x like hooks can be used for those controllers with limits.

Alan

