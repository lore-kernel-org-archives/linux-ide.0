From: Mark Lord <liml@rtr.ca>
Subject: Re: WARNING: at drivers/ata/libata-sff.c:1016
Date: Fri, 18 Apr 2008 20:02:09 -0400
Message-ID: <48093681.7050100@rtr.ca>
References: <4807F96F.8060500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4617 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756269AbYDSACF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Apr 2008 20:02:05 -0400
In-Reply-To: <4807F96F.8060500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun,
> 
> While flailing away the evening on sata_mv hotplug,
> I managed to get some complaints from libata-sff that
> do not appear to be due to any bug of my own (ha ha).
> 
> Looks like maybe a race or something?
..

Mmmm.. got another one, slightly different line perhaps,
though maybe it just moved around (latest libata-dev#upstream this morning).


ata201: SATA link down (SStatus 0 SControl 300)
ata202: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
------------[ cut here ]------------
WARNING: at drivers/ata/libata-sff.c:1211 ata_sff_hsm_move+0x595/0x628()
Modules linked in: sata_mv(+) nfs binfmt_misc rfcomm l2cap bluetooth nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs acpi_cpufreq cpufreq_stats cpufreq_powersave cpufreq_conservative cpufreq_userspace ac container fan battery af_packet firewire_sbp2 fuse mousedev snd_hda_intel snd_pcm_oss snd_pcm snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore firewire_ohci ehci_hcd psmouse r8169 firewire_core uhci_hcd sr_mod bitrev sg crc_itu_t intel_agp serio_raw crc32 usbcore floppy pcspkr snd_page_alloc cdrom thermal agpgart button processor unix [last unloaded: sata_mv]
Pid: 150, comm: ata/3 Not tainted 2.6.25-upstream #4
 [warn_on_slowpath+65/81] warn_on_slowpath+0x41/0x51
 [_spin_unlock_irqrestore+66/88] ? _spin_unlock_irqrestore+0x42/0x58
 [rb_insert_color+85/188] ? rb_insert_color+0x55/0xbc
 [_spin_unlock_irqrestore+54/88] ? _spin_unlock_irqrestore+0x36/0x58
 [ata_sff_hsm_move+1429/1576] ata_sff_hsm_move+0x595/0x628
 [delay_tsc+47/69] ? delay_tsc+0x2f/0x45
 [ata_pio_task+168/185] ata_pio_task+0xa8/0xb9
 [run_workqueue+187/390] run_workqueue+0xbb/0x186
 [run_workqueue+128/390] ? run_workqueue+0x80/0x186
 [ata_pio_task+0/185] ? ata_pio_task+0x0/0xb9
 [worker_thread+0/191] ? worker_thread+0x0/0xbf
 [worker_thread+180/191] worker_thread+0xb4/0xbf
 [autoremove_wake_function+0/51] ? autoremove_wake_function+0x0/0x33
 [kthread+59/100] kthread+0x3b/0x64
 [kthread+0/100] ? kthread+0x0/0x64
 [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace b9c8d67c25f0871c ]---
ata202.15: failed to read PMP GSCR[0] (Emask=0x10)
ata202: failed to recover some devices, retrying in 5 secs
ata202: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
