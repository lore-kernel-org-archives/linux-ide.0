From: Manoj Kasichainula <manoj@io.com>
Subject: ICH8-R without NCQ support?
Date: Wed, 22 Nov 2006 21:18:15 -0800
Message-ID: <20061123051815.GD18344@dosa.chappati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl081-057-242.sfo1.dsl.speakeasy.net ([64.81.57.242]:4776 "EHLO
	samosa.lan") by vger.kernel.org with ESMTP id S932164AbWKWFSQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Nov 2006 00:18:16 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[Please cc: me, I'm not subscribed]

libata seems to not be detecting NCQ capabilities on my ICH8-R chipset:

[   44.529319] ahci 0000:00:1f.2: flags: 64bit ilck stag led pmp pio 

I understand that ICH8 wouldn't have NCQ, but ICH8-R should, according 
to all the docs I've seen.

I have a silly theory that the code in ahci.c:ahci_reset_controller() 
that writes over HOST_CAP is preventing NCQ from being detected. It 
forces only bits 28 and 17 to retain their old values, and 27 to be set.
The silly theory contents that other chipsets don't actually let that 
register get overwritten, but ICH8-R is clearing most capability bits.

It's more likely to be something wrong I'm doing, but I don't see it 
yet. There's nothing in the BIOS for me to change.

Thanks for your help.

I have an Asus P5B Deluxe motherboard. 

lspci -v output
00:1f.2 SATA controller: Intel Corporation SATA Controller AHCI (rev 02) (prog-i
f 01 [AHCI 1.0])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ec
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 507
        I/O ports at ec00 [size=8]
        I/O ports at e880 [size=4]
        I/O ports at e800 [size=8]
        I/O ports at e480 [size=4]
        I/O ports at e400 [size=32]
        Memory at febff800 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/4 Enable+
        Capabilities: [70] Power Management version 3
        Capabilities: [a8] #12 [0010]

(latest kernel from Ubuntu Feisty)
Linux samosa 2.6.19-6-generic #2 SMP Wed Nov 15 22:22:53 UTC 2006 x86_64 GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
reiserfsprogs          3.6.19
PPP                    2.4.4
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.96
udev                   093
Modules Loaded         video sbs i2c_ec i2c_core button battery container ac asus_acpi ipv6 nls_cp437 isofs udf loop af_packet cpufreq_ondemand speedstep_centrino freq_table sbp2 parport_pc lp parport snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss ata_generic sg psmouse pata_jmicron sk98lin snd_pcm snd_timer sky2 serio_raw skge snd soundcore snd_page_alloc evdev intel_agp iTCO_wdt shpchp pci_hotplug pcspkr ext3 jbd mbcache raid456 xor raid1 md_mod usb_storage libusual ohci1394 ieee1394 ehci_hcd uhci_hcd usbcore ide_generic ide_cd cdrom generic sd_mod ahci libata scsi_mod thermal processor fan vesafb capability commoncap vga16fb cfbcopyarea vgastate cfbimgblt cfbfillrect fbcon tileblit font bitblit softcursor

