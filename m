From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Wed, 22 Mar 2006 20:25:18 +0900
Message-ID: <4421341E.80704@gmail.com>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:12806 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750704AbWCVLZd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2006 06:25:33 -0500
Received: by pproxy.gmail.com with SMTP id m51so101416pye
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2006 03:25:32 -0800 (PST)
In-Reply-To: <442051A0.1050200@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, all.

Mark Lord wrote:
> Jens Axboe wrote:
> ..
>> Seems to me that your reasoning is correct. It's a fact that the
>> original block mapped sg lists satisfies all requirements of the device
>> driver and/or hardware, otherwise would be a bug. The iommu may go nuts
>> of course, but logically that new sg list should be choppable into the
>> same requirements.
> 
> I just finished going through all of the arch implementations and,
> as near as I can tell, they only ever *merge* sg list items,
> and never create additional sg entries.
> 

One question though. Do IOMMU's preserve alignment? ie. Do they align 
33k block on 64k boundary? I guess they do, just wanna make sure.

-- 
tejun
