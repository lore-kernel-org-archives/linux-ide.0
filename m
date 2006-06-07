From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.17-rc6:  libata WARN_ON() in ata_scsi_error
Date: Wed, 07 Jun 2006 13:45:50 -0400
Message-ID: <448710CE.6020700@rtr.ca>
References: <448705BB.5060202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:14483 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750857AbWFGRp6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jun 2006 13:45:58 -0400
In-Reply-To: <448705BB.5060202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff -- I'm trying to figure out where the race that causes this is:
> 
>> ata6: status=0x51 { DriveReady SeekComplete Error }
>> ata6: error=0x40 { UncorrectableError }
>> BUG: warning at drivers/scsi/libata-scsi.c:792/ata_scsi_error()
..
..
>> RIP: 0010:[__nosave_end+129921632/2132602880] 
>> <ffffffff88018260>{:sata_mv:mv_eng_timeout+64}
..

Mmmm... happens with sata_via, as well.  Must be a libata-core issue (?):


ata2: translated ATA stat/err 0x51/40 to SCSI SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x40 { UncorrectableError }
BUG: warning at drivers/scsi/libata-scsi.c:792/ata_scsi_error()

Call Trace: <ffffffff80283430>{ata_scsi_error+144} <ffffffff802746cc>{scsi_error_handler+220}
       <ffffffff80181bb7>{__activate_task+39} <ffffffff80165a9f>{thread_return+0}
       <ffffffff802745f0>{scsi_error_handler+0} <ffffffff802745f0>{scsi_error_handler+0}
       <ffffffff801951c0>{keventd_create_kthread+0} <ffffffff8013569b>{kthread+219}
       <ffffffff801625ba>{child_rip+8} <ffffffff801951c0>{keventd_create_kthread+0}
       <ffffffff801355c0>{kthread+0} <ffffffff801625b2>{child_rip+0}
Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
<ffffffff8027edc2>{ata_eng_timeout+50}
PGD 7b288067 PUD 7b27d067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand cpufreq_conservative video thermal processor fan container button battery ac dm_mod md_mod ide_cd cdrom snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq af_packet mousedev snd_via82xx_modem snd_via82xx snd_ac97_codec snd_ac97_bus snd_mpu401_uart snd_pcm_oss snd_mixer_oss i2c_viapro snd_rawmidi snd_seq_device psmouse via82cxxx snd_pcm snd_timer i2c_core uhci_hcd ehci_hcd floppy pcspkr serio_raw ide_core snd_page_alloc snd soundcore usbcore sk98lin sata_mv sg unix
Pid: 740, comm: scsi_eh_1 Not tainted 2.6.17-rc5-git11 #8
RIP: 0010:[<ffffffff8027edc2>] <ffffffff8027edc2>{ata_eng_timeout+50}
RSP: 0018:ffff81007f9d5e08  EFLAGS: 00010282
RAX: 00000000fafbfcfd RBX: ffff81007f931468 RCX: 0000000000008000
RDX: ffff81007f9315d0 RSI: ffff81007f9d5dc8 RDI: ffff81007f931468
RBP: ffff81007f931000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000000000a R12: 0000000000000000
R13: ffffffff802745f0 R14: ffff810002f43b88 R15: ffffffff801951c0
FS:  00002b450f83ab60(0000) GS:ffffffff803fc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 000000007b293000 CR4: 00000000000006e0
Process scsi_eh_1 (pid: 740, threadinfo ffff81007f9d4000, task ffff81007ff795b0)
Stack: ffff81007f931468 ffff81007f931000 0000000000000286 ffffffff802745f0
       ffff810002f43b88 ffffffff80283475 00000000fffffffc ffff81007f931000
       ffff81007f931000 ffffffff802746cc
Call Trace: <ffffffff802745f0>{scsi_error_handler+0}
       <ffffffff80283475>{ata_scsi_error+213} <ffffffff802746cc>{scsi_error_handler+220}
       <ffffffff80181bb7>{__activate_task+39} <ffffffff80165a9f>{thread_return+0}
       <ffffffff802745f0>{scsi_error_handler+0} <ffffffff802745f0>{scsi_error_handler+0}
       <ffffffff801951c0>{keventd_create_kthread+0} <ffffffff8013569b>{kthread+219}
       <ffffffff801625ba>{child_rip+8} <ffffffff801951c0>{keventd_create_kthread+0}
       <ffffffff801355c0>{kthread+0} <ffffffff801625b2>{child_rip+0}

Code: 49 8b 2c 24 c7 85 e8 02 00 00 01 00 00 00 9c 41 5e fa 65 48
RIP <ffffffff8027edc2>{ata_eng_timeout+50} RSP <ffff81007f9d5e08>
CR2: 0000000000000000



