From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 14:38:42 -0500
Message-ID: <44205642.7070302@pobox.com>
References: <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca> <4420541E.3070303@pobox.com> <44205484.9000702@rtr.ca> <44205525.20306@rtr.ca> <20060321193538.GO4285@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12973 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965076AbWCUTio (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:38:44 -0500
In-Reply-To: <20060321193538.GO4285@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, James Bottomley <James.Bottomley@steeleye.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Jens Axboe wrote:
> My explanation was for the block layer part of course, I'm hoping (did
> not check) that the iommu has similar sane defaults.

Part of the problem is that the iommu doesn't know as much as the block 
layer.


> But this still really wants a unification of the dma restrictions...

Strongly agreed.  ISTR JamesB had some concrete thoughts in that 
direction, but they never made it beyond an IRC channel and/or a few emails.

	Jeff



