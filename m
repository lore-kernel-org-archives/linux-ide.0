From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] pdc202xx_old: ignore "FIFO empty" bit in
 test_irq() method
Date: Thu, 22 Apr 2010 19:12:36 -0700 (PDT)
Message-ID: <20100422.191236.183038347.davem@davemloft.net>
References: <201004141952.59445.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40562
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754475Ab0DWCMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 22:12:31 -0400
In-Reply-To: <201004141952.59445.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org, rmk@arm.linux.org.uk

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Wed, 14 Apr 2010 19:52:59 +0400

> The driver takes into account not only the interrupt status bit but also "FIFO
> empty" bit in its test_irq() method. This actually is a superfluous check since
> for the DMA commands calling the dma_test_irq() method further in the interrupt
> handler makes sure FIFO is emptied.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is atop of ide-2.6.git tree...
> 
> Russell, would you mind giving this patch a test?

Applied, but I don't want to push this out until there is
positive testing from Russell.

Russell, please test Sergei's patch, thanks!
