From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH,v2][0/2] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Wed, 11 Mar 2009 14:01:10 +0100
Message-ID: <200903111401.13562.elendil@planet.nl>
References: <200903110813.25650.elendil@planet.nl> <49B7AF88.5050900@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml106.kpnxchange.com ([195.121.3.10]:54762 "EHLO
	CPSMTPM-EML106.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905AbZCKNBR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 09:01:17 -0400
In-Reply-To: <49B7AF88.5050900@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Wednesday 11 March 2009, Mark Lord wrote:
> How many HDD activity LEDs does your SoC system have?
>
> Just one, for all channels?

Just one as my TS-109 [0] can hold only one disk. Although, it does have a 
separate LED for its eSATA port on the back, but I've never used that.
So the answer could also be 2.

During boot I get:
sata_mv sata_mv.0: version 1.25
sata_mv sata_mv.0: slots 32 ports 2
scsi0 : sata_mv
scsi1 : sata_mv
ata1: SATA max UDMA/133 irq 29
ata2: SATA max UDMA/133 irq 29
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: HDT722516DLA380, V43OA91A, max UDMA/133
ata1.00: 321672960 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access   ATA    HDT722516DLA380  V43O PQ: 0 ANSI: 5

I guess scsi0/ata1 is the internal disk and scsi1/ata2 the eSATA?

There are other QNAP variants that can hold multiple disks.
Looking at [1] the TS-209 has 2 LEDs, one for each disk. I cannot make out 
on [2] how many LEDs the TS-409 has.

Cheers,
FJP

[0] http://www.cyrius.com/debian/orion/qnap/ts-109/images/img_0013.jpg
[1] http://www.cyrius.com/debian/orion/qnap/ts-209/images/img_0004.jpg
[2] http://www.cyrius.com/debian/orion/qnap/ts-409/images/img_0201.jpg
