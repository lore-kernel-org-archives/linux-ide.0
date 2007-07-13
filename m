From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported modes
Date: Fri, 13 Jul 2007 22:39:48 +0100
Message-ID: <20070713213948.GA18000@flint.arm.linux.org.uk>
References: <200707110200.37607.bzolnier@gmail.com> <200707112321.41597.bzolnier@gmail.com> <46967FA8.4090406@ru.mvista.com> <200707132302.04065.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:32992 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbXGMVkI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:40:08 -0400
Content-Disposition: inline
In-Reply-To: <200707132302.04065.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Fri, Jul 13, 2007 at 11:02:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> weeeeee, take 3

I'm probably going to drop this driver as soon as the PATA people get
their finger(s) out and respond to the issues I raised when merging
the pata_icside driver.

> v3:
> * Remove no longer needed initialization/checking of cycle_time
>   (Noticed by Sergei).
> 
> * No need to set drive->drive_data if DMA is not going to be used
>   (Noticed by Sergei).
> 
> * Remove incorrect setting of drive->current_speed
>   (Noticed by Sergei).
> 
> * Move ide_config_drive_speed() at the end of icside_set_speed().

What happens if we set a DMA mode but ide_config_drive_speed()
fails?  Wouldn't we set drive_data to the timing for that mode
and start to use it for future DMA accesses?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
