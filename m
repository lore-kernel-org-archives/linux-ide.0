From: Chris Spiegel <lkml@happyjack.org>
Subject: Kernel BUG report
Date: Wed, 22 Jun 2005 13:06:10 -0700
Message-ID: <20050622200609.GA12159@midgard.spiegels>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-xfs-bounce@oss.sgi.com>
Content-Disposition: inline
Sender: linux-xfs-bounce@oss.sgi.com
Errors-to: linux-xfs-bounce@oss.sgi.com
To: linux-ide@vger.kernel.org, linux-xfs@oss.sgi.com
List-Id: linux-ide@vger.kernel.org

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I ran into a bug while reorganizing an XFS filesystem with xfs_fsr.

I'm running a vanilla 2.6.12 from kernel.org on a dual P4 Xeon system.

I have a RAID1 setup with two IDE drives, hdb and hdc.  /dev/md0 is
encrypted using dm-crypt, so the filesystem was created on
/dev/mapper/md0.  At the time I received the bug, the array was running
in degraded mode, with only hdb1.  I was also running "shred" on hdc1,
preparing to attach it to md0.

My IDE controller is:
00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 02)

My first thought is that it's a hardware problem.  I've had intermittent
IDE issues, although there have been no recent errors logged as reported
by smartctl.  Regardless, I thought I should report this -- but if it's
an issue that can easily be explained by hardware problems, that's
likely the culprit.

Let me know if you need any more information.

Chris

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=crashdump

kernel BUG at include/asm/dma-mapping.h:44!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in: xfs snd_intel8x0
CPU:    3
EIP:    0060:[<c02d1422>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12) 
EIP is at ide_build_sglist+0x92/0xb0
eax: 00000000   ebx: df812000   ecx: 00000000   edx: 00000000
esi: 00000021   edi: cf0b6ab8   ebp: 00000000   esp: d301badc
ds: 007b   es: 007b   ss: 0068
Process xfs_fsr (pid: 2167, threadinfo=d301a000 task=d2228530)
Stack: c05bbba8 cf0b6ab8 df810000 c05bb980 00000000 c02d147f c05bbba8 cf0b6ab8 
       c0133930 00000000 c05bb980 cf0b6ab8 c05bb980 c05bbba8 00000000 c02d18ec 
       c05bbba8 cf0b6ab8 00000012 12310071 c05bb980 c05bbba8 c02d39e9 c05bbba8 
Call Trace:
 [<c02d147f>] ide_build_dmatable+0x3f/0x170
 [<c0133930>] autoremove_wake_function+0x0/0x60
 [<c02d18ec>] ide_dma_setup+0x3c/0xd0
 [<c02d39e9>] __ide_do_rw_disk+0x2f9/0x520
 [<c0250da2>] __delay+0x12/0x20
 [<c02c95d6>] start_request+0x156/0x240
 [<c02c991b>] ide_do_request+0x22b/0x3c0
 [<c02c9ad4>] do_ide_request+0x24/0x30
 [<c0296b3e>] __generic_unplug_device+0x3e/0x40
 [<c0296b5e>] generic_unplug_device+0x1e/0x30
 [<c0345af8>] unplug_slaves+0xe8/0x100
 [<c0350aa6>] dm_table_unplug_all+0x46/0x50
 [<c034e5f7>] dm_unplug_all+0x27/0x40
 [<c0296b89>] blk_backing_dev_unplug+0x19/0x20
 [<c0182420>] dio_await_one+0xc0/0xd0
 [<c018253b>] dio_await_completion+0x2b/0x60
 [<c0183309>] direct_io_worker+0x3f9/0x5a0
 [<e0c61d95>] xfs_ilock_map_shared+0x25/0x40 [xfs]
 [<c018379b>] __blockdev_direct_IO+0x2eb/0x3fd
 [<e0c89f20>] linvfs_get_blocks_direct+0x0/0x50 [xfs]
 [<e0c88730>] linvfs_unwritten_convert_direct+0x0/0x70 [xfs]
 [<e0c8a055>] linvfs_direct_IO+0xe5/0xf0 [xfs]
 [<e0c89f20>] linvfs_get_blocks_direct+0x0/0x50 [xfs]
 [<e0c88730>] linvfs_unwritten_convert_direct+0x0/0x70 [xfs]
 [<c042bd5d>] _spin_unlock+0xd/0x30
 [<c0177b9c>] update_atime+0x9c/0xd0
 [<c0140e82>] generic_file_direct_IO+0x72/0x120
 [<c013fb56>] generic_file_direct_write+0x76/0x190
 [<e0c918fd>] xfs_write+0x53d/0xd20 [xfs]
 [<e0c8cc0e>] linvfs_aio_read_invis+0x8e/0xa0 [xfs]
 [<e0c8d87c>] linvfs_write+0x10c/0x140 [xfs]
 [<e0c8d6d0>] linvfs_ioctl+0x60/0x80 [xfs]
 [<c0133930>] autoremove_wake_function+0x0/0x60
 [<c042b916>] _spin_lock+0x16/0x90
 [<c0188b9a>] dnotify_parent+0x3a/0xb0
 [<c015c86e>] vfs_write+0xae/0x130
 [<c015c9c1>] sys_write+0x51/0x80
 [<c0102f3b>] sysenter_past_esp+0x54/0x75
Code: 13 85 c0 74 26 8b 3d 10 2f 5b c0 41 29 f8 8b 7c 13 04 c1 f8 05 c1 e0 0c 01 f8 39 f1 89 44 13 08 7c d7 83 c4 08 89 f0 5b 5e 5f c3 <0f> 0b 2c 00 03 ea 45 c0 eb d0 0f 0b 29 00 03 ea 45 c0 eb b1 8d 
 

--SLDf9lqlvOQaIe6s--
