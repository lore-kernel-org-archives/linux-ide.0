From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv fix MSI irq race condition
Date: Fri, 13 Mar 2009 14:57:49 -0400
Message-ID: <49BAACAD.4090707@pobox.com>
References: <49B6CD83.1020904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51685 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbZCMS54 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Mar 2009 14:57:56 -0400
In-Reply-To: <49B6CD83.1020904@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Fix a (rare) race condition in mv_interrupt() when using MSI.
> 
> The value of hpriv->main_irq_mask_addr can change on on the fly,
> and without this patch we could end up writing back a stale copy
> to the hardware.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> -- 
> 
> ** This is required for 2.6.29 and beyond ***

applied


