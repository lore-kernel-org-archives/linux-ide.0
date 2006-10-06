From: Olivier Kaloudoff <kalou@kalou.net>
Subject: feedback with VIA vt8251 and 2.6.17.4
Date: Fri, 6 Oct 2006 07:17:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610051835140.1955@s1.ckr-solutions.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s1.ckr-solutions.com ([82.97.10.19]:6028 "EHLO
	s1.ckr-solutions.com") by vger.kernel.org with ESMTP
	id S932581AbWJFFPB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Oct 2006 01:15:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by s1.ckr-solutions.com (Postfix) with ESMTP id 82B9487DB
	for <linux-ide@vger.kernel.org>; Fri,  6 Oct 2006 07:17:11 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

 	I just patched and installed kernel
2.6.17-1.2139_FC4 with patch [1] . Using 2x brand new
"Maxtor 6V250F0 Rev: VA11", and a md raid 1 array, I
got the following errors in my log ([2] for full details);

Apr  4 07:54:29 raidy kernel: BUG: warning at 
drivers/scsi/ahci.c:1291/ahci_host_intr() (Not tainted)
Apr  4 07:54:29 raidy kernel:  <dc827e66> ahci_interrupt+0x10a/0x218 
[ahci]  <c043d4d4> handle_IRQ_event+0x21/0x4a
Apr  4 07:54:29 raidy kernel:  <c043d575> __do_IRQ+0x78/0xcb  <c0404ad2> 
do_IRQ+0x5e/0x7a
Apr  4 07:54:29 raidy kernel:  =======================
Apr  4 07:54:29 raidy kernel:  <c0403602> common_interrupt+0x1a/0x20 
<dc82007b> sd_store_cache_type+0x7b/0x16d [sd_mod]
Apr  4 07:54:29 raidy kernel:  <c05fbb0a> _spin_unlock_irqrestore+0xa/0xc 
<dc827ca9> ahci_eng_timeout+0x63/0x6e [ahci]
Apr  4 07:54:29 raidy kernel:  <dc875e0b> scsi_error_handler+0x0/0x117 
[scsi_mod]  <dc8c4d85> ata_scsi_error+0xaa/0x111 [libata]
Apr  4 07:54:29 raidy kernel:  <dc875eb8> scsi_error_handler+0xad/0x117 
[scsi_mod]  <c042bcfd> kthread+0x75/0x9d
Apr  4 07:54:29 raidy kernel:  <c042bc88> kthread+0x0/0x9d  <c04012ad> 
kernel_thread_helper+0x5/0xb


After this, I could not see the SATA drives anymore, had to reboot.

I don't know how to reproduce the problem, nor if it's hw related
or really a sw problem.

If you have any advice on this or suggestion on how to stress the
whole disk subsystem to trigger such problems, let me know.


Sincere Regards,



[1] - 
http://www.linux.org.py/wiki/_media/howto/linux-2.6.17-vt8251-ahci-rcx.patch.txt?id=howto%3Asata_vt8251_centos4&cache=cache

[2] - http://pastebin.com/801182



Olivier Kaloudoff
Saint Raphael
France
