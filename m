From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 01:14:04 -0500
Message-ID: <441F99AC.4000200@pobox.com>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12779 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030348AbWCUGOI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 01:14:08 -0500
In-Reply-To: <441F8478.50806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> But (as I replied to myself earlier), I think it is a non issue,
> because the IOMMU merging cannot produce more SG entries than
> there were originally.  It may produce less, and the driver may then
> end up splitting them apart again, but it will never exceed what
> the block layer permitted in the first place.

That says nothing about the boundaries upon which the IOMMU layer will 
or will not merge.  Without the fix, the problem case happens when (for 
example) the IOMMU output produces sg_tablesize segments, but some of 
those segments cross a 64k boundary and need to be split.

	Jeff


