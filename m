From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA hotplug
Date: Wed, 22 Aug 2007 16:31:28 +0100
Message-ID: <20070822163128.2bc6e64e@the-village.bc.nu>
References: <20070819180611.7b83e476@the-village.bc.nu>
	<548551.9705.qm@web57903.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48426 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763939AbXHVPXV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 11:23:21 -0400
In-Reply-To: <548551.9705.qm@web57903.mail.re3.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Wakeman <prwakeman@yahoo.com>
Cc: linux-ide@vger.kernel.org

> My target is an embedded SoC which has PATA autodetect support.

Nice.

> First, I need to convert the vendor-supplied legacy IDE driver to a
> PATA platform driver. Can you recommend best-of-breed existing PATA
> drivers to use as a reference for this work? 

pata_platform is a dumb platform device driver and shows how to interface
to the platform layer. I'm guessing your hardware is a bit smarter in
which case you probably want to use pata_platform as a reference for
setting up platform class interfaces with arbitary port mappings and
something like pata_amd to see how the various cable detect, dma and pio
timing functions can be used.

If you've got hardware which supports master/slave but only single timing
registers take a look at the code in pata_oldpiix and the
oldpiix_qc_issue_prot function for how to do timing switching according
to the device, and pata_atiixp is a worked example of how to do clock
switching on the start/end of DMA operations.

Any other questions just ask
