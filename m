From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] libata: blacklist NCQ on WDC WD740ADFD-00NLR4
Date: Wed, 18 Jan 2012 11:38:26 +0000
Message-ID: <20120118113826.7fc60f12@pyramind.ukuu.org.uk>
References: <201201181038.30271.srowe@mose.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60345 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab2ARLhM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2012 06:37:12 -0500
In-Reply-To: <201201181038.30271.srowe@mose.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Simon J. Rowe" <srowe@mose.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Jan 16 21:17:08 gilraen kernel: ata5: SError: { UnrecovData Handshk }
> Jan 16 21:17:08 gilraen kernel: ata5.00: failed command: WRITE DMA EXT
> Jan 16 21:17:08 gilraen kernel: ata5.00: cmd 
> 35/00:68:6f:5d:9a/00:01:00:00:00/e0 tag 0 dma 184320 out
> Jan 16 21:17:08 gilraen kernel:         res 
> 50/00:00:66:5d:9a/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
> Jan 16 21:17:08 gilraen kernel: ata5.00: status: { DRDY }
> Jan 16 21:17:08 gilraen kernel: ata5: hard resetting link
> Jan 16 21:17:08 gilraen kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 
> SControl 300)
> Jan 16 21:17:08 gilraen kernel: ata5.00: configured for UDMA/133
> Jan 16 21:17:08 gilraen kernel: ata5: EH complete
> 
> Googling revealed that this is often caused by faulty cabling. I moved the 
> power and SATA cables and the problem has now gone but I think the disk should 
> still be added to the blacklist,

We add things to the NCQ blacklist because we have multiple clear cases
showing NCQ problems and preferably vendor confirmation. You have neither
and as you said yourself when you fixed the cables it went away.

Your drive is report UnrecovData Handshk, and its' reporting it on a non
NCQ command in your second example. You had a cable problem.

So NAK this patch

Alan


