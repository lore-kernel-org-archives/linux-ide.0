From: <Stuart_Hayes@Dell.com>
Subject: RE: [patch 1/3] libata: change drive ready wait after hard reset to 5s
Date: Wed, 11 Mar 2009 11:16:00 -0500
Message-ID: <DFEF91B22ED07447AB6AA4B237F913F902185BD2@ausx3mpc125.aus.amer.dell.com>
References: <200903041959.n24Jxl2X028532@imap1.linux-foundation.org> <49B76AA9.2030707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:40093 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbZCKQZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 12:25:49 -0400
Content-class: urn:content-classes:message
In-Reply-To: <49B76AA9.2030707@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> akpm@linux-foundation.org wrote:
>> From: Stuart Hayes <stuart_hayes@dell.com>
>> 
>> This fixes problems during resume with drives that take longer than
>> 1s to be ready.  The ATA-6 spec appears to allow 5 seconds for a
>> drive to be ready. 
>> 
>> On one affected system, this patch changes "PM: resume devices
>> took..." message from 17 seconds to 4 seconds, and gets rid of a lot
>> of ugly timeout/error messages.
> 
> Can you please attach log for this?  Which controller was it?
> 

Here's the relevant bits of the log... I don't have a copy of a whole
log, but I should be able to get one if there's something missing that
you need from this.  I had a more detailed description of what was
happening in a question I posted to linux-scsi back in January
(http://kerneltrap.org/index.php?q=mailarchive/linux-scsi/2009/1/20/4777
124).


[181214.964561] sd 0:0:0:0: [sda] Starting disk
[181220.664100] ata1: link is slow to respond, please be patient
(ready=0)
[181224.136100] ata1: softreset failed (device not ready)
[181224.136106] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[181229.136103] ata1.00: qc timeout (cmd 0xec)
[181229.136108] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[181229.136110] ata1.00: revalidation failed (errno=-5)
[181229.620102] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[181229.629530] ata1.00: configured for UDMA/133
[181229.629539] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9
t4
[181229.629541] ata1: irq_stat 0x00400040, connection status changed
[181229.640113] ata1.00: configured for UDMA/133
[181229.640116] ata1: EH complete
[181229.640159] sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors
(200050 MB)
[181229.640172] sd 0:0:0:0: [sda] Write Protect is off
[181229.640174] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[181229.640193] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[181229.640212] sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors
(200050 MB)
[181229.640223] sd 0:0:0:0: [sda] Write Protect is off
[181229.640225] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[181229.640243] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[181230.480106] usb 4-3: reset high speed USB device using ehci_hcd and
address 2
[181230.620234] PM: resume devices took 17.376 seconds
[181230.620240] ------------[ cut here ]------------
[181230.620241] WARNING: at
/build/buildd/linux-2.6.27/kernel/power/main.c:176
suspend_test_finish+0x74/0x80()
[181230.620243] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat
mmc_block af_packet binfmt_misc rfcomm bridge stp bnep sco l2cap
bluetooth vboxnetflt vboxdrv ppdev ipv6 acpi_cpufreq
cpufreq_conservative cpufreq_stats cpufreq_powersave cpufreq_userspace
cpufreq_ondemand freq_table pci_slot container sbs sbshc iptable_filter
ip_tables x_tables sbp2 parport_pc lp parport joydev psmouse dcdbas
uvcvideo nvidia(P) serio_raw evdev ieee80211_crypt_tkip compat_ioctl32
pcspkr agpgart wl(P) videodev v4l1_compat ieee80211_crypt i2c_core ac
battery sdhci_pci sdhci mmc_core ricoh_mmc video output snd_hda_intel
snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi
snd_rawmidi snd_seq_midi_event snd_seq wmi shpchp button snd_timer
snd_seq_device snd pci_hotplug soundcore snd_page_alloc ext3 jbd mbcache
sd_mod crc_t10dif sr_mod cdrom sg ohci_hcd ehci_hcd ahci libata scsi_mod
dock ohci1394 forcedeth ieee1394 usbcore thermal processor fan fbcon
tileblit font bitblit softcursor fuse
[181230.620293] Pid: 4199, comm: pm-suspend Tainted: P        W
2.6.27-11-generic #1
[181230.620296]  [<c037d386>] ? printk+0x1d/0x1f
[181230.620299]  [<c0131e99>] warn_on_slowpath+0x59/0x90
[181230.620303]  [<c014d305>] ? sched_clock_cpu+0xd5/0x170
[181230.620306]  [<c014c15f>] ? down_trylock+0x2f/0x40
[181230.620308]  [<c0132572>] ? try_acquire_console_sem+0x12/0x40
[181230.620311]  [<c024ed00>] ? kobject_put+0x20/0x50
[181230.620314]  [<c015d2b4>] suspend_test_finish+0x74/0x80
[181230.620317]  [<c015d3a6>] suspend_devices_and_enter+0xe6/0x190
[181230.620319]  [<c015d621>] enter_state+0xd1/0x100
[181230.620321]  [<c015d6d5>] state_store+0x85/0xd0
[181230.620323]  [<c015d650>] ? state_store+0x0/0xd0
[181230.620325]  [<c024ebc4>] kobj_attr_store+0x24/0x30
[181230.620328]  [<c01ffac7>] sysfs_write_file+0x97/0x100
[181230.620330]  [<c01b2760>] vfs_write+0xa0/0x110
[181230.620333]  [<c01ffa30>] ? sysfs_write_file+0x0/0x100
[181230.620335]  [<c01b28a2>] sys_write+0x42/0x70
[181230.620337]  [<c0103f7b>] sysenter_do_call+0x12/0x2f
[181230.620340]  [<c0370000>] ? init_memory_mapping+0x230/0x320
[181230.620343]  =======================
[181230.620345] ---[ end trace cefb6a77a684b9aa ]---
[181230.620805] PM: Finishing wakeup.
[181230.620807] Restarting tasks ... done.

>> Without this patch, the libata code moves on after 1s, tries to send
>> a soft reset (which the drive doesn't see because it isn't ready)
>> which also times out, then an IDENTIFY command is sent to the drive
>> which times out, and finally the error handler will try to send
>> another hard reset which will finally get things working.
> 
> This adds 5s delays to common detection paths.  That said, 1s could
> be too short. 
> 
>> diff -puN
>>
include/linux/libata.h~libata-change-drive-ready-wait-after-hard-reset
>> -to-5s include/linux/libata.h
>> ---
>>
a/include/linux/libata.h~libata-change-drive-ready-wait-after-hard-res
>> et-to-5s +++ a/include/linux/libata.h
>> @@ -275,7 +275,7 @@ enum {
>>  	 * advised to wait only for the following duration before
>>  	 * doing SRST.
>>  	 */
>> -	ATA_TMOUT_PMP_SRST_WAIT	= 1000,
>> +	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
> 
> Okay, it's already merged but this will add a lot of delay to device
> probing.  I think we better be a bit smarter here. 
> 
> Thanks.

