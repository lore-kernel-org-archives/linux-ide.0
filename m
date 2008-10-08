From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v3)
Date: Wed, 8 Oct 2008 21:09:58 +0200
Message-ID: <200810082109.58282.bzolnier@gmail.com>
References: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:20061 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853AbYJHT3A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 15:29:00 -0400
Received: by gv-out-0910.google.com with SMTP id e6so679871gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 12:28:58 -0700 (PDT)
In-Reply-To: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org, sshtylyov@ru.mvista.com

On Thursday 02 October 2008, Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/tp_ops routines and build_dmatable.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against linux-next 20080919.
> 
> Changes since v2:
> * more consistent symbol naming
> * drop custom selectproc
> * more reasonable delay values
> * custom ide_build_dmatable for big endian
> * cleanup irq handling
> * use ide_host_alloc/ide_host_register instead of ide_host_alloc
> * drop custom init_iops
> * and so on  (Many many thanks to Sergei)

I think that Sergei is still on vacation so it may take a while to
get his feedback.

[ in the meantime I replaced v2 by v3 in pata tree ]
