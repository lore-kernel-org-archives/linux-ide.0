From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] [libata] Set proper ATA UDMA mode for bf548 according
 to	system clock.
Date: Sat, 01 Dec 2007 17:36:45 -0500
Message-ID: <4751E1FD.60206@garzik.org>
References: <1196138859.6974.2.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41907 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbXLAWgr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 17:36:47 -0500
In-Reply-To: <1196138859.6974.2.camel@eight.analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sonic zhang <sonic.adi@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

sonic zhang wrote:
> UDMA Mode - Frequency compatibility
> 
> UDMA5 - 100 MB/s   - SCLK  = 133 MHz
> UDMA4 - 66 MB/s    - SCLK >=  80 MHz
> UDMA3 - 44.4 MB/s  - SCLK >=  50 MHz
> UDMA2 - 33 MB/s    - SCLK >=  40 MHz
> 
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/ata/pata_bf54x.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)

applied #upstream-fixes


