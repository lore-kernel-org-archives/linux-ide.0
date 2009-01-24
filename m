From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] icside: use struct ide_port_info also for PCB version 5
Date: Sat, 24 Jan 2009 14:50:51 +0000
Message-ID: <20090124145051.GA26833@flint.arm.linux.org.uk>
References: <200901241514.23036.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58094 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbZAXOvD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 09:51:03 -0500
Content-Disposition: inline
In-Reply-To: <200901241514.23036.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jan 24, 2009 at 03:14:22PM +0100, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] icside: use struct ide_port_info also for PCB version 5
> 
> This fixes hwif->channel and drive->dn assignments.

I really don't care about this driver anymore - people should
be using the PATA version instead.

Nevertheless, this patch looks broken.

> @@ -534,7 +538,7 @@ icside_register_v6(struct icside_state *
                      ^^^^^^^^^^^^^^^^^^ v6 function

>  		d.dma_ops = NULL;
>  	}
>  
> -	ret = ide_host_register(host, NULL, hws);
> +	ret = ide_host_register(host, &icside_v5_port_info, hws);
                                      ^^^^^^^^^^^^^^^^^^^^^ v5 info

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
