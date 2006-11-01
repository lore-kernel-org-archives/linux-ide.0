From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] sata_sil: implement Mod15Write workaround by split
 request processing
Date: Tue, 31 Oct 2006 20:59:50 -0500
Message-ID: <4547FF96.4070808@pobox.com>
References: <11612370993859-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12757 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946372AbWKAB7x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 20:59:53 -0500
In-Reply-To: <11612370993859-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Instead of limiting max_sectors to 15 unconditionally, this patch
> leaves max_sectors at the default value and process write requests
> larger than 15 sectors by processing them in <= 15 sectors chunks.
> This results in unhamplered read performance and better write
> performance.
> 
> Split request processing is performed only for DMA write requests > 15
> sectors.  dev->max_sectors is limited to 15 sectors when the device is
> put into PIO mode.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

I'm still put off by the complexity that this adds to each transfer, and 
to the overall driver itself.

It's largely older chips and drives, so I don't think it's worth 
carrying this code for decades to come, just for some early SATA screwups.


