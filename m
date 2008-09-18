From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Thu, 18 Sep 2008 16:45:09 -0700
Message-ID: <200809181645.10410.bzolnier@gmail.com>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:63767 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911AbYIRXxt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Sep 2008 19:53:49 -0400
Received: by rv-out-0506.google.com with SMTP id k40so151226rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 18 Sep 2008 16:53:49 -0700 (PDT)
In-Reply-To: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org, sshtylyov@ru.mvista.com

On Wednesday 17 September 2008 08:13:42 Atsushi Nemoto wrote:
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

Sergei, are you OK with this version?

[ I tentatively applied it to pata tree.  I still see the use of legacy
  HWIF()/HWGROUP() macros but I can deal with it myself before pushing
  the patch upstream. ]
