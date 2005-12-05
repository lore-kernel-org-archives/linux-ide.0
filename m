From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil: improved interrupt handling
Date: Mon, 05 Dec 2005 13:36:53 -0500
Message-ID: <439488C5.6070309@pobox.com>
References: <20051203054127.GA11208@havoc.gtf.org> <439319ED.8050303@gmail.com> <439343BC.902@pobox.com> <4393DFE5.1020409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:2188 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932498AbVLESg5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2005 13:36:57 -0500
In-Reply-To: <4393DFE5.1020409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Ethan Chen <thanatoz@ucla.edu>, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Tejun Heo wrote:
> Jeff Garzik wrote:
>=20
>> Tejun Heo wrote:
>>
>>> Hi, Jeff.
>>>
>>> Jeff Garzik wrote:
>>>
>>>> Just committed the following to the 'sii-irq' branch of libata-dev=
=2Egit,
>>>> and verified it on an Adaptec 1210SA (3112).
>>>>
>>>> Haven't decided whether I will push it upstream or not, but I thin=
k I
>>>> will.  It does a bit better job of handling handling errors, and s=
hould
>>>> be more efficient (less CPU usage) than the standard ATA interrupt
>>>> handler as well.
>>>>
>>>> For users seeing sata_sil problems, this may make them happy.
>>>>
>>>
>>> This patch doesn't make any difference on my sil3114 controller. =20
>>> I'll write about it in the m15w thread.
>>
>>
>>
>> "doesn't make any difference" I will interpret to mean there are no=20
>> regressions.
>>
>=20
> I wasn't clear enough.  I meant that the change did not fix the=20
> seemlingly-m15w problems on 3114.

That's expected.  3114 should work (or not) as before.


>>> Also, this patch doesn't implement proper handling of PIO protocols=
=20
>>> and thus breaks ALL branch.
>>
>>
>>
>> PIO should work fine, modulo the obvious changes for ATA_FLAG_NOINTR=
=20
>> disappearance.
>>
>=20
> I took out ATA_FLAG_NOINTR test from sata_sil in the latest ALL branc=
h=20
> and tested it.  It fails to read IDENTIFY data.  Actually, there is n=
o=20
> code to read PIO data.  It should be done in the interrupt handler bu=
t=20
> sil_port_irq doesn't do it.

Correct.  sata_sil only works against upstream 2.6.x, not=20
libata-dev.git#ALL.

The next step is to support PIO-via-DMA, but supporting the updates in=20
the irq-pio branch may also be a good next-step.


>> That's the preferred way to handle interrupts on this hardware. =20
>> Normal ATA is broken due to the lack of a way to ask "did I receive =
an=20
>> interrupt?" without unduly affecting state.  311x, like AHCI,=20
>> sata_sil24 and other hardware, provides a method to easily determine=
=20
>> if a PCI interrupt is owned by the hardware or not.
>>
>=20
> Ah... I see.  Section 7.4 of sii3112 manual says that
>=20
> Wait until an IDE channel interrupt (bit 11 in the IDEx Task File Tim=
ing=20
> + Configuration + Status register is set).
>=20
> Where the register is at BAR5 + 0xA0 and bit 11 is
>=20
> =95 Bit [11]: Interrupt Status (R) =96 IDE0 Interrupt Status. This bi=
t set=20
> indicates that an interrupt is pending on IDE0. This bit provides=20
> real-time status of the IDE0 interrupt pin.
>=20
> And, section 6.7.1 (PCI bus master - IDE0 register) says
>=20
> =95 Bit [18]: IDE0 DMA Comp (R/W1C) =96 IDE0 DMA Completion Interrupt=
=2E=20
> During write DMA operation, This bit set indicates that the IDE0=20
> interrupt has been asserted and all data has been written to system=20
> memory. During Read DMA, This bit set indicates that the IDE0 interru=
pt=20
> has been asserted. This bit must be W1C by software when set during D=
MA=20
> operation (bit 0 is set). During normal operation, this bit reflects=20
> IDE0 interrupt line.
>=20
> So, the last sentence means that while on DMA command is in progress,=
=20
> bit 18 of the PCI bus master is identical to bit 11 of the conf/statu=
s=20
> register.  Right?

Not quite.  When the operation is DMA, the 8-bit bmdma status reflects=20
the DMA operation.  When the operation is not DMA, the status reflects=20
the IDE interrupt line.


> Yeap, I agree that this is a good change although it hurts a little b=
it=20
> that it causes a few extra PCI transactions.

What, for the non-existent ports?

=46urther code should be added to disable the interrupts for the disabl=
ed=20
ports, then we can skip the check.


> Also, it seems a little bit weird that the code enters interrupt=20
> handling even for ports which don't have ATA_DMA_INTR set, although I=
=20
> don't think the current code would bogusly finish commands due to the=
=20
> ATA_BUSY check.  Is this intentional?

dma_stat_mask=3D=3D0 check needs to be added, for non-DMA commands.  Th=
at's=20
about it.

	Jeff


