From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v6)
Date: Thu, 23 Oct 2008 22:02:07 +0200
Message-ID: <200810232202.07849.bzolnier@gmail.com>
References: <20081023.010607.07457252.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:1076 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbYJWVuB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 17:50:01 -0400
Received: by gv-out-0910.google.com with SMTP id e6so111620gvc.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 14:50:00 -0700 (PDT)
In-Reply-To: <20081023.010607.07457252.anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org, sshtylyov@ru.mvista.com

On Wednesday 22 October 2008, Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/tp_ops routines and build_dmatable.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
