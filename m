From: "Denys Fedoryshchenko" <denys@visp.net.lb>
Subject: Re: SC1200 failure in 2.6.23 and 2.6.24-rc1-git10
Date: Thu, 8 Nov 2007 21:56:32 +0200
Message-ID: <20071108195605.M20599@visp.net.lb>
References: <20071101213013.M54162@visp.net.lb> <20071107232045.GA26706@havoc.gtf.org> <20071107235548.M95675@visp.net.lb> <200711080130.54143.bzolnier@gmail.com> <20071108071204.M66693@visp.net.lb> <20071108104813.78ca4d65@the-village.bc.nu> <20071108164320.M82021@visp.net.lb> <20071108173139.GA1932@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=koi8-r
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usermail.globalproof.net ([194.146.153.18]:36950 "EHLO
	usermail.globalproof.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759541AbXKHT4x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 14:56:53 -0500
In-Reply-To: <20071108173139.GA1932@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, James Andrewartha <jamesa@daa.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com

Thanks, it works like that.

Seems in libata there is no fall-back to non-DMA mode, if DMA didn't work.

On Thu, 8 Nov 2007 12:31:39 -0500, Jeff Garzik wrote
> On Thu, Nov 08, 2007 at 06:44:31PM +0200, Denys Fedoryshchenko wrote:
> > Doesn't help
> > 
> > WRAP ~ #cat /proc/cmdline
> > console=ttyS0,38400n8 libata.dma_mask=3
> 
> It's "libata.dma" if its built into the kernel, or 'dma' module 
> option if built as a kernel module.
> 
> 	Jeff


--
Denys Fedoryshchenko
Technical Manager
Virtual ISP S.A.L.

