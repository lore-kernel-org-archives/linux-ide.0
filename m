From: Tom Wirschell <linux-ide@wirschell.nl>
Subject: Re: BUG() with MV88SX6081 and other problems
Date: Wed, 21 Jun 2006 09:07:34 +0200
Message-ID: <20060621090734.5c237bad@localhost>
References: <20060617191703.45e6f348@localhost>
	<87f94c370606201053l55f85236kf7f3c1177c49a576@mail.gmail.com>
	<4498C544.7080907@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from basillia.speedxs.net ([83.98.255.13]:62087 "EHLO
	basillia.speedxs.net") by vger.kernel.org with ESMTP
	id S1751203AbWFUHHi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 03:07:38 -0400
In-Reply-To: <4498C544.7080907@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, linux-ide@vger.kernel.org

On 21 Jun 2006, Mark Lord wrote:
> 
> I really don't understand the traceback above -- that's not a possible
> calling sequence in the source code.  You do have frame-pointers
> enabled in the kernel .config, right?  Weird.

Oops. Here's the trace from a kernel that has that and a number of
other at first glance interesting debugging options turned on:

ata9: SATA max UDMA/133 cmd 0x0 ctl 0xF88B6120 bmdma 0x0 irq 24
ata10: SATA max UDMA/133 cmd 0x0 ctl 0xF88B8120 bmdma 0x0 irq 24
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
BUG: warning at drivers/scsi/sata_mv.c:1921/__msleep()
 [<c0103316>] show_trace_log_lvl+0x11d/0x137
 [<c01039f7>] show_trace+0x12/0x14
 [<c0103b17>] dump_stack+0x19/0x1b 
 [<c026689e>] __mv_phy_reset+0x3a5/0x3aa
 [<c02668e2>] mv_stop_and_reset+0x30/0x35
 [<c026696d>] mv_err_intr+0x86/0xae
 [<c02671ea>] mv_interrupt+0x2b5/0x3b6
 [<c0138401>] handle_IRQ_event+0x35/0x65
 [<c01394fe>] handle_fasteoi_irq+0x62/0x9f
 [<c0104c05>] do_IRQ+0x63/0x90
 [<c0102d7a>] common_interrupt+0x1a/0x20
 [<c0101832>] mwait_idle+0x2c/0x3a
 [<c01017f1>] cpu_idle+0x61/0x76
 [<c010058d>] rest_init+0x23/0x36
 [<c03eb77a>] start_kernel+0x304/0x37a
 [<c0100210>] 0xc0100210 
ata4.00: cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003
88:407f ata4.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48 
ata4.00: configured for UDMA/133 
scsi3 : sata_mv

Current config:
http://www.wirschell.nl/config.txt

> Another really messed up traceback.  Can you turn on a few
> more kernel options to make this readable, please?
> Like CONFIG_FRAME_POINTER=y and CONFIG_UNWIND_INFO=y
> and anything else that looks good .  :)

I'm running my standard test now. I'll post the trace once it goes
down.

Thank you.

Kind regards,

Tom Wirschell
