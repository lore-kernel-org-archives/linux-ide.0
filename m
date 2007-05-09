From: David Miller <davem@davemloft.net>
Subject: Re: [git patches] IDE update
Date: Wed, 09 May 2007 16:20:38 -0700 (PDT)
Message-ID: <20070509.162038.21595311.davem@davemloft.net>
References: <200705100046.05280.bzolnier@gmail.com>
	<46424F38.7010405@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60048
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759263AbXEIXUi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2007 19:20:38 -0400
In-Reply-To: <46424F38.7010405@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Wed, 09 May 2007 18:46:16 -0400

> Bartlomiej Zolnierkiewicz wrote:
> > Bartlomiej Zolnierkiewicz (11):
> >       ide: fix UDMA/MWDMA/SWDMA masks (v3)
> >       ide: rework the code for selecting the best DMA transfer mode (v3)
> >       ide: add ide_tune_dma() helper
> >       ide: make /proc/ide/ optional
> >       ide: split off ioctl handling from IDE settings (v2)
> >       ide: move IDE settings handling to ide-proc.c
> >       ide: cable detection fixes (take 2)
> >       ide: add "initializing" argument to ide_register_hw()
> >       ide: add ide_proc_register_port()
> >       ide: legacy PCI bus order probing fixes
> >       ide: fix PIO setup on resume for ATAPI devices
> > 
> > 
> > [ sorry but the patch is too big to be included ]
> 
> 
> The limit was raised to 400K IIRC.

On lkml but not linux-ide, I'll go and bump it up there too.

There, done...
