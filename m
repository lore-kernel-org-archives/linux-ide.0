From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Wed, 17 Sep 2008 17:58:45 -0400
Message-ID: <48D17D95.6050008@garzik.org>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34010 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbYIQV6w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Sep 2008 17:58:52 -0400
In-Reply-To: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org, sshtylyov@ru.mvista.com

Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against linux-next 20080916.
> 
> Changes since v1:
> * rework IO accessors
> * rework pio/dma timing setup
> * use ide_get_pair_dev
> * do not do ATA hard reset
> * and so on  (Many thanks to Sergei)
> 
>  drivers/ide/Kconfig          |    6 +
>  drivers/ide/mips/Makefile    |    1 +
>  drivers/ide/mips/tx4939ide.c |  744 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 751 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ide/mips/tx4939ide.c

I hope a libata driver is coming, too?


