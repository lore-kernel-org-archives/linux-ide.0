From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable
 detection in pata_via and pata_amd
Date: Fri, 2 Nov 2007 23:45:45 +0000
Message-ID: <20071102234545.61353ce1@the-village.bc.nu>
References: <472B402A.4030009@gmail.com>
	<472B4078.90009@gmail.com>
	<20071102154215.1a93249c@the-village.bc.nu>
	<472BA249.6000107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57465 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752602AbXKBXoj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 19:44:39 -0400
In-Reply-To: <472BA249.6000107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> GTM results do change whether you call STM or not.  GTM in many cases is
> implemented as reading the current configuration value from the
> controller so if you configure PIO0, it will return PIO0 timings.  And,
> yeah, on ASUS A8N-E, if you configure PIO0, GTM answer says DMA is off.

Oh fun - ok then we do need to cache it.

> What the function answers is not actually cable type but "according to
> the current configuration, using this cable type won't violate BIOS
> configuration" kind of answer.  How the caller is to use that is the
> caller's responsibility.

How does the caller make use of it ? The only way I can think of to use
it is that if either drive says UDMA > 33 then we know its 80 wire.
Otherwise we can't really prove anything. And if neither drive says > 80
wire we have to go on what other info we have, which for NVidia appears
to be "guess 40".

I'm not sure therefore we gain anything ?
