From: Siddhartha Jain <siddhartha@siddharthajain.net>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Mon, 30 Aug 2010 17:59:09 -0700
Message-ID: <AANLkTin5uTJA0G+hWxfsGFhyC_N9ZR7rZN9qCjK5VyvU@mail.gmail.com>
References: <1283027290.2721.37.camel@myfedorahat>
	<4C7BAA42.2050809@kernel.org>
	<AANLkTimEQEAF7WfCmmSfS_Ryq7HEfqemAnh9BvdKRhqL@mail.gmail.com>
	<AANLkTi=3BVGUSNUZn=QbDciWdhBPmxe0kQgKcBFtkSH7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33571 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187Ab0HaA7K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2010 20:59:10 -0400
Received: by pxi10 with SMTP id 10so2276519pxi.19
        for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2010 17:59:09 -0700 (PDT)
In-Reply-To: <AANLkTi=3BVGUSNUZn=QbDciWdhBPmxe0kQgKcBFtkSH7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Re-installed with encryption off and netconsole logging on. Same
result, that is, sda switches to sdc and everything goes haywire.

eth0: link up.
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#2884877 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#2884877 offset 0
sd 0:0:0:0: [sda] Stopping disk
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#13631490 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670077 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670077 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3677072 offset 0
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456489 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670077 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456489 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D4456517, block=3D17825828
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3691827 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3812945 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3681172 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670113 offset 0
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#2884877 offset 0
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MJA2250B 0081 PQ: 0 AN=
SI: 5
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata2.00: detaching (SCSI 1:0:0:0)
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#2884877 offset 0
sd 0:0:0:0: [sdc] 488397168 512-byte logical blocks: (250 GB/232 GiB)
sd 0:0:0:0: [sdc] Write Protect is off
sd 0:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc:
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456489 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670077 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670017 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670068 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#10485761 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670068 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRW  GS23N     SB03 PQ: 0 AN=
SI: 5
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456486 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
sr 1:0:0:0: Attached scsi CD-ROM sr0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#2883586 offset 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
EXT4-fs error (device sda2): ext4_find_entry: reading directory #2 offs=
et 0
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
 sdc1 sdc2 sdc3
sd 0:0:0:0: [sdc] Attached SCSI disk
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670077 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#3670026 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
EXT4-fs error (device sda2): ext4_find_entry: reading directory
#4456450 offset 0
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D2885332, block=3D11534477
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D13631490, block=3D54525984
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D13631490, block=3D54525984
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D13631490, block=3D54525984
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D13631490, block=3D54525984
EXT4-fs error (device sda2): __ext4_get_inode_loc: unable to read
inode block - inode=3D13631490, block=3D54525984



On Mon, Aug 30, 2010 at 3:26 PM, Siddhartha Jain
<siddhartha@siddharthajain.net> wrote:
> Got into runlevel 3 and manually invoked suspend via "pm-suspend". On
> resume, got these logs via netconsole. For some reason, sda becomes
> sdc and all sorts of panicking ensues.
>
>
> PM: Syncing filesystems ... done.
> PM: Preparing system for mem sleep
> Freezing user space processes ... (elapsed 0.01 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> PM: Entering mem sleep
> Suspending console(s) (use no_console_suspend to debug)
> eth0: link up.
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> Buffer I/O error on device dm-0, logical block 41791664
> lost page write due to I/O error on dm-0
> Buffer I/O error on device dm-0, logical block 41791665
> lost page write due to I/O error on dm-0
> Buffer I/O error on device dm-0, logical block 41791666
> lost page write due to I/O error on dm-0
> Buffer I/O error on device dm-0, logical block 41800003
> lost page write due to I/O error on dm-0
> Buffer I/O error on device dm-0, logical block 41963521
> lost page write due to I/O error on dm-0
> Buffer I/O error on device dm-0, logical block 41789440
> lost page write due to I/O error on dm-0
> Buffer I/O error on device dm-0, logical block 41789449
> lost page write due to I/O error on dm-0
> Buffer I/O error on device dm-0, logical block 41791667
> lost page write due to I/O error on dm-0
> Buffer I/O error on device dm-0, logical block 41791667
> lost page write due to I/O error on dm-0
> EXT3-fs: ext3_journal_dirty_data: aborting transaction: IO failure in
> ext3_journal_dirty_data
> EXT3-fs (dm-0): error in ext3_orphan_add: Readonly filesystem
> EXT3-fs (dm-0): error in ext3_ordered_write_end: IO failure
> ------------[ cut here ]------------
> WARNING: at fs/buffer.c:1159 mark_buffer_dirty+0x2b/0x86()
> Hardware name: MacBookPro5,4
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0Modules linked in: rfcomm
> sco bridge stp llc bnep l2cap sbs sbshc coretemp sunrpc
> cpufreq_ondemand acpi_cpufreq freq_table ip6t_REJECT nf_conntrack_ipv=
6
> ip6table_filter ip6_tables ipv6 netconsole configfs uinput b43
> snd_hda_codec_cirrus snd_hda_intel mac80211 snd_hda_codec cfg80211
> snd_hwdep snd_seq uvcvideo snd_seq_device ssb snd_pcm applesmc
> snd_timer videodev snd forcedeth v4l1_compat mmc_core shpchp
> v4l2_compat_ioctl32 btusb soundcore snd_page_alloc bluetooth
> i2c_nforce2 joydev input_polldev bcm5974 appleir rfkill mbp_nvidia_bl
> microcode aes_x86_64 aes_generic xts gf128mul dm_crypt firewire_ohci
> usb_storage firewire_core crc_itu_t nouveau ttm drm_kms_helper drm
> i2c_algo_bit vid
> eo output i2c_core [last unloaded: scsi_wait_scan]
> Pid: 1989, comm: rsyslogd Not tainted 2.6.33.8-149.fc13.x86_64 #1
> Call Trace:
> =A0[<ffffffff81049ecc>] warn_slowpath_common+0x77/0x8f
> =A0[<ffffffff81049ef3>] warn_slowpath_null+0xf/0x11
> =A0[<ffffffff81120247>] mark_buffer_dirty+0x2b/0x86
> =A0[<ffffffff81162b24>] ext3_commit_super.clone.0+0x54/0x64
> =A0[<ffffffff81162bc4>] ext3_handle_error+0x90/0xb7
> =A0[<ffffffff81162c5d>] __ext3_std_error+0x72/0x8f
> =A0[<ffffffff81162cb9>] __ext3_journal_stop+0x3f/0x49
> =A0[<ffffffff8115cf9d>] ext3_ordered_write_end+0xd7/0x11b
> =A0[<ffffffff810bf335>] generic_file_buffered_write+0x165/0x25f
> =A0[<ffffffff8115ae9d>] ? ext3_dirty_inode+0x7b/0x84
> =A0[<ffffffff810c0479>] __generic_file_aio_write+0x247/0x27c
> =A0[<ffffffff810c0506>] generic_file_aio_write+0x58/0xa2
> =A0[<ffffffff811000cd>] do_sync_write+0xbf/0xfc
> =A0[<ffffffff8103b7d4>] ? pick_next_task+0x22/0x41
> =A0[<ffffffff81427c78>] ? schedule+0x850/0x8e6
> =A0[<ffffffff8100f02f>] ? native_sched_clock+0x2d/0x5f
> =A0[<ffffffff811bcb9f>] ? security_file_permission+0x11/0x13
> =A0[<ffffffff8110062b>] vfs_write+0xa9/0x106
> =A0[<ffffffff8110073e>] sys_write+0x45/0x69
> =A0[<ffffffff81008b02>] system_call_fastpath+0x16/0x1b
> ---[ end trace 65d387dd571aab2f ]---
> JBD: Detected IO errors while flushing file data on dm-0
> Aborting journal on device dm-0.
> EXT3-fs (dm-0): error in ext3_orphan_add: Journal has aborted
> EXT3-fs (dm-0): error in ext3_truncate: Journal has aborted
> JBD: Detected IO errors while flushing file data on dm-0
> EXT3-fs (dm-0): error: ext3_journal_start_sb: Detected aborted journa=
l
> EXT3-fs (dm-0): error: ext3_journal_start_sb: Detected aborted journa=
l
> EXT3-fs (dm-0): error: remounting filesystem read-only
> INFO: task ata_aux:27 blocked for more than 120 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> ata_aux =A0 =A0 =A0 D ffff8800057157c0 =A0 =A0 0 =A0 =A027 =A0 =A0 =A0=
2 0x00000000
> =A0ffff88013b441950 0000000000000046 ffff8801382a0000 000000000000000=
0
> =A0ffff88013b4418d0 ffffffff812bb5f8 ffff88013b441960 ffff88013b441fd=
8
> =A0ffff88013b441fd8 000000000000f9b0 00000000000157c0 ffff88013b43b26=
8
> Call Trace:
> =A0[<ffffffff812bb5f8>] ? __scsi_get_command+0x15/0x90
> =A0[<ffffffff81428079>] schedule_timeout+0x31/0xde
> =A0[<ffffffff811fb10c>] ? kobject_put+0x47/0x4b
> =A0[<ffffffff812a8a74>] ? put_device+0x12/0x14
> =A0[<ffffffff81427f0b>] wait_for_common+0xd1/0x12c
> =A0[<ffffffff81044f21>] ? default_wake_function+0x0/0xf
> =A0[<ffffffff811e980c>] ? __generic_unplug_device+0x2d/0x32
> =A0[<ffffffff81427ff0>] wait_for_completion+0x18/0x1a
> =A0[<ffffffff811ed7a1>] blk_execute_rq+0xa1/0xd0
> =A0[<ffffffffa014126c>] ? write_msg+0xe5/0xf4 [netconsole]
> =A0[<ffffffff811ea366>] ? blk_get_request+0x3c/0x72
> =A0[<ffffffff812c1ca5>] scsi_execute+0xf1/0x143
> =A0[<ffffffff812c1d9b>] scsi_execute_req+0xa4/0xd6
> =A0[<ffffffff812c8ef8>] sd_sync_cache+0x95/0xf3
> =A0[<ffffffff81427274>] ? printk+0x3c/0x40
> =A0[<ffffffff812c9115>] sd_shutdown+0x93/0x116
> =A0[<ffffffff812c92da>] sd_remove+0x56/0x8b
> =A0[<ffffffff812ac36a>] __device_release_driver+0x70/0xc3
> =A0[<ffffffff812ac481>] device_release_driver+0x1e/0x2b
> =A0[<ffffffff812ab6aa>] bus_remove_device+0xb1/0xe0
> =A0[<ffffffff812a9953>] device_del+0x135/0x1a1
> =A0[<ffffffff812c5592>] __scsi_remove_device+0x4d/0x98
> =A0[<ffffffff812c55fe>] scsi_remove_device+0x21/0x2e
> =A0[<ffffffff812db944>] ata_scsi_handle_link_detach+0xfe/0x131
> =A0[<ffffffff812dbb29>] ata_scsi_hotplug+0x26/0x62
> =A0[<ffffffff8105f6e9>] worker_thread+0x1a4/0x232
> =A0[<ffffffff812dbb03>] ? ata_scsi_hotplug+0x0/0x62
> =A0[<ffffffff810631bf>] ? autoremove_wake_function+0x0/0x34
> =A0[<ffffffff8105f545>] ? worker_thread+0x0/0x232
> =A0[<ffffffff81062d6f>] kthread+0x7a/0x82
> =A0[<ffffffff81009924>] kernel_thread_helper+0x4/0x10
> =A0[<ffffffff81062cf5>] ? kthread+0x0/0x82
> =A0[<ffffffff81009920>] ? kernel_thread_helper+0x0/0x10
> sd 0:0:0:0: timing out command, waited 180s
>
>
> Thanks,
>
> - Siddhartha
>
>
> On Mon, Aug 30, 2010 at 8:25 AM, Siddhartha Jain
> <siddhartha@siddharthajain.net> wrote:
>> Hi Tejun,
>>
>> Will get more debugging info by setting up netconsole. Meanwhile,
>> syslog did glean some important info, I think. Looks like, for some
>> reason, after resume, device mapping for the hdd changes from sda to
>> sdc. Please see logs below. For ease of troubleshooting, I
>> re-installed the box with stock Fedora 13 x64 with no modifications
>> except that dmcrypt is turned on for root and swap (so using Nouveau
>> display drivers instead of Nvidia).
>>
>> Aug 29 19:13:45 192.168.1.199 kernel: PM: Syncing filesystems ... do=
ne.
>> Aug 29 19:13:45 192.168.1.199 kernel: PM: Preparing system for mem s=
leep
>> Aug 29 19:18:57 192.168.1.199 kernel: scsi 0:0:0:0: Direct-Access
>> ATA =A0 =A0 =A0FUJITSU MJA2250B 0081 PQ: 0 ANSI: 5
>> Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: Attached scsi
>> generic sg0 type 0
>> Aug 29 19:18:57 192.168.1.199 kernel: ata2.00: detaching (SCSI 1:0:0=
:0)
>> Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: [sdc] 488397168
>> 512-byte logical blocks: (250 GB/232 GiB)
>> Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: [sdc] Write Protec=
t is off
>> Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: [sdc] Mode Sense: =
00 3a 00 00
>> Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: [sdc] Write cache:
>> enabled, read cache: enabled, doesn't support DPO or FUA
>> Aug 29 19:18:57 192.168.1.199 kernel: sdc:
>> Aug 29 19:18:57 192.168.1.199 kernel: scsi 1:0:0:0: CD-ROM
>> HL-DT-ST DVDRW =A0GS23N =A0 =A0 SB03 PQ: 0 ANSI: 5
>> Aug 29 19:18:57 192.168.1.199 kernel: sr0: scsi3-mmc drive: 24x/24x
>> writer cd/rw xa/form2 cdda caddy
>> Aug 29 19:18:57 192.168.1.199 kernel: sr 1:0:0:0: Attached scsi CD-R=
OM sr0
>> Aug 29 19:18:57 192.168.1.199 kernel: sr 1:0:0:0: Attached scsi
>> generic sg1 type 5
>> Aug 29 19:18:58 192.168.1.199 kernel: sdc1 sdc2 sdc3
>> Aug 29 19:18:58 192.168.1.199 kernel: sd 0:0:0:0: [sdc] Attached SCS=
I disk
>> Aug 29 19:20:20 192.168.1.199 ntpd[1466]: 0.0.0.0 c61c 0c clock_step=
 -0.389692 s
>> Aug 29 19:20:20 192.168.1.199 ntpd[1466]: 0.0.0.0 c614 04 freq_mode
>> Aug 29 19:20:21 192.168.1.199 ntpd[1466]: 0.0.0.0 c618 08 no_sys_pee=
r
>> Aug 29 19:22:29 192.168.1.199 sshd[2425]: WARNING: no suitable prime=
s
>> in /etc/ssh/primes
>> Aug 29 19:22:29 192.168.1.199 rsyslogd: /var/log/secure
>> Aug 29 19:22:37 192.168.1.199 auditd[1734]: Record was not written t=
o
>> disk (Read-only file system)
>> Aug 29 19:22:37 192.168.1.199 auditd[1734]: write: Audit daemon
>> detected an error writing an event to disk (Connection refused)
>> Aug 29 19:22:37 192.168.1.199 sshd[2425]: Failed password for sjain
>> from 192.168.1.100 port 49902 ssh2
>> Aug 29 19:22:37 192.168.1.199 auditd[2428]: Audit daemon failed to e=
xec (null)
>> Aug 29 19:22:37 192.168.1.199 auditd[2428]: The audit daemon is exit=
ing.
>> Aug 29 19:22:37 192.168.1.199 auditd[1734]: Record was not written t=
o
>> disk (Read-only file system)
>> Aug 29 19:22:37 192.168.1.199 auditd[1734]: write: Audit daemon
>> detected an error writing an event to disk (Read-only file system)
>> Aug 29 19:22:37 192.168.1.199 auditd[2429]: Audit daemon failed to e=
xec (null)
>> Aug 29 19:22:37 192.168.1.199 auditd[2429]: The audit daemon is exit=
ing.
>> Aug 29 19:22:37 192.168.1.199 kernel: type=3D1305
>> audit(1283134957.511:19078): audit_pid=3D0 old=3D1734 auid=3D4294967=
295
>> ses=3D4294967295 res=3D1
>> Aug 29 19:22:37 192.168.1.199 kernel: type=3D1305
>> audit(1283134957.511:19079): audit_pid=3D0 old=3D0 auid=3D4294967295
>> ses=3D4294967295 res=3D1
>> Aug 29 19:22:54 192.168.1.199 kernel: EXT3-fs error (device dm-0):
>> ext3_find_entry: reading directory #10445218 offset 0
>> Aug 29 19:22:54 192.168.1.199 sshd[2426]: Connection closed by 192.1=
68.1.100
>> Aug 29 19:23:17 192.168.1.199 auditd[2428]: Error setting audit daem=
on
>> pid (Resource temporarily unavailable)
>> Aug 29 19:23:18 192.168.1.199 auditd[2429]: Error setting audit daem=
on
>> pid (Resource temporarily unavailable)
>> Aug 29 19:34:26 192.168.1.199 kernel: CE: hpet increasing min_delta_=
ns
>> to 15000 nsec
>> Aug 29 19:35:46 192.168.1.199 ntpd[1466]: 0.0.0.0 c612 02 freq_set
>> kernel -65.666 PPM
>> Aug 29 19:35:46 192.168.1.199 ntpd[1466]: 0.0.0.0 c615 05 clock_sync
>> Aug 29 19:38:26 192.168.1.199 kernel: EXT3-fs error (device dm-0):
>> ext3_find_entry: reading directory #1803721 offset 0
>>
>> Odd?
>>
>> Thanks,
>>
>> - Siddhartha
>>
>>
>>
>> On Mon, Aug 30, 2010 at 5:55 AM, Tejun Heo <tj@kernel.org> wrote:
>>> On 08/28/2010 10:28 PM, Siddhartha Jain wrote:
>>>> I am going to try pointing rsyslog at a remote syslog server to se=
e if I
>>>> can capture what happens at resume-time but any other pointers to
>>>> debug/troubleshoot this issue will be helpful.
>>>
>>> Setting up netconsole (see Documentation/networking/netconsole.txt =
in
>>> the kernel source tree) would be better.
>>>
>>> Thanks.
>>>
>>> --
>>> tejun
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ide=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
