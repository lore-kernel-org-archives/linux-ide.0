From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Tue, 19 Jun 2007 18:24:38 +0400
Message-ID: <4677E726.1080602@ru.mvista.com>
References: <20070618175713.GD5836@austin.ibm.com>	<20070618212704.394912b8@the-village.bc.nu>	<20070618204601.GF5836@austin.ibm.com>	<20070618220441.3a3af8ca@the-village.bc.nu>	<4677E3BC.3040307@ru.mvista.com> <20070619151919.79c79af1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37739 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752516AbXFSOWz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jun 2007 10:22:55 -0400
In-Reply-To: <20070619151919.79c79af1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linas Vepstas <linas@austin.ibm.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:

>>>>I can prepare a patch, but only with a lot of guidance. I can test 
>>>>& debug, I'm highly motivated just right now ... 

>>>If you've got a nice repeatable problem please try using the libata
>>>driver. That handles the error paths differently and doesn't try a FIFO
>>>drain which might matter in this case I guess.

>>    FIFO drain for DMA commands?

> Welcome to the old IDE layer which I am so glad I left behind 8)

> ide_ata_error will try and do a PIO flush regardless of the command type
> if DRQ_STAT is asserted. See ide_dma_intr -> ide_error -> ...

    Indeed... but the thing is we don't know what's asserted in this case -- 
remember, it's reading the status register that locks everything up...

> Alan

MBR, Sergei
