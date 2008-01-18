From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Fri, 18 Jan 2008 23:20:14 +0100
Message-ID: <200801182320.15096.bzolnier@gmail.com>
References: <200801172150.57059.asalnikov@ru.mvista.com> <20080118150402.16a3a387@lxorguk.ukuu.org.uk> <4790E9FD.8060506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:46210 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762858AbYARWIe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 17:08:34 -0500
Received: by ug-out-1314.google.com with SMTP id z38so536791ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 14:08:33 -0800 (PST)
In-Reply-To: <4790E9FD.8060506@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Anton Salnikov <asalnikov@ru.mvista.com>, linux-ide@vger.kernel.org


On Friday 18 January 2008, Sergei Shtylyov wrote:
> Alan Cox wrote:
> 
> >>    It won't -- we can *not* call ide_setup_dma() which fills them out as this 
> >>is not a PCI chip.
> 
> > Gak.
> 
>     Or maybe we still can -- with hwif->mmio set?
>     AFAIR (from the 2006 discussion) Bart said it's *only* for PCI devices...

Well, since BLK_DEV_PALMCHIP_BK3710 selects BLK_DEV_IDEDMA_PCI it should be
possible to call ide_setup_dma() in this driver...

Bart
