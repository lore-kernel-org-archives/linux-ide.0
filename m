From: David Sims <dpsims@virtualdave.com>
Subject: sata_vsc, sata_core problem.... Please help me.
Date: Mon, 24 Jan 2005 14:03:38 -0600 (CST)
Message-ID: <Pine.LNX.4.21.0501241348520.32512-100000@ernie.virtualdave.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ernie.virtualdave.com ([198.216.116.246]:43023 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S261606AbVAXUD5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jan 2005 15:03:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: jeremy@classic.engr.sgi.com, linux-ide@vger.kernel.org, jgarzik@pobox.com

Hi,

  With kernel 2.6.10 on Intel (Dell Powervault 745N).... When I insert the
sata_vsc module via 'modprobe sata_vsc' from the command line, the module
immediately recognizes the controller card and when it then enumerates the
attached disks, I am getting errors logged in syslog for each disk as
follows:

Jan 24 13:55:37 linux kernel: irq 3: nobody cared!
Jan 24 13:55:37 linux kernel:  [<c0128972>] __report_bad_irq+0x22/0x90
Jan 24 13:55:37 linux kernel:  [<c0128a68>] note_interrupt+0x58/0x90
Jan 24 13:55:37 linux kernel:  [<c01285f8>] __do_IRQ+0xd8/0xe0
Jan 24 13:55:37 linux kernel:  [<c0103a7a>] do_IRQ+0x1a/0x30
Jan 24 13:55:37 linux kernel:  [<c010254a>] common_interrupt+0x1a/0x20
Jan 24 13:55:37 linux kernel:  [<c0114fc0>] __do_softirq+0x30/0x90
Jan 24 13:55:37 linux kernel:  [<c0115055>] do_softirq+0x35/0x40
Jan 24 13:55:37 linux kernel:  [<c0103a7f>] do_IRQ+0x1f/0x30
Jan 24 13:55:37 linux kernel:  [<c010254a>] common_interrupt+0x1a/0x20
Jan 24 13:55:37 linux kernel:  [<c0100590>] default_idle+0x0/0x40
Jan 24 13:55:37 linux kernel:  [<c01005b4>] default_idle+0x24/0x40
Jan 24 13:55:37 linux kernel:  [<c010063e>] cpu_idle+0x2e/0x40
Jan 24 13:55:37 linux kernel:  [<c03d277b>] start_kernel+0x15b/0x190
Jan 24 13:55:37 linux kernel: handlers:
Jan 24 13:55:37 linux kernel: [<c02471e0>] (ide_intr+0x0/0x120)
Jan 24 13:55:37 linux kernel: [<c02471e0>] (ide_intr+0x0/0x120)
Jan 24 13:55:37 linux kernel: [<e08ef250>] (vsc_sata_interrupt+0x0/0xa0
[sata_vsc])
Jan 24 13:55:37 linux kernel: Disabling IRQ #3


  It seems to me that this driver is initializing itself and enabling
interrupts before it is fully loaded and ready to deal with them.... 

  If I insert the module during the boot up process, the machine just
hangs trying to read/identify the first disk... 

  Is there a way to disable or ignore these interrupts until the driver is
fully loaded, the disks are identified and all of the necessary
housekeeping is finished and the driver is finished loading?? 

  If you folks can't help me, where should I look for help??

TIA,

Dave Sims

