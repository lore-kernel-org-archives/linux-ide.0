From: Tom Wirschell <Tom@Wirschell.nl>
Subject: Re: BUG() with MV88SX6081 and other problems
Date: Wed, 21 Jun 2006 17:32:10 +0200
Message-ID: <20060621173210.6a7b3a83@localhost>
References: <20060617191703.45e6f348@localhost>
	<87f94c370606201053l55f85236kf7f3c1177c49a576@mail.gmail.com>
	<4498C544.7080907@rtr.ca>
	<20060621090734.5c237bad@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from basillia.speedxs.net ([83.98.255.13]:1408 "EHLO
	basillia.speedxs.net") by vger.kernel.org with ESMTP
	id S932191AbWFUPcN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 11:32:13 -0400
In-Reply-To: <20060621090734.5c237bad@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mark Lord <liml@rtr.ca>, Greg Freemyer <greg.freemyer@gmail.com>

On 21 Jun 2006, Tom Wirschell wrote:
> 
> I'm running my standard test now. I'll post the trace once it goes
> down.

And that one looks like this:

md: unbind<sdi2>
md: export_rdev(sdi2)
BUG: warning at fs/block_dev.c:1109/__blkdev_put()
 [<c0103316>] show_trace_log_lvl+0x11d/0x137
 [<c01039f7>] show_trace+0x12/0x14
 [<c0103b17>] dump_stack+0x19/0x1b
 [<c015f136>] __blkdev_put+0x174/0x1b7
 [<c015f186>] blkdev_put_partition+0xd/0xf
 [<c028cb80>] unlock_rdev+0x23/0x4c
 [<c028cc1c>] export_rdev+0x73/0x81
 [<c028cccb>] kick_rdev_from_array+0x12/0x15
 [<c028ccf4>] export_array+0x26/0x95
 [<c028e96c>] do_md_stop+0x1e3/0x2f8
 [<c0292c60>] md_ioctl+0x6cb/0x17a0
 [<c02016a6>] blkdev_driver_ioctl+0x55/0x5e
 [<c020196d>] blkdev_ioctl+0x2be/0x7c1
 [<c015ea84>] block_ioctl+0x1b/0x21
 [<c0168652>] do_ioctl+0x22/0x71
 [<c01686f6>] vfs_ioctl+0x55/0x28e
 [<c0168962>] sys_ioctl+0x33/0x51
 [<c02f8b6f>] syscall_call+0x7/0xb
 [<b7e7a904>] 0xb7e7a904
BUG: warning at fs/block_dev.c:1128/__blkdev_put()
 [<c0103316>] show_trace_log_lvl+0x11d/0x137
 [<c01039f7>] show_trace+0x12/0x14
 [<c0103b17>] dump_stack+0x19/0x1b
 [<c015f174>] __blkdev_put+0x1b2/0x1b7
 [<c015f186>] blkdev_put_partition+0xd/0xf
 [<c028cb80>] unlock_rdev+0x23/0x4c
 [<c028cc1c>] export_rdev+0x73/0x81
 [<c028cccb>] kick_rdev_from_array+0x12/0x15
 [<c028ccf4>] export_array+0x26/0x95
 [<c028e96c>] do_md_stop+0x1e3/0x2f8
 [<c0292c60>] md_ioctl+0x6cb/0x17a0
 [<c02016a6>] blkdev_driver_ioctl+0x55/0x5e
 [<c020196d>] blkdev_ioctl+0x2be/0x7c1
 [<c015ea84>] block_ioctl+0x1b/0x21
 [<c0168652>] do_ioctl+0x22/0x71
 [<c01686f6>] vfs_ioctl+0x55/0x28e
 [<c0168962>] sys_ioctl+0x33/0x51
 [<c02f8b6f>] syscall_call+0x7/0xb
 [<b7e7a904>] 0xb7e7a904

Kind regards,

Tom Wirschell
