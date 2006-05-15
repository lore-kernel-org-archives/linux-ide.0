From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105
	interfaces
Date: Mon, 15 May 2006 16:25:16 +0100
Message-ID: <1147706716.26686.64.camel@localhost.localdomain>
References: <20051112165548.GB28987@flint.arm.linux.org.uk>
	 <1131818615.18258.6.camel@localhost.localdomain>
	 <446890F0.3020408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58830 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964967AbWEOPMu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 11:12:50 -0400
In-Reply-To: <446890F0.3020408@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 18:32 +0400, Sergei Shtylyov wrote:
>     Heh, this driver also tries to cache the single PCI register per-channel 
> like hpt366.c... This buglet concerns using fast PIO timings and is probably 
> harmless though but needs to be fixed -- I'll send a patch soon...
>     I wonder what is otherwise wrong with using 2 channels concurrently?

I've not got any dual channel devices to test, and in fact I couldn't
find anyone with dual channel stuff at all. The caching is one bug, the
fact the reset hits both channels is the other I know about.

Otherwise the libata driver is fairly similar although the timing is
pre-computed from the documentation for the DMA modes.

Alan
