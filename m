From: "Martin K. Petersen" <mkp@mkp.net>
Subject: Re: [PATCH 1/1] pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 03 Oct 2007 14:45:12 -0400
Message-ID: <yq1tzp8vxzb.fsf@sermon.lab.mkp.net>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
	<20071003192232.558ec72b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:35115 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbXJCSpN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 14:45:13 -0400
In-Reply-To: <20071003192232.558ec72b@the-village.bc.nu> (Alan Cox's message of "Wed\, 3 Oct 2007 19\:22\:32 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, info-linux@geode.amd.com

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> The older AMD ex NS ex Cyrix chipsets mishandle 64K DMA blocks -
Alan> is that the case for the CS5536 or not - does it consider a PRD
Alan> entry with zero length as 64K or 0 bytes

The databook says: "The size must be in multiples of 1 WORD (2 bytes)
or zero (which means a 64 KB transfer)."


>> + if ((cfg & IDE_CFG_CHANEN) == 0) { + printk(KERN_ERR "CS5536:
>> disabled by BIOS\n");

Alan> To save Jeff whining - he'll want that to be DRV_NAME or similar
Alan> and to call it pata_cs5536

Ok.

-- 
Martin K. Petersen      http://mkp.net/
