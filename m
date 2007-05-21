From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: sata via lockups
Date: Mon, 21 May 2007 13:12:28 +0200
Message-ID: <a5d587fb0705210412s69429491v33f81c27226611ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:37227 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbXEULMa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 07:12:30 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1162308uga
        for <linux-ide@vger.kernel.org>; Mon, 21 May 2007 04:12:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello

I am experiencing occasional lockups that seem related to my via sata
controller.

Normally I get sata controller resets like this:

May 19 20:10:22 [kernel] [  809.542325] ata1.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x2 frozen
May 19 20:10:22 [kernel] [  809.542339] ata1.00: cmd
b0/d8:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
May 19 20:10:22 [kernel] [  809.542341]          res
40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
May 19 20:10:22 [kernel] [  809.749359] ata1: soft resetting port
May 19 20:10:22 [kernel] [  809.910985] ATA: abnormal status 0x7F on
port 0x0001ec07
May 19 20:10:22 [kernel] [  809.921589] ATA: abnormal status 0x7F on
port 0x0001ec07
May 19 20:10:22 [kernel] [  809.928615] ata1.00: configured for UDMA/133
May 19 20:10:22 [kernel] [  809.928658] ata1: EH complete
May 19 20:10:23 [kernel] [  810.010064] SCSI device sda: 398297088
512-byte hdwr sectors (203928 MB)
May 19 20:10:23 [kernel] [  810.010435] sda: Write Protect is off
May 19 20:10:23 [kernel] [  810.010441] sda: Mode Sense: 00 3a 00 00
May 19 20:10:23 [kernel] [  810.012468] SCSI device sda: write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
May 19 20:12:08 [kernel] [  915.402338] APIC error on CPU0: 00(02)
May 19 20:12:08 [kernel] [  915.685418] APIC error on CPU0: 02(02)
May 19 20:14:13 [kernel] [ 1040.624274] ata1.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x2 frozen
May 19 20:14:13 [kernel] [ 1040.624288] ata1.00: cmd
b0/d8:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
May 19 20:14:13 [kernel] [ 1040.624291]          res
40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
May 19 20:14:14 [kernel] [ 1041.596505] ata1: soft resetting port
May 19 20:14:14 [kernel] [ 1041.758128] ATA: abnormal status 0x7F on
port 0x0001ec07
May 19 20:14:14 [kernel] [ 1041.768872] ATA: abnormal status 0x7F on
port 0x0001ec07
May 19 20:14:14 [kernel] [ 1041.775762] ata1.00: configured for UDMA/133
May 19 20:14:14 [kernel] [ 1041.775806] ata1: EH complete
May 19 20:14:14 [kernel] [ 1041.893216] SCSI device sda: 398297088
512-byte hdwr sectors (203928 MB)
May 19 20:14:14 [kernel] [ 1041.893598] sda: Write Protect is off
May 19 20:14:14 [kernel] [ 1041.893631] sda: Mode Sense: 00 3a 00 00
May 19 20:14:14 [kernel] [ 1041.894993] SCSI device sda: write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
May 19 20:15:09 [kernel] [ 1096.341264] APIC error on CPU0: 02(0a)

Since there is an apic error message I tried to disable apic. That
makes the situation worse, the reset after sata irq error does not
succeed, and the controller is disabled:

May 19 18:29:15 [kernel] [  948.679782] ata1.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x2 frozen
May 19 18:29:15 [kernel] [  948.679796] ata1.00: cmd
b0/d8:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
May 19 18:29:15 [kernel] [  948.679799]          res
40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
May 19 18:29:19 [kernel] [  952.498616] irq 10: nobody cared (try
booting with the "irqpoll" option)
May 19 18:29:19 [kernel] [  952.498626]  [<c010514a>]
show_trace_log_lvl+0x1a/0x30
May 19 18:29:19 [kernel] [  952.498639]  [<c0105912>] show_trace+0x12/0x20
May 19 18:29:19 [kernel] [  952.498645]  [<c0105a16>] dump_stack+0x16/0x20
May 19 18:29:19 [kernel] [  952.498650]  [<c014a037>] __report_bad_irq+0x27/0x90
May 19 18:29:19 [kernel] [  952.498659]  [<c014a2a9>] note_interrupt+0x209/0x240
May 19 18:29:19 [kernel] [  952.498664]  [<c014ad9b>] handle_level_irq+0xbb/0xf0
May 19 18:29:19 [kernel] [  952.498670]  [<c0106ba8>] do_IRQ+0x48/0xa0
May 19 18:29:19 [kernel] [  952.498675]  [<c0104bb6>] common_interrupt+0x2e/0x34
May 19 18:29:19 [kernel] [  952.498680]  [<c0121025>] do_softirq+0x55/0x60
May 19 18:29:19 [kernel] [  952.498690]  [<c0121298>] irq_exit+0x48/0x50
May 19 18:29:19 [kernel] [  952.498695]  [<c01112fa>]
smp_apic_timer_interrupt+0x4a/0x80
May 19 18:29:19 [kernel] [  952.498702]  [<c0104bef>]
apic_timer_interrupt+0x33/0x38
May 19 18:29:19 [kernel] [  952.498708]  [<c01023c2>] cpu_idle+0x42/0x70
May 19 18:29:19 [kernel] [  952.498712]  [<c0101147>] rest_init+0x37/0x40
May 19 18:29:19 [kernel] [  952.498716]  [<c03eec72>] start_kernel+0x342/0x3d0
May 19 18:29:19 [kernel] [  952.498727]  [<00000000>] 0x0
May 19 18:29:19 [kernel] [  952.498750]  =======================
May 19 18:29:19 [kernel] [  952.498752] handlers:
May 19 18:29:19 [kernel] [  952.498754] [<c0283fd0>] (ata_interrupt+0x0/0x200)
May 19 18:29:19 [kernel] [  952.498764] [<f09c0690>]
(ohci_irq_handler+0x0/0x990 [ohci1394])
May 19 18:29:19 [kernel] [  952.498777] [<f0990fb0>]
(usb_hcd_irq+0x0/0x60 [usbcore])
May 19 18:29:19 [kernel] [  952.498820] [<f0990fb0>]
(usb_hcd_irq+0x0/0x60 [usbcore])
May 19 18:29:19 [kernel] [  952.507947] ata1: soft resetting port
May 19 18:29:19 [kernel] [  952.669353] ATA: abnormal status 0x7F on
port 0x0001ec07
May 19 18:29:19 [kernel] [  952.679978] ATA: abnormal status 0x7F on
port 0x0001ec07

Adding irqpoll as suggested in the message makes things even worse,
the system locks up instead of just disabling the controller.

I also tried pci=routeirq with apic but it makes no noticeable difference.

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:07.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
00:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA
RAID Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon
9200 PRO] (rev 01)
01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200
PRO] (Secondary) (rev 01)


Linux 2.6.21.1-src #3 PREEMPT Sat May 19 14:40:27 CEST 2007 i686 AMD
Athlon(tm) XP 1800+ AuthenticAMD GNU/Linux

Gnu C                  4.1.1
Gnu make               3.81
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
reiserfsprogs          3.6.19
Linux C Library        > libc.2.5
Dynamic linker (ldd)   2.5
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               6.7
udev                   106
Modules Loaded         ohci1394 button nls_utf8 nls_cp852 vfat fat
nls_base usb_storage libusual radeon drm thermal processor fan ac
w83627hf hwmon_vid eeprom i2c_isa snd_pcm_oss snd_mixer_oss
snd_seq_oss snd_seq_midi_event snd_seq joydev genrtc ext3 jbd mbcache
cap
ability commoncap ohci_hcd usbhid hid sr_mod cdrom ata_generic
radeonfb fb_ddc i2c_algo_bit psmouse serio_raw rtc_cmos rtc_core rtc_l
ib parport_pc parport via_agp agpgart ehci_hcd uhci_hcd snd_via82xx
snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu4
01_uart snd_rawmidi snd_seq_device snd soundcore 3c59x evdev sg
ieee1394 pata_via i2c_viapro i2c_core usbcore

If you reply CC me, please.

Thanks

Michal
