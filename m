From: David Sims <dpsims@virtualdave.com>
Subject: Re: Small help or advice please.... more clues....
Date: Sun, 23 Jan 2005 15:10:22 -0600 (CST)
Message-ID: <Pine.LNX.4.21.0501231504550.24491-100000@ernie.virtualdave.com>
References: <20050123003008.GD558606@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ernie.virtualdave.com ([198.216.116.246]:22285 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S261357AbVAWVK1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Jan 2005 16:10:27 -0500
In-Reply-To: <20050123003008.GD558606@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: jeremy@classic.engr.sgi.com, linux-ide@vger.kernel.org

Hi,

  When the sata_vsc module is loaded, it seems to try to enumerate or
otherwise talk to each drive.... after which it completes loading and
returns control to stdin... During this period (after laoding and talking
to the controller but before and during the disk enumeration part there
are numerous (once for each disk) errors logged in syslog:

Jan 23 13:49:53 linux kernel: Disabling IRQ #3
Jan 23 13:49:54 linux kernel: irq 3: nobody cared!
Jan 23 13:49:54 linux kernel:  [<c0127012>] __report_bad_irq+0x22/0x90
Jan 23 13:49:54 linux kernel:  [<c0127108>] note_interrupt+0x58/0x90
Jan 23 13:49:54 linux kernel:  [<c0126c98>] __do_IRQ+0xd8/0xe0
Jan 23 13:49:54 linux kernel:  [<c0103a5a>] do_IRQ+0x1a/0x30
Jan 23 13:49:54 linux kernel:  [<c010253a>] common_interrupt+0x1a/0x20
Jan 23 13:49:54 linux kernel:  [<c0114870>] __do_softirq+0x30/0x90
Jan 23 13:49:54 linux kernel:  [<c0114905>] do_softirq+0x35/0x40
Jan 23 13:49:54 linux kernel:  [<c0103a5f>] do_IRQ+0x1f/0x30
Jan 23 13:49:54 linux kernel:  [<c010253a>] common_interrupt+0x1a/0x20
Jan 23 13:49:54 linux kernel:  [<c0100590>] default_idle+0x0/0x40
Jan 23 13:49:54 linux kernel:  [<c01005b4>] default_idle+0x24/0x40
Jan 23 13:49:54 linux kernel:  [<c010063e>] cpu_idle+0x2e/0x40
Jan 23 13:49:54 linux kernel:  [<c03ce77b>] start_kernel+0x15b/0x190
Jan 23 13:49:54 linux kernel: handlers:
Jan 23 13:49:54 linux kernel: [<c0244620>] (ide_intr+0x0/0x120)
Jan 23 13:49:54 linux kernel: [<c0244620>] (ide_intr+0x0/0x120)
Jan 23 13:49:54 linux kernel: [<e08ef250>] (vsc_sata_interrupt+0x0/0xa0
[sata_vsc])


  I would say that the contoller is throwing interrupts during this
enumeration phase and before the module is fully loaded to be able to deal
with them.... but what to do about it??? Any additional thoughts??

TIA,

Dave


