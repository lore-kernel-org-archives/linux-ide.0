From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_sl82c105: wrong assumptions about compatible PIO
 modes
Date: Tue, 30 Jan 2007 22:08:12 +0300
Message-ID: <45BF979C.80200@ru.mvista.com>
References: <200701302040.30895.sshtylyov@ru.mvista.com> <20070130190759.3d941365@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:34740 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750896AbXA3TIP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 14:08:15 -0500
In-Reply-To: <20070130190759.3d941365@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

Alan wrote:

>>Fix the wrong "compatible" PIO mode choices: MWDMA0 has 480 ns cycle while PIO1
>>only has 383 ns cycle, and MWDMA2 timings matchs those of PIO4 exactly.

> Thanks for all this review work

    Oh, I've only started but there's too much to do elsewhere... :-)

>>Frankly speaking, I'm not sure this function is useful or correct at all --
>>with the DMA timings being actually programmed in sl82c105_bmdma_start()...

> It ought to be right
> - bmdma_start loads the real DMA mode
> - set_dmamode/set_piomode load the right PIO timings

    You just said set_piomode() is called before set_dmamode() by the libata 
core anyway -- there seems to be no point in re-writing the modes until the 
actual DMA is started.

> - bmdma_stop restores the right PIO timings

>>And the issue of the same registers being used for both PIO and DMA timings is
>>not specific for this driver at all but seems to be addressed only by it...

> For most drivers (those using the ata_timing interface) the timing merge
> is done by ata_timing_compute(). 

    Ah...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Acked-by: Alan Cox <alan@redhat.com>

MBR, Sergei
