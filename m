From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 2.6.29-rc2] palm_bk3710 buildfix
Date: Mon, 19 Jan 2009 13:07:33 +0100
Message-ID: <200901191307.33405.bzolnier@gmail.com>
References: <200901180833.53969.david-b@pacbell.net> <49743B36.90909@ru.mvista.com> <4974408A.9050608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:43416 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759761AbZASM6r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 07:58:47 -0500
Received: by fxm13 with SMTP id 13so533812fxm.13
        for <linux-ide@vger.kernel.org>; Mon, 19 Jan 2009 04:58:45 -0800 (PST)
In-Reply-To: <4974408A.9050608@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-ide@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Monday 19 January 2009, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>>> Someone should fix hw_regs_t to neither be a typedef, nor
> >>>> use "unsigned long" where it should use "void __iomem *".
> >>>>       
> >>>     It cannot use pointers of course -- as the addresses can be I/O 
> >>> ports.
> >>>     
> >>
> >> It could use the ioread*() calls, which take pointers
> >> and handle both types of I/O in a type-safe manner.
> >>   
> >
> >   Probably they can... though using those would only slow down 
> > register access on x86.
> 
>    ... and cause code bloat due to switching to real function calls from 
> inlines which now should render into in/out isns.

OTOH it would allow to unify a lot of 'if (hwif->host_flags & IDE_HFLAG_MMIO)'
cases so the code may even shrink.  I also suspect that register access slow
down is most likely negligable (we can always measure and check it).

The real reason for not using ioread*() and co. is that not all archs support
them (though I checked some time ago, maybe they do now?) and we don't want to
break IDE support for them.

Thanks,
Bart
