From: "matson" <lists-matsonpa@luxsci.me>
Subject: additional model for sata_sil Mod15Write list
Date: Tue, 21 Jan 2014 19:12:46 +0000
Message-ID: <201401211912.s0LJCk7F015058@rs103.luxsci.com>
Reply-To: lists-matsonpa@luxsci.me
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rs103.luxsci.com ([72.32.40.101]:33305 "EHLO rs103.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbaAUTSM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2014 14:18:12 -0500
Received: from rs103.luxsci.com (localhost.localdomain [127.0.0.1])
	by rs103.luxsci.com (8.13.8/8.13.8) with ESMTP id s0LJCkcK015061
	for <linux-ide@vger.kernel.org>; Tue, 21 Jan 2014 13:12:46 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I have a SiI3112 rev 2 and a Toshiba MK2561GSYN HDD.  I think it 
belongs in the list of buggy drives which require Mod15Write.

To test, I perform:
dd if=/dev/zero of=/dev/sdb oflag=direct bs=8192
Without enabling slow_down, after moment of pause, this shows up in dmesg:

ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata7.00: failed command: WRITE DMA
ata7.00: cmd ca/00:10:80:01:00/00:00:00:00:00/e0 tag 0 dma 8192 out
           res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata7.00: status: { DRDY }
ata7: hard resetting link
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata7.00: configured for UDMA/100
ata7.00: device reported invalid CHS sector 0
ata7: EH complete

If I use slow_down, these timeouts are gone completely.  If I write 
7680 (15 sector), repeated 100000 times, it is okay.  Reading any size 
is okay.  All of my other drives behave with this card.

My HDD is HP part 625239, firmware is MH000C.  I do know whether other 
models (in the series) or firmwares have this problem.

The following drives are in series TOSHIBA MKxx61GSYN:
MK1661GSYN MK2561GSYN MK3261GSYN MK5061GSYN MK6461GSYN

I searched for pictures on the Web, and found that these models used by 
Dell have firmware MH000D, and some others have firmware MH000A (maybe 
these are retail).

MKxx61GSYN listed as current, not discontinued, at Toshiba's Web site.

http://storage.toshiba.com/storagesolutions/pc-notebook/mkxx61gsyn-series

