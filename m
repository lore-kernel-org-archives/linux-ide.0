From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] linux-next remove wmb() from ide-dma-sff.c and scc_pata.c
Date: Thu, 2 Apr 2009 21:08:32 +0200
Message-ID: <200904022108.32808.bzolnier@gmail.com>
References: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com> <alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be> <49D1E384.8080009@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:57353 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761872AbZDBTgg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 15:36:36 -0400
Received: by bwz17 with SMTP id 17so671400bwz.37
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2009 12:36:33 -0700 (PDT)
In-Reply-To: <49D1E384.8080009@toshiba.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, IDE/ATA Devel <linux-ide@vger.kernel.org>, Grant Grundler <grundler@google.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, LKML <linux-kernel@google.com>, Linux/MIPS Development <linux-mips@linux-mips.org>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

On Tuesday 31 March 2009, KOBAYASHI Yoshitake wrote:
> 2009/03/31 16:51, Geert Uytterhoeven wrote:
> > On Mon, 30 Mar 2009, Grant Grundler wrote:
> >> Followup to "[PATCH 03/10] ide: destroy DMA mappings after ending DMA"
> >> email on March 14th:
> >>     http://lkml.org/lkml/2009/3/14/17
> >>
> >> No maintainer is listed for "Toshiba CELL Reference Set IDE" (BLK_DEV_CELLEB)
> >> or tx4939ide.c in MAINTAINERS. I've CC'd "Ishizaki Kou" @Toshiba (Maintainer for
> >> "Spidernet Network Driver for CELL") and linuxppc-dev list in the hope
> >> someone else
> >> would know or would be able to ACK this patch.
> > 
> > tx49xx is MIPS, for Nemoto-san.
> 
> The patch looks good for Toshiba Cell Reference Set.

Great, I applied the patch.

Thanks,
Bart
