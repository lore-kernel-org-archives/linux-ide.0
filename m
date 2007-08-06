From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/11] atiixp: DMA setup fixes
Date: Mon, 06 Aug 2007 18:58:17 +0400
Message-ID: <46B73709.8080509@ru.mvista.com>
References: <200708042205.37590.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:9492 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755719AbXHFO4P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Aug 2007 10:56:15 -0400
In-Reply-To: <200708042205.37590.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Fix handling of unsupported/invalid modes in atiixp_set_dma_mode().

> * ATI controllers allow separate PIO and DMA timings so remove programming
>   of PIO modes from atiixp_set_dma_mode().  Also remove no longer needed
>   atiixp_dma_2_pio() helper.

    Why they copied it over from the piix.c in the firs place?! Oh, the human 
laziness (an cluelessness too)! :-(

> * SWDMA timings are not programmed by atiixp_set_dma_mode() and if SWDMA
>   mode is chosen atiixp_dma_host_on() erroneously enables UDMA, just disable
>   support for SWDMA modes for now.

> * Enable support for MWDMA0 mode.

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
