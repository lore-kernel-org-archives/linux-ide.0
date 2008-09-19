From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Fri, 19 Sep 2008 10:10:08 -0700
Message-ID: <200809191010.09457.bzolnier@gmail.com>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp> <200809181645.10410.bzolnier@gmail.com> <48D37025.2030501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:42453 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbYISRLF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Sep 2008 13:11:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so530334rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 19 Sep 2008 10:11:05 -0700 (PDT)
In-Reply-To: <48D37025.2030501@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Friday 19 September 2008 02:25:57 Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >> This is the driver for the Toshiba TX4939 SoC ATA controller.
> >>
> >> This controller has standard ATA taskfile registers and DMA
> >> command/status registers, but the register layout is swapped on big
> >> endian.  There are some other endian issue and some special registers
> >> which requires many custom dma_ops/port_ops routines.
> >>
> >> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >> ---
> >> This patch is against linux-next 20080916.
> >>
> >> Changes since v1:
> >> * rework IO accessors
> >> * rework pio/dma timing setup
> >> * use ide_get_pair_dev
> >> * do not do ATA hard reset
> >> * and so on  (Many thanks to Sergei)
> >>     
> >
> > Sergei, are you OK with this version?
> >   
> 
>    I didn't have tome to look at it.

I didn't mean to rush you.  I just prefer to have it in pata tree
because I may not have much time to work on ide next week and also
since the code looks much better now the further changes could be
addressed more effectively with the incremental patches.

Thanks,
Bart
