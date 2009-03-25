From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/03] sata_mv  cosmetic preparations for IRQ coalescing
Date: Tue, 24 Mar 2009 22:34:09 -0400
Message-ID: <49C99821.7050404@pobox.com>
References: <49B6EE95.1010808@rtr.ca> <49B6EED8.8060205@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58601 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbZCYCeS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 22:34:18 -0400
In-Reply-To: <49B6EED8.8060205@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Various cosmetic changes in preparation for the IRQ coalescing feature.
> 
> Note that the various MV_IRQ_COAL_* definitions are restored/renamed
> in the folloup patch which adds IRQ coalescing to the driver.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> 
> This is for libata-dev #upstream
> 
> --- old/drivers/ata/sata_mv.c    2009-03-10 18:20:20.000000000 -0400
> +++ new/drivers/ata/sata_mv.c    2009-03-10 18:26:54.000000000 -0400
> @@ -1,10 +1,13 @@
> /*
>  * sata_mv.c - Marvell SATA support
>  *
> - * Copyright 2008: Marvell Corporation, all rights reserved.
> + * Copyright 2008-2009: Marvell Corporation, all rights reserved.
>  * Copyright 2005: EMC Corporation, all rights reserved.
>  * Copyright 2005 Red Hat, Inc.  All rights reserved.
>  *
> + * Originally written by Brett Russ.
> + * Extensive overhaul and enhancement by Mark Lord <mlord@pobox.com>.

I'd like to think my own extensive overhaul, conversion to new EH, 
preparation for NCQ, 64-bit DMA changes, and work on chip generation 
separation amounted to something...


