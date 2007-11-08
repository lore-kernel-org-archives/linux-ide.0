From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SC1200 failure in 2.6.23 and 2.6.24-rc1-git10
Date: Thu, 8 Nov 2007 22:40:43 +0000
Message-ID: <20071108224043.4e0bd7b6@the-village.bc.nu>
References: <20071101213013.M54162@visp.net.lb>
	<20071107232045.GA26706@havoc.gtf.org>
	<20071107235548.M95675@visp.net.lb>
	<200711080130.54143.bzolnier@gmail.com>
	<20071108071204.M66693@visp.net.lb>
	<20071108104813.78ca4d65@the-village.bc.nu>
	<20071108164320.M82021@visp.net.lb>
	<20071108173139.GA1932@havoc.gtf.org>
	<20071108195605.M20599@visp.net.lb>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56754 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751552AbXKHWlD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 17:41:03 -0500
In-Reply-To: <20071108195605.M20599@visp.net.lb>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Fedoryshchenko <denys@visp.net.lb>
Cc: Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, James Andrewartha <jamesa@daa.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com

On Thu, 8 Nov 2007 21:56:32 +0200
"Denys Fedoryshchenko" <denys@visp.net.lb> wrote:

> Thanks, it works like that.
> 
> Seems in libata there is no fall-back to non-DMA mode, if DMA didn't work.


It should be falling back from UDMA or MWDMA to PIO, if not please file a
bug

Alan
