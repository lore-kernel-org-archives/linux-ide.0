From: Mark Lord <liml@rtr.ca>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Wed, 22 Mar 2006 09:52:40 -0500
Message-ID: <442164B8.9070007@rtr.ca>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca> <4421341E.80704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:26012 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751186AbWCVOwu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2006 09:52:50 -0500
In-Reply-To: <4421341E.80704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
>
> One question though. Do IOMMU's preserve alignment? ie. Do they align 
> 33k block on 64k boundary? I guess they do, just wanna make sure.

They don't move the physical memory (that the sg list targets) around,
so it doesn't really matter, does it?

Cheers
