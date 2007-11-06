From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: Hitachi SATA HSM violation (Was: Re: Adding SATA disk with broken
	NCQ)
Date: Tue, 06 Nov 2007 22:49:26 +0000
Message-ID: <1194389366.11273.5.camel@user-computer>
References: <1194313843.6277.8.camel@user-computer>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-CgEyMBGCNQ0HGHbadnWX"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:16117 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbXKFWtc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 17:49:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so34970ugc
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 14:49:30 -0800 (PST)
In-Reply-To: <1194313843.6277.8.camel@user-computer>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-CgEyMBGCNQ0HGHbadnWX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Reading other similar reports on this issue, I attach a dmesg that shows
the HSM violations/NCQ being disabled.

In addition,

# hdparm -i /dev/sda

/dev/sda:

 Model=HITACHI HTS541616J9SA00                 , FwRev=SB4IC7UP,
SerialNo=...
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=7516kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 1:
ATA/ATAPI-2,3,4,5,6,7

 * signifies the current active mode

Simos

On Tue, 2007-11-06 at 01:50 +0000, Simos Xenitellis wrote:
> Hi,
> I'ld like to add another disk in the blacklist regarding NCQ
> (libata-core.c).
> 
> It is the disk model "HITACHI HTS541616J9SA00" with rev "SB4IC7UP".
> 
> Currently there is a similar description,
>          { "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
> Notice the difference between SB4IC7UP and SB4OC70P.
> 
> I have verified that the model name and rev are "HITACHI
> HTS541616J9SA00" and "SB4IC7UP" by adding printks in the kernel. The
> word HITACHI is all caps.
> Blacklisting does eliminate NCQ-related disk errors.
> 
> Simos
> 

--=-CgEyMBGCNQ0HGHbadnWX
Content-Disposition: attachment; filename=hsm-violation.txt
Content-Type: text/plain; name=hsm-violation.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

[   51.294197] ata1.00: exception Emask 0x2 SAct 0x785 SErr 0x0 action 0x2 frozen
[   51.294208] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x785 FIS=005040a1:00000010)
[   51.294219] ata1.00: cmd 60/08:00:49:64:9f/00:00:06:00:00/40 tag 0 cdb 0x0 data 4096 in
[   51.294222]          res 50/00:08:f9:5b:5a/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   51.294232] ata1.00: cmd 60/08:10:f9:5b:5a/00:00:06:00:00/40 tag 2 cdb 0x0 data 4096 in
[   51.294235]          res 50/00:08:f9:5b:5a/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   51.294244] ata1.00: cmd 60/08:38:51:64:9f/00:00:06:00:00/40 tag 7 cdb 0x0 data 4096 in
[   51.294247]          res 50/00:08:f9:5b:5a/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   51.294256] ata1.00: cmd 60/08:40:59:64:9f/00:00:06:00:00/40 tag 8 cdb 0x0 data 4096 in
[   51.294259]          res 50/00:08:f9:5b:5a/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   51.294268] ata1.00: cmd 60/08:48:a9:2a:56/00:00:06:00:00/40 tag 9 cdb 0x0 data 4096 in
[   51.294271]          res 50/00:08:f9:5b:5a/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   51.294281] ata1.00: cmd 60/08:50:61:64:9f/00:00:06:00:00/40 tag 10 cdb 0x0 data 4096 in
[   51.294283]          res 50/00:08:f9:5b:5a/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[   51.325202] ata1: soft resetting port
[   51.330258] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   51.331248] ata1.00: configured for UDMA/100
[   51.331279] ata1: EH complete
[   51.331463] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   51.331494] sd 0:0:0:0: [sda] Write Protect is off
[   51.331498] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   51.331575] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[23679.735640] ata1.00: exception Emask 0x2 SAct 0x3fc SErr 0x0 action 0x2 frozen
[23679.735651] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x3fc FIS=005040a1:00000002)
[23679.735662] ata1.00: cmd 61/30:10:cc:be:5e/00:00:0a:00:00/40 tag 2 cdb 0x0 data 24576 out
[23679.735665]          res 50/00:08:bc:bf:61/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
[23679.735676] ata1.00: cmd 61/08:18:64:c3:5e/00:00:0a:00:00/40 tag 3 cdb 0x0 data 4096 out
[23679.735679]          res 50/00:08:bc:bf:61/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
[23679.735689] ata1.00: cmd 61/10:20:fc:55:5f/00:00:0a:00:00/40 tag 4 cdb 0x0 data 8192 out
[23679.735692]          res 50/00:08:bc:bf:61/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
[23679.735701] ata1.00: cmd 61/08:28:fc:56:5f/00:00:0a:00:00/40 tag 5 cdb 0x0 data 4096 out
[23679.735704]          res 50/00:08:bc:bf:61/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
[23679.735714] ata1.00: cmd 61/48:30:0c:57:5f/00:00:0a:00:00/40 tag 6 cdb 0x0 data 36864 out
[23679.735717]          res 50/00:08:bc:bf:61/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
[23679.735727] ata1.00: cmd 61/08:38:74:57:5f/00:00:0a:00:00/40 tag 7 cdb 0x0 data 4096 out
[23679.735730]          res 50/00:08:bc:bf:61/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
[23679.735740] ata1.00: cmd 61/10:40:7c:57:5f/00:00:0a:00:00/40 tag 8 cdb 0x0 data 8192 out
[23679.735743]          res 50/00:08:bc:bf:61/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
[23679.735752] ata1.00: cmd 61/08:48:bc:bf:61/00:00:0a:00:00/40 tag 9 cdb 0x0 data 4096 out
[23679.735755]          res 50/00:08:bc:bf:61/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
[23679.833152] ata1: soft resetting port
[23679.883781] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[23679.884583] ata1.00: configured for UDMA/100
[23679.884619] ata1: EH complete
[23679.884704] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[23679.884722] sd 0:0:0:0: [sda] Write Protect is off
[23679.884727] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[23679.884752] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[23978.150065] ata1.00: exception Emask 0x2 SAct 0x1fff9 SErr 0x0 action 0x2 frozen
[23978.150076] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x1fff9 FIS=005040a1:00000004)
[23978.150087] ata1.00: cmd 61/08:00:9c:5d:65/00:00:0b:00:00/40 tag 0 cdb 0x0 data 4096 out
[23978.150090]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150101] ata1.00: cmd 61/08:18:34:7e:82/00:00:0a:00:00/40 tag 3 cdb 0x0 data 4096 out
[23978.150104]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150114] ata1.00: cmd 61/08:20:f4:53:85/00:00:0a:00:00/40 tag 4 cdb 0x0 data 4096 out
[23978.150117]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150126] ata1.00: cmd 61/08:28:9c:5d:85/00:00:0a:00:00/40 tag 5 cdb 0x0 data 4096 out
[23978.150130]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150139] ata1.00: cmd 61/08:30:9c:5d:99/00:00:0a:00:00/40 tag 6 cdb 0x0 data 4096 out
[23978.150142]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150152] ata1.00: cmd 61/08:38:9c:5d:a5/00:00:0a:00:00/40 tag 7 cdb 0x0 data 4096 out
[23978.150155]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150165] ata1.00: cmd 61/08:40:9c:5d:a9/00:00:0a:00:00/40 tag 8 cdb 0x0 data 4096 out
[23978.150168]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150178] ata1.00: cmd 61/08:48:9c:5d:ad/00:00:0a:00:00/40 tag 9 cdb 0x0 data 4096 out
[23978.150181]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150191] ata1.00: cmd 61/08:50:9c:5d:ed/00:00:0a:00:00/40 tag 10 cdb 0x0 data 4096 out
[23978.150194]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150204] ata1.00: cmd 61/08:58:bc:5d:ed/00:00:0a:00:00/40 tag 11 cdb 0x0 data 4096 out
[23978.150207]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150217] ata1.00: cmd 61/08:60:14:61:ed/00:00:0a:00:00/40 tag 12 cdb 0x0 data 4096 out
[23978.150220]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150230] ata1.00: cmd 61/08:68:14:14:ef/00:00:0a:00:00/40 tag 13 cdb 0x0 data 4096 out
[23978.150233]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150243] ata1.00: cmd 61/08:70:bc:15:ef/00:00:0a:00:00/40 tag 14 cdb 0x0 data 4096 out
[23978.150246]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150256] ata1.00: cmd 61/08:78:84:25:ef/00:00:0a:00:00/40 tag 15 cdb 0x0 data 4096 out
[23978.150259]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.150269] ata1.00: cmd 61/08:80:9c:5d:89/00:00:0b:00:00/40 tag 16 cdb 0x0 data 4096 out
[23978.150272]          res 50/00:08:9c:5d:89/00:00:0b:00:00/40 Emask 0x2 (HSM violation)
[23978.211938] ata1: soft resetting port
[23978.220125] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[23978.221123] ata1.00: configured for UDMA/100
[23978.221172] ata1: EH complete
[23978.221645] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[23978.221692] sd 0:0:0:0: [sda] Write Protect is off
[23978.221697] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[23978.221747] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[23996.045029] ata1.00: exception Emask 0x2 SAct 0x4 SErr 0x0 action 0x2 frozen
[23996.045038] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x4 FIS=005040a1:00000002)
[23996.045050] ata1.00: cmd 60/08:10:09:8e:08/00:00:08:00:00/40 tag 2 cdb 0x0 data 4096 in
[23996.045053]          res 50/00:08:09:8e:08/00:00:08:00:00/40 Emask 0x2 (HSM violation)
[23996.078435] ata1: soft resetting port
[23996.109689] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[23996.111110] ata1.00: configured for UDMA/100
[23996.111131] ata1: EH complete
[23996.111252] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[23996.111288] sd 0:0:0:0: [sda] Write Protect is off
[23996.111293] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[23996.111369] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[23997.163991] ata1.00: exception Emask 0x2 SAct 0xaf SErr 0x0 action 0x2 frozen
[23997.164003] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0xaf FIS=005040a1:00000100)
[23997.164014] ata1.00: cmd 60/08:00:f1:29:12/00:00:08:00:00/40 tag 0 cdb 0x0 data 4096 in
[23997.164017]          res 50/00:60:c1:62:66/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[23997.164027] ata1.00: cmd 60/28:08:c1:e6:06/00:00:08:00:00/40 tag 1 cdb 0x0 data 20480 in
[23997.164030]          res 50/00:60:c1:62:66/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[23997.164040] ata1.00: cmd 60/60:10:c1:62:66/00:00:06:00:00/40 tag 2 cdb 0x0 data 49152 in
[23997.164043]          res 50/00:60:c1:62:66/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[23997.164053] ata1.00: cmd 60/08:18:f1:38:06/00:00:08:00:00/40 tag 3 cdb 0x0 data 4096 in
[23997.164056]          res 50/00:60:c1:62:66/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[23997.164066] ata1.00: cmd 60/08:28:19:2a:12/00:00:08:00:00/40 tag 5 cdb 0x0 data 4096 in
[23997.164069]          res 50/00:60:c1:62:66/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[23997.164079] ata1.00: cmd 60/18:38:e9:5b:5a/00:00:06:00:00/40 tag 7 cdb 0x0 data 12288 in
[23997.164082]          res 50/00:60:c1:62:66/00:00:06:00:00/40 Emask 0x2 (HSM violation)
[23997.193299] ata1: soft resetting port
[23997.201220] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[23997.202832] ata1.00: configured for UDMA/100
[23997.202863] ata1: EH complete
[23997.203030] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[23997.203051] sd 0:0:0:0: [sda] Write Protect is off
[23997.203056] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[23997.203082] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[23998.308088] ata1.00: NCQ disabled due to excessive errors
[23998.308099] ata1.00: exception Emask 0x2 SAct 0x80ac SErr 0x0 action 0x2 frozen
[23998.308106] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x80ac FIS=005040a1:00000040)
[23998.308117] ata1.00: cmd 60/08:10:ec:dd:5a/00:00:0a:00:00/40 tag 2 cdb 0x0 data 4096 in
[23998.308121]          res 50/00:40:e9:72:0d/00:00:08:00:00/40 Emask 0x2 (HSM violation)
[23998.308131] ata1.00: cmd 60/20:18:09:11:07/00:00:08:00:00/40 tag 3 cdb 0x0 data 16384 in
[23998.308134]          res 50/00:40:e9:72:0d/00:00:08:00:00/40 Emask 0x2 (HSM violation)
[23998.308144] ata1.00: cmd 60/08:28:71:17:07/00:00:08:00:00/40 tag 5 cdb 0x0 data 4096 in
[23998.308147]          res 50/00:40:e9:72:0d/00:00:08:00:00/40 Emask 0x2 (HSM violation)
[23998.308157] ata1.00: cmd 60/40:38:e9:72:0d/00:00:08:00:00/40 tag 7 cdb 0x0 data 32768 in
[23998.308160]          res 50/00:40:e9:72:0d/00:00:08:00:00/40 Emask 0x2 (HSM violation)
[23998.308170] ata1.00: cmd 60/08:78:01:11:07/00:00:08:00:00/40 tag 15 cdb 0x0 data 4096 in
[23998.308173]          res 50/00:40:e9:72:0d/00:00:08:00:00/40 Emask 0x2 (HSM violation)
[23998.333828] ata1: soft resetting port
[23998.343242] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[23998.344371] ata1.00: configured for UDMA/100
[23998.344400] ata1: EH complete
[23998.368986] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[23998.387550] sd 0:0:0:0: [sda] Write Protect is off
[23998.387558] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[23998.396175] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA



--=-CgEyMBGCNQ0HGHbadnWX--

