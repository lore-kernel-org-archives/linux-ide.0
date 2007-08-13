From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_artop: fix UDMA5 for AEC6280[R] and UDMA6 for
 AEC6880[R]
Date: Mon, 13 Aug 2007 14:30:32 +0100
Message-ID: <20070813143032.4caffc28@the-village.bc.nu>
References: <200708121153.l7CBrsm5011470@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60589 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S972837AbXHMNXT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 09:23:19 -0400
In-Reply-To: <200708121153.l7CBrsm5011470@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: mikpe@it.uu.se, bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > It would be nice to know why - is the cable detet coming out right on
> > this ?
> 
> The box has a short 40-wire cable, so pata_artop drops to udma/33
> while aec62xx does udma/100 without intervention. I added an override

Curious as both use the same cable detect logic. 

> to artop6260_cable_detect() to make it return PATA40_SHORT on this
> platform, and with that it does udma/100 as expected.

Patch would be good. Looks like there are a couple of cases anyway where
artop needs platform specific uglies


> 
> Read performance fluctuates quite a bit, but seems to be 1-3 MB/s
> slower than aec62xx on average. I compared lspci -vvxxx and the
> only differences are a latency setting and some ROM thingy:

Latency shouldn't matter but you can tweak the driver to verify easily
enough
