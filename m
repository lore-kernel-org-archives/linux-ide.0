From: linux@horizon.com
Subject: IDE panic, 2.6.18
Date: 5 Oct 2006 17:11:12 -0400
Message-ID: <20061005211112.1800.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:12341 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751351AbWJEVLZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Oct 2006 17:11:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com

I've had some disk problems on a server that is generally very stable.
I thought all the lockups and data corruption I was seeing were the
drive's fault, but after restoring corrupted file systems from backup
twice this week, it dawmed on me that there appears to be a correlation
between "smartctl -t long /dev/hdX" and the kernel freezing.

The latest made it really clear that there's some problem on the kernel
side.  Hand-transcribed from a photo I took of the console after the crash:

Call Trace:
 [<b0248228>] ata_output_data+0x4d/0x64
 [<b024a60f>] ide_pio_sector+0xcd/0x102
 [<b024af35>] ide_pio_datablock+0x46/0x5c
 [<b024b160>] pre_task_out_intr+0x9a/0xa5
 [<b0246812>] ide_do_request+0x52b/0x6e0
 [<b01cb5c3>] __generic_unplug_device+0x1d/0x1f
 [<b01cbe7b>] generic_unplug_device+0x6/0x8
 [<b0263252>] unplug_slaves+0x4b/0x7a
 [<b02650c8>] raid1d+0xa51/0xac0
 [<b026f123>] md_thread+0xd6/0xef
 [<b0120db7>] kthread+0x1d/0xda
 [<b0100b3d>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stauck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
Code: c3 89 c2 ed c3 57 89 d7 89 c2 f3 6d 5f c3 89 d0 89 ca ee c3 0f b7 c0 66 ef
 c3 56 89 d6 89 c2 f3 66 6f 5e c3 ef c3 56 89 d6 89 c2 <f3> 6f 5e c3 c7 80 00 05
 00 00 45 82 24 b0 c7 80 04 05 00 00 52
EIP: [<b024726f>] ide_outsl+0x5/0x9 SS:ESP 0068:eff4ddf0
 <1>BUG: unable to handle kernel paging request at virtual address 30000200
 printing eip:
b024726f
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<b024726f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.18 #4)
EIP is at ide_outsl+0x5/0x9
eax: 0000b000   ebx: b0444d18   ecx: 00000080   edx: 0000b000
esi: 30000200   edi: b0444d18   ebp: 00000080   esp: b0421f3c
ds: 007b   es: 007b   ss: 0068
Process klogd (pid: 1146, ti=b0421000 task=eff08ad0 task.ti=b1a2b000)
Stack: b0444dac b0248228 30000200 b0444d18 30000200 b0444dac b0444d18 b024a60f
       00000020 00000200 00000001 0000000f b0444dac 00000001 b0444d18 b024af35
       ffffffff b0444dac c2baef38 b024afc5 b190ef04 b0444dac 00000286 b190eee0
Call Trace:
 [<b0248228>] ata_output_data+0x4d/0x64
 [<b024a60f>] ide_pio_sector+0xcd/0x102
 [<b024af35>] ide_pio_datablock+0x46/0x5c
 [<b024afc5>] task_out_intr+0x7a/0x9c
 [<b02471e1>] ide_intr+0x13d/0x188
 [<b012795e>] handle_IRQ_event+0x23/0x49
 [<b01279e2>] __do_IRQ+0x5e/0xa4
 [<b0142ca2>] do_IRQ+0x91/0xaf
Code: c3 89 c2 ed c3 57 89 d7 89 c2 f3 6d 5f c3 89 d0 89 ca ee c3 0f b7 c0 66 ef
 c3 56 89 d6 89 c2 f3 66 6f 5e c3 ef c3 56 89 d6 89 c2 <f3> 6f 5e c3 c7 80 00 05
 00 00 45 82 24 b0 c7 80 04 05 00 00 52
EIP: [<b024726f>] ide_outsl+0x5/0x9 SS:ESP 0068:b0421f3c
 <0>Kernel panic - not syncing: Fatal exception in interrupt


This is an old 440BX motherboard that's been in continuous reliable
service, 1 GB of ECC RAM, all partitions mirrored and very well cooled,
good quality power supply and UPS, no recent hardware changes of any sort,
etc.  The active drives are on PDC20268 PCI controllers, one per channel.

But it appears that if I try to run SMART self-tests while the system is
up (which I have distant memories of being able to do with impunity),
the system quickly locks up with disk corruption.  It usually just
reports lost interrupts, which I thought were the drive's fault and the
IDE driver wasn't coping with too gracefully, but then I got the above
panic, and that goes beyond "ungraceful".

One of the drives *did* have a couple of bad blocks at the time; it's
possible that the code path through RAID-1 recovery is somehow involved.

Since this is actually an important server, I have to schedule reproducing
it, and I'm not very eager to try unless I can manage it in a read-only
mode.  Recovering corrupted file systems twice in one week is Not Fun,
expecially when the first was so bad it uncovered a bug in e2fsck.

Well... I did just install a couple of big new drives (ordered when
I thought this was purely a drive problem), so I can play with them.
Perhaps I can image off the file systems that are at risk and then
reproduce it.

Does anyone have any particular ideas to investigate other than "git
bisect drivers/ide drivers/md"?

Thanks!
