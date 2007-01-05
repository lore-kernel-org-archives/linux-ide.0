From: Brad Fitzpatrick <brad@danga.com>
Subject: Norco DS-1220 (sil3726+sil3124) / libata-tj bug report
Date: Fri, 5 Jan 2007 04:08:51 +0000 (UTC)
Message-ID: <Pine.LNX.4.58.0701050407060.26166@mailx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.danga.com ([207.7.148.197]:49292 "EHLO danga.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030328AbXAEEfd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Jan 2007 23:35:33 -0500
Received: from localhost (mailx [127.0.0.1])
	by danga.com (Postfix) with ESMTP id 001561413298
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2007 04:08:53 +0000 (UTC)
Received: from danga.com ([127.0.0.1])
	by localhost (mailx [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13181-10 for <linux-ide@vger.kernel.org>;
	Fri, 5 Jan 2007 04:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by danga.com (Postfix) with ESMTP id 5F669343019A
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2007 04:08:51 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun, et al,

Hardware:
   Norco DS-1220 SATA enclosure (sil2134 card w/ 4 PMP/direct ports,
   enclosure is 2x sil3726 (5 disks each), and then 2 direct SATA ports.

   (also have 2x SATA internal, on ata_piix, md raid1, that's working fine...
    those are sd[ab], ata[12].nn, scsi[01])

Kernel:
   2.6.18.6 + libata-tj-2.6.18.1-20061020.

Issue:

Disks in DS-1220 show up, kinda, but don't work.  Errors reading /
writing blocks.  Tried a single disk in both a PMP port and a direct
(non-sil3726) port.

Full dmesg:
  http://bradfitz.com/temp/libata-norco-timeout-dmesg.txt

.config:
  http://bradfitz.com/temp/libata-norco-config.txt

Snippet of dmesg:

....
18:29:45 ata3.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x1
18:29:45 ata3.15: (irq_stat 0x08000800, SDB notify)
18:29:45 ata3.01: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0x43
18:29:46 ata3.01: waiting for device to spin up (8 secs)
18:29:53 ata3.01: hard resetting port
18:29:54 ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
18:29:54 ata3.01: ATA-6, max UDMA/100, 488397168 sectors: LBA48
18:29:54 ata3.01: ata3: dev 0 multi count 0
18:29:54 ata3.01: applying bridge limits
18:29:54 ata3.01: configured for UDMA/100
18:29:54 ata3: EH complete
18:29:55   Vendor: ATA       Model: WDC WD2500JD-00G  Rev: 02.0
18:29:55   Type:   Direct-Access                      ANSI SCSI revision: 05
18:29:55 SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
18:29:55 sdd: Write Protect is off
18:29:55 sdd: Mode Sense: 00 3a 00 00
18:29:55 SCSI device sdd: drive cache: write back
18:29:55 SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
18:29:55 sdd: Write Protect is off
18:29:55 sdd: Mode Sense: 00 3a 00 00
18:29:55 SCSI device sdd: drive cache: write back
18:29:55  sdd:<3>ata3.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
18:29:55 ata3.01: (irq_stat 0x00020002, device error via D2H FIS)
18:29:55 ata3.01: tag 0 cmd 0xc8 Emask 0x1 stat 0x50 err 0x0 (device error)
18:29:55 ata3: EH complete
18:29:55 ata3.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
18:29:55 ata3.01: (irq_stat 0x00060002, device error via D2H FIS)
18:29:55 ata3.01: tag 0 cmd 0xc8 Emask 0x1 stat 0x50 err 0x0 (device error)
18:29:55 ata3: EH complete
18:29:55 ata3.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
18:29:55 ata3.01: (irq_stat 0x00060002, device error via D2H FIS)
18:29:55 ata3.01: tag 0 cmd 0xc8 Emask 0x1 stat 0x50 err 0x0 (device error)
18:29:55 ata3: EH complete
18:29:55 ata3.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
18:29:55 ata3.01: (irq_stat 0x00060002, device error via D2H FIS)
18:29:55 ata3.01: tag 0 cmd 0xc8 Emask 0x1 stat 0x50 err 0x0 (device error)
18:29:55 ata3: EH complete
18:29:56 ata3.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
18:29:56 ata3.01: (irq_stat 0x00060002, device error via D2H FIS)
18:29:56 ata3.01: tag 0 cmd 0xc8 Emask 0x1 stat 0x50 err 0x0 (device error)
18:29:56 ata3: EH complete
18:29:56 ata3.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
18:29:56 ata3.01: (irq_stat 0x00060002, device error via D2H FIS)
18:29:56 ata3.01: tag 0 cmd 0xc8 Emask 0x1 stat 0x50 err 0x0 (device error)
18:29:56 sd 2:0:1:0: SCSI error: return code = 0x08000002
18:29:56 sdd: Current: sense key: Aborted Command
18:29:56     Additional sense: No additional sense information
18:29:56 end_request: I/O error, dev sdd, sector 0
18:29:56 Buffer I/O error on device sdd, logical block 0
18:29:56 ata3: EH complete
18:29:56 ata3.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
18:29:56 ata3.01: (irq_stat 0x00060002, device error via D2H FIS)
....

lspci:

0000:03:01.0 Mass storage controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller
        Flags: bus master, stepping, 66MHz, medium devsel, latency 32, IRQ 21
        Memory at ff9ffc00 (64-bit, non-prefetchable) [size=128]
        Memory at ff9f0000 (64-bit, non-prefetchable) [size=32K]
        I/O ports at bc00 [size=16]
        Expansion ROM at f6a00000 [disabled] [size=512K]
        Capabilities: [64] Power Management version 2
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [54] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller (rev 02)
0000:00:03.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to CSA Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
0000:00:1f.2 RAID bus controller: Intel Corporation 82801ER (ICH5R) SATA Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)
0000:02:01.0 Ethernet controller: Intel Corporation 82547EI Gigabit Ethernet Controller (LOM)
** 0000:03:01.0 Mass storage controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 01)
0000:03:02.0 Communication controller: Tiger Jet Network Inc. Tiger3XX Modem/ISDN interface
0000:03:03.0 Communication controller: Tiger Jet Network Inc. Tiger3XX Modem/ISDN interface
0000:03:04.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 05)
0000:03:07.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61)

lsmod:

Module                  Size  Used by
af_packet              23944  2
ip_conntrack_ftp        8860  0
ip_conntrack           48676  1 ip_conntrack_ftp
ide_scsi               19076  0
loop                   17416  0
bridge                 58780  0
llc                     9236  1 bridge
aes_i586               34292  0
dm_crypt               13192  0
dm_mod                 56340  4 dm_crypt
usb_storage            65984  1
sd_mod                 21120  8
snd_intel8x0           34076  0
snd_ac97_codec         95776  1 snd_intel8x0
snd_ac97_bus            3584  1 snd_ac97_codec
snd_pcm_oss            44704  0
snd_mixer_oss          18176  1 snd_pcm_oss
snd_pcm                79492  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
sata_sil24             20356  0
snd_timer              24580  1 snd_pcm
snd                    52992  6 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              11104  1 snd
e1000                 123200  0
ata_piix               17672  4
libata                131092  2 sata_sil24,ata_piix
snd_page_alloc         11528  2 snd_intel8x0,snd_pcm
e100                   37000  0
mii                     7168  1 e100
evdev                  11264  1
i2c_i801                9228  0
pcspkr                  4352  0
scsi_mod              136684  4 ide_scsi,usb_storage,sd_mod,libata
ehci_hcd               30728  0
uhci_hcd               24716  0
i2c_core               22656  1 i2c_i801
unix                   29456  254

....


I'm more than willing to be your guinea pig, testing whatever.  Would
love this wonderful hardware to work well for others eventually with
less pain.

Thanks!
Brad


