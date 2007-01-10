From: Michael Bueker <m.bueker@berlin.de>
Subject: Re: No DMA with HTP370 IDE controller
Date: Wed, 10 Jan 2007 01:38:59 +0100
Message-ID: <45A435A3.2020506@berlin.de>
References: <45A29690.3040003@berlin.de>	 <58cb370e0701081155j7376d15dv32e3b65906c8d325@mail.gmail.com>	 <45A35A8C.9040200@berlin.de> <58cb370e0701090544p2a851182m30f24e0fdd86f328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waikiki.ops.eusc.inter.net ([84.23.254.155]:56318 "EHLO
	waikiki.ops.eusc.inter.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932498AbXAJAje (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jan 2007 19:39:34 -0500
In-Reply-To: <58cb370e0701090544p2a851182m30f24e0fdd86f328@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Have you looked at changes to drivers/ide/pci/hpt366.c?
> The code is not the same, there are a lot of fixes in -mm:
> 
> hpt3xx-rework-rate-filtering.patch
> hpt3xx-rework-rate-filtering-tidy.patch
> hpt3xx-print-the-real-chip-name-at-startup.patch
> hpt3xx-switch-to-using-pci_get_slot.patch
> hpt3xx-cache-channels-mcr-address.patch
> hpt3x7-merge-speedproc-handlers.patch
> hpt370-clean-up-dma-timeout-handling.patch
> hpt3xx-init-code-rewrite.patch

I applied all of these patches, but the errors remains just the same. I 
actually did it twice to be sure, but to no avail.

~Mik

-- 
Hey Fred, did you save that posting about restoring filesystems
with vi and a toothpick? More importantly, did you print it out?
- From "101 Things You Don't Want To Hear Your Admin Say"
