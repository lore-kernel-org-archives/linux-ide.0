From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported modes
Date: Wed, 11 Jul 2007 20:56:41 +0100
Message-ID: <20070711195641.GA2301@flint.arm.linux.org.uk>
References: <200707110200.37607.bzolnier@gmail.com> <46952A87.6010005@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:33003 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbXGKT5P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 15:57:15 -0400
Content-Disposition: inline
In-Reply-To: <46952A87.6010005@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Wed, Jul 11, 2007 at 11:07:51PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >icside_set_speed() happily accepts unsupported transfer modes which
> >results in drive->drive_data being set to the maximum value (480)
> >and drive->current_speed being set to the unsupported transfer mode.
> 
> >Fix it.
> 
> >Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

I wonder why Sergei's acking this patch - do you have the hardware to
test it on?  Are you somehow involved in this driver?  I think the
answer to both is most likely no.

Moreover, I think the patch is quite broken.  If an invalid DMA mode
is passed, currently the driver sets the cycle time to 480ns (stored
in drive_data) since both cycle_time and use_dma_info will be zero.
Moreover, 'on' will be zero, causing icside_set_speed() to return zero
which means the DMA setting was not successful (iow, use PIO).

This causes icside_dma_check() to return -1 to the IDE layer which
should fail the setting.

With your patch, you make icside_set_speed() return '1' meaning DMA
was succesfully configured.  That then causes icside_dma_check() to
return success to the IDE layer, so we now allow invalid speeds.

Ergo, what wasn't broken before is now broken.  So the patch is
completely wrong and was trying to fix a problem which didn't exist in
the first place.

BIG NAK.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
