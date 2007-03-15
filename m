From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] cmd64x: fix recovery time calculation (take 3)
Date: Thu, 15 Mar 2007 21:29:04 +0100
Message-ID: <200703152129.04688.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702262332.31751.sshtylyov@ru.mvista.com> <200703032317.10173.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:38153 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbXCOWMd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 18:12:33 -0400
Received: by ug-out-1314.google.com with SMTP id 44so515765uga
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 15:12:32 -0700 (PDT)
In-Reply-To: <200703032317.10173.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Saturday 03 March 2007, Sergei Shtylyov wrote:
> [PATCH] cmd64x: fix recovery time calculation
> 
> The driver wrongly takes the address setup time into account when calculating
> the PIO recovery time -- this leads to slight overclocking of the PIO modes 0
> and 1 (so, the prayers failed to help, as usual :-).  Rework the code to be
> calculating recovery clock count as a difference between the total cycle count
> and the active count (we don't need to calculate the recovery time itself since
> it's not specified for the PIO modes 0 to 2, and for modes 3 and 4 this formula
> gives enough recovery time anyway in the chip's supported PCI frequency range).
> 
> This patch has been inspired by reading the datasheets and looking at what the
> libata driver does; it has been compile-tested only (as usual :-) but anyway,
> the new code gives the same or longer recovery times than the old one...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> ---
> This patch has been changed in accordance to the pending reordering as DMA
> support removal and addition patches are going to be merged.  In addition,
> I've put quantize_timing() to its proper place to avoid moving it later...

thanks, I replaced the old patch with this one
