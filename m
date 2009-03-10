From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 03/03] sata_mv implement IRQ coalescing
Date: Tue, 10 Mar 2009 19:21:20 -0400
Message-ID: <49B6F5F0.2010905@rtr.ca>
References: <49B6EE95.1010808@rtr.ca> <49B6EED8.8060205@rtr.ca> <49B6EF18.8050000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:39148 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754374AbZCJXVX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 19:21:23 -0400
In-Reply-To: <49B6EF18.8050000@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Grant Grundler <grundler@google.com>

Mark Lord wrote:
> Add IRQ coalescing to sata_mv (off by default).
> 
> This feature can reduce total interrupt overhead for RAID setups
> in some situations, by deferring the interrupt signal until one or both of:
> 
> a) a specified io_count (completed SATA commands) is achieved, or
> b) a specified time interval elapses after an IO completion.
> 
> For now, module parameters are used to set the irq_coalescing_io_count
> and irq_coalescing_usecs (timeout) globally.  These may eventually
> be supplemented with sysfs attributes, so that thresholds can be set
> on-the-fly and on a per-chip (or even per-host_controller) basis.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> 
> This is for #upstream libata-dev #upstream
> 
> --- old/drivers/ata/sata_mv.c    2009-03-10 18:28:30.000000000 -0400
> +++ new/drivers/ata/sata_mv.c    2009-03-10 18:48:07.000000000 -0400
> @@ -34,10 +34,7 @@
..

Ooops.. hold off on 03/03 for the moment.
I messed up a couple of bits.. will repost (v2) shortly.

-ml
