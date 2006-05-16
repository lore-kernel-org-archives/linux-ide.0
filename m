From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: SATA failure, 2.6.16.16
Date: Tue, 16 May 2006 23:09:20 +1000
Message-ID: <4469CF00.2050506@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from customer-domains.icp-qv1-irony7.iinet.net.au ([203.59.1.128]:33850
	"EHLO customer-domains.icp-qv1-irony7.iinet.net.au")
	by vger.kernel.org with ESMTP id S1751818AbWEPNJe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 09:09:34 -0400
Received: from [192.168.3.7] (e7.eyal.emu.id.au [192.168.3.7])
	by e4.eyal.emu.id.au (8.11.6/8.11.6) with ESMTP id k4GD9KP27213
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 23:09:20 +1000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: list linux-ide <linux-ide@vger.kernel.org>

Linux e7 2.6.16.16 #1 PREEMPT Thu May 11 23:15:49 EST 2006 i686 GNU/Linux

Had a massive SATA failure, a 5 disk raid5 failed and gone into an endless
look of errors. When I remounted the fs readonly the raid finally shut down.
I then managed to cleanly reboot, No problem bringing up the raid (the kicked
out disk was rebuilt). Data looks OK so far.

I must say that this setup was going fine for a few months now, and I really
hoped that these sata problems are behind me (it only happens to others...)
now.

I should mention that I noticed many stuck processed (naturally) and some were
'smartctl', which may be relevant?

Saw this on all consoles/xterms. The first line point to what probably
started it all.

eyal kernel: [6016706.665000] Disabling IRQ #21
eyal kernel: [6016857.113000] Oops: 0002 [#1]
eyal kernel: [6016857.113000] PREEMPT
eyal kernel: [6016857.113000] CPU:    0
eyal kernel: [6016857.113000] EIP is at ata_pio_poll+0x8c/0xfa [libata]
eyal kernel: [6016857.113000] eax: 66a1f3e7   ebx: f7484280   ecx: f7d5e570   edx: f74a1000
eyal kernel: [6016857.113000] esi: 00000000   edi: 00000004   ebp: 00000002   esp: f74a1ee4
eyal kernel: [6016857.113000] ds: 007b   es: 007b   ss: 0068
eyal kernel: [6016857.113000] Process ata/0 (pid: 2551, threadinfo=f74a1000 task=f7d5e570)
eyal kernel: [6016857.113000] Stack: <0>f7484280 f89cafb1 f89cad09 f89c9dd7 00000b51 d5a7b030 f7484280 00000000
eyal kernel: [6016857.113000]        f74a1000 f7434240 f89c58f0 f7484280 f7484830 f748482c c0128a89 f7484280
eyal kernel: [6016857.113000]        00000000 d5a7b030 f7434258 f7434248 f7484280 f89c58ab 00000282 f7434250
eyal kernel: [6016857.113000] Call Trace:
eyal kernel: [6016857.113000]  [pg0+945510640/1069474816] ata_pio_task+0x45/0x6e [libata]
eyal kernel: [6016857.113000]  [run_workqueue+138/288] run_workqueue+0x8a/0x120
eyal kernel: [6016857.113000]  [pg0+945510571/1069474816] ata_pio_task+0x0/0x6e [libata]
eyal kernel: [6016857.113000]  [worker_thread+320/354] worker_thread+0x140/0x162
eyal kernel: [6016857.113000]  [default_wake_function+0/18] default_wake_function+0x0/0x12
eyal kernel: [6016857.113000]  [default_wake_function+0/18] default_wake_function+0x0/0x12
eyal kernel: [6016857.113000]  [worker_thread+0/354] worker_thread+0x0/0x162
eyal kernel: [6016857.113000]  [kthread+177/183] kthread+0xb1/0xb7
eyal kernel: [6016857.113000]  [kthread+0/183] kthread+0x0/0xb7
eyal kernel: [6016857.113000]  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
eyal kernel: [6016857.113000] Code: 78 1c 89 bb dc 05 00 00 31 c0 8b 5c 24 18 8b 74 24 1c 8b 7c 24 20 8b 6c 24 24 83 c4 28 c3 a1 58 91 30 c0 39 83 e0 05 00 00 79 13 <83> 8e 8c 00 00 00 04 c7 83 dc 05 00 00 03 00 00 00 eb ca b8 10


This is in 'messages':

May 15 21:46:14 eyal kernel: [6016706.665000]  [__report_bad_irq+42/143] __report_bad_irq+0x2a/0x8f
May 15 21:46:14 eyal kernel: [6016706.665000]  [handle_IRQ_event+46/100] handle_IRQ_event+0x2e/0x64
May 15 21:46:14 eyal kernel: [6016706.665000]  [note_interrupt+124/223] note_interrupt+0x7c/0xdf
May 15 21:46:14 eyal kernel: [6016706.665000]  [__do_IRQ+218/241] __do_IRQ+0xda/0xf1
May 15 21:46:14 eyal kernel: [6016706.665000]  [do_IRQ+62/94] do_IRQ+0x3e/0x5e
May 15 21:46:14 eyal kernel: [6016706.665000]  =======================
May 15 21:46:14 eyal kernel: [6016706.665000]  [common_interrupt+26/32] common_interrupt+0x1a/0x20
May 15 21:46:14 eyal kernel: [6016706.665000]  [get_offset_pmtmr+16/83] get_offset_pmtmr+0x10/0x53
May 15 21:46:14 eyal kernel: [6016706.665000]  [do_gettimeofday+24/174] do_gettimeofday+0x18/0xae
May 15 21:46:14 eyal kernel: [6016706.665000]  [getnstimeofday+23/50] getnstimeofday+0x17/0x32
May 15 21:46:14 eyal kernel: [6016706.665000]  [do_gettimeofday+24/174] do_gettimeofday+0x18/0xae
May 15 21:46:14 eyal kernel: [6016706.665000]  [ktime_get_ts+27/90] ktime_get_ts+0x1b/0x5a
May 15 21:46:14 eyal kernel: [6016706.665000]  [getnstimeofday+23/50] getnstimeofday+0x17/0x32
May 15 21:46:14 eyal kernel: [6016706.665000]  [ktime_get+27/75] ktime_get+0x1b/0x4b
May 15 21:46:14 eyal kernel: [6016706.665000]  [hrtimer_run_queues+40/289] hrtimer_run_queues+0x28/0x121
May 15 21:46:14 eyal kernel: [6016706.665000]  [run_timer_softirq+12/507] run_timer_softirq+0xc/0x1fb
May 15 21:46:14 eyal kernel: [6016706.665000]  [__do_softirq+126/138] __do_softirq+0x7e/0x8a
May 15 21:46:14 eyal kernel: [6016706.665000]  [do_softirq+65/80] do_softirq+0x41/0x50
May 15 21:46:14 eyal kernel: [6016706.665000]  =======================
May 15 21:46:14 eyal kernel: [6016706.665000]  [irq_exit+54/56] irq_exit+0x36/0x38
May 15 21:46:14 eyal kernel: [6016706.665000]  [do_IRQ+69/94] do_IRQ+0x45/0x5e
May 15 21:46:14 eyal kernel: [6016706.665000]  [common_interrupt+26/32] common_interrupt+0x1a/0x20

May 15 21:48:44 eyal kernel: [6016857.113000] Modules linked in: isofs zlib_inflate nls_iso8859_1 cifs nvidia tsdev loop psmouse v4l1_compat dvb_bt8xx nxt6000 mt352 dvb_p
ll sp887x dst_ca dst dvb_core cx24110 or51211 lgdt330x i810_audio ac97_codec rtc it87 hwmon_vid hwmon eeprom i2c_isa i2c_i801 raid5 xor eth1394 ide_cd cdrom ns558 gamepor
t snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device parport_pc parport ohci_hcd ohci1394 ieee1394 dc395x bt878 bttv tuner video_buf firmware_class compat_ioctl32 i2c_
algo_bit v4l2_common btcx_risc ir_common tveeprom videodev sata_promise e1000 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd snd_page_alloc soundcore i2c_
core ata_piix libata ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_agp agpgart ext3 jbd nls_cp437 msdos fat sd_mod scsi_mod md_mod dm_mod unix
May 15 21:48:44 eyal kernel: [6016857.113000] EIP:    0060:[pg0+945508257/1069474816]    Tainted: P      VLI
	>>> tainted by the binary nvidia driver
May 15 21:48:44 eyal kernel: [6016857.113000] EFLAGS: 00010283   (2.6.16.11 #1)

Followed by an endless repeats like this:

May 15 21:50:33 eyal kernel: [6016966.144000] ata3: status=0xff { Busy }
May 15 21:50:33 eyal kernel: [6016966.207000] ATA: abnormal status 0xFF on port 0xF899A21C
May 15 21:50:33 eyal last message repeated 2 times
May 15 21:50:33 eyal kernel: [6016966.732000] ATA: abnormal status 0xFF on port 0xF899A29C
May 15 21:50:33 eyal kernel: [6016966.732000] ata4: status=0xff { Busy }
May 15 21:50:33 eyal kernel: [6016966.732000] sd 3:0:0:0: SCSI error: return code = 0x8000002
May 15 21:50:33 eyal kernel: [6016966.732000] sdd: Current: sense key: Aborted Command
May 15 21:50:33 eyal kernel: [6016966.732000]     Additional sense: Scsi parity error
May 15 21:50:33 eyal kernel: [6016966.732000] end_request: I/O error, dev sdd, sector 428951623
May 15 21:50:33 eyal kernel: [6016966.871000] ATA: abnormal status 0xFF on port 0xF899A31C
May 15 21:50:33 eyal kernel: [6016966.871000] ata5: status=0xff { Busy }
May 15 21:50:33 eyal kernel: [6016966.871000] sd 4:0:0:0: SCSI error: return code = 0x8000002
May 15 21:50:33 eyal kernel: [6016966.871000] sde: Current: sense key: Aborted Command
May 15 21:50:33 eyal kernel: [6016966.871000]     Additional sense: Scsi parity error
May 15 21:50:33 eyal kernel: [6016966.871000] end_request: I/O error, dev sde, sector 428954767
May 15 21:50:42 eyal kernel: [6016975.874000] ATA: abnormal status 0x58 on port 0xC007
May 15 21:50:42 eyal last message repeated 2 times
May 15 21:50:43 eyal kernel: [6016976.207000] ata3: status=0xff { Busy }
May 15 21:51:02 eyal kernel: [6016995.798000] ATA: abnormal status 0x58 on port 0xC007
May 15 21:51:02 eyal last message repeated 3 times
May 15 21:51:03 eyal kernel: [6016996.871000] ATA: abnormal status 0xFF on port 0xF899A29C
May 15 21:51:03 eyal kernel: [6016996.871000] ata4: status=0xff { Busy }
May 15 21:51:03 eyal kernel: [6016996.871000] sd 3:0:0:0: SCSI error: return code = 0x8000002
May 15 21:51:03 eyal kernel: [6016996.871000] sdd: Current: sense key: Aborted Command
May 15 21:51:03 eyal kernel: [6016996.871000]     Additional sense: Scsi parity error
May 15 21:51:03 eyal kernel: [6016996.871000] end_request: I/O error, dev sdd, sector 428951631
May 15 21:51:04 eyal kernel: [6016997.036000] ATA: abnormal status 0xFF on port 0xF899A31C
May 15 21:51:04 eyal kernel: [6016997.036000] ata5: status=0xff { Busy }
May 15 21:51:04 eyal kernel: [6016997.036000] sd 4:0:0:0: SCSI error: return code = 0x8000002
May 15 21:51:04 eyal kernel: [6016997.036000] sde: Current: sense key: Aborted Command
May 15 21:51:04 eyal kernel: [6016997.036000]     Additional sense: Scsi parity error
May 15 21:51:04 eyal kernel: [6016997.036000] end_request: I/O error, dev sde, sector 428954775
May 15 21:51:12 eyal kernel: [6017005.878000] ATA: abnormal status 0x58 on port 0xC807
May 15 21:51:12 eyal last message repeated 2 times
May 15 21:51:22 eyal kernel: [6017015.975000] ATA: abnormal status 0xFF on port 0xF899A21C
May 15 21:51:22 eyal last message repeated 2 times
May 15 21:51:32 eyal kernel: [6017025.975000] ata3: status=0xff { Busy }
May 15 21:51:32 eyal kernel: [6017026.038000] ATA: abnormal status 0xFF on port 0xF899A21C
May 15 21:51:32 eyal last message repeated 2 times
May 15 21:51:33 eyal kernel: [6017027.010000] ATA: abnormal status 0xFF on port 0xF899A29C
May 15 21:51:33 eyal kernel: [6017027.010000] ata4: status=0xff { Busy }
May 15 21:51:33 eyal kernel: [6017027.010000] sd 3:0:0:0: SCSI error: return code = 0x8000002
May 15 21:51:33 eyal kernel: [6017027.010000] sdd: Current: sense key: Aborted Command
May 15 21:51:33 eyal kernel: [6017027.010000]     Additional sense: Scsi parity error
May 15 21:51:33 eyal kernel: [6017027.010000] end_request: I/O error, dev sdd, sector 428951639
May 15 21:51:34 eyal kernel: [6017027.175000] ATA: abnormal status 0xFF on port 0xF899A31C
May 15 21:51:34 eyal kernel: [6017027.175000] ata5: status=0xff { Busy }
May 15 21:51:34 eyal kernel: [6017027.175000] sd 4:0:0:0: SCSI error: return code = 0x8000002
May 15 21:51:34 eyal kernel: [6017027.175000] sde: Current: sense key: Aborted Command
May 15 21:51:34 eyal kernel: [6017027.175000]     Additional sense: Scsi parity error
May 15 21:51:34 eyal kernel: [6017027.175000] end_request: I/O error, dev sde, sector 428954783
May 15 21:51:43 eyal kernel: [6017036.038000] ata3: status=0xff { Busy }
May 15 21:52:02 eyal kernel: [6017055.815000] ATA: abnormal status 0x58 on port 0xC007
May 15 21:52:02 eyal last message repeated 2 times
May 15 21:52:04 eyal kernel: [6017057.149000] ATA: abnormal status 0xFF on port 0xF899A29C
May 15 21:52:04 eyal kernel: [6017057.149000] ata4: status=0xff { Busy }
May 15 21:52:04 eyal kernel: [6017057.149000] sd 3:0:0:0: SCSI error: return code = 0x8000002
May 15 21:52:04 eyal kernel: [6017057.149000] sdd: Current: sense key: Aborted Command
May 15 21:52:04 eyal kernel: [6017057.149000]     Additional sense: Scsi parity error
May 15 21:52:04 eyal kernel: [6017057.149000] end_request: I/O error, dev sdd, sector 428951647
May 15 21:52:04 eyal kernel: [6017057.314000] ATA: abnormal status 0xFF on port 0xF899A31C

All the errors are on ata[345] which are on a Promise SATA II 150 TX4.

$ lspci
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02)
0000:00:03.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to CSA Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX 5600XT] (rev a1)
0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
0000:03:01.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 3d18 (rev 02)
0000:03:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:03:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:03:03.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:03:03.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:03:04.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
0000:03:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
