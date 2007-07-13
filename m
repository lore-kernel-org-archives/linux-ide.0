From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported modes
Date: Sat, 14 Jul 2007 00:49:30 +0200
Message-ID: <200707140049.30245.bzolnier@gmail.com>
References: <200707110200.37607.bzolnier@gmail.com> <200707132302.04065.bzolnier@gmail.com> <20070713213948.GA18000@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:43841 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759714AbXGMWcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 18:32:05 -0400
Received: by ug-out-1314.google.com with SMTP id j3so655167ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 15:32:03 -0700 (PDT)
In-Reply-To: <20070713213948.GA18000@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Friday 13 July 2007, Russell King wrote:
> On Fri, Jul 13, 2007 at 11:02:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > weeeeee, take 3
> 
> I'm probably going to drop this driver as soon as the PATA people get
> their finger(s) out and respond to the issues I raised when merging
> the pata_icside driver.
> 
> > v3:
> > * Remove no longer needed initialization/checking of cycle_time
> >   (Noticed by Sergei).
> > 
> > * No need to set drive->drive_data if DMA is not going to be used
> >   (Noticed by Sergei).
> > 
> > * Remove incorrect setting of drive->current_speed
> >   (Noticed by Sergei).
> > 
> > * Move ide_config_drive_speed() at the end of icside_set_speed().
> 
> What happens if we set a DMA mode but ide_config_drive_speed()
> fails?  Wouldn't we set drive_data to the timing for that mode
> and start to use it for future DMA accesses?

If ide_config_drive_speed() fails then icside_dma_check() also fails
so IDE core doesn't enable DMA.  Therefore we never start DMA engine
and icside_dma_setup() (the only place which reads drive->drive_data)
is never called.

Thanks,
Bart
