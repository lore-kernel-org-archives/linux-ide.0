From: Mark Lord <liml@rtr.ca>
Subject: Re: WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
Date: Thu, 24 Jan 2008 23:29:53 -0500
Message-ID: <479965C1.3070009@rtr.ca>
References: <4798ACCC.3040104@rtr.ca> <4798AE28.4000408@gmail.com> <4798B526.4020709@rtr.ca> <47992115.6050501@gmail.com> <479924B5.5060202@rtr.ca> <479925FF.4060501@gmail.com> <4799270D.3010009@rtr.ca> <4799285F.3060308@gmail.com> <47995EFD.8030102@rtr.ca> <479960DB.8050109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3439 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbYAYE3z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 23:29:55 -0500
In-Reply-To: <479960DB.8050109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>..
>> Super!  You've done a great job with this stuff, Tejun!
> 
> Thanks but I can't really say nice things about how sata_sil24's
> qc_defer() is implemented or how we generally handle command deferring.
>  We really need the control at the higher level - request_queue group.
> Oh well... I guess you guys will be talking about it over beer again
> soon.  :-)
..

You too?

Another one for those beers, is a way to tell the IOMMU code about
physical segment limitations -- so we can stop having to allocate
PRD tables 2X as big as necessary in drivers like sata_mv.

Cheers
