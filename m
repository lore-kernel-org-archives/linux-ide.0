From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 11086] New: 2.6.26 (sata_nv = irq 21 problem
 after halting)
Date: Mon, 14 Jul 2008 12:58:21 -0700
Message-ID: <20080714125821.714013e2.akpm@linux-foundation.org>
References: <bug-11086-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58817 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756249AbYGNT6Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jul 2008 15:58:24 -0400
In-Reply-To: <bug-11086-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, fragabr@gmail.com


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Mon, 14 Jul 2008 12:31:54 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11086
> 
>            Summary: 2.6.26 (sata_nv = irq 21 problem after halting)
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.26
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: fragabr@gmail.com
> 
> 
> Latest working kernel version: 2.6.25
> Earliest failing kernel version: 2.6.26
> Distribution: Linux from scratch
> Hardware Environment: athlon64 x2 5600+, Asus M2N-E
> Software Environment:
> Problem Description:
> 
>         Something happened with ncq's sata_nv support. When I halt my
> system (Athlon64, Asus M2N-E), I get the following (I had to copy by
> hand, since the system is halted, so it's just an excerpt):
> 
> IRQ 21: nobody cared (try booting with the "irqpool" option)
> Pid 0, comm: swapper not tainted 2.6.26 #2
> 
> Call trace:
> ........... nv_swncq_interrupt
> ........... __report_bad_irq
> ........... note_interrupt
> ........... handle_fasteoi_irq
> ........... do_irq
> ........... ret_from_intr
> 
> Handles:
> 
> [<f88888888803a5b90>] (nv_swncq_interrupt+0x0/0xd0)
> 
> Disabling IRQ #21
> 
>         This just happens after a halt.
> 
>         If I use irqpool, this error doesn't happen.
> 
>         Thanks.
> 
> Steps to reproduce:
> 
> Just shutdown the system (halt).
> 

It's a 2.6.26 regression.  It happens at halt-time, so it won't be the
usual ACPI stuff.

I think this is the second report of ata going splat in this manner at
shutdown time.  Did we get the order of something wrong?
