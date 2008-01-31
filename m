From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Hitachi 7K1000 1tb drives and sata_sil 3114 chipset
Date: Thu, 31 Jan 2008 03:13:12 -0500
Message-ID: <76366b180801310013k48a8929ei2eb939b1cf449acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:65377 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbYAaINO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jan 2008 03:13:14 -0500
Received: by rv-out-0910.google.com with SMTP id k20so473890rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 31 Jan 2008 00:13:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've been encountering many, many problems with Hitachi 1tb drives
under a Sil3114 chipset and I'm wondering if there could be something
wrong with the driver/chipset in relation to these drives.
Statistically, I've had 6 out of 7 drives exhibit very strange failure
conditions while being used under this controller.

Some symptoms:
- Clicking noises while in operation
- What appears to sound/feel like the drive spins down quickly and
back up again with no console output
- SMART reporting seek read errors which mysteriously appear/disappear
completely
- Failed I/O requests

I most recently swapped out the 1tb drives for 500gb Hitachi models
and have not experienced any of the problems above. The most recent
failed I/O requests output lots of messages, which I've pasted below.
I triggered the I/O errors by setting up lots of simultaneous copies
of large files between two drives to test the configuration.

If anyone has any ideas whether this could be some kind of
incompatibility or bug, let me know. If anyone has any
positive/negative experiences with these drives on this controller, it
would also help.

Thanks,
-Andrew

sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 1559281795
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 1563089767
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 1563115585
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 7775
printk: 124 messages suppressed.
Buffer I/O error on device sdb1, logical block 3856
Buffer I/O error on device sdb1, logical block 3857
Buffer I/O error on device sdb1, logical block 3858
Buffer I/O error on device sdb1, logical block 3859
EXT3-fs error (device sdb1): ext3_readdir: directory #2 contains a
hole at offset 0

# lspci -vvnnxxx -s 00:11.0
00:11.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller [1095:3114] (rev 02)
        Subsystem: Silicon Image, Inc. SiI 3114 SATARaid Controller [1095:6114]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at fd00 [size=8]
        Region 1: I/O ports at fc00 [size=4]
        Region 2: I/O ports at fb00 [size=8]
        Region 3: I/O ports at fa00 [size=4]
        Region 4: I/O ports at f900 [size=16]
        Region 5: Memory at efffb000 (32-bit, non-prefetchable) [size=1K]
        [virtual] Expansion ROM at 10000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 95 10 14 31 07 00 b0 02 02 00 04 01 08 40 00 00
10: 01 fd 00 00 01 fc 00 00 01 fb 00 00 01 fa 00 00
20: 01 f9 00 00 00 b0 ff ef 00 00 00 00 95 10 14 61
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00
40: 02 00 00 00 02 c0 81 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 60 00 00 f0 0a 0f 00 00 60 00 00 b0 15 0f
80: 03 00 00 00 03 00 00 00 00 00 00 00 3f 5b ca 53
90: 00 00 00 08 ff ff 00 00 00 00 00 19 00 00 00 00
a0: 01 31 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 31 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
