From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH][pata-2.6 tree] pdc202xx_old: rewrite mode programming code
Date: Mon, 5 Mar 2007 23:08:36 +0100
Message-ID: <200703052308.36887.bzolnier@gmail.com>
References: <200703040149.46186.bzolnier@gmail.com> <45EC82BB.8000709@ru.mvista.com> <45EC8713.5060304@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:2339 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXCEWB4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Mar 2007 17:01:56 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2248256nfa
        for <linux-ide@vger.kernel.org>; Mon, 05 Mar 2007 14:01:54 -0800 (PST)
In-Reply-To: <45EC8713.5060304@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Monday 05 March 2007, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >> official == same as in the docs and vendor driver :-)
> 
> >>>    Erm, those look a bit doubtful...
> 
> >> I believe that they are correct - please see explanations below.
> 
> >    Yeah, sorry about that. Only SWDMA timings are suspicious.
> 
>     Hm, too early to say sorry. I was hasty/distacted and forgot what I was 
> going to write... :-)
> 
> >>>> Index: b/drivers/ide/pci/pdc202xx_old.c
> >>>> ===================================================================
> >>>> --- a/drivers/ide/pci/pdc202xx_old.c
> >>>> +++ b/drivers/ide/pci/pdc202xx_old.c
> >>>
> >>> [...]
> 
> >>>> @@ -161,7 +95,7 @@ static int pdc202xx_tune_chipset (ide_dr
> >>>>         case XFER_UDMA_0:
> >>>>         case XFER_MW_DMA_2:    TB = 0x60; TC = 0x03; break;
> >>>>         case XFER_MW_DMA_1:    TB = 0x60; TC = 0x04; break;
> >>>> -        case XFER_MW_DMA_0:
> >>>> +        case XFER_MW_DMA_0:    TB = 0xE0; TC = 0x0F; break;
> 
> >>>    This seems even slower than SWDMA0!
> >>>    Let's assume that means 7 active cycles and 15 recovery cycles 
> >>> (MWDMA1/2 settings seem to confirm this hypothesis) -- this would 
> >>> give us 720 ns vs the specified 480. Could you shed some light on 
> >>> what these fields mean? :-/
> 
> >> The calculations are done in a different way so we get the correct 
> >> timings:
> 
> >>  7 cycles (== 210 ns) are used for active time
> 
>     Ugh, forgot to say: this is overclocked, 215 ns is the minimum active time 
> for this mode.

I know that is why I wrote in my previous mail:

"These timings are the maximum possible ones using MB[2:0] and MC[3:0]"

Driver can't do better than hardware and hopefully these 5 ns
are compensated somehow by the chipset (or not :-).

Bart
