From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 29922] New: irqpool crash
Date: Tue, 1 Mar 2011 15:28:33 -0800
Message-ID: <20110301152833.66dc5e6f.akpm@linux-foundation.org>
References: <bug-29922-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35690 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755828Ab1CAX3C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2011 18:29:02 -0500
In-Reply-To: <bug-29922-10286@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, mysql.jorge@decimal.pt


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

Guys, does this look like an ata problem or an acpi problem?

Thanks.


On Sat, 26 Feb 2011 13:53:03 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=29922
> 
>            Summary: irqpool crash
>            Product: Drivers
>            Version: 2.5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: blocking
>           Priority: P1
>          Component: PCI
>         AssignedTo: drivers_pci@kernel-bugs.osdl.org
>         ReportedBy: mysql.jorge@decimal.pt
>         Regression: No
> 
> 
> Howdy,
> 
> I'm having some crash's with the information below:
> 
> --
> irq 16: nobody cared (try booting with the "irqpoll" option)
> Pid: 0, comm: swapper Not tainted 2.6.35.11 #1
> Call Trace:
>  [<c1049c3c>] __report_bad_irq+0x2e/0x6f
>  [<c1049d72>] note_interrupt+0xf5/0x14b
>  [<c1048b27>] ? handle_IRQ_event+0x1d/0x90
>  [<c104a39c>] handle_fasteoi_irq+0x84/0xa2
>  [<c1003f0a>] handle_irq+0x1a/0x20
>  [<c10038ec>] do_IRQ+0x41/0x9a
>  [<c1002ae9>] common_interrupt+0x29/0x30
>  [<f8628d44>] ? acpi_idle_enter_c1+0xa3/0xba [processor]
>  [<c11b6825>] cpuidle_idle_call+0x62/0x95
>  [<c10018e7>] cpu_idle+0x44/0x5d
>  [<c121b0e5>] rest_init+0x71/0x73
>  [<c131c7d7>] start_kernel+0x274/0x279
>  [<c131c074>] i386_start_kernel+0x74/0x76
> handlers:
> [<c1199350>] (ahci_interrupt+0x0/0x51f)
> Disabling IRQ #16
> --
> 
> My configuration is:
> 
> Intel i3 540
> 8GB DDR3
> 
> PCI interfaces are (lspci output):
> 
> --
> 00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller (rev 18)
> 00:01.0 PCI bridge: Intel Corporation Core Processor PCI Express x16 Root Port
> (rev 18)
> 00:02.0 VGA compatible controller: Intel Corporation Core Processor Integrated
> Graphics Controller (rev 18)
> 00:16.0 Communication controller: Intel Corporation 5 Series/3400 Series
> Chipset HECI Controller (rev 06)
> 00:1a.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB
> Universal Host Controller (rev 06)
> 00:1a.1 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB
> Universal Host Controller (rev 06)
> 00:1a.2 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB
> Universal Host Controller (rev 06)
> 00:1a.7 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB2
> Enhanced Host Controller (rev 06)
> 00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express
> Root Port 1 (rev 06)
> 00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express
> Root Port 2 (rev 06)
> 00:1d.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB
> Universal Host Controller (rev 06)
> 00:1d.1 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB
> Universal Host Controller (rev 06)
> 00:1d.2 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB
> Universal Host Controller (rev 06)
> 00:1d.7 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB2
> Enhanced Host Controller (rev 06)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a6)
> 00:1f.0 ISA bridge: Intel Corporation 5 Series Chipset LPC Interface Controller
> (rev 06)
> 00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset 6 port
> SATA AHCI Controller (rev 06)
> 00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus Controller
> (rev 06)
> 01:00.0 USB Controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev
> 03)
> 02:00.0 SATA controller: JMicron Technology Corp. JMB362/JMB363 Serial ATA
> Controller (rev 02)
> 02:00.1 IDE interface: JMicron Technology Corp. JMB362/JMB363 Serial ATA
> Controller (rev 02)
> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI
> Express Gigabit Ethernet controller (rev 06)
> 04:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit
> Ethernet (rev 10)
> --
> 
> IRQ 16 seems to be the SATA controller.
> 
> A fast dmesg grep for 16 & irq, gives:
> 
> --
> flecha:~# dmesg |grep -i 16|grep -i irq
>   alloc irq_desc for 16 on node -1
> pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ahci 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> ata7: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe100 irq 16
> ata8: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe180 irq 16
> r8169 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
> r8169 0000:03:00.0: irq 44 for MSI/MSI-X
> r8169 0000:03:00.0: eth0: RTL8168b/8111b at 0xf86cc000, 1c:6f:65:85:79:47, XID
> 0c200000 IRQ 44
> r8169 0000:04:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> r8169 0000:04:02.0: eth1: RTL8169 at 0xf86d0000, 00:13:f7:ef:31:8e, XID
> 10000000 IRQ 18
> irq 16: nobody cared (try booting with the "irqpoll" option)
> Disabling IRQ #16
> flecha:~#
> --
> 
> 
> a full dmesg here for full analysis.
> 
> http://pastebin.com/ky9eumHD
> 
> Should I worry about this?
> In the last weeks I'd had some crash's of the kernel with a system restart
> needed, maybe this is related.
> 

