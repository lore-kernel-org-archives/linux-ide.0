From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Thu, 1 Nov 2007 14:15:01 +0000
Message-ID: <20071101141501.3746cec2@the-village.bc.nu>
References: <47274A5F.6070409@gentoo.org>
	<20071030153417.59b9182c@the-village.bc.nu>
	<47276DCA.1000808@gentoo.org>
	<20071030190153.373c9347@the-village.bc.nu>
	<47278439.4030801@gentoo.org>
	<20071031114958.210bd7cc@the-village.bc.nu>
	<20071031115754.GK5059@kernel.dk>
	<4729A0DF.20800@garzik.org>
	<20071101105335.1f20bab3@the-village.bc.nu>
	<4729B3EA.6040707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42837 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753044AbXKAOPP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2007 10:15:15 -0400
In-Reply-To: <4729B3EA.6040707@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Daniel Drake <dsd@gentoo.org>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Albert Lee <albertcc@tw.ibm.com>

> We are both half-right.  I reverted my version of that completely, 
> applied your version verbatim, and pushed it upstream.  The result: 
> atapi_xlat _did_ start programming lbam/lbah for DMA (another behavior 
> change), but request-sense DMA path was not changed to program lba[mh] 
> for DMA.

I didn't realise we ever issued reques sense by DMA ?

> > Only if your transfer is actually 8K or more.
> 
> No, that's precisely the problem cause for what Daniel is reporting.  We 
> are setting blimit=xfer_len(==10), when the device wants to return more 
> than 10 bytes.  When set to the old limit (8k), the problem didn't occur.

Lots of *other* problems occur instead. Daniel is reporting that if he
makes a stupid request to a buggy drive he gets a reset and the system
continues happily. Even that reset being a reset not a new command issue
is actually us being excessively paranoid.

Prior to these changes people were reporting things like "I cannot
use my CD-ROM".

So given we have ten years of experience of the method I put in taken
from the old IDE layer versus a good way to make one buggy request work
and break everything else - I *know* which I consider to be the right
path.

And PIO drains of DMA controllers do not work for most controllers, some
will simply hang solid if you touch the data register as part of a DMA
sequence (eg promise 2026x)

Alan
