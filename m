From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: remove broken SW/MW DMA support
Date: Fri, 16 Feb 2007 15:42:16 +0100
Message-ID: <200702161542.16883.bzolnier@gmail.com>
References: <200702080858.l188wjmG008432@harpo.it.uu.se> <45D5AD8B.1060702@ru.mvista.com> <45D5B420.7040509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:5218 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161001AbXBPOg0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 09:36:26 -0500
Received: by wr-out-0506.google.com with SMTP id i31so1121661wra
        for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 06:36:25 -0800 (PST)
In-Reply-To: <45D5B420.7040509@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Friday 16 February 2007 14:39, Sergei Shtylyov wrote:
> Hello.
> 
> Sergei Shtylyov wrote:
> 
> >    The intent of the patch was exactly to *remove* broken DMA support 
> > until it's fixed (which requires more work).  It only worked by chance 
> > -- because MWDMA2 timings are the same as of PIO4.  Have patience please.
> 
>     You may also consider switching to the libata driver -- Alan said he fixed 
> DMA support there after I frisrt reported the breakage (however, I' still not 
> seeing it fixed in the mainline)...

I've just checked 2.6.20-mm1 (contains libata tree) and it is not fixed.

Bart
