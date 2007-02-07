From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sl82c105: wrong assumptions about compatible PIO
 modes
Date: Tue, 06 Feb 2007 19:37:19 -0500
Message-ID: <45C91F3F.1010300@garzik.org>
References: <200701302040.30895.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56899 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030352AbXBGAhW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 19:37:22 -0500
In-Reply-To: <200701302040.30895.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Sergei Shtylyov wrote:
> Fix the wrong "compatible" PIO mode choices: MWDMA0 has 480 ns cycle while PIO1
> only has 383 ns cycle, and MWDMA2 timings matchs those of PIO4 exactly.
> 
> ---
> Frankly speaking, I'm not sure this function is useful or correct at all --
> with the DMA timings being actually programmed in sl82c105_bmdma_start()...
> 
> And the issue of the same registers being used for both PIO and DMA timings is
> not specific for this driver at all but seems to be addressed only by it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>  drivers/ata/pata_sl82c105.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

applied

