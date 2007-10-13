From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: 2.6.23-mm1
Date: Sat, 13 Oct 2007 17:13:00 +0200
Message-ID: <64bb37e0710130813le68c48dve36f8473b197b84b@mail.gmail.com>
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>
	 <20071011234202.2f15bb76.akpm@linux-foundation.org>
	 <64bb37e0710120131y6b939951y74c50bd596b1d938@mail.gmail.com>
	 <20071012013729.ada2127b.akpm@linux-foundation.org>
	 <64bb37e0710130101y7fb8e4c0lf214fd821e8305ed@mail.gmail.com>
	 <4710A407.3070000@garzik.org>
	 <64bb37e0710130503haa66d6eu93e75ecdc78ac866@mail.gmail.com>
	 <4710B7C5.5050403@garzik.org>
	 <64bb37e0710130732p303547e3n54cfa9dac34c53b5@mail.gmail.com>
	 <64bb37e0710130740u78613f83wbd4f43d073bbe13d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:42030 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbXJMPNC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 11:13:02 -0400
Received: by py-out-1112.google.com with SMTP id u77so2152429pyb
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 08:13:01 -0700 (PDT)
In-Reply-To: <64bb37e0710130740u78613f83wbd4f43d073bbe13d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

On 10/13/07, Torsten Kaiser <just.for.lkml@googlemail.com> wrote:
> Wait!
>
> I think I found the bug: Its a evil interaction between the above
> patch and the swncq patch that is applied later.
> The qc_defer patch removes the old ata_scmd_need_defer that was always
> called for all drivers and substitutes it for ata_std_qc_defer and
> adds it as aops->qc_defer to all drivers that support NCQ *at that
> point*.
> Then the swncq patch adds a new NCQ capable driver, but the nobody
> added the qc_defer-ops to the ops-structure that is added. So swncq
> will never defer any commands and the first command that would need to
> be defered (the SMART commands) blows up, if there is still another
> command in flight.
>
> I will only add the qc_defer and try this...

3 boots, all worked. So I'm very sure that was the bug, but I will now
do a little load testing...

The only strange thing about 2.6.23-mm1 is, that it takes ~4 second
more to boot.

2.6.23-rc8-mm1:
[    3.720000] scsi0 : sata_sil24
[    3.730000] scsi1 : sata_sil24
[    3.740000] ata1: SATA max UDMA/100 irq 17
[    3.750000] ata2: SATA max UDMA/100 irq 17
[    4.110000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.160000] ata1.00: ATA-7: MAXTOR STM3320820AS, 3.AAE, max UDMA/133
[    4.180000] ata1.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    4.240000] ata1.00: configured for UDMA/100
[    4.600000] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.660000] ata2.00: ATA-7: MAXTOR STM3320820AS, 3.AAE, max UDMA/133
[    4.680000] ata2.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    4.730000] ata2.00: configured for UDMA/100

2.6.23-mm1:
[    3.650000] scsi0 : sata_sil24
[    3.660000] scsi1 : sata_sil24
[    3.660000] ata1: SATA max UDMA/100 host m128@0xefeffc00 port
0xefef8000 irq 17
[    3.690000] ata2: SATA max UDMA/100 host m128@0xefeffc00 port
0xefefa000 irq 17
[    5.930000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    5.980000] ata1.00: ATA-7: MAXTOR STM3320820AS, 3.AAE, max UDMA/133
[    6.000000] ata1.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    6.060000] ata1.00: configured for UDMA/100
[    8.290000] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    8.340000] ata2.00: ATA-7: MAXTOR STM3320820AS, 3.AAE, max UDMA/133
[    8.360000] ata2.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    8.420000] ata2.00: configured for UDMA/100

Torsten
