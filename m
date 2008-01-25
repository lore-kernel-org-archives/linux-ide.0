From: Jeff Garzik <jeff@garzik.org>
Subject: Re: WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
Date: Fri, 25 Jan 2008 02:20:20 -0500
Message-ID: <47998DB4.8000207@garzik.org>
References: <4798ACCC.3040104@rtr.ca> <4798AE28.4000408@gmail.com> <4798B526.4020709@rtr.ca> <47992115.6050501@gmail.com> <479924B5.5060202@rtr.ca> <479925FF.4060501@gmail.com> <4799270D.3010009@rtr.ca> <4799285F.3060308@gmail.com> <47995EFD.8030102@rtr.ca> <479960DB.8050109@gmail.com> <479965C1.3070009@rtr.ca> <47996738.8030908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34777 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759446AbYAYHUW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 02:20:22 -0500
In-Reply-To: <47996738.8030908@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> Another one for those beers, is a way to tell the IOMMU code about
>> physical segment limitations -- so we can stop having to allocate
>> PRD tables 2X as big as necessary in drivers like sata_mv.
> 
> Hmmm... What's the restriction for sata_mv?  The same as BMDMA?  We need
> to update the block layer too to get the BMDMA right.


Same as for BMDMA, specifically:  after block/etc. merging is done, and 
things are passed to the IOMMU via dma_map_sg(), the IOMMU may merge 
-too- aggressively, merging across boundaries (like 64k bmdma boundary) 
because it is unaware of such restrictions.

	Jeff


