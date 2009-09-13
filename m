From: "Jung-Ik (John) Lee" <jilee@google.com>
Subject: Re: [PATCH] libata: Add pata_atp867x driver for Artop/Acard ATP867X
	controllers
Date: Sat, 12 Sep 2009 19:41:49 -0700
Message-ID: <8b5805ff0909121941y38b7764fv3cc4d0b5c1ba6c89@mail.gmail.com>
References: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com>
	<1252721641.28368.34.camel@desktop> <8b5805ff0909120359g2faf661br463b19518d935110@mail.gmail.com>
	<4AABD122.2000400@gmail.com> <8b5805ff0909121717w1516c273k2a568779b9c31662@mail.gmail.com>
	<8b5805ff0909121726g2f1a78c1o1ff7289e059eabe5@mail.gmail.com>
	<4AAC4315.6010102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:48317 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbZIMCmL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Sep 2009 22:42:11 -0400
In-Reply-To: <4AAC4315.6010102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Daniel Walker <dwalker@fifo99.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Eric Uhrhane <ericu@google.com>

On Sat, Sep 12, 2009 at 5:55 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
>
>
> General comment:
>
> * since you use iomap to map the region, you should use ioread{8,16,3=
2} /
> iowrite{8,16,32} accessors. =A0Do not use inb/outb/inl/outl/etc.
=2E
I used them for runtime hot registers by separately mapping them
simply to avoid an extra overhead of ioread/iowrite, over the
portability.
I know it's not a good idea but in this case for these hot ports can
in/out be used?


>
> * run through scripts/checkpatch.pl
>

Weird. I don't see any WS issues you pointed below in my source code
or git diff file, except UT =3D T/4 below.

>
> On 09/12/2009 08:26 PM, Jung-Ik (John) Lee wrote:
>>
>> +/*
>> + * IO Registers
>> + * Note that all runtime hot ports are cached in ap private_data
>> + */
>> +
>> +#define ATP867X_IO_CHANNEL_OFFSET =A0 =A0 =A00x10
>> +#define ATP867X_IOBASE(d) =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_resource_s=
tart((d), 0)
>> +#define ATP867X_SYS_INFO(d) =A0 =A0 =A0 =A0 =A0 =A0(0x3F + ATP867X_=
IOBASE(d))
>> +
>> +#define ATP867X_IO_PORTBASE(d, port) =A0 (0x00 + ATP867X_IOBASE(d) =
+ \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (port) *
>> ATP867X_IO_CHANNEL_OFFSET)
>> +#define ATP867X_IO_DMABASE(d, port) =A0 =A0(0x40 + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((d), (port)))
>> +
>> +#define ATP867X_IO_STATUS(d, port) =A0 =A0 (0x07 + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((d), (port)))
>> +#define ATP867X_IO_ALTSTATUS(d, port) =A0(0x0E + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((d), (port)))
>> +
>> +#define ATP867X_IO_MSTRPIOSPD(d, port) (0x08 + ATP867X_IO_DMABASE((=
d),
>> (port)))
>> +#define ATP867X_IO_SLAVPIOSPD(d, port) (0x09 + ATP867X_IO_DMABASE((=
d),
>> (port)))
>> +#define ATP867X_IO_8BPIOSPD(d, port) =A0 (0x0A + ATP867X_IO_DMABASE=
((d),
>> (port)))
>> +#define ATP867X_IO_DMAMODE(d, port) =A0 =A0(0x0B + ATP867X_IO_DMABA=
SE((d),
>> (port)))
>> +
>> +#define ATP867X_IO_PORTSPEED(d, port) =A0(0x4A + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((d), (port)))
>> +#define ATP867X_IO_PREREAD(d, port) =A0 =A0(0x4C + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((d), (port)))
>> +
>> +/*
>> + * IO Register Bitfields
>> + */
>> +
>> +#define ATP867X_IO_PIOSPD_ACTIVE_SHIFT 4
>> +#define ATP867X_IO_PIOSPD_RECOVER_SHIFT =A0 =A0 =A0 =A00
>> +
>> +#define ATP867X_IO_DMAMODE_MSTR_SHIFT =A00
>> +#define ATP867X_IO_DMAMODE_MSTR_MASK =A0 0x07
>> +#define ATP867X_IO_DMAMODE_SLAVE_SHIFT 4
>> +#define ATP867X_IO_DMAMODE_SLAVE_MASK =A00x70
>> +
>> +#define ATP867X_IO_DMAMODE_UDMA_6 =A0 =A0 =A00x07
>> +#define ATP867X_IO_DMAMODE_UDMA_5 =A0 =A0 =A00x06
>> +#define ATP867X_IO_DMAMODE_UDMA_4 =A0 =A0 =A00x05
>> +#define ATP867X_IO_DMAMODE_UDMA_3 =A0 =A0 =A00x04
>> +#define ATP867X_IO_DMAMODE_UDMA_2 =A0 =A0 =A00x03
>> +#define ATP867X_IO_DMAMODE_UDMA_1 =A0 =A0 =A00x02
>> +#define ATP867X_IO_DMAMODE_UDMA_0 =A0 =A0 =A00x01
>> +#define ATP867X_IO_DMAMODE_DISABLE =A0 =A0 0x00
>> +
>> +#define ATP867X_IO_SYS_INFO_66MHZ =A0 =A0 =A00x04
>> +#define ATP867X_IO_SYS_INFO_SLOW_UDMA5 0x02
>> +#define ATP867X_IO_SYS_MASK_RESERVED =A0 (~0xf1)
>> +
>> +#define ATP867X_IO_PORTSPEED_VAL =A0 =A0 =A0 0x1143
>> +#define ATP867X_PREREAD_VAL =A0 =A0 =A0 =A0 =A0 =A00x0200
>> +
>> +#define ATP867X_NUM_PORTS =A0 =A0 =A0 =A0 =A0 =A0 =A04
>> +#define ATP867X_BAR_IOBASE =A0 =A0 =A0 =A0 =A0 =A0 0
>> +#define ATP867X_BAR_ROMBASE =A0 =A0 =A0 =A0 =A0 =A06
>
> enums are the preferred method of creating named constants. =A0This
> potentially makes the code more readable in the debugger, imparts typ=
e
> information with the constant, and makes CPP output more readable. =A0=
eg.
>
> enum {
> =A0 =A0 =A0 =A0ATP867X_NUM_PORTS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 4,
> =A0 =A0 =A0 =A0ATP867X_BAR_IOBASE =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0,
> };

Sure.

>
>> +struct atp867x_priv {
>> + =A0 =A0 =A0 unsigned long =A0 dma_mode;
>> + =A0 =A0 =A0 unsigned long =A0 mstr_piospd;
>> + =A0 =A0 =A0 unsigned long =A0 slave_piospd;
>> + =A0 =A0 =A0 unsigned long =A0 eightb_piospd;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 pci66mhz;
>> +};
>> +
>> +
>> +static void atp867x_set_dmamode(struct ata_port *ap, struct ata_dev=
ice
>> *adev)
>> +{
>> + =A0 =A0 =A0 struct pci_dev *pdev =A0 =A0=3D to_pci_dev(ap->host->d=
ev);
>> + =A0 =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>> + =A0 =A0 =A0 u8 speed =3D adev->dma_mode;
>> + =A0 =A0 =A0 u8 b;
>> + =A0 =A0 =A0 u8 mode;
>> +
>> +
>> + =A0 =A0 =A0 switch (speed) {
>> + =A0 =A0 =A0 case XFER_UDMA_6:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case XFER_UDMA_5:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case XFER_UDMA_4:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case XFER_UDMA_3:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case XFER_UDMA_2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case XFER_UDMA_1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case XFER_UDMA_0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: Unsuppor=
ted speed %#x."
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " Default to XFER_UDMA=
_0.\n", (unsigned)speed);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D ATP867X_IO_DMAMODE_UDMA_0;
>
> a table would be nice, preferred over a switch statement. =A0You may =
use
> ARRAY_SIZE() macro to generate a constant at compile time for number =
of
> elements in array.

OK. I had it in a pure math like mode =3D speed - XFER_UDMA_0 +1;

>
>
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Doc 6.6.9: decrease the udma mode value by 1 for =
safer UDMA
>> speed
>> + =A0 =A0 =A0 =A0* on 66MHz bus
>> + =A0 =A0 =A0 =A0* =A0 rev-A: UDMA_1~4 (5, 6 no change)
>> + =A0 =A0 =A0 =A0* =A0 rev-B: all UDMA modes
>> + =A0 =A0 =A0 =A0* =A0 UDMA_0 stays not to disable UDMA
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (dp->pci66mhz&& =A0mode> =A0ATP867X_IO_DMAMODE_UDMA=
_0&&
>> + =A0 =A0 =A0 =A0 =A0(pdev->device =3D=3D PCI_DEVICE_ID_ARTOP_ATP867=
B ||
>> + =A0 =A0 =A0 =A0 =A0 mode< =A0ATP867X_IO_DMAMODE_UDMA_5))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode--;
>> +
>> + =A0 =A0 =A0 b =3D inb(dp->dma_mode);
>> + =A0 =A0 =A0 if (adev->devno& =A01) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b& =A0~ATP867X_IO_DMAMODE_SLAVE=
_MASK) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mode<< =A0ATP867X_IO_=
DMAMODE_SLAVE_SHIFT);
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b& =A0~ATP867X_IO_DMAMODE_MSTR_=
MASK) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mode<< =A0ATP867X_IO_=
DMAMODE_MSTR_SHIFT);
>
> add whitespace between all tokens, eg. surrounding "&&" and ">" and "=
&"
> operators

Weird. I don;t these in my source/git diff file.

>
>
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 outb(b, dp->dma_mode);
>> +}
>> +
>> +static int atp867x_get_active_clocks_shifted(unsigned int clk)
>> +{
>> + =A0 =A0 =A0 unsigned char clocks =3D clk;
>> +
>> + =A0 =A0 =A0 switch (clocks) {
>> + =A0 =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 1 ... 7:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 8 ... 12:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 7;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: active %=
dclk is invalid. "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using default 8clk.\n=
", clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0; =A0 =A0 /* 8 clk */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return clocks<< =A0ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
>> +}
>> +
>> +static int atp867x_get_recover_clocks_shifted(unsigned int clk)
>> +{
>> + =A0 =A0 =A0 unsigned char clocks =3D clk;
>> +
>> + =A0 =A0 =A0 switch (clocks) {
>> + =A0 =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 1 ... 11:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 12:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 13: case 14:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --clocks;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 15:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: recover =
%dclk is invalid. "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using default 15clk.\=
n", clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0; =A0 =A0 /* 12 clk */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return clocks<< =A0ATP867X_IO_PIOSPD_RECOVER_SHIFT;
>
> whitespace between all tokens

ditto

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
>
> ditto

Done.

>
>
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
>
> unsupported speeds are masked out via ata_port_info. =A0no need for a=
dditional
> checks.

Done.

>
>
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
>> + =A0 =A0 =A0 b =3D atp867x_get_active_clocks_shifted(t.active) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atp867x_get_recover_clocks_shifted(t.r=
ecover);
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
>
> whitespace + ioread/iowrite

ditto.

>
>
>> +static int atp867x_cable_detect(struct ata_port *ap)
>> +{
>> + =A0 =A0 =A0 return ATA_CBL_PATA40_SHORT;
>> +}
>> +
>> +static struct scsi_host_template atp867x_sht =3D {
>> + =A0 =A0 =A0 ATA_BMDMA_SHT(DRV_NAME),
>> +};
>> +
>> +static struct ata_port_operations atp867x_ops =3D {
>> + =A0 =A0 =A0 .inherits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D&ata_bmdma_po=
rt_ops,
>> + =A0 =A0 =A0 .cable_detect =A0 =A0 =A0 =A0 =A0 =3D atp867x_cable_de=
tect,
>> + =A0 =A0 =A0 .set_piomode =A0 =A0 =A0 =A0 =A0 =A0=3D atp867x_set_pi=
omode,
>> + =A0 =A0 =A0 .set_dmamode =A0 =A0 =A0 =A0 =A0 =A0=3D atp867x_set_dm=
amode,
>> +};
>> +
>> +
>> +#ifdef ATP867X_DEBUG
>> +static void atp867x_check_res(struct pci_dev *pdev)
>> +{
>> + =A0 =A0 =A0 int i;
>> + =A0 =A0 =A0 unsigned long start, len;
>> +
>> + =A0 =A0 =A0 /* Check the PCI resources for this channel are enable=
d */
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0DEVICE_COUNT_RESOURCE; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D pci_resource_start(pdev, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =A0 =3D pci_resource_len(pdev, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "ATP867X: resource s=
tart:len=3D%lx:%lx\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start, len);
>> + =A0 =A0 =A0 }
>> +}
>> +
>> +static void atp867x_check_ports(struct ata_port *ap, struct pci_dev
>> *pdev)
>> +{
>> + =A0 =A0 =A0 struct ata_ioports *ioaddr =3D&ap->ioaddr;
>> + =A0 =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>> + =A0 =A0 =A0 int port =3D ap->port_no;
>> +
>> + =A0 =A0 =A0 printk(KERN_DEBUG "ATP867X: port[%d] addresses\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0cmd_addr =A0 =A0 =3D0x%llx, 0x%ll=
x\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0ctl_addr =A0 =A0 =3D0x%llx, 0x%ll=
x\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0bmdma_addr =A0 =3D0x%llx, 0x%llx\=
n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0data_addr =A0 =A0=3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0error_addr =A0 =3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0feature_addr =3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0nsect_addr =A0 =3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0lbal_addr =A0 =A0=3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0lbam_addr =A0 =A0=3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0lbah_addr =A0 =A0=3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0device_addr =A0=3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0status_addr =A0=3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0command_addr =3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0dp->dma_mode =3D0x%llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0dp->mstr_piospd =A0 =A0 =A0=3D0x%=
llx\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0dp->slave_piospd =A0 =A0 =3D0x%ll=
x\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0dp->eightb_piospd =A0 =A0=3D0x%ll=
x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->cmd_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATP867X_IO_PORTBASE(pd=
ev, port),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->ctl_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATP867X_IO_ALTSTATUS(p=
dev, port),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->bmdma_addr=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATP867X_IO_DMABASE(pde=
v, port),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->data_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->error_addr=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->feature_ad=
dr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->nsect_addr=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->lbal_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->lbam_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->lbah_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->device_add=
r,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->status_add=
r,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)ioaddr->command_ad=
dr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)dp->dma_mode,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)dp->mstr_piospd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)dp->slave_piospd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)dp->eightb_piospd)=
;
>> +}
>> +#endif
>> +
>> +static inline void atp867x_get_ports(struct pci_dev *dev, unsigned =
int
>> port,
>> + =A0 =A0 =A0 unsigned long *base, unsigned long *control)
>> +{
>> + =A0 =A0 =A0 *base =3D ATP867X_IO_PORTBASE(dev, port);
>> + =A0 =A0 =A0 *control =3D ATP867X_IO_ALTSTATUS(dev, port);
>> +}
>> +
>> +static inline unsigned long atp867x_get_dma_base(struct pci_dev *de=
v,
>> + =A0 =A0 =A0 unsigned int port)
>> +{
>> + =A0 =A0 =A0 return ATP867X_IO_DMABASE(dev, port);
>> +}
>> +
>> +static int atp867x_set_priv(struct ata_port *ap)
>> +{
>> + =A0 =A0 =A0 struct pci_dev *pdev =3D to_pci_dev(ap->host->dev);
>> + =A0 =A0 =A0 struct atp867x_priv *dp;
>> + =A0 =A0 =A0 int port =3D ap->port_no;
>> +
>> + =A0 =A0 =A0 dp =3D ap->private_data =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_kzalloc(&pdev->dev, sizeof(*dp), =
GFP_KERNEL);
>> + =A0 =A0 =A0 if (dp =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 =A0 dp->dma_mode =A0 =A0 =3D ATP867X_IO_DMAMODE(pdev, port=
);
>> + =A0 =A0 =A0 dp->mstr_piospd =A0=3D ATP867X_IO_MSTRPIOSPD(pdev, por=
t);
>> + =A0 =A0 =A0 dp->slave_piospd =3D ATP867X_IO_SLAVPIOSPD(pdev, port)=
;
>> + =A0 =A0 =A0 dp->eightb_piospd =3D ATP867X_IO_8BPIOSPD(pdev, port);
>> +
>> + =A0 =A0 =A0 dp->pci66mhz =3D inb(ATP867X_SYS_INFO(pdev))&
>> =A0ATP867X_IO_SYS_INFO_66MHZ;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>> +{
>> + =A0 =A0 =A0 struct device *gdev =3D host->dev;
>> + =A0 =A0 =A0 struct pci_dev *pdev =3D to_pci_dev(gdev);
>> + =A0 =A0 =A0 unsigned int mask =3D 0;
>> + =A0 =A0 =A0 int i, rc;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* do not map rombase
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 rc =3D pcim_iomap_regions(pdev, 1<< =A0ATP867X_BAR_IOB=
ASE, DRV_NAME);
>> + =A0 =A0 =A0 if (rc =3D=3D -EBUSY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcim_pin_device(pdev);
>> + =A0 =A0 =A0 if (rc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
>> + =A0 =A0 =A0 host->iomap =3D pcim_iomap_table(pdev);
>> +
>> +#ifdef ATP867X_DEBUG
>> + =A0 =A0 =A0 atp867x_check_res(pdev);
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0PCI_ROM_RESOURCE; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "ATP867X: iomap[%d]=3D=
0x%llx\n", i,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)(h=
ost->iomap[i]));
>> +#endif
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* request, iomap BARs and init port addresses accor=
dingly
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 for (i =3D 0; i< =A0host->n_ports; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long base, control, dmabase;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ata_port *ap =3D host->ports[i]=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ata_ioports *ioaddr =3D&ap->ioa=
ddr;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atp867x_get_ports(pdev, i,&base,&contr=
ol);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmabase =3D atp867x_get_dma_base(pdev,=
 i);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioaddr->cmd_addr =3D devm_ioport_map(g=
dev, base, 8);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioaddr->ctl_addr =3D ioaddr->altstatus=
_addr =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_i=
oport_map(gdev, control, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioaddr->bmdma_addr =3D devm_ioport_map=
(gdev, dmabase, 8);
>
> why are you mapping separately from pcim_iomap_regions?
>
> Just do the mapping all at once, with pcim_iomap_regions, then simply
> calculate addresses in the n_ports loop.

OK.

>
>
>
>
>> + =A0 =A0 =A0 rc =3D pcim_enable_device(pdev);
>> + =A0 =A0 =A0 if (rc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Broken BIOS might not set latency high enough
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 pci_read_config_byte(pdev, PCI_LATENCY_TIMER,&v);
>> + =A0 =A0 =A0 if (v< =A00x80) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D 0x80;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_byte(pdev, PCI_LATENC=
Y_TIMER, v);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "ATP867X: set latenc=
y timer of device
>> %s"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " to %d\n", pci_name(p=
dev), v);
>> + =A0 =A0 =A0 }
>
> this seems pointless - pci_set_master() already does this
>
pci_set_master won't re-set it if BIOS set it to somewhere between 16
and 256. This controller wants 0x80.
so, if BIOS set to less than 0x80, like 0x20, pci_set_master will keep
the value.
I could do this via pci fixup or quirks but that seems too much for
this simple setting.

Will send a new rev soon.
Thanks,
-John

>
