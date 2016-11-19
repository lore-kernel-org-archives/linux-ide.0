From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 188141] New: PCI0680 can't work reliably in UDMA mode over 33
Date: Sat, 19 Nov 2016 07:46:38 +0000
Message-ID: <bug-188141-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbcKSHqm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 19 Nov 2016 02:46:42 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 991602040F
        for <linux-ide@vger.kernel.org>; Sat, 19 Nov 2016 07:46:40 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id EC1F7203DA
        for <linux-ide@vger.kernel.org>; Sat, 19 Nov 2016 07:46:38 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=188141

            Bug ID: 188141
           Summary: PCI0680 can't work reliably in UDMA mode over 33
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 4.8.0-27-generic #29-Ubuntu SMP Thu Oct 20 21:03:13
                    UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: ilario.gottardello@gmail.com
        Regression: No

Subsituting an HPT366 IDE controller with a Silicon Image, Inc. PCI0680 Ultra
ATA-133 Host Controller (rev 02) (so same pci slot / cables / hard drives), it
immediately fails to read data from the disks, slowing down the link to
UDMA/33.
Here the log on dmesg:

[  526.912245] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  526.912252] ata3.00: failed command: READ DMA EXT
[  526.912258] ata3.00: cmd 25/00:00:4f:98:ee/00:04:01:00:00/e0 tag 0 dma
524288 in
                        res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4
(timeout)                                                                       
[  526.912261] ata3.00: status: { DRDY }
[  531.951419] ata3: link is slow to respond, please be patient (ready=0)
[  536.930691] ata3: device not ready (errno=-16), forcing hardreset
[  536.930705] ata3: soft resetting link
[  537.145123] ata3.00: configured for UDMA/133
[  537.145138] ata3: EH complete
[  569.918070] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  569.918076] ata3.00: failed command: READ DMA
[  569.918083] ata3.00: cmd c8/00:50:ef:ba:2f/00:00:00:00:00/e1 tag 0 dma 40960
in
                        res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4
(timeout)                                                                       
[  569.918086] ata3.00: status: { DRDY }
[  574.957860] ata3: link is slow to respond, please be patient (ready=0)
[  579.945773] ata3: device not ready (errno=-16), forcing hardreset
[  579.945788] ata3: soft resetting link
[  580.159919] ata3.00: configured for UDMA/133
[  580.159933] ata3: EH complete
[  612.924604] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  612.924610] ata3.00: failed command: READ DMA EXT
[  612.924616] ata3.00: cmd 25/00:00:4f:10:da/00:04:01:00:00/e0 tag 0 dma
524288 in
                        res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4
(timeout)                                                                       
[  612.924619] ata3.00: status: { DRDY }
[  617.968302] ata3: link is slow to respond, please be patient (ready=0)
[  622.948039] ata3: device not ready (errno=-16), forcing hardreset
[  622.948053] ata3: soft resetting link
[  623.162218] ata3.00: configured for UDMA/133
[  623.162232] ata3: EH complete
[  655.930086] ata3.00: limiting speed to UDMA/100:PIO4
[  655.930089] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  655.930095] ata3.00: failed command: READ DMA EXT
[  655.930101] ata3.00: cmd 25/00:a8:8f:4e:a8/00:02:01:00:00/e0 tag 0 dma
348160 in
                        res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4
(timeout)                                                                       
[  655.930104] ata3.00: status: { DRDY }
[  660.933621] ata3: link is slow to respond, please be patient (ready=0)
[  665.985242] ata3: device not ready (errno=-16), forcing hardreset
[  665.985256] ata3: soft resetting link
[  666.180539] ata3.00: configured for UDMA/100
[  666.180553] ata3: EH complete
[  698.934573] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  698.934580] ata3.00: failed command: READ DMA EXT
[  698.934586] ata3.00: cmd 25/00:00:f7:ad:aa/00:08:01:00:00/e0 tag 0 dma
1048576 in
                        res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4
(timeout)
[  698.934589] ata3.00: status: { DRDY }
[  703.986089] ata3: link is slow to respond, please be patient (ready=0)
[  708.969586] ata3: device not ready (errno=-16), forcing hardreset
[  708.969600] ata3: soft resetting link
[  709.164047] ata3.00: configured for UDMA/100
[  709.164063] ata3: EH complete
[  741.938477] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  741.938484] ata3.00: failed command: READ DMA EXT
[  741.938489] ata3.00: cmd 25/00:00:47:9f:a3/00:08:01:00:00/e0 tag 0 dma
1048576 in
                        res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4
(timeout)
[  741.938492] ata3.00: status: { DRDY }
[  746.977880] ata3: link is slow to respond, please be patient (ready=0)
[  751.957395] ata3: device not ready (errno=-16), forcing hardreset
[  751.957410] ata3: soft resetting link
[  752.152040] ata3.00: configured for UDMA/100
[  752.152055] ata3: EH complete
[  784.941944] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  784.941951] ata3.00: failed command: READ DMA EXT
[  784.941958] ata3.00: cmd 25/00:08:47:ac:da/00:04:01:00:00/e0 tag 0 dma
528384 in
                        res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4
(timeout)
[  784.941961] ata3.00: status: { DRDY }
[  789.985298] ata3: link is slow to respond, please be patient (ready=0)
[  794.988755] ata3: device not ready (errno=-16), forcing hardreset
[  794.988768] ata3: soft resetting link
[  795.183363] ata3.00: configured for UDMA/100
[  795.183377] ata3: EH complete
[  827.945045] ata3.00: limiting speed to UDMA/33:PIO4
[  827.945047] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  827.945051] ata3.00: failed command: READ DMA
[  827.945055] ata3.00: cmd c8/00:58:9f:ed:a4/00:00:00:00:00/e1 tag 0 dma 45056
in
                        res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4
(timeout)
[  827.945056] ata3.00: status: { DRDY }
[  832.996422] ata3: link is slow to respond, please be patient (ready=0)
[  837.983822] ata3: device not ready (errno=-16), forcing hardreset
[  837.983836] ata3: soft resetting link
[  838.178364] ata3.00: configured for UDMA/33
[  838.178377] ata3: EH complete

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
