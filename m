From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: add per-dev pio/mwdma/udma_mask
Date: Mon, 13 Mar 2006 03:29:24 -0500
Message-ID: <44152D64.6000903@pobox.com>
References: <11421469551000-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:22241 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932356AbWCMI3b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 03:29:31 -0500
In-Reply-To: <11421469551000-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add per-dev pio/mwdma/udma_mask.  All transfer mode limits used to be
> applied to ap->*_mask which unnecessarily restricted other devices
> sharing the port.  This change will also benefit later EH speed down
> and hotplug.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

I don't see much value in the separation.  Rather than 3 separate masks, 
it seems like this patch would be simplified if you simply added 
dev->xfer_mask.

	Jeff


