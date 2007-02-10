From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: remove broken SW/MW DMA support
Date: Sat, 10 Feb 2007 01:11:55 +0100
Message-ID: <200702100111.55257.bzolnier@gmail.com>
References: <200702080858.l188wjmG008432@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:36423 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423377AbXBJAGr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 19:06:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1386506nfa
        for <linux-ide@vger.kernel.org>; Fri, 09 Feb 2007 16:06:46 -0800 (PST)
In-Reply-To: <200702080858.l188wjmG008432@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: sshtylyov@ru.mvista.com, linux-ide@vger.kernel.org


On Thursday 08 February 2007 09:58, Mikael Pettersson wrote:
> On Thu, 8 Feb 2007 00:00:32 +0300, Sergei Shtylyov wrote:
> >Remove the bogus code pretending to set SW/MW DMA timings -- I wonder whether
> >its author really thought that he could achieve that wrtiting to BMIDE status
> >registers?  Stop fiddling with the DMA capable bits in the speedproc() -- they
> >do not enable DMA, and are properly dealt with by the dma_host_{on,off} methods;
> >also, get rid of the duplicate reads/writes of UDIDETCRx registers, and do some
> >coding style and whitespace changes while at it...
> >
> >Unfortunately, fixing the SW/MW DMA support would requre a major driver rewrite
> >along with some more fixing, so I'm putting it off...
> >
> >Warning: this has been compile-tested only.
> 
> Worked fine on my SPARC Ultra5.

thanks, applied
