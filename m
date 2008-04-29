From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] [IDE] alim15x3: disable init_hwif_ali15x3 for PowerPC
Date: Tue, 29 Apr 2008 23:01:38 +0200
Message-ID: <200804292301.39037.bzolnier@gmail.com>
References: <20080429161914.GA4980@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:37615 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067AbYD2U5A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 16:57:00 -0400
Received: by fg-out-1718.google.com with SMTP id l27so141636fgb.17
        for <linux-ide@vger.kernel.org>; Tue, 29 Apr 2008 13:56:54 -0700 (PDT)
In-Reply-To: <20080429161914.GA4980@polina.dev.rtsoft.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Tuesday 29 April 2008, Anton Vorontsov wrote:
> We don't need init_hwif_ali15x3() on the PowerPC systems either.
> 
> Before:
> 
> ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc8) at  PCI slot 0001:03:1f.0
> ALI15X3: 100% native mode on irq 19
>     ide0: BM-DMA at 0x1120-0x1127
>     ide1: BM-DMA at 0x1128-0x112f
> hda: SONY DVD RW AW-Q170A, ATAPI CD/DVD-ROM drive
> hda: UDMA/66 mode selected
> ide0: Disabled unable to get IRQ 14.
> ide0: failed to initialize IDE interface
> ide1: Disabled unable to get IRQ 15.
> ide1: failed to initialize IDE interface
> 
> After:
> 
> ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc8) at  PCI slot 0001:03:1f.0
> ALI15X3: 100% native mode on irq 19
>     ide0: BM-DMA at 0x1120-0x1127
>     ide1: BM-DMA at 0x1128-0x112f
> hda: SONY DVD RW AW-Q170A, ATAPI CD/DVD-ROM drive
> hda: UDMA/66 mode selected
> ide0 at 0x1100-0x1107,0x110a on irq 19
> ide1 at 0x1110-0x1117,0x111a on irq 19
> hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
> 
> ide0 works well, though I can't test ide1, it isn't traced out on
> the board.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

applied, thanks
