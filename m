From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sl82c105: wrong assumptions about compatible PIO
 modes
Date: Tue, 30 Jan 2007 19:07:59 +0000
Message-ID: <20070130190759.3d941365@localhost.localdomain>
References: <200701302040.30895.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33694 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750910AbXA3S4K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 13:56:10 -0500
In-Reply-To: <200701302040.30895.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 30 Jan 2007 20:40:30 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Fix the wrong "compatible" PIO mode choices: MWDMA0 has 480 ns cycle while PIO1
> only has 383 ns cycle, and MWDMA2 timings matchs those of PIO4 exactly.

Thanks for all this review work

> Frankly speaking, I'm not sure this function is useful or correct at all --
> with the DMA timings being actually programmed in sl82c105_bmdma_start()...

It ought to be right
- bmdma_start loads the real DMA mode
- set_dmamode/set_piomode load the right PIO timings
- bmdma_stop restores the right PIO timings

> And the issue of the same registers being used for both PIO and DMA timings is
> not specific for this driver at all but seems to be addressed only by it...

For most drivers (those using the ata_timing interface) the timing merge
is done by ata_timing_compute(). 

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Alan Cox <alan@redhat.com>

