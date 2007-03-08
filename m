From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [RFT] sata_promise: decode and report error reasons
Date: Thu, 8 Mar 2007 11:09:37 +0100
Message-ID: <17903.57569.139263.798351@alkaid.it.uu.se>
References: <200703010158.l211wXPS012467@harpo.it.uu.se>
	<45EB9DF4.20402@gmail.com>
	<17903.6217.992304.800959@alkaid.it.uu.se>
	<45EF40A5.70208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:39958 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932574AbXCHKJ5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Mar 2007 05:09:57 -0500
In-Reply-To: <45EF40A5.70208@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik writes:
 > > ATA_DMA_CNT_ERR is when a DMA FIS data size differs from total DMA S/G size.
 > > I think AC_ERR_ATA_BUS is the correct choice for this one too.
 > 
 > Where is this in the Promise docs, so that I can take a closer look?

Pages 38-39 in the PDC205xx development guide (my primary source),
page 32 in the PDC2037x guide, and pages 35-36 in the PDC20319 guide.

 > This condition sounds like overrun/underrun, something that would not 
 > occur outside of a driver bug?

I got overruns (or was it underruns?) when running a SATA300 TX2plus
with a 3Gbps disk in an UltraSPARC box, which were "cured" by hacking
SControl to limit speeds to 1.5Gbps. These issues did not occur when
the same card/cable/disk combo sat in an x86 PC, which makes me think
that the chip's x86 BIOS did some initialisation that never occurred
on the UltraSPARC box. I intend to investigate that this evening.

/Mikael
