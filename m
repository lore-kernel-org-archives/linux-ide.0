From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: shasta driver crashes in dual cpu amd(tyan) machine
Date: Tue, 30 May 2006 20:01:20 +0200
Message-ID: <5d96567b0605301101q6dd7bf89ld6d0f34d9b420fc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:37732 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932370AbWE3SBW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 14:01:22 -0400
Received: by nf-out-0910.google.com with SMTP id i2so256119nfe
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2006 11:01:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

hello
i am using 2 promise controllers on tyan (h8dec). if i boot the
machine in a uniprocessor
kernel shasta works fine. booting dual cpu kernel i am having these
crashes.  kernel is 32bit kernel.

thank you

raz


May 29 19:51:22 localhost kernel:  [<c0403796>] schedule_timeout+0x56/0xb0
May 29 19:51:22 localhost kernel:  [<c0127d30>] process_timeout+0x0/0x10
May 29 19:51:22 localhost kernel:  [<c0127d30>] process_timeout+0x0/0x10
May 29 19:51:23 localhost kernel:  [<c0107e90>] do_gettimeofday+0x20/0xc0
May 29 19:51:23 localhost kernel:  [<c0107e90>] do_gettimeofday+0x20/0xc0
May 29 19:51:23 localhost kernel:  [<c0128114>] msleep+0x24/0x30
May 29 19:51:23 localhost kernel:  [<c0128114>] msleep+0x24/0x30
May 29 19:51:23 localhost kernel:  [<f881f1a7>]
shasta_handshake+0x117/0x190 [shasta]
May 29 19:51:23 localhost kernel:  [<f881f1a7>]
shasta_handshake+0x117/0x190 [shasta]
May 29 19:51:23 localhost kernel:  [<f881f008>] shasta_reset+0x38/0xc0 [shasta]
May 29 19:51:23 localhost kernel:  [<f881f008>] shasta_reset+0x38/0xc0 [shasta]
May 29 19:51:23 localhost kernel:  [<c03044ed>]
scsi_try_bus_device_reset+0x2d/0x50
May 29 19:51:23 localhost kernel:  [<c03044ed>]
scsi_try_bus_device_reset+0x2d/0x50
May 29 19:51:23 localhost kernel:  [<c030475e>]
scsi_eh_bus_device_reset+0x5e/0xe0
May 29 19:51:23 localhost kernel:  [<c030475e>]
scsi_eh_bus_device_reset+0x5e/0xe0
May 29 19:51:23 localhost kernel:  [<c0304ebf>] scsi_eh_ready_devs+0x4f/0xa0
May 29 19:51:23 localhost kernel:  [<c0304ebf>] scsi_eh_ready_devs+0x4f/0xa0
May 29 19:51:23 localhost kernel:  [<c0305068>] scsi_unjam_host+0xb8/0xc0
May 29 19:51:23 localhost kernel:  [<c0305068>] scsi_unjam_host+0xb8/0xc0
May 29 19:51:23 localhost kernel:  [<c03050e8>] scsi_error_handler+0x78/0xb0
May 29 19:51:23 localhost kernel:  [<c03050e8>] scsi_error_handler+0x78/0xb0
May 29 19:51:23 localhost kernel:  [<c0305070>] scsi_error_handler+0x0/0xb0
May 29 19:51:23 localhost kernel:  [<c0305070>] scsi_error_handler+0x0/0xb0
May 29 19:51:23 localhost kernel:  [<c0133777>] kthread+0xb7/0xc0
May 29 19:51:23 localhost kernel:  [<c0133777>] kthread+0xb7/0xc0
May 29 19:51:23 localhost kernel:  [<c01336c0>] kthread+0x0/0xc0
May 29 19:51:23 localhost kernel:  [<c01336c0>] kthread+0x0/0xc0
May 29 19:51:23 localhost kernel:  [<c0101275>] kernel_thread_helper+0x5/0x10
May 29 19:51:23 localhost kernel:  [<c0101275>] kernel_thread_helper+0x5/0x10
May 29 19:53:20 localhost kernel: irq 7: nobody cared (try booting
with the "irqpoll" option)
May 29 19:53:20 localhost kernel: irq 7: nobody cared (try booting
with the "irqpoll" option)
May 29 19:53:20 localhost kernel:  [<c0141cca>] __report_bad_irq+0x2a/0x90
May 29 19:53:20 localhost kernel:  [<c0141cca>] __report_bad_irq+0x2a/0x90
May 29 19:53:20 localhost kernel:  [<c01414e0>] handle_IRQ_event+0x30/0x70
May 29 19:53:20 localhost kernel:  [<c01414e0>] handle_IRQ_event+0x30/0x70
May 29 19:53:20 localhost kernel:  [<c0141dd0>] note_interrupt+0x80/0xf0
May 29 19:53:20 localhost kernel:  [<c0141dd0>] note_interrupt+0x80/0xf0
May 29 19:53:20 localhost kernel:  [<c0141618>] __do_IRQ+0xf8/0x120
May 29 19:53:20 localhost kernel:  [<c0141618>] __do_IRQ+0xf8/0x120
May 29 19:53:20 localhost kernel:  [<c0105919>] do_IRQ+0x19/0x30
May 29 19:53:20 localhost kernel:  [<c0105919>] do_IRQ+0x19/0x30
May 29 19:53:20 localhost kernel:  [<c0103c12>] common_interrupt+0x1a/0x20
May 29 19:53:20 localhost kernel:  [<c0103c12>] common_interrupt+0x1a/0x20


lspci out


00:00.0 Memory controller: nVidia Corporation: Unknown device 005e (rev a3)
00:01.0 ISA bridge: nVidia Corporation: Unknown device 0051 (rev a3)
00:01.1 SMBus: nVidia Corporation: Unknown device 0052 (rev a2)
00:04.0 Multimedia audio controller: nVidia Corporation: Unknown
device 0059 (rev a2)
00:06.0 IDE interface: nVidia Corporation: Unknown device 0053 (rev f2)
00:09.0 PCI bridge: nVidia Corporation: Unknown device 005c (rev a2)
00:0a.0 Bridge: nVidia Corporation: Unknown device 0057 (rev a3)
00:0d.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3)
00:0e.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
03:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 03)
04:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7458 (rev 12)
04:01.1 PIC: Advanced Micro Devices [AMD]: Unknown device 7459 (rev 12)
04:02.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7458 (rev 12)
04:02.1 PIC: Advanced Micro Devices [AMD]: Unknown device 7459 (rev 12)
05:01.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 03)
05:02.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 03)
06:04.0 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
06:04.1 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
06:06.0 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
06:06.1 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
07:04.0 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
07:04.1 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
07:06.0 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
07:06.1 Ethernet controller: Intel Corp.: Unknown device 1079 (rev 03)
80:00.0 Memory controller: nVidia Corporation: Unknown device 005e (rev a3)
80:01.0 Memory controller: nVidia Corporation: Unknown device 00d3 (rev a3)
80:0a.0 Bridge: nVidia Corporation: Unknown device 0057 (rev a3)
80:0d.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3)
80:0e.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3)
81:00.0 PCI bridge: Intel Corp.: Unknown device 0370
81:00.2 PCI bridge: Intel Corp.: Unknown device 0372
83:0e.0 RAID bus controller: Promise Technology, Inc.: Unknown device 8350
84:00.0 PCI bridge: Intel Corp.: Unknown device 0370
84:00.2 PCI bridge: Intel Corp.: Unknown device 0372
86:0e.0 RAID bus controller: Promise Technology, Inc.: Unknown device 8350
[
-- 
Raz
