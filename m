From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] IDE update
Date: Wed, 09 May 2007 19:15:50 -0400
Message-ID: <46425626.1020208@garzik.org>
References: <200705100046.05280.bzolnier@gmail.com>	<46424F7B.8060004@garzik.org> <20070509155912.20596814.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49943 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756724AbXEIXPx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 19:15:53 -0400
In-Reply-To: <20070509155912.20596814.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Andrew Morton wrote:
> Jeff Garzik <jeff@garzik.org> wrote:
>> Has this seen testing/exposure in -mm tree?
>>
> 
> argh.  If this was in a file called
> ide-rework-the-code-for-selecting-the-best-DMA-transfer-mode.patch then it
> would be so easy.
> 
> <logs into hera>
> 
> <greps>
> 
> ah, it's hidden in ide-max-dma-mode-v3.patch.
> 
> akpm:/usr/src/25> grep ide-max-dma-mode-v3 pc/*series
> pc/2.6.21-mm1-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-mm2-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-rc2-mm2-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-rc3-mm1-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-rc3-mm2-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-rc4-mm1-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-rc5-mm3-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-rc5-mm4-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-rc6-mm1-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-rc7-mm1-series:ide-ide-max-dma-mode-v3.patch
> pc/2.6.21-rc7-mm2-series:ide-ide-max-dma-mode-v3.patch
> 
> No probs.

Cool beans.  I'm happy then.

	Jeff



