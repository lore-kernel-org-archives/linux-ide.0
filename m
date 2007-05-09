From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] IDE update
Date: Wed, 09 May 2007 18:46:16 -0400
Message-ID: <46424F38.7010405@garzik.org>
References: <200705100046.05280.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49565 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505AbXEIWqU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 18:46:20 -0400
In-Reply-To: <200705100046.05280.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Bartlomiej Zolnierkiewicz (11):
>       ide: fix UDMA/MWDMA/SWDMA masks (v3)
>       ide: rework the code for selecting the best DMA transfer mode (v3)
>       ide: add ide_tune_dma() helper
>       ide: make /proc/ide/ optional
>       ide: split off ioctl handling from IDE settings (v2)
>       ide: move IDE settings handling to ide-proc.c
>       ide: cable detection fixes (take 2)
>       ide: add "initializing" argument to ide_register_hw()
>       ide: add ide_proc_register_port()
>       ide: legacy PCI bus order probing fixes
>       ide: fix PIO setup on resume for ATAPI devices
> 
> 
> [ sorry but the patch is too big to be included ]


The limit was raised to 400K IIRC.

	Jeff


