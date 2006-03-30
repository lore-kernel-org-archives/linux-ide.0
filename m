From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 6311] New: libata/sata_sil Oops on boot
Date: Thu, 30 Mar 2006 15:27:31 -0800
Message-ID: <20060330152731.6b385335.akpm@osdl.org>
References: <200603302303.k2UN3CT8031412@fire-2.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:6314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751145AbWC3X1S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2006 18:27:18 -0500
In-Reply-To: <200603302303.k2UN3CT8031412@fire-2.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugme-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, sndoc@free.fr, Tejun Heo <htejun@gmail.com>

bugme-daemon@bugzilla.kernel.org wrote:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=6311
> 
>            Summary: libata/sata_sil Oops on boot
>     Kernel Version: Debian 2.6.16-1-k7
>             Status: NEW
>           Severity: blocking
>              Owner: jgarzik@pobox.com
>          Submitter: sndoc@free.fr
> 
> 
> Most recent kernel where this bug did not occur: 
> Similar reports on lkml seems to indicate everything was ok with 2.6.13
> (http://lkml.org/lkml/2006/1/17/306)
> 
> Distribution:
> Debian unstable
> 
> Hardware Environment:
> - Asus A7N8X delux / NForce2 chipset / SATA Silicon Image 3112A
> - Sata device 1 : Plextor PX 755 SA (Dvd recorder)
> - Everything is ok under an alternative OS.
> 
> Software Environment:
> - Debian unstable, kernel 2.6.16, libata 1.20
> - not using the nvidia binary module.
> 
> Steps to reproduce: boot...
> 
> Problem Description:
> 
> On boot, with libata.atapi_enabled=1
> - Sata device detected, sata_sil loaded, sata link up OK
> - Indicates an " abnormal status 0x78 on port 0xE0918087"
> - After claiming that  "ata1 is slow to respond, please be patient" and letting
> some other kernel booting stuff go their way, libata finally Oops and dump a
> stack trace.
> - Boot process still continue and the computer is usable afterward
> - However trying to rmmod libata (after having removed sata_sil) hangs
>   indefinitely.
> 
> Trying with libata.fua=0 gives the same results
> Trying with sata_sil.slow_down=1 gives the same results
> Trying with both : same
> 
> Trying to boot with libata.atapi_enabled=0, removing the modules, then reloading
> them with libata.atapi_enabled=1 gives the same results except that the error
> messages are thrown to the console and the keybord stops working...
> 
> 
> Here is the dmesg, from a boot with
> libata.atapi_enabled=1
> libata.fua=0
> sata_sil.slow_down=1
> 
> dmesg
> -------------------------------------------------
> sata_sil 0000:01:0b.0: version 0.9
> ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
> ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [APC3] -> GSI 18 (level, high) ->
> IRQ 201
> ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
> ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 22 (level, high) ->
> IRQ 177
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> ata1: SATA max UDMA/100 cmd 0xE0918080 ctl 0xE091808A bmdma 0xE0918000 irq 201
> ata2: SATA max UDMA/100 cmd 0xE09180C0 ctl 0xE09180CA bmdma 0xE0918008 irq 201
> input: PS2++ Logitech MX Mouse as /class/input/input2
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> intel8x0_measure_ac97_clock: measured 50672 usecs
> intel8x0: clocking to 47382
> ata1: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:001f
> ata1: dev 0 ATAPI, max UDMA/66
> ata1(0): applying bridge limits
> ata1(0): applying Seagate errata fix (mod15write workaround)
> ata1: dev 0 configured for UDMA/66
> scsi0 : sata_sil
> ata2: SATA link down (SStatus 0)
> scsi1 : sata_sil
> ATA: abnormal status 0x78 on port 0xE0918087
> ATA: abnormal status 0x78 on port 0xE0918087
> ATA: abnormal status 0x78 on port 0xE0918087
> ATA: abnormal status 0x78 on port 0xE0918087
> ts: Compaq touchscreen protocol output
> ata1 is slow to respond, please be patient
> ata1: command 0xa0 timeout, stat 0xf8 host_stat 0x0
> ata1: translated ATA stat/err 0xf8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> Adding 2000084k swap on /dev/hda3.  Priority:-1 extents:1 across:2000084k
> EXT3 FS on hda2, internal journal
> device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda4, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [AP3C] -> GSI 20 (level, high) ->
> IRQ 193
> ata1 failed to respond (30 secs)
> ATA: abnormal status 0xF8 on port 0xE0918087
> Assertion failed! qc->flags &
> ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3631
> ata1: translated ATA stat/err 0xf8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> Unable to handle kernel NULL pointer dereference at virtual address 000000cc
>  printing eip:
> e084f9c3
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in: dm_mod tsdev analog gameport snd_intel8x0 snd_ac97_codec
> snd_ac97_bus snd_mpu401 snd_mpu401_uart snd_pcm_oss snd_mixer_oss snd_rawmidi
> snd_seq_device sata_sil snd_pcm snd_timer psmouse nvidia_agp 3c59x parport_pc
> parport snd soundcore ehci_hcd ohci_hcd serio_raw mii ide_cd cdrom i2c_nforce2
> floppy snd_page_alloc agpgart rtc usbcore forcedeth i2c_core pcspkr shpchp
> pci_hotplug ohci1394 ieee1394 ext3 jbd mbcache ide_disk amd74xx generic ide_core
> sata_nv libata scsi_mod evdev mousedev
> CPU:    0
> EIP:    0060:[<e084f9c3>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.16-1-k7 #1) 
> EIP is at scsi_device_unbusy+0xb/0x31 [scsi_mod]
> eax: deeed74c   ebx: df362400   ecx: ffffffff   edx: 00000000
> esi: 00000046   edi: 00000202   ebp: df363b60   esp: dfaedf08
> ds: 007b   es: 007b   ss: 0068
> Process ata/0 (pid: 810, threadinfo=dfaec000 task=df98b560)
> Stack: <0>00000000 df362400 e084a238 df362400 deeed74c 00000000 00000202 deeed74c 
>        e08399d0 df363b60 deeed280 e08357ef deeed74c deeed280 deeed280 00000000 
>        00000202 deeed74c e0835f2b deeed74c deeed280 deeed800 dfaf9660 00000293 
> Call Trace:
>  [<e084a238>] scsi_finish_command+0x13/0xbf [scsi_mod]
>  [<e08399d0>] atapi_sense_complete+0x20/0x25 [libata]
>  [<e08357ef>] ata_qc_complete+0x1ba/0x1d1 [libata]
>  [<e0835f2b>] ata_poll_qc_complete+0x88/0x91 [libata]
>  [<b0121a95>] run_workqueue+0x64/0x94
>  [<e0835f34>] atapi_packet_task+0x0/0x127 [libata]
>  [<b0121b39>] worker_thread+0x0/0x10f
>  [<b0121c18>] worker_thread+0xdf/0x10f
>  [<b011361e>] default_wake_function+0x0/0x15
>  [<b0124139>] kthread+0x94/0xc1
>  [<b01240a5>] kthread+0x0/0xc1
>  [<b0101005>] kernel_thread_helper+0x5/0xb
> Code: d0 88 46 09 0f b6 55 06 66 0f b6 45 07 c1 e2 08 01 d0 66 89 46 04 83 c4 20
> 89 f8 5b 5e 5f 5d c3 56 53 8b 5c 24 0c 8b 13 9c 5e fa <8b> 82 cc 00 00 00 ff 4a
> 54 83 e8 05 83 f8 02 77 0d 83 7a 58 00 
>  <6>ACPI: Power Button (FF) [PWRF]
> ACPI: Power Button (CM) [PWRB]
> ------------------------

It's one of those might-be-ata, might-be-scsi bugs.

It appears that scsi_device.host contains garbage in scsi_device_unbusy(). 
At a guess I'd say that ata hasn't got enough stuff initialised to be
calling scsi_device_unbusy().

Once we've sorted that out, we need to work out why you got that assertion
failure.

Once we've done that, we need to work out why ATA isn't working.

I guess it would be helpful if you could determine whether 2.6.13 indeed
works OK on your machine as well.

