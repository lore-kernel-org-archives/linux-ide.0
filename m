From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: MSI broken in libata?
Date: Tue, 19 Jan 2010 21:00:34 -0600
Message-ID: <51f3faa71001191900y521f2be3u3a5e341f3113559@mail.gmail.com>
References: <64bb37e0912250122n4e0e1842q88c0dad7e99ec6a7@mail.gmail.com>
	 <64bb37e1001092033r1f0b4defw46c1a07101bb2d1b@mail.gmail.com>
	 <4B4A7BC7.6060106@kernel.org> <4B4A815A.60503@gmail.com>
	 <64bb37e1001161358r79ea2da0u88e9894fa5987ef1@mail.gmail.com>
	 <4B536383.7090609@gmail.com>
	 <64bb37e1001171311u21c58fbj9a13b6aaeb7b2c3f@mail.gmail.com>
	 <64bb37e1001181251y733513cdm1be9850af880ee73@mail.gmail.com>
	 <4B55130D.8070503@gmail.com>
	 <64bb37e1001191220u72f7af29xdc1c39f1d114bc21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:63182 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0ATDAi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 22:00:38 -0500
In-Reply-To: <64bb37e1001191220u72f7af29xdc1c39f1d114bc21@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tue, Jan 19, 2010 at 2:20 PM, Torsten Kaiser
<just.for.lkml@googlemail.com> wrote:
> On Tue, Jan 19, 2010 at 3:03 AM, Robert Hancock <hancockrwd@gmail.com=
> wrote:
>> On 01/18/2010 02:51 PM, Torsten Kaiser wrote:
>>> If I kill the drive with reading a 1GB file with dd, I get the abov=
e
>>> errors, include the one from do_IRQ.
>>> If I kill the drive with writing a 1GB file with dd, I do not get t=
he
>>> do_IRQ error.
>>> As I tested the earlier -rcs only with writes, I didn't see it ther=
e.
>>> (Its not even in the old logs that contain the libata errors)
>>>
>>> Should I try to put some printks in arch/x86/kernel/apic/io_apic.c
>>> __assign_irq_vector() or is there a better way to look at the irq
>>> vectors?
>>
>> Might not be a bad idea. Something definitely seems to be banging on=
 vector
>> 165. Any references to 165 in dmesg prior to that? I wonder where th=
at is
>> coming from..
>
> I still have no clue, where that interrupt comes from, maybe these
> outputs will help:
> (complete log attached)
>
> First the PCIe bridges allocate some vectors:
> [ =A0 =A01.789044] pcieport 0000:00:0b.0: setting latency timer to 64
> [ =A0 =A01.789058] =A0 alloc irq_desc for 24 on node 0
> [ =A0 =A01.789060] =A0 alloc kstat_irqs on node 0
> [ =A0 =A01.789063] __assign_irq_vector:assigning irq 24 to vector 73
> [ =A0 =A01.794655] pcieport 0000:00:0b.0: irq 24 for MSI/MSI-X
> [ =A0 =A01.794968] pcieport 0000:00:0c.0: setting latency timer to 64
> [ =A0 =A01.794980] =A0 alloc irq_desc for 25 on node 0
> [ =A0 =A01.794981] =A0 alloc kstat_irqs on node 0
> [ =A0 =A01.794983] __assign_irq_vector:assigning irq 25 to vector 81
> [ =A0 =A01.800569] pcieport 0000:00:0c.0: irq 25 for MSI/MSI-X
> [ =A0 =A01.800870] pcieport 0000:00:0d.0: setting latency timer to 64
> [ =A0 =A01.800882] =A0 alloc irq_desc for 26 on node 0
> [ =A0 =A01.800883] =A0 alloc kstat_irqs on node 0
> [ =A0 =A01.800885] __assign_irq_vector:assigning irq 26 to vector 89
> [ =A0 =A01.806455] pcieport 0000:00:0d.0: irq 26 for MSI/MSI-X
> [ =A0 =A01.806766] pcieport 0000:00:0f.0: setting latency timer to 64
> [ =A0 =A01.806778] =A0 alloc irq_desc for 27 on node 0
> [ =A0 =A01.806779] =A0 alloc kstat_irqs on node 0
> [ =A0 =A01.806781] __assign_irq_vector:assigning irq 27 to vector 97
> [ =A0 =A01.812366] pcieport 0000:00:0f.0: irq 27 for MSI/MSI-X
> radeon allocates to vectors, is that right?
> [ =A0 =A01.861528] [drm] radeon kernel modesetting enabled.
> [ =A0 =A01.866835] ACPI: PCI Interrupt Link [LNEB] enabled at IRQ 19
> [ =A0 =A01.872598] =A0 alloc irq_desc for 19 on node 0
> [ =A0 =A01.872600] =A0 alloc kstat_irqs on node 0
> [ =A0 =A01.872602] __assign_irq_vector:assigning irq 19 to vector 105
> [ =A0 =A01.878261] radeon 0000:01:00.0: PCI INT A -> Link[LNEB] -> GS=
I 19
> (level, low) -> IRQ 19
> [ =A0 =A01.886673] radeon 0000:01:00.0: setting latency timer to 64
> [ =A0 =A01.888791] [drm] radeon: Initializing kernel modesetting.
> [ =A0 =A01.894449] [drm] register mmio base: 0xEFBF0000
> [ =A0 =A01.899068] [drm] register mmio size: 65536
> [ =A0 =A01.903947] [drm] GPU reset succeed (RBBM_STATUS=3D0x00000140)
> [ =A0 =A01.909620] [drm] Generation 2 PCI interface, using max access=
ible memory
> [ =A0 =A01.916436] [drm] radeon: VRAM 128M
> [ =A0 =A01.919930] [drm] radeon: VRAM from 0x00000000 to 0x07FFFFFF
> [ =A0 =A01.925610] [drm] radeon: GTT 512M
> [ =A0 =A01.929022] [drm] radeon: GTT from 0x20000000 to 0x3FFFFFFF
> [ =A0 =A01.934635] =A0 alloc irq_desc for 28 on node 0
> [ =A0 =A01.934637] =A0 alloc kstat_irqs on node 0
> [ =A0 =A01.934640] __assign_irq_vector:assigning irq 28 to vector 113
> [ =A0 =A01.940314] radeon 0000:01:00.0: irq 28 for MSI/MSI-X
> [ =A0 =A01.940522] [drm] radeon: using MSI.
> [ =A0 =A01.944120] [drm] radeon: irq initialized.
> Now sata_sil24 gets vector 121:
> [ =A0 =A02.525316] sata_sil24 0000:04:00.0: version 1.1
> [ =A0 =A02.525337] sata_sil24 0000:04:00.0: PCI INT A -> Link[LNEB] -=
> GSI
> 19 (level, low)
> -> IRQ 19
> [ =A0 =A02.533990] =A0 alloc irq_desc for 29 on node 0
> [ =A0 =A02.533991] =A0 alloc kstat_irqs on node 0
> [ =A0 =A02.533994] __assign_irq_vector:assigning irq 29 to vector 121
> [ =A0 =A02.539681] sata_sil24 0000:04:00.0: irq 29 for MSI/MSI-X
> [ =A0 =A02.539882] sata_sil24 0000:04:00.0: Using MSI
> [ =A0 =A02.544372] sata_sil24 0000:04:00.0: setting latency timer to =
64
> sata_nv gets 3 interrupts (the MCP55 has 6 ports)
> [ =A0 =A02.565829] sata_nv 0000:00:05.0: version 3.5
> [ =A0 =A02.566114] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
> [ =A0 =A02.571896] =A0 alloc irq_desc for 23 on node 0
> [ =A0 =A02.571898] =A0 alloc kstat_irqs on node 0
> [ =A0 =A02.571900] __assign_irq_vector:assigning irq 23 to vector 129
> [ =A0 =A02.577583] sata_nv 0000:00:05.0: PCI INT A -> Link[LSA0] -> G=
SI 23
> (level, low) ->
> IRQ 23
> [ =A0 =A02.586099] sata_nv 0000:00:05.0: Using SWNCQ mode
> [ =A0 =A02.590956] sata_nv 0000:00:05.0: setting latency timer to 64
> [ =A0 =A02.591071] scsi2 : sata_nv
> [ =A0 =A02.594013] scsi3 : sata_nv
> [ =A0 =A02.597018] ata3: SATA max UDMA/133 cmd 0xcc00 ctl 0xc880 bmdm=
a 0xc400 irq 23
> [ =A0 =A02.604196] ata4: SATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdm=
a 0xc408 irq 23
> [ =A0 =A02.611671] ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 22
> [ =A0 =A02.617435] =A0 alloc irq_desc for 22 on node 0
> [ =A0 =A02.617436] =A0 alloc kstat_irqs on node 0
> [ =A0 =A02.617438] __assign_irq_vector:assigning irq 22 to vector 137
> [ =A0 =A02.623152] sata_nv 0000:00:05.1: PCI INT B -> Link[LSA1] -> G=
SI 22
> (level, low) ->
> IRQ 22
> [ =A0 =A02.631657] sata_nv 0000:00:05.1: Using SWNCQ mode
> [ =A0 =A02.636490] sata_nv 0000:00:05.1: setting latency timer to 64
> [ =A0 =A02.636618] scsi4 : sata_nv
> [ =A0 =A02.639558] scsi5 : sata_nv
> [ =A0 =A02.642573] ata5: SATA max UDMA/133 cmd 0xc080 ctl 0xc000 bmdm=
a 0xb800 irq 22
> [ =A0 =A02.649726] ata6: SATA max UDMA/133 cmd 0xbc00 ctl 0xb880 bmdm=
a 0xb808 irq 22
> [ =A0 =A02.657246] ACPI: PCI Interrupt Link [LSA2] enabled at IRQ 21
> [ =A0 =A02.663034] =A0 alloc irq_desc for 21 on node 0
> [ =A0 =A02.663035] =A0 alloc kstat_irqs on node 0
> [ =A0 =A02.663037] __assign_irq_vector:assigning irq 21 to vector 145
> [ =A0 =A02.668720] sata_nv 0000:00:05.2: PCI INT C -> Link[LSA2] -> G=
SI 21
> (level, low) -> IRQ 21
> [ =A0 =A02.677237] sata_nv 0000:00:05.2: Using SWNCQ mode
> [ =A0 =A02.682085] sata_nv 0000:00:05.2: setting latency timer to 64
> [ =A0 =A02.682204] scsi6 : sata_nv
> [ =A0 =A02.685148] scsi7 : sata_nv
> [ =A0 =A02.688149] ata7: SATA max UDMA/133 cmd 0xb480 ctl 0xb400 bmdm=
a 0xac00 irq 21
> [ =A0 =A02.695325] ata8: SATA max UDMA/133 cmd 0xb080 ctl 0xb000 bmdm=
a 0xac08 irq 21
> the network chips follow:
> [ =A0 =A02.729649] tg3.c:v3.105 (December 2, 2009)
> [ =A0 =A02.735339] ACPI: PCI Interrupt Link [LNEA] enabled at IRQ 18
> [ =A0 =A02.742377] =A0 alloc irq_desc for 18 on node 0
> [ =A0 =A02.742378] =A0 alloc kstat_irqs on node 0
> [ =A0 =A02.742380] __assign_irq_vector:assigning irq 18 to vector 153
> [ =A0 =A02.748065] tg3 0000:03:00.0: PCI INT A -> Link[LNEA] -> GSI 1=
8
> (level, low) -> IRQ 18
> ...
> [ =A0 =A02.838517] ACPI: PCI Interrupt Link [LNED] enabled at IRQ 17
> [ =A0 =A02.845796] =A0 alloc irq_desc for 17 on node 0
> [ =A0 =A02.845797] =A0 alloc kstat_irqs on node 0
> [ =A0 =A02.845799] __assign_irq_vector:assigning irq 17 to vector 161
> [ =A0 =A02.851501] tg3 0000:02:00.0: PCI INT A -> Link[LNED] -> GSI 1=
7
> (level, low) -> IRQ 17
> one for the firewrie chip:
> [ =A0 =A02.939495] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 16
> [ =A0 =A02.946971] =A0 alloc irq_desc for 16 on node 0
> [ =A0 =A02.946972] =A0 alloc kstat_irqs on node 0
> [ =A0 =A02.946974] __assign_irq_vector:assigning irq 16 to vector 169
> [ =A0 =A02.952677] ohci1394 0000:05:08.0: PCI INT A -> Link[LNKA] -> =
GSI
> 16 (level, low) -> IRQ 16
> USB:
> [ =A0 =A03.058354] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI=
) Driver
> [ =A0 =A03.066956] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 20
> [ =A0 =A03.074517] =A0 alloc irq_desc for 20 on node 0
> [ =A0 =A03.074518] =A0 alloc kstat_irqs on node 0
> [ =A0 =A03.074520] __assign_irq_vector:assigning irq 20 to vector 177
> [ =A0 =A03.080223] ehci_hcd 0000:00:02.1: PCI INT B -> Link[LUB2] -> =
GSI
> 20 (level, low) -> IRQ 20
> and the last allocation for HDA Intel:
> [ =A0 =A04.993274] =A0 alloc irq_desc for 30 on node 0
> [ =A0 =A04.993276] =A0 alloc kstat_irqs on node 0
> [ =A0 =A04.993279] __assign_irq_vector:assigning irq 30 to vector 185
> [ =A0 =A04.998961] HDA Intel 0000:00:06.1: irq 30 for MSI/MSI-X
> During booting the tg3's change there interrupts. Huh?
> [ =A0 19.135631] =A0 alloc irq_desc for 31 on node 0
> [ =A0 19.135639] =A0 alloc kstat_irqs on node 0
> [ =A0 19.135646] __assign_irq_vector:assigning irq 31 to vector 193
> [ =A0 19.135663] tg3 0000:03:00.0: irq 31 for MSI/MSI-X
> [ =A0 22.326847] tg3: eth0: Link is up at 1000 Mbps, full duplex.
> [ =A0 22.326854] tg3: eth0: Flow control is on for TX and on for RX.
> [ =A0 23.434378] =A0 alloc irq_desc for 32 on node 0
> [ =A0 23.434386] =A0 alloc kstat_irqs on node 0
> [ =A0 23.434393] __assign_irq_vector:assigning irq 32 to vector 201
> [ =A0 23.434410] tg3 0000:02:00.0: irq 32 for MSI/MSI-X
> [ =A0 26.104711] tg3: eth1: Link is up at 1000 Mbps, full duplex.
> [ =A0 26.104718] tg3: eth1: Flow control is on for TX and on for RX.
>
> Then I rerun my readtest and got the same do_IRQ error again:
> [ =A0100.664581] do_IRQ: 0.165 No irq handler for vector (irq -1)
> [ =A0100.664598] do_IRQ: 1.165 No irq handler for vector (irq -1)
> [ =A0100.664619] do_IRQ: 3.165 No irq handler for vector (irq -1)
> [ =A0100.664632] do_IRQ: 2.165 No irq handler for vector (irq -1)
> [ =A0130.980054] ata2.00: exception Emask 0x0 SAct 0x3 SErr 0x0 actio=
n 0x6 frozen
> [ =A0130.980065] ata2.00: failed command: READ FPDMA QUEUED
> [ =A0130.980077] ata2.00: cmd 60/00:00:ad:9b:da/01:00:01:00:00/40 tag=
 0
> ncq 131072 in
> [ =A0130.980080] =A0 =A0 =A0 =A0 =A0res 40/00:00:01:4f:c2/00:00:00:00=
:00/00 Emask
> 0x4 (timeout)
> [ =A0130.980085] ata2.00: status: { DRDY }
> [ =A0130.980090] ata2.00: failed command: READ FPDMA QUEUED
> [ =A0130.980099] ata2.00: cmd 60/00:08:ad:9c:da/01:00:01:00:00/40 tag=
 1
> ncq 131072 in
> [ =A0130.980101] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00=
:00/00 Emask
> 0x4 (timeout)
> [ =A0130.980106] ata2.00: status: { DRDY }
>
> As I did not see any real relation, I disabled all unneeded drivers
> and tested again.
> This minimal kernel had the following interrupt map:
> =A0 =A0 =A0 =A0 =A0 CPU0 =A0 =A0 =A0 CPU1 =A0 =A0 =A0 CPU2 =A0 =A0 =A0=
 CPU3
> =A00: =A0 =A0 =A0 =A0 36 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 =A0 =A01 =A0 IO-APIC-edge =A0 =A0 =A0timer
> =A01: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A01 =
=A0 =A0 =A0 =A0152 =A0 IO-APIC-edge =A0 =A0 =A0i8042
> =A04: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =
=A0 =A0 =A0 =A0212 =A0 IO-APIC-edge =A0 =A0 =A0serial
> =A07: =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =
=A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-edge
> =A09: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =
=A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-fasteoi =A0 acpi
> =A012: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00=
 =A0 =A0 =A0 =A0 =A04 =A0 IO-APIC-edge =A0 =A0 =A0i8042
> =A021: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00=
 =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-fasteoi =A0 sata_nv
> =A022: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00=
 =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-fasteoi =A0 sata_nv
> =A023: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A05 =A0 =A0 =A0 =A0 =A04=
 =A0 =A0 =A0 4980 =A0 IO-APIC-fasteoi =A0 sata_nv
> =A028: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A00=
 =A0 =A0 =A0 =A0168 =A0 PCI-MSI-edge =A0 =A0 =A0sata_sil24
> NMI: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 =A0 =A00 =A0 Non-maskable interrupts
> LOC: =A0 =A0 =A0 2147 =A0 =A0 =A0 2390 =A0 =A0 =A0 2285 =A0 =A0 =A0 2=
344 =A0 Local timer interrupts
> SPU: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 =A0 =A00 =A0 Spurious interrupts
> PMI: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 =A0 =A00 =A0 Performance
> monitoring interrupts
> PND: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 =A0 =A00 =A0 Performance pending work
> RES: =A0 =A0 =A0 3702 =A0 =A0 =A0 3458 =A0 =A0 =A0 2094 =A0 =A0 =A0 2=
746 =A0 Rescheduling interrupts
> CAL: =A0 =A0 =A0 =A0660 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0 =A0 41 =A0 =A0=
 =A0 =A0 26 =A0 Function call interrupts
> TLB: =A0 =A0 =A0 =A0484 =A0 =A0 =A0 =A0200 =A0 =A0 =A0 =A0448 =A0 =A0=
 =A0 =A0581 =A0 TLB shootdowns
> THR: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 =A0 =A00 =A0 Threshold APIC interrupts
> MCE: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 =A0 =A00 =A0 Machine check exceptions
> MCP: =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A01 =A0=
 =A0 =A0 =A0 =A01 =A0 Machine check polls
> ERR: =A0 =A0 =A0 =A0 =A01
> MIS: =A0 =A0 =A0 =A0 =A00
>
> Output of the __assign_irq:
> 4x PCIe bridge:
> [ =A0 =A01.759016] __assign_irq_vector:assigning irq 24 to vector 73
> [ =A0 =A01.764928] __assign_irq_vector:assigning irq 25 to vector 81
> [ =A0 =A01.770827] __assign_irq_vector:assigning irq 26 to vector 89
> [ =A0 =A01.776720] __assign_irq_vector:assigning irq 27 to vector 97
> sata_sil24 first gets 19:
> [ =A0 =A01.856245] __assign_irq_vector:assigning irq 19 to vector 105
> then switches to MSI-28:
> [ =A0 =A01.870768] __assign_irq_vector:assigning irq 28 to vector 113
> 3 normal interrupts for sata_nv:
> [ =A0 =A01.908504] __assign_irq_vector:assigning irq 23 to vector 121
> [ =A0 =A01.953848] __assign_irq_vector:assigning irq 22 to vector 129
> [ =A0 =A01.999155] __assign_irq_vector:assigning irq 21 to vector 137
>
> Writing failed again without a message, but the read test showed:
> [ =A0 85.695745] do_IRQ: 0.165 No irq handler for vector (irq -1)
> [ =A0 85.695763] do_IRQ: 1.165 No irq handler for vector (irq -1)
> [ =A0 85.695785] do_IRQ: 3.165 No irq handler for vector (irq -1)
> [ =A0 85.695800] do_IRQ: 2.165 No irq handler for vector (irq -1)
> Same vector in this error, but sata_sil24 had MSI irq 28 instead of 2=
9!
> And the vector allocations where not even near 165!

Hmm.. Can you send the output of lspci -vv with MSI in use?
