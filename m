From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] cmd64x: interrupt status fixes (take 2)
Date: Mon, 23 Apr 2007 23:52:38 +0200
Message-ID: <200704232352.38601.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702151653.00416.sshtylyov@ru.mvista.com> <200704142317.41365.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:32073 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbXDWWaP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 18:30:15 -0400
Received: by ug-out-1314.google.com with SMTP id 44so51007uga
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 15:30:13 -0700 (PDT)
In-Reply-To: <200704142317.41365.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 April 2007, Sergei Shtylyov wrote:
> The driver's ide_dma_test_irq() method was reading the MRDMODE register even on
> PCI0643/6 where it was write-only -- fix this by always reading the "backward-
> compatible" interrupt bits, renaming dma_alt_stat to irq_stat as the interrupt
> status bits are not coupled to DMA.
> In addition, wrong interrupt bit was tested/cleared for the primary channel --
> it's bit 2 in all the chip specs and the driver used bit 1... :-/
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> ---
> This is an update due to patch order changes.  Has also been tested on PCI-649.

applied
