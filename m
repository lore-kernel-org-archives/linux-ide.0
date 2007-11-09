From: Tejun Heo <htejun@gmail.com>
Subject: Re: SC1200 failure in 2.6.23 and 2.6.24-rc1-git10
Date: Fri, 09 Nov 2007 10:44:31 +0900
Message-ID: <4733BB7F.8010004@gmail.com>
References: <20071101213013.M54162@visp.net.lb> <20071107232045.GA26706@havoc.gtf.org> <20071107235548.M95675@visp.net.lb> <200711080130.54143.bzolnier@gmail.com> <20071108071204.M66693@visp.net.lb> <20071108104813.78ca4d65@the-village.bc.nu> <20071108164320.M82021@visp.net.lb> <20071108173139.GA1932@havoc.gtf.org> <20071108195605.M20599@visp.net.lb>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:58673 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbXKIBon (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 20:44:43 -0500
Received: by wa-out-1112.google.com with SMTP id v27so445155wah
        for <linux-ide@vger.kernel.org>; Thu, 08 Nov 2007 17:44:42 -0800 (PST)
In-Reply-To: <20071108195605.M20599@visp.net.lb>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Fedoryshchenko <denys@visp.net.lb>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, James Andrewartha <jamesa@daa.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Denys Fedoryshchenko wrote:
> Thanks, it works like that.
> 
> Seems in libata there is no fall-back to non-DMA mode, if DMA didn't work.

There is, it's just too conservative about that.  With improvements
pending for 2.6.24, it should be quite snappy at falling back to PIO if
configured transfer mode doesn't seem to work at all (consecutive IO
command failures after transfer mode configuration change).

-- 
tejun
