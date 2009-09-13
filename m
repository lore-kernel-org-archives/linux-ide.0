From: "Jung-Ik (John) Lee" <jilee@google.com>
Subject: Re: [PATCH] libata: Add pata_atp867x driver for Artop/Acard ATP867X
	controllers
Date: Sat, 12 Sep 2009 21:55:33 -0700
Message-ID: <8b5805ff0909122155u77a869c5t89a81fbf1a7eb391@mail.gmail.com>
References: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com>
	<1252721641.28368.34.camel@desktop> <8b5805ff0909120359g2faf661br463b19518d935110@mail.gmail.com>
	<4AABD122.2000400@gmail.com> <8b5805ff0909121717w1516c273k2a568779b9c31662@mail.gmail.com>
	<8b5805ff0909121726g2f1a78c1o1ff7289e059eabe5@mail.gmail.com>
	<4AAC4315.6010102@pobox.com> <8b5805ff0909121941y38b7764fv3cc4d0b5c1ba6c89@mail.gmail.com>
	<4AAC632E.3090902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750958AbZIMEz5@vger.kernel.org>
In-Reply-To: <4AAC632E.3090902@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Daniel Walker <dwalker@fifo99.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Eric Uhrhane <ericu@google.com>
List-Id: linux-ide@vger.kernel.org

On Sat, Sep 12, 2009 at 8:12 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 09/12/2009 10:41 PM, Jung-Ik (John) Lee wrote:
>>
>> On Sat, Sep 12, 2009 at 5:55 PM, Jeff Garzik<jgarzik@pobox.com> =A0w=
rote:
>>>
>>>
>>> General comment:
>>>
>>> * since you use iomap to map the region, you should use ioread{8,16=
,32} /
>>> iowrite{8,16,32} accessors. =A0Do not use inb/outb/inl/outl/etc.
>>
>> .
>> I used them for runtime hot registers by separately mapping them
>> simply to avoid an extra overhead of ioread/iowrite, over the
>> portability.
>> I know it's not a good idea but in this case for these hot ports can
>> in/out be used?
>
> It is _highly_ unlikely that the overhead is even measureable above t=
he
> noise, I would think. =A0Do you have data showing that ioread/iowrite=
 impose a
> noticeable penalty?

I agree in that it's hard to measure/signify the additional overhead,
since those io insts are already too slow.
Anyways, the two extra "if"s and one PIO_MASK on every ioread/iowrite
are pure overhead on top of in/out insts.

Thanks,
-John

>
>
>>
>>
>>>
>>> * run through scripts/checkpatch.pl
>>>
>>
>> Weird. I don't see any WS issues you pointed below in my source code
>> or git diff file, except UT =3D T/4 below.
>
> My apologies; most of those appear to be problems with Thunderbird. =A0=
I think
> it renders <tab> incorrectly.
>
>
>>>> +static void atp867x_set_dmamode(struct ata_port *ap, struct ata_d=
evice
>>>> *adev)
>>>> +{
>>>> + =A0 =A0 =A0 struct pci_dev *pdev =A0 =A0=3D to_pci_dev(ap->host-=
>dev);
>>>> + =A0 =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>>>> + =A0 =A0 =A0 u8 speed =3D adev->dma_mode;
>>>> + =A0 =A0 =A0 u8 b;
>>>> + =A0 =A0 =A0 u8 mode;
>>>> +
>>>> +
>>>> + =A0 =A0 =A0 switch (speed) {
>>>> + =A0 =A0 =A0 case XFER_UDMA_6:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_6;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 case XFER_UDMA_5:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_5;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 case XFER_UDMA_4:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_4;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 case XFER_UDMA_3:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_3;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 case XFER_UDMA_2:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_2;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 case XFER_UDMA_1:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_1;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 case XFER_UDMA_0:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_0;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 default:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: Unsupp=
orted speed %#x."
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " Default to XFER_UD=
MA_0.\n", (unsigned)speed);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_0;
>>>
>>> a table would be nice, preferred over a switch statement. =A0You ma=
y use
>>> ARRAY_SIZE() macro to generate a constant at compile time for numbe=
r of
>>> elements in array.
>>
>> OK. I had it in a pure math like mode =3D speed - XFER_UDMA_0 +1;
>
> That's fine too.
>
>
>
>
>>>> + =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0* Broken BIOS might not set latency high enough
>>>> + =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 pci_read_config_byte(pdev, PCI_LATENCY_TIMER,&v);
>>>> + =A0 =A0 =A0 if (v< =A0 =A00x80) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D 0x80;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_byte(pdev, PCI_LATE=
NCY_TIMER, v);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "ATP867X: set late=
ncy timer of device
>>>> %s"
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " to %d\n", pci_name=
(pdev), v);
>>>> + =A0 =A0 =A0 }
>>>
>>> this seems pointless - pci_set_master() already does this
>>>
>> pci_set_master won't re-set it if BIOS set it to somewhere between 1=
6
>> and 256. This controller wants 0x80.
>> so, if BIOS set to less than 0x80, like 0x20, pci_set_master will ke=
ep
>> the value.
>> I could do this via pci fixup or quirks but that seems too much for
>> this simple setting.
>
> Given your explanation, that's fine.
>
> =A0 =A0 =A0 =A0Jeff
>
>
>
>
