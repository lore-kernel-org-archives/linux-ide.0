From: Mark Lord <liml@rtr.ca>
Subject: 2.6.17-rc6:  libata WARN_ON() in ata_scsi_error
Date: Wed, 07 Jun 2006 12:58:35 -0400
Message-ID: <448705BB.5060202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:61933 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932331AbWFGQ6n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jun 2006 12:58:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff -- I'm trying to figure out where the race that causes this is:

>ata6: status=0x51 { DriveReady SeekComplete Error }
>ata6: error=0x40 { UncorrectableError }
>BUG: warning at drivers/scsi/libata-scsi.c:792/ata_scsi_error()
>
>Call Trace: <ffffffff80283430>{ata_scsi_error+144} <ffffffff802746cc>{scsi_error_handler+220}
>       <ffffffff80181bb7>{__activate_task+39} <ffffffff80165a9f>{thread_return+0}
>       <ffffffff802745f0>{scsi_error_handler+0} <ffffffff802745f0>{scsi_error_handler+0}
>       <ffffffff801951c0>{keventd_create_kthread+0} <ffffffff8013569b>{kthread+219}
>       <ffffffff801625ba>{child_rip+8} <ffffffff801951c0>{keventd_create_kthread+0}
>       <ffffffff801355c0>{kthread+0} <ffffffff801625b2>{child_rip+0}
>PGD 75264067 PUD 75283067 PMD 0
>CPU 0
>Modules linked in: cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand cpufreq_conservative vi
>deo thermal processor fan container button battery ac dm_mod md_mod snd_seq_dummy snd_seq_oss ide_cd cdrom snd_seq_midi snd_seq_midi_event snd_seq af_p
>acket mousedev snd_via82xx snd_via82xx_modem snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_mpu401_uart psmouse ehci_hcd snd_pcm snd_timer s
>erio_raw snd_rawmidi snd_seq_device i2c_viapro sk98lin floppy pcspkr via82cxxx i2c_core snd snd_page_alloc uhci_hcd usbcore ide_core soundcore sata_mv
>sg unix
>Pid: 1693, comm: scsi_eh_5 Not tainted 2.6.17-rc5-git11 #7
>RIP: 0010:[__nosave_end+129921632/2132602880] <ffffffff88018260>{:sata_mv:mv_eng_timeout+64}
>RSP: 0018:ffff81007d54fe18  EFLAGS: 00010282
>RAX: ffff81007ddbb1c0 RBX: ffff81007f601c68 RCX: 0000000000008000
>RDX: ffff81007f601c68 RSI: 0000000000004e4f RDI: ffffffff88018cd8
>RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000033
>R10: 0000000000000001 R11: 000000000000000a R12: 0000000000000286
>R13: ffffffff802745f0 R14: ffff81007df59bc8 R15: ffffffff801951c0
>FS:  00002b0e1bad6d60(0000) GS:ffffffff803fc000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
>CR2: 0000000000000010 CR3: 0000000075270000 CR4: 00000000000006e0
>Process scsi_eh_5 (pid: 1693, threadinfo ffff81007d54e000, task ffff81007f9032a0)
>Stack: ffffffff802745f0 ffff81007f601c68 ffff81007f601800 ffffffff80283475
>       00000000fffffffc ffff81007f601800 ffff81007f601800 ffffffff802746cc
>       ffffffff80181bb7 ffff81007ea240c0
>Call Trace: <ffffffff802745f0>{scsi_error_handler+0}
>       <ffffffff80283475>{ata_scsi_error+213} <ffffffff802746cc>{scsi_error_handler+220}
>       <ffffffff80181bb7>{__activate_task+39} <ffffffff80165a9f>{thread_return+0}
>       <ffffffff802745f0>{scsi_error_handler+0} <ffffffff802745f0>{scsi_error_handler+0}
>       <ffffffff801951c0>{keventd_create_kthread+0} <ffffffff8013569b>{kthread+219}
>       <ffffffff801625ba>{child_rip+8} <ffffffff801951c0>{keventd_create_kthread+0}
>       <ffffffff801355c0>{kthread+0} <ffffffff801625b2>{child_rip+0}
>
>Code: 4c 8b 45 10 48 89 e9 48 8b 70 10 31 c0 4d 8d 48 70 e8 ca cd

This happens *after* several successful strides through error-handling
for the same (known) bad sector on a SATA drive attached to sata_mv.
My guess is that something from the earlier (successful) error-handling
is causing the later entry to have troubles.  2.6.17-rc6

Happens with/without the sata_mv eng_timeout patch that I also just posted.

Afterwards the drive is effectively locked-up.
I am recreating this with some "success" on an AMD64 kernel.

???? 
