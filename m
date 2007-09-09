From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: Maxtor 6L200M0 sata irq timeouts
Date: Sun, 9 Sep 2007 11:34:54 +0200
Message-ID: <a5d587fb0709090234x1942e987u4187bf0dbe977a06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:32595 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbXIIJfA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Sep 2007 05:35:00 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1526459mue
        for <linux-ide@vger.kernel.org>; Sun, 09 Sep 2007 02:34:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello

(please CC me when replying)

I gott this drive connected to the sata controler (it's the only
drive, the other two ata buses are pata):

 Model=Maxtor 6L200M0                          , FwRev=BANC1E00
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1,2,3,4,5,6,7

ata3.00: ATA-7: Maxtor 6L200M0, BANC1E00, max UDMA/133
ata3.00: 398297088 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133

Note: I beleive here the reports of dmesg and hdparm diverge. iirc
udma/133 is udma6.

FIrst I got a board with via chipset, and when it died I replaced it
with one with intel chipset.
The problem was there probably for a long time and went unnoticed
until the via board started dying and I looked into the logs. It
usually manifested while playing video that required something between
95% and 115% of the available cpu power to decode properly so I
assumed it is just mplayer catching up with realtime.

I get resets like this from time to time:

Sep  8 16:44:08 heretic ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Sep  8 16:44:08 heretic ata3.00: cmd
b0/d8:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
Sep  8 16:44:08 heretic res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask
0x4 (timeout)
Sep  8 16:44:08 heretic ata3: soft resetting port
Sep  8 16:44:08 heretic ata3.00: configured for UDMA/133
Sep  8 16:44:08 heretic ata3: EH complete
Sep  8 16:44:08 heretic sd 2:0:0:0: [sda] 398297088 512-byte hardware
sectors (203928 MB)
Sep  8 16:44:08 heretic sd 2:0:0:0: [sda] Write Protect is off
Sep  8 16:44:08 heretic sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
Sep  8 16:44:08 heretic sd 2:0:0:0: [sda] Write cache: enabled, read
cache: enabled, doesn't support DPO or FUA

These are only noticable vhen doing realtime stuff like video playback.

When playing with stuff like noapic or pci=routeirq earlier I got
crashes instead of ata resets (there is not much you can do with a
system where the only drive gets disconnected, even if it does not
panic right away). With some combination of these I got a spurious
interrupt instead of timeout.

Thanks

Michal
