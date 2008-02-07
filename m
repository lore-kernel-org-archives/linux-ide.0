From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: falconide broken
Date: Thu, 7 Feb 2008 09:38:31 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802070933130.17555@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yergi.telenet-ops.be ([195.130.132.36]:54969 "EHLO
	yergi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbYBGIjP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 03:39:15 -0500
Received: from edna.telenet-ops.be (unknown [195.130.132.58])
	by yergi.telenet-ops.be (Postfix) with ESMTP id 663FA5CAB4E
	for <linux-ide@vger.kernel.org>; Thu,  7 Feb 2008 09:39:15 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org


One of the recent IDE changes seems to have broken Atari Falcon IDE.
My smoke test boot on Aranym gives:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
ide: Falcon IDE controller
Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oops: 00000000
Modules linked in:
PC: [<00133abc>] ide_outb+0x8/0xa
SR: 2300  SP: 00817e80  a2: 008159c0
d0: 00000008    d1: 00000000    d2: 008312b0    d3: 00000000
d4: 00000000    d5: 00817f34    a0: 00000039    a1: 00000000
Process swapper (pid: 1, task=008159c0)
Frame format=7 eff addr=01000039 ssw=0000 faddr=01000039
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 01000039 00000000
push data: 00000000 00000000 00000000 00000000
Stack from 00817ee8:
        00136e52 00000008 00000039 0025fc20 00000000 00000000 00000000 00000000
        00000000 00000000 0025fbd6 00817f62 0027f394 00817f38 00131350 00002300
        00137922 00817f34 00000000 00ffffff 00817f9c 00276f96 00817f98 00000000
        0025fbd6 00817f62 0025fbd6 00000000 00266a6c 00027a58 0002fff0 0000fff0
        0005fff0 0009fff0 000dfff0 0011fff0 0015fff0 0019fff0 001d0000 00390000
        00000000 000f0000 00000000 00000000 00ffffff 00283ff8 00266ada 00000000
Call Trace: [<00136e52>] ide_device_add_all+0x2e0/0xd84
 [<00131350>] ide_init_port_data+0x6c/0x10a
 [<00002300>] system_call+0x10/0x26
 [<00137922>] ide_device_add+0x2c/0x32
 [<00276f96>] falconide_init+0xd4/0xe6
 [<00266a6c>] kernel_init+0x0/0x2ce
 [<00027a58>] printk+0x0/0x1a
 [<0002fff0>] __group_complete_signal+0x48/0x1bc
 [<0000fff0>] slognp1+0xe0/0x140
 [<0005fff0>] sys_swapoff+0x5a6/0x92e
 [<0009fff0>] sysfs_open_file+0x40/0x1c8
 [<000dfff0>] blk_end_sync_rq+0xc/0x2c
 [<0011fff0>] do_con_write+0x1422/0x1aa0
 [<0015fff0>] psmouse_connect+0x10e/0x212
 [<0019fff0>] raw_sendmsg+0x476/0x68c
 [<000f0000>] bitmap_scnprintf+0x46/0x122
 [<00266ada>] kernel_init+0x6e/0x2ce
 [<00266a6c>] kernel_init+0x0/0x2ce
 [<00027a58>] printk+0x0/0x1a
 [<002704be>] __alloc_bootmem+0x0/0x3e
 [<00002950>] kernel_thread+0x3a/0x4e

I'll try to bisect later...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
