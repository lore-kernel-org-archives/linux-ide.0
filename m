From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Hang during boot, bisected to commit 96d60303fd
Date: Sun, 6 Jun 2010 22:34:45 -0600
Message-ID: <AANLkTinIM8swHZTide7MAQsaYbWcFD90FrKUXE9NFG-5@mail.gmail.com>
References: <AANLkTiktNufXK_pn6mP2-zyowAIbHlUy5TGu3AtpALv-@mail.gmail.com>
	<20100603020006.GB19123@srcf.ucam.org>
	<AANLkTikpv86r5BBPCEOHujpm8uCgY0DxghSKjBufBWiM@mail.gmail.com>
	<4C08760B.8050002@gmail.com>
	<AANLkTimFY5YQv8DC-zTQ1RF84rno6svvcyLzHGWL6HOk@mail.gmail.com>
	<AANLkTimXcF1pafrSt8dMbUs59AjnqaRwpzDnPIPjdjsn@mail.gmail.com>
	<AANLkTinZ7d3WWyO3m9A7GVnaTuSbn1G33ADFW6ixywcT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56210 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab0FGEer convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2010 00:34:47 -0400
In-Reply-To: <AANLkTinZ7d3WWyO3m9A7GVnaTuSbn1G33ADFW6ixywcT@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Dionne <marc.c.dionne@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, garzik@redhat.com, Tejun Heo <tj@kernel.org>

On Fri, Jun 4, 2010 at 8:01 PM, Marc Dionne <marc.c.dionne@gmail.com> w=
rote:
> On Fri, Jun 4, 2010 at 9:37 PM, Robert Hancock <hancockrwd@gmail.com>=
 wrote:
>> Is that the right dmesg? I didn't see where the extra output was. It
>> might be useful to put a WARN_ON(1); inside ahci_start_engine to see
>> the two code paths where it's being called..
>
> The first series of calls to ahci_start_engine have a stack trace tha=
t
> looks like this:
>
> Call Trace:
> =A0[<ffffffff81077002>] warn_slowpath_common+0x85/0x9d
> =A0[<ffffffff81077034>] warn_slowpath_null+0x1a/0x1c
> =A0[<ffffffff813572dd>] ahci_start_engine+0x92/0xa4
> =A0[<ffffffff8135736a>] ahci_start_port+0x7b/0x16c
> =A0[<ffffffff81357792>] ahci_port_resume+0x52/0x73
> =A0[<ffffffff81357901>] ahci_port_start+0x14e/0x164
> =A0[<ffffffff81341dc5>] ata_host_start+0xdf/0x184
> =A0[<ffffffff81357b35>] ? ahci_interrupt+0x0/0x5f3
> =A0[<ffffffff8134266f>] ata_host_activate+0x2a/0xdc
> =A0[<ffffffff81355aab>] ahci_init_one+0x9dd/0x9fe
> =A0[<ffffffff81170a9c>] ? __sysfs_add_one+0x38/0x9a
> =A0[<ffffffff812519bd>] ? kobject_get+0x1a/0x22
> =A0[<ffffffff81269891>] local_pci_probe+0x17/0x1b
> =A0[<ffffffff8126a63f>] pci_device_probe+0xca/0xfa
> =A0[<ffffffff81308fbe>] ? driver_sysfs_add+0x4c/0x71
> =A0[<ffffffff81309110>] driver_probe_device+0xac/0x13b
> =A0[<ffffffff813091fc>] __driver_attach+0x5d/0x81
> =A0[<ffffffff8130919f>] ? __driver_attach+0x0/0x81
> =A0[<ffffffff81308714>] bus_for_each_dev+0x53/0x88
> =A0[<ffffffff81308f70>] driver_attach+0x1e/0x20
> =A0[<ffffffff81308bc3>] bus_add_driver+0xb6/0x203
> =A0[<ffffffff813094ed>] driver_register+0x9e/0x10f
> =A0[<ffffffff8126a869>] __pci_register_driver+0x58/0xc8
> =A0[<ffffffff81b6582c>] ? ahci_init+0x0/0x1b
> =A0[<ffffffff81b65845>] ahci_init+0x19/0x1b
> =A0[<ffffffff81002069>] do_one_initcall+0x5e/0x159
> =A0[<ffffffff81b33713>] kernel_init+0x183/0x211
> =A0[<ffffffff810319a4>] kernel_thread_helper+0x4/0x10
> =A0[<ffffffff81b33590>] ? kernel_init+0x0/0x211
> =A0[<ffffffff810319a0>] ? kernel_thread_helper+0x0/0x10
>
> The later calls:
>
> Call Trace:
> =A0[<ffffffff81077002>] warn_slowpath_common+0x85/0x9d
> =A0[<ffffffff81077034>] warn_slowpath_null+0x1a/0x1c
> =A0[<ffffffff813572dd>] ahci_start_engine+0x92/0xa4
> =A0[<ffffffff81357a0d>] ahci_hardreset+0xc6/0x124
> =A0[<ffffffff81357947>] ? ahci_hardreset+0x0/0x124
> =A0[<ffffffff81342e08>] ? ata_std_prereset+0x0/0xb7
> =A0[<ffffffff8134aeca>] ata_do_reset+0x59/0x62
> =A0[<ffffffff8134c3fa>] ata_eh_reset+0x512/0xc99
> =A0[<ffffffff81356baa>] ? ahci_postreset+0x0/0x5d
> =A0[<ffffffff81357947>] ? ahci_hardreset+0x0/0x124
> =A0[<ffffffff81358498>] ? ahci_softreset+0x0/0x44
> =A0[<ffffffff81357947>] ? ahci_hardreset+0x0/0x124
> =A0[<ffffffff8134d9a1>] ? ata_eh_schedule_probe+0xc5/0xf3
> =A0[<ffffffff8134dca7>] ata_eh_recover+0x2d8/0xd6d
> =A0[<ffffffff81356baa>] ? ahci_postreset+0x0/0x5d
> =A0[<ffffffff81357947>] ? ahci_hardreset+0x0/0x124
> =A0[<ffffffff81358498>] ? ahci_softreset+0x0/0x44
> =A0[<ffffffff81342e08>] ? ata_std_prereset+0x0/0xb7
> =A0[<ffffffff81352ec9>] sata_pmp_error_handler+0xd3/0xa0a
> =A0[<ffffffff81067f73>] ? dequeue_entity+0x4a/0x183
> =A0[<ffffffff8108c1ae>] ? __cancel_work_timer+0xad/0x193
> =A0[<ffffffff8108395e>] ? lock_timer_base+0x2c/0x52
> =A0[<ffffffff810839ff>] ? try_to_del_timer_sync+0x7b/0x89
> =A0[<ffffffff81357943>] ahci_error_handler+0x2c/0x30
> =A0[<ffffffff8134f2c7>] ata_scsi_error+0x33d/0x697
> =A0[<ffffffff8131bc10>] scsi_error_handler+0xc2/0x3c5
> =A0[<ffffffff8131bb4e>] ? scsi_error_handler+0x0/0x3c5
> =A0[<ffffffff8108f451>] kthread+0x7f/0x87
> =A0[<ffffffff810319a4>] kernel_thread_helper+0x4/0x10
> =A0[<ffffffff8108f3d2>] ? kthread+0x0/0x87
> =A0[<ffffffff810319a0>] ? kernel_thread_helper+0x0/0x10

I'm thinking that the hardreset and device classification makes more
sense as a place to do this anyways, since that's the point where we
really know if there's a device connected or not.. Tejun, any
thoughts?
