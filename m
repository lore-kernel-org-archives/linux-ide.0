From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_sil: improved interrupt handling
Date: Mon, 05 Dec 2005 15:36:21 +0900
Message-ID: <4393DFE5.1020409@gmail.com>
References: <20051203054127.GA11208@havoc.gtf.org> <439319ED.8050303@gmail.com> <439343BC.902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:6611 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751059AbVLEGg1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2005 01:36:27 -0500
Received: by zproxy.gmail.com with SMTP id 14so887034nzn
        for <linux-ide@vger.kernel.org>; Sun, 04 Dec 2005 22:36:27 -0800 (PST)
In-Reply-To: <439343BC.902@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Ethan Chen <thanatoz@ucla.edu>, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>=20
>> Hi, Jeff.
>>
>> Jeff Garzik wrote:
>>
>>> Just committed the following to the 'sii-irq' branch of libata-dev.=
git,
>>> and verified it on an Adaptec 1210SA (3112).
>>>
>>> Haven't decided whether I will push it upstream or not, but I think=
 I
>>> will.  It does a bit better job of handling handling errors, and sh=
ould
>>> be more efficient (less CPU usage) than the standard ATA interrupt
>>> handler as well.
>>>
>>> For users seeing sata_sil problems, this may make them happy.
>>>
>>
>> This patch doesn't make any difference on my sil3114 controller.  I'=
ll=20
>> write about it in the m15w thread.
>=20
>=20
> "doesn't make any difference" I will interpret to mean there are no=20
> regressions.
>=20

I wasn't clear enough.  I meant that the change did not fix the=20
seemlingly-m15w problems on 3114.

>=20
>> Also, this patch doesn't implement proper handling of PIO protocols=20
>> and thus breaks ALL branch.
>=20
>=20
> PIO should work fine, modulo the obvious changes for ATA_FLAG_NOINTR=20
> disappearance.
>=20

I took out ATA_FLAG_NOINTR test from sata_sil in the latest ALL branch=20
and tested it.  It fails to read IDENTIFY data.  Actually, there is no=20
code to read PIO data.  It should be done in the interrupt handler but=20
sil_port_irq doesn't do it.

scsi3 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000=
=20
88:0000
ata4: no dma
ata4: dev 0 not supported, ignoring
scsi4 : sata_sil
ata5: SATA link up 1.5 Gbps (SStatus 113)
ata5: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000=
=20
88:0000
ata5: no dma
ata5: dev 0 not supported, ignoring
scsi5 : sata_sil
ata6: SATA link up 1.5 Gbps (SStatus 113)
ata6: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000=
=20
88:0000
ata6: no dma
ata6: dev 0 not supported, ignoring
scsi6 : sata_sil

>=20
>> It seems to me that the changes made by the new interrupt handler is=
=20
>> not very sil3112 specific.  Is there any reason this change is sil31=
12=20
>> specific?
>=20
>=20
> There is nothing 3112-specific about this new code.
>=20
>=20
>>> commit b6abf7755a79383f0e5f108d23a0394f156c54c1
>>> Author: Jeff Garzik <jgarzik@pobox.com>
>>> Date:   Sat Dec 3 00:30:57 2005 -0500
>>>
>>>     [libata sata_sil] improved interrupt handling
>>>
>>>  drivers/scsi/sata_sil.c |  118=20
>>> +++++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 files changed, 117 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
>>> index 3609186..37398a5 100644
>>> --- a/drivers/scsi/sata_sil.c
>>> +++ b/drivers/scsi/sata_sil.c
>>> @@ -85,6 +85,7 @@ static void sil_dev_config(struct ata_po
>>>  static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg)=
;
>>>  static void sil_scr_write (struct ata_port *ap, unsigned int sc_re=
g,=20
>>> u32 val);
>>>  static void sil_post_set_mode (struct ata_port *ap);
>>> +static irqreturn_t sil_irq (int irq, void *dev_instance, struct=20
>>> pt_regs *regs);
>>> =20
>>> =20
>>>  static const struct pci_device_id sil_pci_tbl[] =3D {
>>> @@ -167,7 +168,7 @@ static const struct ata_port_operations     =20
>>> .qc_prep        =3D ata_qc_prep,
>>>      .qc_issue        =3D ata_qc_issue_prot,
>>>      .eng_timeout        =3D ata_eng_timeout,
>>> -    .irq_handler        =3D ata_interrupt,
>>> +    .irq_handler        =3D sil_irq,
>>>      .irq_clear        =3D ata_bmdma_irq_clear,
>>>      .scr_read        =3D sil_scr_read,
>>>      .scr_write        =3D sil_scr_write,
>>> @@ -233,6 +234,121 @@ MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
>>>  MODULE_VERSION(DRV_VERSION);
>>> =20
>>> =20
>>> +static inline void sil_port_irq(struct ata_port *ap, void __iomem=20
>>> *mmio,
>>> +                u8 dma_stat, u8 dma_stat_mask)
>>> +{
>>> +    struct ata_queued_cmd *qc =3D NULL;
>>> +    unsigned int err_mask =3D AC_ERR_OTHER;
>>> +    int complete =3D 1;
>>> +    u8 dev_stat;
>>> +
>>> +    /* Exit now, if port or port's irqs are disabled */
>>> +    if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR)) {
>>> +        complete =3D 0;
>>> +        goto out;
>>> +    }
>>
>>
>>
>> Hmmm... By performing this test here, we end up reading bmdma status=
=20
>> registers of all ports everytime an interrupt occurs.  Is this to=20
>> prevent screaming IRQ problem?
>=20
>=20
> That's the preferred way to handle interrupts on this hardware.  Norm=
al=20
> ATA is broken due to the lack of a way to ask "did I receive an=20
> interrupt?" without unduly affecting state.  311x, like AHCI, sata_si=
l24=20
> and other hardware, provides a method to easily determine if a PCI=20
> interrupt is owned by the hardware or not.
>=20

Ah... I see.  Section 7.4 of sii3112 manual says that

Wait until an IDE channel interrupt (bit 11 in the IDEx Task File Timin=
g=20
+ Configuration + Status register is set).

Where the register is at BAR5 + 0xA0 and bit 11 is

=95 Bit [11]: Interrupt Status (R) =96 IDE0 Interrupt Status. This bit =
set=20
indicates that an interrupt is pending on IDE0. This bit provides=20
real-time status of the IDE0 interrupt pin.

And, section 6.7.1 (PCI bus master - IDE0 register) says

=95 Bit [18]: IDE0 DMA Comp (R/W1C) =96 IDE0 DMA Completion Interrupt.=20
During write DMA operation, This bit set indicates that the IDE0=20
interrupt has been asserted and all data has been written to system=20
memory. During Read DMA, This bit set indicates that the IDE0 interrupt=
=20
has been asserted. This bit must be W1C by software when set during DMA=
=20
operation (bit 0 is set). During normal operation, this bit reflects=20
IDE0 interrupt line.

So, the last sentence means that while on DMA command is in progress,=20
bit 18 of the PCI bus master is identical to bit 11 of the conf/status=20
register.  Right?

Yeap, I agree that this is a good change although it hurts a little bit=
=20
that it causes a few extra PCI transactions.

Also, it seems a little bit weird that the code enters interrupt=20
handling even for ports which don't have ATA_DMA_INTR set, although I=20
don't think the current code would bogusly finish commands due to the=20
ATA_BUSY check.  Is this intentional?

> The code should eliminate all screaming interrupt problems, yes.
>=20
> As an aside, 3114 should use a single 32-bit read of the Interrupt=20
> Summary register, rather than the four separate 8-bit reads that this=
=20
> code does.

That sounds cool.

--=20
tejun
