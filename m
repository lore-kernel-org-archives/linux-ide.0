From: Tigran Aivazian <tigran@veritas.com>
Subject: Re: question about SATA and IDE DVD/CD drives.
Date: Fri, 2 Jul 2004 17:28:03 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0407021704060.2190-100000@einstein.homenet>
References: <Pine.LNX.4.44.0407021656110.2190-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pengo.systems.pipex.net ([62.241.160.193]:65468 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263020AbUGBQ3a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 12:29:30 -0400
In-Reply-To: <Pine.LNX.4.44.0407021656110.2190-100000@einstein.homenet>
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

> > For some strange reason, you need the PATA HD driver compiled into the 
> > kernel, together with the SATA driver compiled into the kernel.
> > Then SATA takes the HDs, and the PATA HD driver is used to identify the 
> > DVD drive, and thus you can then load the PATA CD module, or the 
> > IDE-SCSI module to access the DVD drives.
> > 
> > I have a ICH5 chipset, so I had exactly the same problems as you.
> > The strange bit is needing the PATA HD driver compiled into the kernel, 
> > even though you only need PATA CD/DVD drivers.

No, still doesn't work. SATA disk is seen but DVD is not seen.

Here is config:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y

but worse, now I get an oops by doing cat /proc/iomem consistently:

Unable to handle kernel paging request at ffffffff00000000 RIP: 
<ffffffff801ce50c>{strnlen+13}
PML4 103027 PGD 0 
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: udf iptable_filter ip_tables
Pid: 1593, comm: cat Not tainted 2.6.7
RIP: 0010:[<ffffffff801ce50c>] <ffffffff801ce50c>{strnlen+13}
RSP: 0018:000001002ae3fd60  EFLAGS: 00010297
RAX: ffffffff00000000 RBX: 000001003d178014 RCX: 000000000000000a
RDX: 000001002ae3feb8 RSI: fffffffffffffffe RDI: ffffffff00000000
RBP: 0000000000000000 R08: 00000000fffffffe R09: 0000000000000004
R10: 00000000ffffffff R11: 0000000000000000 R12: 000001003d178fff
R13: ffffffff00000000 R14: 00000000ffffffff R15: 000001002ae3fdc8
FS:  0000002a958624c0(0000) GS:ffffffff8040a800(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff00000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process cat (pid: 1593, threadinfo 000001002ae3e000, task 
000001003c9ea6b0)
Stack: ffffffff801cedc6 0000010000000001 ffffffff80195bfd 0000000000001000 
       000001003d178000 ffffffff802c90bd 0000010001e39468 0000010000002000 
       0000000000002000 0000000000000400 
Call Trace:<ffffffff801cedc6>{vsnprintf+752} 
<ffffffff80195bfd>{proc_lookup+223} 
       <ffffffff80183909>{seq_printf+165} 
<ffffffff801740c2>{do_lookup+105} 
       <ffffffff8017497b>{link_path_walk+2157} 
<ffffffff801702fc>{cp_new_stat+233} 
       <ffffffff80135d4e>{r_show+113} <ffffffff801833fa>{seq_read+273} 
       <ffffffff801678af>{vfs_read+201} <ffffffff80167b00>{sys_read+73} 
       <ffffffff8010e976>{system_call+126} 

Code: 80 3f 00 74 13 48 83 ee 01 48 83 c0 01 48 83 fe ff 74 05 80 
RIP <ffffffff801ce50c>{strnlen+13} RSP <000001002ae3fd60>
CR2: ffffffff00000000

Kind regards
Tigran



