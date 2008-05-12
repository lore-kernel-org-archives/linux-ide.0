From: Martin Michlmayr <tbm@cyrius.com>
Subject: sata_mv on Orion: CONFIG_SATA_PMP=y needed even when no multiplier
Date: Mon, 12 May 2008 15:28:40 +0200
Message-ID: <20080512132840.GA15711@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:1871 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbYELNzp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 May 2008 09:55:45 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org
Cc: nico@cam.org, buytenh@wantstofly.org

With 2.6.26-rc1 I have to enable CONFIG_SATA_PMP=y otherwise sata_mv
doesn't find a disk on my Orion based device (QNAP TS-209).  Without
CONFIG_SATA_PMP I get:

[42949381.790000] sata_mv sata_mv.0: version 1.20
[42949381.790000] sata_mv sata_mv.0: slots 32 ports 2
[42949381.800000] scsi0 : sata_mv
[42949381.800000] scsi1 : sata_mv
[42949381.810000] ata1: SATA max UDMA/133 irq 29
[42949381.810000] ata2: SATA max UDMA/133 irq 29
[42949382.170000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[42949382.520000] ata2: SATA link down (SStatus 0 SControl 300)
[and nothing else]

So obviously it sees that something is connected to ata1, but it
doesn't actually print anything about the disk or create the device
node.

This works correctly with 2.6.25 or when I set CONFIG_SATA_PMP=y.
However, my device doesn't have a multiplier.
-- 
Martin Michlmayr
http://www.cyrius.com/
