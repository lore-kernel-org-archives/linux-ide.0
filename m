From: "Jung-Ik (John) Lee" <jilee@google.com>
Subject: Re: [PATCH] libata: Add pata_atp867x driver for Artop/Acard ATP867X
	controllers
Date: Sat, 12 Sep 2009 17:17:08 -0700
Message-ID: <8b5805ff0909121717w1516c273k2a568779b9c31662@mail.gmail.com>
References: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com>
	<1252721641.28368.34.camel@desktop> <8b5805ff0909120359g2faf661br463b19518d935110@mail.gmail.com>
	<4AABD122.2000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:25605 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZIMAR3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Sep 2009 20:17:29 -0400
In-Reply-To: <4AABD122.2000400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Daniel Walker <dwalker@fifo99.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Eric Uhrhane <ericu@google.com>

On Sat, Sep 12, 2009 at 9:49 AM, Robert Hancock <hancockrwd@gmail.com> =
wrote:
> On 09/12/2009 04:59 AM, Jung-Ik (John) Lee wrote:
>
> (snip)
>
> Looks mostly reasonable to me, other than a few issues:
>
>> +static void atp867x_set_piomode(struct ata_port *ap, struct ata_dev=
ice
>> *adev)
>> +{
>> + =A0 =A0 =A0 struct ata_device *peer =3D ata_dev_pair(adev);
>> + =A0 =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>> + =A0 =A0 =A0 u8 speed =3D adev->pio_mode;
>> + =A0 =A0 =A0 struct ata_timing t, p;
>> + =A0 =A0 =A0 int T, UT;
>> + =A0 =A0 =A0 u8 b;
>> +
>> + =A0 =A0 =A0 T =3D 1000000000 / 33333;
>> + =A0 =A0 =A0 UT =3D T/4;
>> +
>> + =A0 =A0 =A0 switch (speed) {
>> + =A0 =A0 =A0 case XFER_PIO_4:
>> + =A0 =A0 =A0 case XFER_PIO_3:
>> + =A0 =A0 =A0 case XFER_PIO_2:
>> + =A0 =A0 =A0 case XFER_PIO_1:
>> + =A0 =A0 =A0 case XFER_PIO_0:
>> + =A0 =A0 =A0 case XFER_PIO_SLOW:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: Unsuppor=
ted speed %#x."
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " Default to XFER_PIO_=
0.\n", (unsigned)speed);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D XFER_PIO_0;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ata_timing_compute(adev, speed,&t, T, UT);
>> + =A0 =A0 =A0 if (peer&& =A0peer->pio_mode) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ata_timing_compute(peer, peer->pio_mod=
e,&p, T, UT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ata_timing_merge(&p,&t,&t, ATA_TIMING_=
8BIT);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 b =3D inb(dp->dma_mode);
>> + =A0 =A0 =A0 if (adev->devno& =A01)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b& =A0~ATP867X_IO_DMAMODE_SLAVE=
_MASK);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b& =A0~ATP867X_IO_DMAMODE_MSTR_=
MASK);
>> + =A0 =A0 =A0 outb(b, dp->dma_mode);
>> +
>> +#ifdef ATP867X_NO_HACK_PIOMODE
>> + =A0 =A0 =A0 b =3D atp867x_get_active_clocks_shifted(t.active) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atp867x_get_recover_clocks_shifted(t.r=
ecover);
>> +#else
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* magic value that works (from doc 6.4, 6.6.9)
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 b =3D 0x31;
>> +#endif
>
> What's the purpose of this ifdef?

The magic value part must go. I'll update the patch.

>
>> + =A0 =A0 =A0 if (dp->pci66mhz)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b +=3D 0x10;
>> +
>> + =A0 =A0 =A0 if (adev->devno& =A01)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb(b, dp->slave_piospd);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb(b, dp->mstr_piospd);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* use the same value for comand timing as for PIO t=
imimg
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 outb(b, dp->eightb_piospd);
>> +}
>> +
>> +static int atp867x_cable_detect(struct ata_port *ap)
>> +{
>> + =A0 =A0 =A0 return ATA_CBL_PATA40_SHORT;
>> +}
>
> Doesn't the controller have a way to do proper 80-wire cable detectio=
n?

No programmatic way. libata.force should be used for other configuratio=
ns.

Thanks,
-John
