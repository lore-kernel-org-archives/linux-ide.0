From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/11] au1xxx-ide: use ide_tune_dma()
Date: Fri, 10 Aug 2007 23:58:25 +0200
Message-ID: <200708102358.25715.bzolnier@gmail.com>
References: <200708042206.57529.bzolnier@gmail.com> <200708090057.13155.bzolnier@gmail.com> <46BCB86A.1010107@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:47118 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbXHJV6w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:58:52 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1242939mue
        for <linux-ide@vger.kernel.org>; Fri, 10 Aug 2007 14:58:49 -0700 (PDT)
In-Reply-To: <46BCB86A.1010107@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 10 August 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>    Good, that's what I lacked for hpt366.c!  Were you planning to push it to 
> >>Linus soon?
> 
> > Not really but if needed I will extract MWDMA filter part and push it sooner.
> 
>     Erm, may I just merge it to my patch (mentioning you of course)?

Sure.

> > I planned to cc: AU1XXX platform maintainers on this patch but to my
> > surprise MAINTAINERS lacks AU1XXX entry.
> 
>     It's been solt out to Raza Microelectronics last year and those guys never
> sent a single patch to linux-mips...

Thanks for the info.

Bart
