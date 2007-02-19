From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: interrupt status fixes (resend)
Date: Tue, 20 Feb 2007 00:04:34 +0100
Message-ID: <200702200004.34768.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702151653.00416.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:34455 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965157AbXBSW6c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 17:58:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2555377nfa
        for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2007 14:58:31 -0800 (PST)
In-Reply-To: <200702151653.00416.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Thursday 15 February 2007 14:53, Sergei Shtylyov wrote:
> The driver's ide_dma_test_irq() method was reading the MRDMODE register even on
> PCI0643/6 where it was write-only -- fix this by always reading the "backward-
> compatible" interrupt bits, renaming dma_alt_stat to irq_stat as these interrupt
> status bits are not coupled to DMA.
> In addition, wrong interrupt bit was tested/cleared for the primary channel --
> it's bit 2 in all the chip specs and the driver used bit 1... :-/
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
