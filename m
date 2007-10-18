From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Bug?  2.6.23-git13 + Jens's latest sg_next fixes:   DRDY?
Date: Thu, 18 Oct 2007 15:14:02 -0400
Message-ID: <4717B07A.2090300@garzik.org>
References: <47177863.1080500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44712 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755029AbXJRTOQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 15:14:16 -0400
In-Reply-To: <47177863.1080500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> 
> Something weird in libata with latest -git13 + Jens's patch.
> Jeff, did I miss a libata fix somewhere?

Yes, you need

[PATCH] Re: [bug] ata subsystem related crash with latest -git

from me.

	Jeff


