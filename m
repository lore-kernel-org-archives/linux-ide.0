From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/11] it8213/piix/slc90e66: remove {it8213,piix,slc90e66}_dma_2_pio()
Date: Thu, 9 Aug 2007 21:40:22 +0200
Message-ID: <200708092140.22179.bzolnier@gmail.com>
References: <200708042206.22546.bzolnier@gmail.com> <46B5F305.5040206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:48944 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbXHIUP6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 16:15:58 -0400
Received: by nf-out-0910.google.com with SMTP id g13so163750nfb
        for <linux-ide@vger.kernel.org>; Thu, 09 Aug 2007 13:15:57 -0700 (PDT)
In-Reply-To: <46B5F305.5040206@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Sunday 05 August 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>     Sigh... when I was talking about getting rid of that function, I meant 
> that we need to also decouple UltraDMA from PIO -- which is what this patch 
> misses...

Addressed in the follow-up patch.

>     Actually, I intended to decouple DMA form PIO in this drivers completely 
> but that would be a next step...

DMA and PIO timings are shared on these controllers (except when DTE bit is
set, then PIO0 timings are always used and DMA timings are independent)...?

Bart
