From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] sl82c105: DMA support fixes
Date: Sat, 03 Feb 2007 00:04:18 +0100
Message-ID: <45C3C372.90400@gmail.com>
References: <200701302332.22543.sshtylyov@ru.mvista.com> <58cb370e0702021350h7aa08ddbo11a4cb0bb3e8e148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:45422 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946124AbXBBW71 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 17:59:27 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1389272nfa
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 14:59:26 -0800 (PST)
In-Reply-To: <58cb370e0702021350h7aa08ddbo11a4cb0bb3e8e148@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Sergei Shtylyov wrote:
> 
> Fix a number of issues with the DMA support code:
> 
> - driver claims support for all SW/MW DMA modes while supporting only MWDMA2;
> 
> - ide_dma_check() method tries to enable DMA on the "known good" drives which
>  don't support MWDMA2;
> 
> - ide_dma_on() method upon failure to set drive to MWDMA2 re-tunes already
>  tuned PIO mode and calls ide_dma_off() method instead of returning error;
> 
> - ide_dma_off() method sets drive->current_speed while it doesn't actually
>  change (only the PIO timings are re-loaded into the chip's registers);
> 
> - init_hwif() method forcibly sets/resets both "drive DMA capable" bits while
>  this is properly handled by ide_dma_{on,off}() methods being called later...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
