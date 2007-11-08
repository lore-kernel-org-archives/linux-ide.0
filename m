From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SC1200 failure in 2.6.23 and 2.6.24-rc1-git10
Date: Thu, 8 Nov 2007 12:31:39 -0500
Message-ID: <20071108173139.GA1932@havoc.gtf.org>
References: <20071101213013.M54162@visp.net.lb> <20071107232045.GA26706@havoc.gtf.org> <20071107235548.M95675@visp.net.lb> <200711080130.54143.bzolnier@gmail.com> <20071108071204.M66693@visp.net.lb> <20071108104813.78ca4d65@the-village.bc.nu> <20071108164320.M82021@visp.net.lb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:41783 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760678AbXKHRbk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 12:31:40 -0500
Content-Disposition: inline
In-Reply-To: <20071108164320.M82021@visp.net.lb>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Fedoryshchenko <denys@visp.net.lb>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, James Andrewartha <jamesa@daa.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com

On Thu, Nov 08, 2007 at 06:44:31PM +0200, Denys Fedoryshchenko wrote:
> Doesn't help
> 
> WRAP ~ #cat /proc/cmdline
> console=ttyS0,38400n8 libata.dma_mask=3

It's "libata.dma" if its built into the kernel, or 'dma' module option
if built as a kernel module.

	Jeff



