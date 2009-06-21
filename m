From: Adam Wysocki <gophi-lkml@chmurka.net>
Subject: PROBLEM: ide-cs - error when turning disk off
Date: Sun, 21 Jun 2009 04:34:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.0906210351170.6354@avenger>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from avenger.gophi.pl ([62.121.68.209]:46384 "EHLO chmurka.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbZFUCt7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Jun 2009 22:49:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-pcmcia@vger.kernel.org

As suggested in REPORTING-BUGS:

[1.] ide-cs - error when turning disk off

[2.] I have a PCMCIA CF card reader handled by the ide-cs module. It 
has a Kingston CF card plugged in. When I turn off my notebook, just 
after "Will now halt." message, I get:

hdc: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0xe7
Shutdown: hdc

[3.] Keywords: ide-cs, pcmcia, taskfile

[4.1.] Kernel version: Linux version 2.6.30-amilo (gophi@amilo) (gcc 
version 4.3.2 (Debian 4.3.2-1) ) #1 SMP PREEMPT Sun Jun 21 03:23:55 
CEST 2009

[4.2.] Kernel .config file: Seems irrelevant, but I have posted it 
here: http://www.chmurka.net/r/config-2.6.30-amilo

[5.] All kernel versions have this bug.

[6.] Oops: Not applicable.

[7.] Script to demonstrate: Not applicable.

[8.1.] ver_linux:

Linux amilo 2.6.30-amilo #1 SMP PREEMPT Sun Jun 21 03:23:55 CEST 2009 i686 GNU/Linux

Gnu C                  4.3.2
Gnu make               3.81
binutils               2.18.0.20080103
util-linux             2.13.1.1
mount                  2.13.1.1
module-init-tools      3.4
e2fsprogs              1.41.3
pcmciautils            014
Linux C Library        2.9
Dynamic linker (ldd)   2.9
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               6.10
udev                   125
wireless-tools         29
Modules Loaded         nls_iso8859_2 nls_cp852 vfat fat mmc_block rfcomm 
l2cap bluetooth fuse dm_crypt dm_mod fsam7400 loop ide_gd_mod 
snd_hda_codec_si3054 snd_hda_codec_realtek ide_cd_mod cdrom ide_cs pcmcia 
arc4 ecb snd_hda_intel ath5k snd_hda_codec mac80211 snd_hwdep snd_pcm 
snd_seq snd_timer snd_seq_device snd sdhci_pci sdhci soundcore sky2 
yenta_socket rsrc_nonstatic i2c_i801 piix iTCO_wdt bitrev serio_raw 
pcmcia_core mmc_core led_class i2c_core iTCO_vendor_support cfg80211 
ide_core snd_page_alloc crc32 ac battery video backlight output button 
intel_agp agpgart evdev

[8.2.] Processor: Seems irrelevant - Intel Core Duo T2250.

[8.3.] Selected modules:

ide_cs 9628 1 - Live 0xf8546000
pcmcia 32464 1 ide_cs, Live 0xf84b7000
ide_core 88344 4 ide_gd_mod,ide_cd_mod,ide_cs,piix, Live 0xf81a4000
yenta_socket 22888 3 - Live 0xf82a4000
rsrc_nonstatic 8700 1 yenta_socket, Live 0xf8291000
pcmcia_core 33680 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xf823f000
rsrc_nonstatic 8700 1 yenta_socket, Live 0xf8291000

[8.4.] Selected ioports:

3000-3fff : PCI Bus 0000:0a
  3000-30ff : PCI CardBus 0000:0b
  3100-310f : pcmcia_socket0
    3100-3107 : ide-cs
    310e-310e : ide-cs
  3400-34ff : PCI CardBus 0000:0b

[8.5.] Selected PCI info:

0a:06.0 CardBus bridge: ENE Technology Inc CB-712/4 Cardbus Controller (rev 10)
        Subsystem: Fujitsu Siemens Computers Device 10c1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 168, Cache Line Size: 128 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at d4100000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=0a, secondary=0b, subordinate=0e, sec-latency=176
        Memory window 0: 88000000-8bfff000 (prefetchable)
        Memory window 1: 8c000000-8ffff000
        I/O window 0: 00003000-000030ff
        I/O window 1: 00003400-000034ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
        16-bit legacy interface ports at 0001
        Kernel driver in use: yenta_cardbus
        Kernel modules: yenta_socket

The reader identifies as:

Socket 0 Bridge:        [yenta_cardbus]         (bus ID: 0000:0a:06.0)
        Configuration:  state: on       ready: unknown
                        Voltage: 3.3V Vcc: 3.3V Vpp: 0.0V
Socket 0 Device 0:      [ide-cs]                (bus ID: 0.0)
        Configuration:  state: on
        Product Name:   SAMSUNG 04/05/06
        Identification: manf_id: 0x0000 card_id: 0x0000
                        function: 4 (fixed disk)
                        prod_id(1): "SAMSUNG" (0x43d74cb4)
                        prod_id(2): "04/05/06" (0x6a22777d)
                        prod_id(3): --- (---)
                        prod_id(4): --- (---)

And in dmesg, after plugging it in:

Probing IDE interface ide1...
hdc: SAMSUNG CF/ATA, CFA DISK drive
ide1 at 0x3100-0x3107,0x310e on irq 22
hdc: max request size: 128KiB
hdc: 1018080 sectors (521 MB) w/0KiB Cache, CHS=1010/16/63
 hdc: unknown partition table
ide-cs: hdc: Vpp = 0.0

[8.6.] SCSI information: Seems irrelevant.

[8.7.] Other information that might be relevant to the problem:

Doing hdparm -Y /dev/hdc does not reproduce this error, it occurs only 
when turning PC off.

I am not subscribed to the list so please CC me with any replies.

Thanks.

-- 
http://www.gophi.pl/
