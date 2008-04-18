From: Mark Lord <liml@rtr.ca>
Subject: WARNING: at drivers/ata/libata-sff.c:1016
Date: Thu, 17 Apr 2008 21:29:19 -0400
Message-ID: <4807F96F.8060500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3299 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbYDRB3V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Apr 2008 21:29:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun,

While flailing away the evening on sata_mv hotplug,
I managed to get some complaints from libata-sff that
do not appear to be due to any bug of my own (ha ha).

Looks like maybe a race or something?

[  353.852823] ata123: mv_err_intr: serr=04010000  <<< hot inserted drive here >>>

[  303.068080] ata123: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
[  303.068080] ata123: edma_err 0x00000030, SError=04010000, dev connect, SError
[  303.068080] ata123: SError: { PHYRdyChg DevExch }
[  303.068080] ata123: hard resetting link
[  303.068080] ata123: serr=04010000 serr_mask=019d0000
[  303.068080] ata123: serr=00000000 serr_mask=019c0000
[  303.144771] ata123: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  303.154762] ------------[ cut here ]------------
[  303.154768] WARNING: at drivers/ata/libata-sff.c:1016 ata_sff_hsm_move+0x26/0x628()
[  303.154770] Modules linked in: sata_mv nfs binfmt_misc rfcomm l2cap bluetooth nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs acpi_cpufreq cpufreq_stats cpufreq_powersave cpufreq_conservative cpufreq_userspace ac container fan battery af_packet firewire_sbp2 fuse mousedev snd_hda_intel snd_pcm_oss snd_pcm snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer firewire_ohci snd_seq_device firewire_core r8169 sg thermal intel_agp bitrev crc32 snd ehci_hcd uhci_hcd floppy psmouse serio_raw pcspkr sr_mod cdrom crc_itu_t agpgart soundcore snd_page_alloc usbcore button processor unix [last unloaded: sata_mv]
[  303.154839] Pid: 154, comm: ata/1 Not tainted 2.6.25-upstream #12
[  303.154845]  [warn_on_slowpath+65/81] warn_on_slowpath+0x41/0x51
[  303.154861]  [_spin_unlock_irqrestore+54/88] ? _spin_unlock_irqrestore+0x36/0x58
[  303.154874]  [mark_held_locks+65/92] ? mark_held_locks+0x41/0x5c
[  303.154881]  [_spin_unlock_irqrestore+54/88] ? _spin_unlock_irqrestore+0x36/0x58
[  303.154887]  [trace_hardirqs_on+225/258] ? trace_hardirqs_on+0xe1/0x102
[  303.154894]  [_spin_unlock_irqrestore+66/88] ? _spin_unlock_irqrestore+0x42/0x58
[  303.154902]  [try_to_del_timer_sync+72/79] ? try_to_del_timer_sync+0x48/0x4f
[  303.154910]  [ata_sff_hsm_move+38/1576] ata_sff_hsm_move+0x26/0x628
[  303.154917]  [process_timeout+0/10] ? process_timeout+0x0/0xa
[  303.154923]  [schedule_timeout+104/139] ? schedule_timeout+0x68/0x8b
[  303.154929]  [delay_tsc+47/69] ? delay_tsc+0x2f/0x45
[  303.154937]  [ata_pio_task+168/185] ata_pio_task+0xa8/0xb9
[  303.154943]  [run_workqueue+187/390] run_workqueue+0xbb/0x186
[  303.154950]  [run_workqueue+128/390] ? run_workqueue+0x80/0x186
[  303.154956]  [ata_pio_task+0/185] ? ata_pio_task+0x0/0xb9
[  303.154964]  [worker_thread+0/191] ? worker_thread+0x0/0xbf
[  303.154970]  [worker_thread+180/191] worker_thread+0xb4/0xbf
[  303.154976]  [autoremove_wake_function+0/51] ? autoremove_wake_function+0x0/0x33
[  303.154984]  [kthread+59/100] kthread+0x3b/0x64
[  303.154989]  [kthread+0/100] ? kthread+0x0/0x64
[  303.154994]  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
[  303.155002]  =======================
[  303.155006] ---[ end trace e0a256c019b03b26 ]---
[  303.155289] ata123.00: failed to IDENTIFY (I/O error, err_mask=0x100)
[  303.155293] ata123: failed to recover some devices, retrying in 5 secs
[  303.211417] ata123: hard resetting link
[  303.211424] ata123: serr=00000000 serr_mask=019d0000
[  303.214798] ata123: serr=00000000 serr_mask=019c0000
[  303.261429] ata123: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  303.271420] ------------[ cut here ]------------
[  303.271425] WARNING: at drivers/ata/libata-sff.c:1016 ata_sff_hsm_move+0x26/0x628()
[  303.271427] Modules linked in: sata_mv nfs binfmt_misc rfcomm l2cap bluetooth nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs acpi_cpufreq cpufreq_stats cpufreq_powersave cpufreq_conservative cpufreq_userspace ac container fan battery af_packet firewire_sbp2 fuse mousedev snd_hda_intel snd_pcm_oss snd_pcm snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer firewire_ohci snd_seq_device firewire_core r8169 sg thermal intel_agp bitrev crc32 snd ehci_hcd uhci_hcd floppy psmouse serio_raw pcspkr sr_mod cdrom crc_itu_t agpgart soundcore snd_page_alloc usbcore button processor unix [last unloaded: sata_mv]
[  303.271498] Pid: 154, comm: ata/1 Not tainted 2.6.25-upstream #12
[  303.271502]  [warn_on_slowpath+65/81] warn_on_slowpath+0x41/0x51
[  303.271517]  [_spin_unlock_irqrestore+54/88] ? _spin_unlock_irqrestore+0x36/0x58
[  303.271530]  [mark_held_locks+65/92] ? mark_held_locks+0x41/0x5c
[  303.271536]  [_spin_unlock_irqrestore+54/88] ? _spin_unlock_irqrestore+0x36/0x58
[  303.271545]  [trace_hardirqs_on+225/258] ? trace_hardirqs_on+0xe1/0x102
[  303.271551]  [_spin_unlock_irqrestore+66/88] ? _spin_unlock_irqrestore+0x42/0x58
[  303.271559]  [try_to_del_timer_sync+72/79] ? try_to_del_timer_sync+0x48/0x4f
[  303.271566]  [ata_sff_hsm_move+38/1576] ata_sff_hsm_move+0x26/0x628
[  303.271573]  [process_timeout+0/10] ? process_timeout+0x0/0xa
[  303.271580]  [schedule_timeout+104/139] ? schedule_timeout+0x68/0x8b
[  303.271586]  [delay_tsc+47/69] ? delay_tsc+0x2f/0x45
[  303.271593]  [ata_pio_task+168/185] ata_pio_task+0xa8/0xb9
[  303.271600]  [run_workqueue+187/390] run_workqueue+0xbb/0x186
[  303.271605]  [run_workqueue+128/390] ? run_workqueue+0x80/0x186
[  303.271611]  [ata_pio_task+0/185] ? ata_pio_task+0x0/0xb9
[  303.271619]  [worker_thread+0/191] ? worker_thread+0x0/0xbf
[  303.271625]  [worker_thread+180/191] worker_thread+0xb4/0xbf
[  303.271631]  [autoremove_wake_function+0/51] ? autoremove_wake_function+0x0/0x33
[  303.271638]  [kthread+59/100] kthread+0x3b/0x64
[  303.271643]  [kthread+0/100] ? kthread+0x0/0x64
[  303.271649]  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
[  303.271656]  =======================
[  303.271660] ---[ end trace e0a256c019b03b26 ]---
[  303.271941] ata123.00: failed to IDENTIFY (I/O error, err_mask=0x100)
[  303.271944] ata123: failed to recover some devices, retrying in 5 secs
[  303.331410] ata123: hard resetting link
[  303.331418] ata123: serr=00000000 serr_mask=019d0000
[  303.334790] ata123: serr=00000000 serr_mask=019c0000
[  303.388088] ata123: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  303.398078] ------------[ cut here ]------------
[  303.398083] WARNING: at drivers/ata/libata-sff.c:1016 ata_sff_hsm_move+0x26/0x628()
[  303.398085] Modules linked in: sata_mv nfs binfmt_misc rfcomm l2cap bluetooth nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs acpi_cpufreq cpufreq_stats cpufreq_powersave cpufreq_conservative cpufreq_userspace ac container fan battery af_packet firewire_sbp2 fuse mousedev snd_hda_intel snd_pcm_oss snd_pcm snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer firewire_ohci snd_seq_device firewire_core r8169 sg thermal intel_agp bitrev crc32 snd ehci_hcd uhci_hcd floppy psmouse serio_raw pcspkr sr_mod cdrom crc_itu_t agpgart soundcore snd_page_alloc usbcore button processor unix [last unloaded: sata_mv]
[  303.398152] Pid: 154, comm: ata/1 Not tainted 2.6.25-upstream #12
[  303.398156]  [warn_on_slowpath+65/81] warn_on_slowpath+0x41/0x51
[  303.398172]  [_spin_unlock_irqrestore+54/88] ? _spin_unlock_irqrestore+0x36/0x58
[  303.398185]  [mark_held_locks+65/92] ? mark_held_locks+0x41/0x5c
[  303.398192]  [_spin_unlock_irqrestore+54/88] ? _spin_unlock_irqrestore+0x36/0x58
[  303.398198]  [trace_hardirqs_on+225/258] ? trace_hardirqs_on+0xe1/0x102
[  303.398205]  [_spin_unlock_irqrestore+66/88] ? _spin_unlock_irqrestore+0x42/0x58
[  303.398212]  [try_to_del_timer_sync+72/79] ? try_to_del_timer_sync+0x48/0x4f
[  303.398220]  [ata_sff_hsm_move+38/1576] ata_sff_hsm_move+0x26/0x628
[  303.398226]  [process_timeout+0/10] ? process_timeout+0x0/0xa
[  303.398234]  [schedule_timeout+104/139] ? schedule_timeout+0x68/0x8b
[  303.398240]  [delay_tsc+47/69] ? delay_tsc+0x2f/0x45
[  303.398248]  [ata_pio_task+168/185] ata_pio_task+0xa8/0xb9
[  303.398255]  [run_workqueue+187/390] run_workqueue+0xbb/0x186
[  303.398261]  [run_workqueue+128/390] ? run_workqueue+0x80/0x186
[  303.398267]  [ata_pio_task+0/185] ? ata_pio_task+0x0/0xb9
[  303.398274]  [worker_thread+0/191] ? worker_thread+0x0/0xbf
[  303.398281]  [worker_thread+180/191] worker_thread+0xb4/0xbf
[  303.398287]  [autoremove_wake_function+0/51] ? autoremove_wake_function+0x0/0x33
[  303.398295]  [kthread+59/100] kthread+0x3b/0x64
[  303.398299]  [kthread+0/100] ? kthread+0x0/0x64
[  303.398305]  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
[  303.398312]  =======================
[  303.398314] ---[ end trace e0a256c019b03b26 ]---
[  303.398594] ata123.00: failed to IDENTIFY (I/O error, err_mask=0x100)
[  303.398597] ata123: failed to recover some devices, retrying in 5 secs
[  303.561410] ata123: hard resetting link
[  303.561419] ata123: serr=00000000 serr_mask=019d0000
[  303.564791] ata123: serr=00000000 serr_mask=019c0000
[  303.611408] ata123: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  303.611429] ata123: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x1 t4
[  303.611490] ata123: unexpected device interrupt
[  303.611545] ata123: EH complete
