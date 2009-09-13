From: "Jung-Ik (John) Lee" <jilee@google.com>
Subject: Re: [PATCH] libata: Add pata_atp867x driver for Artop/Acard ATP867X
	controllers
Date: Sat, 12 Sep 2009 17:50:53 -0700
Message-ID: <8b5805ff0909121750i4d730696y74cfe308f36f3ed@mail.gmail.com>
References: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com>
	<1252721641.28368.34.camel@desktop> <8b5805ff0909120359g2faf661br463b19518d935110@mail.gmail.com>
	<4AABD122.2000400@gmail.com> <8b5805ff0909121717w1516c273k2a568779b9c31662@mail.gmail.com>
	<4AAC3EEA.1080605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:60483 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbZIMAvP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Sep 2009 20:51:15 -0400
In-Reply-To: <4AAC3EEA.1080605@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Daniel Walker <dwalker@fifo99.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Eric Uhrhane <ericu@google.com>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@linux.intel.com>

On Sat, Sep 12, 2009 at 5:38 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 09/12/2009 08:17 PM, Jung-Ik (John) Lee wrote:
>>
>> On Sat, Sep 12, 2009 at 9:49 AM, Robert Hancock<hancockrwd@gmail.com=
>
>> =A0wrote:
>>>
>>> On 09/12/2009 04:59 AM, Jung-Ik (John) Lee wrote:
>>>
>>> (snip)
>>>
>>> Looks mostly reasonable to me, other than a few issues:
>>>
>>>> +static void atp867x_set_piomode(struct ata_port *ap, struct ata_d=
evice
>>>> *adev)
>>>> +{
>>>> + =A0 =A0 =A0 struct ata_device *peer =3D ata_dev_pair(adev);
>>>> + =A0 =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>>>> + =A0 =A0 =A0 u8 speed =3D adev->pio_mode;
>>>> + =A0 =A0 =A0 struct ata_timing t, p;
>>>> + =A0 =A0 =A0 int T, UT;
>>>> + =A0 =A0 =A0 u8 b;
>>>> +
>>>> + =A0 =A0 =A0 T =3D 1000000000 / 33333;
>>>> + =A0 =A0 =A0 UT =3D T/4;
>>>> +
>>>> + =A0 =A0 =A0 switch (speed) {
>>>> + =A0 =A0 =A0 case XFER_PIO_4:
>>>> + =A0 =A0 =A0 case XFER_PIO_3:
>>>> + =A0 =A0 =A0 case XFER_PIO_2:
>>>> + =A0 =A0 =A0 case XFER_PIO_1:
>>>> + =A0 =A0 =A0 case XFER_PIO_0:
>>>> + =A0 =A0 =A0 case XFER_PIO_SLOW:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 default:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: Unsupp=
orted speed %#x."
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " Default to XFER_PI=
O_0.\n", (unsigned)speed);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D XFER_PIO_0;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 ata_timing_compute(adev, speed,&t, T, UT);
>>>> + =A0 =A0 =A0 if (peer&& =A0 =A0peer->pio_mode) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ata_timing_compute(peer, peer->pio_m=
ode,&p, T, UT);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ata_timing_merge(&p,&t,&t, ATA_TIMIN=
G_8BIT);
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 b =3D inb(dp->dma_mode);
>>>> + =A0 =A0 =A0 if (adev->devno& =A0 =A01)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b& =A0 =A0~ATP867X_IO_DMAMODE=
_SLAVE_MASK);
>>>> + =A0 =A0 =A0 else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b& =A0 =A0~ATP867X_IO_DMAMODE=
_MSTR_MASK);
>>>> + =A0 =A0 =A0 outb(b, dp->dma_mode);
>>>> +
>>>> +#ifdef ATP867X_NO_HACK_PIOMODE
>>>> + =A0 =A0 =A0 b =3D atp867x_get_active_clocks_shifted(t.active) |
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atp867x_get_recover_clocks_shifted(t=
=2Erecover);
>>>> +#else
>>>> + =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0* magic value that works (from doc 6.4, 6.6.9)
>>>> + =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 b =3D 0x31;
>>>> +#endif
>>>
>>> What's the purpose of this ifdef?
>>
>> The magic value part must go. I'll update the patch.
>>
>>>
>>>> + =A0 =A0 =A0 if (dp->pci66mhz)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b +=3D 0x10;
>>>> +
>>>> + =A0 =A0 =A0 if (adev->devno& =A0 =A01)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb(b, dp->slave_piospd);
>>>> + =A0 =A0 =A0 else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb(b, dp->mstr_piospd);
>>>> +
>>>> + =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0* use the same value for comand timing as for PIO=
 timimg
>>>> + =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 outb(b, dp->eightb_piospd);
>>>> +}
>>>> +
>>>> +static int atp867x_cable_detect(struct ata_port *ap)
>>>> +{
>>>> + =A0 =A0 =A0 return ATA_CBL_PATA40_SHORT;
>>>> +}
>>>
>>> Doesn't the controller have a way to do proper 80-wire cable detect=
ion?
>>
>> No programmatic way. libata.force should be used for other configura=
tions.
>
> Ideally you would use ATA_CBL_PATA_UNK / ata_cable_unknown, but it se=
ems
> that ATA_CBL_PATA_UNK has grown rather useless in the current kernel.
>
> We should probably (a) update libata-core/libata-sff to do something
> intelligent with ATA_CBL_PATA_UNK, and (b) use ATA_CBL_PATA_UNK in
> pata_atp867x.
>
> But yes, libata.force works as well. =A0It just seems like we are los=
ing an
> opportunity to accept an existing BIOS-configured 80-wire cable
> configuration by hardcoding ATA_CBL_PATA40_SHORT.

Right. But from my experience relying on BIOS just doesn't seem to
work well in all cases though.

>
> Also, a specific note -- atp867x_cable_detect() should be moved into
> drivers/ata/libata-core.c and made generic. =A0We have ata_cable_xxx =
versions
> for everything except 40-short, it seems.

Sounds right to me.

>
> =A0 =A0 =A0 =A0Jeff
>
>
>
>
>
