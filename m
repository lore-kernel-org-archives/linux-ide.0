From: Dominic Ijichi <dom@ijichi.org>
Subject: Re: [PATCH 6/6 update] SATA ACPI: ata_acpi functions
Date: Thu, 08 Dec 2005 09:43:30 +0000
Message-ID: <1134035010.4398004299a80@www.ijichi.org>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com> <20051202100850.11b831ea.randy_d_dunlap@linux.intel.com> <20051206135815.5026647c.randy_d_dunlap@linux.intel.com> <1133973407.43970f9fdf6dd@www.ijichi.org> <20051207091639.00a7a232.randy_d_dunlap@linux.intel.com> <1133976270.43971ace1c015@www.ijichi.org> <20051207103449.2922faf3.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from buffy.ijichi.org ([213.161.76.94]:48564 "EHLO buffy.ijichi.org")
	by vger.kernel.org with ESMTP id S1751017AbVLHJnt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2005 04:43:49 -0500
In-Reply-To: <20051207103449.2922faf3.randy_d_dunlap@linux.intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-ide@vger.kernel.org, axboe@suse.de, jgarzik@pobox.com

Quoting Randy Dunlap <randy_d_dunlap@linux.intel.com>:

> On Wed, 07 Dec 2005 17:24:30 +0000
> Dominic Ijichi <dom@ijichi.org> wrote:
> 
> > Quoting Randy Dunlap <randy_d_dunlap@linux.intel.com>:
> >
> > > On Wed, 07 Dec 2005 16:36:47 +0000
> > > Dominic Ijichi <dom@ijichi.org> wrote:
> > >
> > > > I get a segfault when applying these patches to 2.6.15-rc4.  ahci
> compiled
> > > as
> > > > module and inserted through initrd so the module fails with segfault
> and
> > > kernel
> > > > doesnt go any further through boot, hence no logging.  last thing
> screen
> > > shows is:
> > > >
> > > > Code: e3 36 34 c0 c7 44 24 18 29 02 00 00 59 5b 5e 5f 5d e9 f3 05 00 00
> 53
> > > 8b 5c
> > > > 2408 e8 e9 03 00 00 a1 dc 0c 42 c0 eb 04 39 d8 74 07 <8b> 40 04 85 c0
> 75 f5
> > > 5b
> > > > c3 55 57 56 53 50 8b 44 24 20 8b 5c 24
> > >
> > > Can you provide any more of the segfault messages?  That one
> > > isn't particularly helpful.
> >
> > ok, see below. this is typed in on another computer, i'll try to minimise
> typos!
> 
> OK, well, that's a little better, but the top of the backtrace
> is where the nitty gritty info is.
> Is it possible for you to use any other method of capturing
> more fault messages, like serial console, netconsole,
> or even higher resolution video (and smaller font)
> so that I can see where the fault is actually happening?
> 
> Thanks.

ok.  eye-watering font, but here's what it says:

ata1: dev 0 configured for UDMA/100
Unable to handle kernel paging request at virtual address eaeaeaee
 printing eip:
c0218c67
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: ahci piix ide_disk ide_core
CPU: 0
EIP: 0060:[<c0218c67>] Not tainted VLI
EFLAGS: 00010202 (2.6.15-rc4)
EIP is at acpi_ut_find_allocation+0x15/0x1e
eax: eaeaeaea ebx: df0d8c00 ec: 00000000 edx: 00000007
esi: c0388b0d edi: 00000000 ebp: dffd0e40 esp: c17e9bdc
ds: 007b es: 007b ss: 0068
Process modprobe (pid: 1353, threadinfo=c17e8000 task=deeb3070)
Stack: df0d8c00 c0218cd8 df0d8c00 0000001 df0d8c00 000001ef 00000010 c0388b0d
 c0218b04 df0d8c00 00000008 00000001 00000010 c0388b0d 000001ef c03890d5
 c17e9c40 c17e9c74 c03890d5 c020ea16 00000008 00000010 c0388b0d 000001ef
Call Trace:
[<c0218cd8>] acpi_ut_track_allocation+0x68/0x127
[<c0218b04>] acpi_ut_callocate_and_track+0x55/0x83
[<c020ea16>] acpi_ns_internalize_name+0x82/0x113
[<c020dcf6>] acpi_ns_evaluate_relatvie+0x66/0x1ca
[<c02195de>] acpi_ut_evaluate_object+0x46/0x22a
[<c0219ba3>] acpi_ut_execute_STA+0x35/0xc4
[<c020d468>] acpi_ns_get_device_callback+0x4e/0x151
[<c02104ec>] acpi_ns_walk_namespace+0xbb/0x1b7
[<c020d604>] acpi_get_devices+0x99/0xc4
[<c020d41a>] acpi_ns_get_device_callback+0x0/0x151
[<c0277280>] get_devices+0x0/0x220
[<c0277539>] get_sata_adr+0x99/0x110
[<c0277280>] get_devices+0x0/0x220
[<c02778e6>] do_drive_get_GTF+0x136/0x200
[<c0277d8f>] do_drive_update_taskfiles+0x2f/0x70
[<c0270578>] ata_set_mode+0x98/0xb0
[<c026fc0b>] ata_bus_probe+0xab/0xc0
> > [<c02516c9>] ata_device_add+0x1e9/0x2b0
> > [<e082d850>] ahci_interrupt+0x0/0x1e0 [achi]
> > [<e082e263>] ahci_init_one+0x1a3/0x270 [achi]
> > [<c01cb5d6>] __pci_device_probe+0x56/0x70
> > [<c01cb61f>] pci_device_probe+0x2f/0x50
> > [<c023b313>] driver_probe_device+0x43/0xd0
> > [<c023b420>] __driver_attach+0x0/0x50
> > [<c023b461>] __driver_attach+0x41/0x50
> > [<c023a84d>] bus_for_each_dev+0x5d/0x80
> > [<c023b495>] driver_attach+0x25/0x30
> > [<c023b420>] __driver_attach+0x0/0x50
> > [<c023ada9>] bus_add_driver+0x89/0xf0
> > [<c01cb8a4>] __pci_register_driver+0x74/0xa0
> > [<e0832018>] ahci_init+0x18/0x1c [achi]
> > [c01364c2>] sys_init_module+0xd/0x210
> > [<c0103291>] syscall_call+0x7/0xb


> 
> > > Is this on your Fujitsu notebook, with the same hardware
> > > configuration as last week?
> >
> > yup
> >
> > --
> >
> > [<c02516c9>] ata_device_add+0x1e9/0x2b0
> > [<e082d850>] ahci_interrupt+0x0/0x1e0 [achi]
> > [<e082e263>] ahci_init_one+0x1a3/0x270 [achi]
> > [<c01cb5d6>] __pci_device_probe+0x56/0x70
> > [<c01cb61f>] pci_device_probe+0x2f/0x50
> > [<c023b313>] driver_probe_device+0x43/0xd0
> > [<c023b420>] __driver_attach+0x0/0x50
> > [<c023b461>] __driver_attach+0x41/0x50
> > [<c023a84d>] bus_for_each_dev+0x5d/0x80
> > [<c023b495>] driver_attach+0x25/0x30
> > [<c023b420>] __driver_attach+0x0/0x50
> > [<c023ada9>] bus_add_driver+0x89/0xf0
> > [<c01cb8a4>] __pci_register_driver+0x74/0xa0
> > [<e0832018>] ahci_init+0x18/0x1c [achi]
> > [c01364c2>] sys_init_module+0xd/0x210
> > [<c0103291>] syscall_call+0x7/0xb
> >
> > then the Code: line
> >
> > thats all that's left on the screen unfortunately, the rest scrolls off the
> top.
> 
> ---
> ~Randy


------------------------------------------
This message was penned by the hand of Dom
