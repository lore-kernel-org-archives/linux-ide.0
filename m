From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/8] alim15x3: PIO fallback fix
Date: Sat, 18 Aug 2007 21:18:23 +0200
Message-ID: <200708182118.23591.bzolnier@gmail.com>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain> <46C6F90E.203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:64080 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757126AbXHRTTS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:19:18 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1246508mue
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 12:19:13 -0700 (PDT)
In-Reply-To: <46C6F90E.203@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 18 August 2007, you wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > [PATCH] alim15x3: PIO fallback fix
> 
> > If DMA tuning fails always set the best PIO mode.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>     Oh, it's belated now. :-/

a bit ;)

>     BTW, I'm going to hack on this driver since I've acquired a board with 
> M1543C chip (that one for which there was an urgent bug that I had to fix some 
> weeks ago :-)...

Cool, this driver still have much room for an improvement i.e. it lacks proper
MWDMA support and would greatly benefit from using ide_timing_compute()...

Bart
