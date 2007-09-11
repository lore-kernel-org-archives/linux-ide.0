From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide: make ide_rate_filter() also respect PIO and SW/MW DMA mode masks (take 2)
Date: Tue, 11 Sep 2007 22:52:02 +0200
Message-ID: <200709112252.02576.bzolnier@gmail.com>
References: <200709022344.18565.sshtylyov@ru.mvista.com> <46E2900D.5010004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:27656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbXIKVkM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1156nfb
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:10 -0700 (PDT)
In-Reply-To: <46E2900D.5010004@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Saturday 08 September 2007, Sergei Shtylyov wrote:
> Once I quothed:
> 
> > Make ide_rate_filter() also respect PIO/SWDMA/MWDMA mode masks.  While at it,
> > make the udma_filter() method calls take precedence over using the mode masks.
> 
>     This one not looking to pretty -- I've geve some thought on how to 
> beautify all these switch fallthoughs but haven't got something much better 
> then uour original approach (AKA Occam's razor :-).

Care to recast the patch to contain only udma_filter() part?

BTW ide_rate_filter() still lacks respecting PIO limits of the device
(Occam's razor doesn't apply to "PIO side" of ide_rate_filter() ;-)

Thanks,
Bart
