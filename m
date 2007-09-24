From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide: make ide_rate_filter() also respect PIO and SW/MW DMA mode masks (take 2)
Date: Mon, 24 Sep 2007 20:48:00 +0200
Message-ID: <200709242048.00192.bzolnier@gmail.com>
References: <200709022344.18565.sshtylyov@ru.mvista.com> <46E2900D.5010004@ru.mvista.com> <46F7B117.5000202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:49201 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064AbXIXSoo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 14:44:44 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1457703nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 11:44:43 -0700 (PDT)
In-Reply-To: <46F7B117.5000202@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 24 September 2007, Sergei Shtylyov wrote:
> Once I quothed:
> 
> >> Make ide_rate_filter() also respect PIO/SWDMA/MWDMA mode masks.  While 
> >> at it,
> >> make the udma_filter() method calls take precedence over using the 
> >> mode masks.
> 
> >    This one not looking to pretty -- I've geve some thought on how to 
> > beautify all these switch fallthoughs but haven't got something much 
> > better then uour original approach (AKA Occam's razor :-).
> 
>     So, it's probably better forget about this patch. But please do take patch 
> 4/4 to merge either before or after your "Occam's razor" -- it makes its best 
> at masking out the MWDMA modes anyways...

Sure, could you re-send patch 4/4 synced against current Linus' tree?

Thanks,
Bart
