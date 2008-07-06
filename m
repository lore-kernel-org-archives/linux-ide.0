From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11047] New: pata_it821x with Maxtor 7270AV: irq 11: nobody cared
Date: Sun,  6 Jul 2008 14:41:08 -0700 (PDT)
Message-ID: <bug-11047-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54278 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756643AbYGFVl0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Jul 2008 17:41:26 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m66Lf85C026526
	for <linux-ide@vger.kernel.org>; Sun, 6 Jul 2008 14:41:09 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3D11047

           Summary: pata_it821x with Maxtor 7270AV: irq 11: nobody care=
d
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.25.3
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: linux@rainbow-software.org


Hardware Environment: IT8212F-based controller in pass-through mode
(pata_it821x.noraid=3D1) with Maxtor 7270AV hard drive connected

Problem Description: Kernel crashes on boot with the following text:

pata_it821x: forcing bypass mode.
pata_it821x: controller in pass through mode.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKC] -> GSI 11 (level, lo=
w) ->=20
IRQ 11
irq 11: nobody cared (try booting with the "irqpoll" option)
Pid: 1, comm: swapper Not tainted 2.6.25.3-pentium #5
=C2=A0[<c012f48f>] __report_bad_irq+0x24/0x69
=C2=A0[<c012f496>] __report_bad_irq+0x2b/0x69
=C2=A0[<c012f680>] note_interrupt+0x1ac/0x1e4
=C2=A0[<c012ee21>] handle_IRQ_event+0x1a/0x3f
=C2=A0[<c012fcda>] handle_level_irq+0x0/0x8a
=C2=A0[<c012fd27>] handle_level_irq+0x4d/0x8a
=C2=A0[<c01051bb>] do_IRQ+0x78/0x9e
=C2=A0[<c0103c53>] common_interrupt+0x23/0x30
=C2=A0[<c013007b>] init_irq_proc+0x6/0x27
=C2=A0[<c0115f59>] __do_softirq+0x2f/0x75
=C2=A0[<c0105111>] do_softirq+0x3b/0x6d
=C2=A0[<c012fcda>] handle_level_irq+0x0/0x8a
=C2=A0[<c0115efc>] irq_exit+0x25/0x53
=C2=A0[<c01051ce>] do_IRQ+0x8b/0x9e
=C2=A0[<c0103c53>] common_interrupt+0x23/0x30
=C2=A0[<c012f214>] setup_irq+0x11f/0x149
=C2=A0[<c0120060>] cpu_clock_sample_group_locked+0x2/0xd3
=C2=A0[<c023ce84>] ata_interrupt+0x0/0x1cc
=C2=A0[<c012f2b5>] request_irq+0x77/0x93
=C2=A0[<c023ce84>] ata_interrupt+0x0/0x1cc
=C2=A0[<c012fe0c>] devm_request_irq+0x42/0x6e
=C2=A0[<c02403a6>] ata_pci_activate_sff_host+0xb4/0x19f
=C2=A0[<c023ce84>] ata_interrupt+0x0/0x1cc
=C2=A0[<c0240850>] ata_pci_init_one+0x8c/0xd5
=C2=A0[<c02475b5>] it821x_init_one+0x87/0x8c
=C2=A0[<c01c632b>] pci_device_probe+0x36/0x55
=C2=A0[<c021f6ce>] driver_probe_device+0x9c/0x112
=C2=A0[<c021f824>] __driver_attach+0x50/0x83
=C2=A0[<c021ed53>] bus_for_each_dev+0x31/0x52
=C2=A0[<c021f582>] driver_attach+0x11/0x13
=C2=A0[<c021f7d4>] __driver_attach+0x0/0x83
=C2=A0[<c021f3c2>] bus_add_driver+0x91/0x193
=C2=A0[<c021f9bd>] driver_register+0x45/0x9a
=C2=A0[<c01c64bf>] __pci_register_driver+0x2b/0x58
=C2=A0[<c0397600>] kernel_init+0x92/0x1d0
=C2=A0[<c010fe52>] schedule_tail+0xe/0x39
=C2=A0[<c01038a6>] ret_from_fork+0x6/0x20
=C2=A0[<c039756e>] kernel_init+0x0/0x1d0
=C2=A0[<c039756e>] kernel_init+0x0/0x1d0
=C2=A0[<c0103d77>] kernel_thread_helper+0x7/0x10
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
handlers:
[<c023ce84>] (ata_interrupt+0x0/0x1cc)
Disabling IRQ #11
scsi2 : pata_it821x
scsi3 : pata_it821x
ata3: PATA max UDMA/133 cmd 0x6800 ctl 0x6c00 bmdma 0x7800 irq 11
ata4: PATA max UDMA/133 cmd 0x7000 ctl 0x7400 bmdma 0x7808 irq 11


--=20
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
