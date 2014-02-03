From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Mon, 03 Feb 2014 17:21:50 +0100
Message-ID: <52EFC21E.7030902@free-electrons.com>
References: <0140131114857.GC26148@htj.dyndns.org> <1391264157-2112-1-git-send-email-andrew@lunn.ch> <1391264157-2112-3-git-send-email-andrew@lunn.ch> <20140203160315.GB30250@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51791 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752160AbaBCQV6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 11:21:58 -0500
In-Reply-To: <20140203160315.GB30250@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: kishon@ti.com, linux-ide@vger.kernel.org

On 03/02/2014 17:03, Tejun Heo wrote:
> On Sat, Feb 01, 2014 at 03:15:57PM +0100, Andrew Lunn wrote:
>> Make use of devm_phy_optional() in order to fix probe failures on
>> Armada 370, XP and others, when there is no phy driver available.
>>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Looks good to me from the ata side.  How should these be routed?  I
> can take them through libata/for-3.14-fixes once phy people ack the
> changes or the other way around is fine too.
> 
> Thanks.
> 

Hi Tejun, Andrew,

I have just tested it on both Armada 370 and Armada XP and it failed
at the end of the mv_platform_probe function while trying to do a
clk_put on the clocks on the second port.

Indeed the devm_phy_optional_get failed on the 1st port, so the clock
of the second port was not allocated. What I don't get is why the
IS_ERR check don't work here.

Here the log of the crash:

Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
d0012000.serial: ttyS0 at MMIO 0xd0012000 (irq = 20, base_baud = 15625000) is a 16550A
console [ttyS0] enabled
d0012100.serial: ttyS1 at MMIO 0xd0012100 (irq = 21, base_baud = 15625000) is a 16550A
sata_mv d00a0000.sata: error getting phy -38
Unable to handle kernel NULL pointer dereference at virtual address 00000054
pgd = c0004000
[00000054] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.0-rc1-00007-g5787958c945a #989
task: ed82bb80 ti: ed83e000 task.ti: ed83e000
PC is at __clk_put+0x1c/0x8c
LR is at clk_prepare_lock+0xc/0xd8
pc : [<c02c02e4>]    lr : [<c02bdac8>]    psr: 60000113
sp : ed83fe18  ip : 00000000  fp : ed807b80
r10: ed908200  r9 : ed234290  r8 : ffffffda
r7 : ed908210  r6 : 00000000  r5 : eda5ced0  r4 : 00000000
r3 : ed82bb80  r2 : 00000001  r1 : ed83fe08  r0 : 00000054
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 0000406a  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xed83e240)
Stack: (0xed83fe18 to 0xed840000)
fe00:                                                       00000001 c01f7390
fe20: ed90ee10 00000001 c04d658c 0000001f ed90ee10 00000002 c03b4e20 00000000
fe40: 74726f70 ed900030 00000001 ed232ca8 ed83e000 ed908210 c07d11c8 00000000
fe60: c07d11c8 c04d658c ed83e000 c04c2510 00000000 c01c2f38 c01c2f20 ed908210
fe80: c0809d88 c01c1ba8 00000000 ed908210 c07d11c8 ed908244 00000000 c01c1d50
fea0: 00000000 c07d11c8 c01c1cc4 c01c03b8 ed85b7dc ed85f1b4 c07d11c8 ed234300
fec0: c07cff90 c01c1380 c045e658 c04e4bf8 c07d11c8 c07d11c8 00000006 c04e4bf8
fee0: c07e6d80 c01c2390 00000000 00000000 00000006 c04d65b4 c04eb3c4 c0008874
ff00: 00000086 ef7fcd48 c04459a8 00000066 00000000 c049fd4c 00000063 ed83ff30
ff20: c0034d48 c0034d4c 00000113 ffffffff ef7fcd55 c03ae82c 00000086 c0034f34
ff40: c049f6ec 00000006 ef7fcd60 00000006 c07bfb70 c04eb3c4 00000006 c04e4bf8
ff60: c07e6d80 00000086 c04e4c04 c04c2510 00000000 c04c2bec 00000006 00000006
ff80: c04c2510 4c011108 00000000 c0393808 00000000 00000000 00000000 00000000
ffa0: 00000000 c0393810 00000000 c000e378 00000000 00000000 00000000 00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 8041106c 11928242
[<c02c02e4>] (__clk_put) from [<c01f7390>] (mv_platform_probe+0x29c/0x410)
[<c01f7390>] (mv_platform_probe) from [<c01c2f38>] (platform_drv_probe+0x18/0x48)
[<c01c2f38>] (platform_drv_probe) from [<c01c1ba8>] (driver_probe_device+0x104/0x220)
[<c01c1ba8>] (driver_probe_device) from [<c01c1d50>] (__driver_attach+0x8c/0x90)
[<c01c1d50>] (__driver_attach) from [<c01c03b8>] (bus_for_each_dev+0x54/0x88)
[<c01c03b8>] (bus_for_each_dev) from [<c01c1380>] (bus_add_driver+0xd4/0x1d0)
[<c01c1380>] (bus_add_driver) from [<c01c2390>] (driver_register+0x78/0xf4)
[<c01c2390>] (driver_register) from [<c04d65b4>] (mv_init+0x28/0x4c)
[<c04d65b4>] (mv_init) from [<c0008874>] (do_one_initcall+0xe4/0x140)
[<c0008874>] (do_one_initcall) from [<c04c2bec>] (kernel_init_freeable+0xfc/0x1c8)
[<c04c2bec>] (kernel_init_freeable) from [<c0393810>] (kernel_init+0x8/0x118)
[<c0393810>] (kernel_init) from [<c000e378>] (ret_from_fork+0x14/0x3c)
Code: 8a000012 ebfff5f7 e2840054 f57ff05b (e1903f9f)
---[ end trace 31531e36499d4923 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b



Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
