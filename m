From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Sat, 13 Sep 2008 22:37:03 +0900 (JST)
Message-ID: <20080913.223703.108120497.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
	<20080911.000649.39154743.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:61347 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbYIMNgy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Sep 2008 09:36:54 -0400
In-Reply-To: <20080911.000649.39154743.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org, sshtylyov@ru.mvista.com

On Thu, 11 Sep 2008 00:06:49 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The dmatable_cpu is allocated by pci_alloc_consistent so that flush is
> not needed.  But... this is not PCI device.  I should not use
> ide_allocate_dma_engine().  I'll fix it.

Fortunately such a fix will not be needed.  A patch making
ide_allocate_dma_engine() independent from PCI already posted (
"[PATCH 4/8] ide: switch to DMA-mapping API part 2").  I can use
ide_allocate_dma_engine() with non-PCI device safely.  Thanks.

---
Atsushi Nemoto
