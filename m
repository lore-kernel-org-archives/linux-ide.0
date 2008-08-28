From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Thu, 28 Aug 2008 13:17:03 +0200
Message-ID: <200808281317.04908.elendil@planet.nl>
References: <200808261045.33241.elendil@planet.nl> <200808281125.14012.elendil@planet.nl> <c70ff3ad0808280353n18967a9frf414091ae768030c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpo-eml01.kpnxchange.com ([213.75.38.150]:15311 "EHLO
	cpsmtpo-eml01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752028AbYH1LRH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Aug 2008 07:17:07 -0400
In-Reply-To: <c70ff3ad0808280353n18967a9frf414091ae768030c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Thursday 28 August 2008, saeed bishara wrote:
> can you try setting bit 0 of the 0xf108002c then run some io?

How can I set that bit?

> which disk you have there?

ata1.00: ATA-7: HDT722516DLA380, V43OA91A, max UDMA/133
ata1.00: 321672960 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0

>From smartctl:
Model Family:     Hitachi Deskstar T7K250 series
Device Model:     HDT722516DLA380
Firmware Version: V43OA91A
User Capacity:    164,696,555,520 bytes
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 1

> is there any chance that you can replace it with different model that
> support NCQ? 

No, sorry. This is the only model SATA disk I have available. However, I use the
exact same model in a x86_64 desktop without any problems.

Possibly another owner of a TS-109 or maybe TS-209 can confirm the issue with a
different model disk.
