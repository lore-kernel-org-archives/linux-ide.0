From: Frans Pop <elendil@planet.nl>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Mon, 22 Jun 2009 08:43:13 +0200
Message-ID: <200906220843.14337.elendil@planet.nl>
References: <200906211446.38598.elendil@planet.nl> <200906220628.37237.elendil@planet.nl> <20090621.224510.96380426.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:63772 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542AbZFVGnN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 02:43:13 -0400
In-Reply-To: <20090621.224510.96380426.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

On Monday 22 June 2009, David Miller wrote:
> Some things other than the commit in question have changed in the area
> of interrupt and chip initialization and I'll try to go through
> the commits to get some clues.

Great.

JFTR, here's the full output of your debug print. All 32 prints are
identical and the "nobody cared" is printed immediately after.
No really new info I guess...

This is on top of v2.6.30-7732-g2453d6f. I'll continue working on top of
current mainline. If you need anything done, just let me know.

cmd64x 0000:01:03.0: IDE controller (0x1095:0x0646 rev 0x03)
cmd64x 0000:01:03.0: 100% native mode on irq 14
    ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027
    ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f
Probing IDE interface ide0...
hda: ST34342A, ATA DISK drive
hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hda: MWDMA2 mode selected
Probing IDE interface ide1...
hdc: Maxtor 6E040L0, ATA DISK drive
hdd: CD-ROM 56X/AKH, ATAPI CD/DVD-ROM drive
hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdc: MWDMA2 mode selected
hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdd: bad DMA info in identify block
hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
IDE-DEBUG: host->host_flags[0x10] hwif(fffff8003e393800) host->cur_port((null))
IDE-DEBUG: hwif->port_ops(cmd648_port_ops+0x0/0xfffffffffffffe54 [cmd64x])
IDE-DEBUG: hwif->handler((null)) hwif->polling(0)
