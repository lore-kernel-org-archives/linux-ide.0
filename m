From: Onis <onion@virasto.com>
Subject: sata_mv dropping disks
Date: Fri, 19 May 2006 00:31:31 +0300
Message-ID: <20060518213131.GA10777@virasto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from virasto.com ([212.213.212.50]:9862 "EHLO virasto.com")
	by vger.kernel.org with ESMTP id S1751399AbWERVbd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 May 2006 17:31:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

Got warnings while rebuilding md raid5 array. Controller is 88SX5081 with
8xMaxtor 300GB 7V300F0. I've ran badblock -w on all disks, smartctl doesn't
report errors.

----
BUG: warning at drivers/scsi/sata_mv.c:1884/mv_channel_reset()

Call Trace: <IRQ> <ffffffff803a39ce>{mv_channel_reset+238}
       <ffffffff803a4277>{mv_stop_and_reset+55}
<ffffffff803a45f7>{mv_interrupt+631}
       <ffffffff8024e9fc>{handle_IRQ_event+44}
<ffffffff8024eae0>{__do_IRQ+176}
       <ffffffff8020c5d2>{do_IRQ+66} <ffffffff80209c88>{ret_from_intr+0} <EOI>
              <ffffffff80322773>{get_request_wait+35}
<ffffffff803b78bf>{xor_sse_5+191}
       <ffffffff803b09fd>{compute_block+221}
<ffffffff80323b5f>{generic_make_request+495}
       <ffffffff803b3520>{handle_stripe+7840} <ffffffff803b487d>{raid5d+349}
              <ffffffff80241268>{prepare_to_wait+24}
<ffffffff80240dd0>{keventd_create_kthread+0}
       <ffffffff803bc2ac>{md_thread+300}
<ffffffff802413e0>{autoremove_wake_function+0}
       <ffffffff802413e0>{autoremove_wake_function+0}
<ffffffff803bc180>{md_thread+0}
       <ffffffff80240d89>{kthread+217} <ffffffff8020a5da>{child_rip+8}
              <ffffffff80240dd0>{keventd_create_kthread+0}
<ffffffff80240cb0>{kthread+0}
       <ffffffff8020a5d2>{child_rip+0}
       BUG: warning at drivers/scsi/sata_mv.c:1904/__msleep()
       
       Call Trace: <IRQ> <ffffffff803a3f21>{__mv_phy_reset+241}
              <ffffffff803a39da>{mv_channel_reset+250}
<ffffffff803a45f7>{mv_interrupt+631}
       <ffffffff8024e9fc>{handle_IRQ_event+44}
<ffffffff8024eae0>{__do_IRQ+176}
       <ffffffff8020c5d2>{do_IRQ+66} <ffffffff80209c88>{ret_from_intr+0} <EOI>
              <ffffffff80322773>{get_request_wait+35}
<ffffffff803b78bf>{xor_sse_5+191}
       <ffffffff803b09fd>{compute_block+221}
<ffffffff80323b5f>{generic_make_request+495}
       <ffffffff803b3520>{handle_stripe+7840} <ffffffff803b487d>{raid5d+349}
              <ffffffff80241268>{prepare_to_wait+24}
<ffffffff80240dd0>{keventd_create_kthread+0}
       <ffffffff803bc2ac>{md_thread+300}
<ffffffff802413e0>{autoremove_wake_function+0}
       <ffffffff802413e0>{autoremove_wake_function+0}
<ffffffff803bc180>{md_thread+0}
       <ffffffff80240d89>{kthread+217} <ffffffff8020a5da>{child_rip+8}
              <ffffffff80240dd0>{keventd_create_kthread+0}
<ffffffff80240cb0>{kthread+0}
       <ffffffff8020a5d2>{child_rip+0}
       ata4: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
       ata4: status=0x50 { DriveReady SeekComplete }
       ata4: error=0x01 { AddrMarkNotFound }
       sata_mv: PCI ERROR; PCI IRQ cause=0x28000020


What does "PCI IRQ cause=0x28000020" mean?

Few minutes after that rebuild stopped:
----
sd 6:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, dev sdg, sector 403739536
sd 6:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, dev sdg, sector 403739544
sd 6:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, dev sdg, sector 403739552
md: md0: sync done.

# cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4] 
md0 : active raid5 sda[0] sdg[8](F) sdh[7] sdf[5] sde[4] sdd[3] sdc[2] sdb[1]
      2051400960 blocks level 5, 128k chunk, algorithm 2 [8/7] [UUUUUU_U]

# hdparm -I /dev/sdg

/dev/sdg:
 HDIO_DRIVE_CMD(identify) failed: Input/output error


Also I'm getting a lots of these on all ports on boot. smartctl also triggers
these:
----
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xd0 { Busy }
...

System
------
* Tyan Thunder S2882 Dual Opteron 240
* Marvell Technology Group Ltd. MV88SX5081 8-port SATA I PCI-X Controller
* 8 x Maxtor Maxline III 300GB SATA2
* Debian Sarge AMD64
* kernel 2.6.17-rc4-mm1

- Onis
