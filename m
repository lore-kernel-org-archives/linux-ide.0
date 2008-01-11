From: James Chapman <jchapman@katalix.com>
Subject: buffer_head list oops with new PATA driver: help request
Date: Fri, 11 Jan 2008 10:20:22 +0000
Message-ID: <478742E6.6020001@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s36.avahost.net ([74.53.95.194]:40346 "EHLO s36.avahost.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757155AbYAKMcJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jan 2008 07:32:09 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Stuart James <sjames@katalix.com>

I'm seeking help for a problem we're having with a new PATA driver for a
Toshiba TX4939 MIPS SoC.

The driver works fine for most use cases, but we get an oops when stress
testing with bonnie++. The oops is always a null pointer while walking a
buffer_head list (b_this_page is null) when bonnie++ reads back its
data. This only happens when DMA is enabled, and only when bonnie++
parameters are chosen to stress memory usage such that buffers are
recycled by the kernel. The oops still happens if the CPU cache is
disabled or if bonnie++'s -b option is specified to force a sync() on
every write.

Below is the most common oops trace. I'm wondering if this can be caused
by a bug in the driver or if there is a platform-specific issue? I can
post the driver source here if it would be useful.

Kernel: 2.6.22 (also happens with 2.6.23)
Arch: mips
RAM: 256M

# bonnie++ -d bench -s 512 -n 1 -x 1 -u root -r 256 -f
Writing intelligently...done
Rewriting...Unhandled kernel unaligned access[#1]:
Cpu 0
$ 0   : 00000000 fffdffff 00000000 00000000
$ 4   : 00000000 00000000 01010101 8463d4d0
$ 8   : 81118880 81118860 00000000 8f0d6884
$12   : 00000001 00000008 00000001 8f0d6884
$16   : 81118880 00000000 00000000 8f0d67b8
$20   : 812d1f08 ffffffff 00000001 842c9700
$24   : 00000001 0000000e
$28   : 812d0000 812d1c48 0000000c 8016e1f8
Hi    : 00000000
Lo    : 00000005
epc   : 801d88d4 __mpage_writepage+0xc0/0x8e8     Not tainted
ra    : 8016e1f8 write_cache_pages+0x35c/0x4fc
Status: 10008403    KERNEL EXL IE
Cause : 10000010
BadVA : 01010101
PrId  : 00002d40
Modules linked in: pata_tx49xx
Process pdflush (pid: 76, threadinfo=812d0000, task=812fa900)
Stack : 00000060 801334b4 00000000 81a9c930 00000020 00000070 00446d85
00000000
        8fe07600 00000000 8030b5ec 812d1f08 0000031a 802ff96c 00000000
fffdffff
        842c9100 842c9100 00000060 00000000 00000008 00000000 8f1342d0
8fdd0c90
        00000060 00000060 00000000 802fb94c 00000968 00000000 0000000e
8f0d6880
        00000000 812d1d58 8f0d6890 812d1d90 80165dd4 00000001 8f0d6880
00000000
        ...
Call Trace:
[<801d88d4>] __mpage_writepage+0xc0/0x8e8
[<8016e1f8>] write_cache_pages+0x35c/0x4fc
[<801d9140>] mpage_writepages+0x44/0xa8
[<8016e438>] do_writepages+0x74/0x7c
[<801c3528>] __writeback_single_inode+0xb4/0x47c
[<801c3fa0>] sync_sb_inodes+0x208/0x33c
[<801c4420>] writeback_inodes+0x11c/0x13c
[<8016ce98>] background_writeout+0xcc/0x120
[<8016efc0>] pdflush+0x1e0/0x2d0
[<80147820>] kthread+0x88/0xc4
[<80105ee4>] kernel_thread_helper+0x10/0x18


Code: 00009021  8d07000c  00e03021 <8cc20000> 00021082  30420001
00028036  8cc



-- 
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development


