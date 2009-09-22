From: "Jung-Ik (John) Lee" <jilee@google.com>
Subject: Re: [git patches] libata updates
Date: Mon, 21 Sep 2009 19:36:13 -0700
Message-ID: <8b5805ff0909211936s4968d11fnd3e6604d38e31c79@mail.gmail.com>
References: <20090917204935.GA7432@havoc.gtf.org> <200909202305.06199.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:48085 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbZIVCge convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Sep 2009 22:36:34 -0400
In-Reply-To: <200909202305.06199.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@google.com>, Gwendal Gringo <gwendal@google.com>

On Sun, Sep 20, 2009 at 2:05 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Thursday 17 September 2009 22:49:35 Jeff Garzik wrote:
>>
>> Bug fixes, and a new driver.
>>
>>
>>
>> Please pull from 'upstream-linus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git u=
pstream-linus
>>
>> to receive the following updates:
>>
>> =A0drivers/ata/Kconfig =A0 =A0 =A0 =A0| =A0 =A09 +
>> =A0drivers/ata/Makefile =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/ata/ahci.c =A0 =A0 =A0 =A0 | =A0 =A04 +-
>> =A0drivers/ata/libata-core.c =A0| =A0 =A04 +-
>> =A0drivers/ata/pata_amd.c =A0 =A0 | =A0 =A03 +
>> =A0drivers/ata/pata_atp867x.c | =A0548 +++++++++++++++++++++++++++++=
+++++++++++++++
>> =A0drivers/ata/sata_promise.c | =A0155 +++++++++++--
>> =A0include/linux/pci_ids.h =A0 =A0| =A0 =A02 +
>> =A08 files changed, 704 insertions(+), 22 deletions(-)
>> =A0create mode 100644 drivers/ata/pata_atp867x.c
>>
>> John(Jung-Ik) Lee (1):
>> =A0 =A0 =A0 libata: Add pata_atp867x driver for Artop/Acard ATP867X =
controllers
>
> That was really fast.. =A0Not necessarily a bad thing but this driver=
 would
> benefit from few polishing touches..
>
>> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
>> new file mode 100644
>> index 0000000..7990de9
>> --- /dev/null
>> +++ b/drivers/ata/pata_atp867x.c
>> @@ -0,0 +1,548 @@
>> +/*
>> + * pata_atp867x.c - ARTOP 867X 64bit 4-channel UDMA133 ATA controll=
er driver
>> + *
>> + * =A0 (C) 2009 Google Inc. John(Jung-Ik) Lee <jilee@google.com>
>> + *
>> + * Per Atp867 data sheet rev 1.2, Acard.
>> + * Based in part on early ide code from
>> + * =A0 2003-2004 by Eric Uhrhane, Google, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1=
307 USA
>> + *
>> + *
>> + * TODO:
>> + * =A0 1. RAID features [comparison, XOR, striping, mirroring, etc.=
]
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/init.h>
>> +#include <linux/blkdev.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <scsi/scsi_host.h>
>> +#include <linux/libata.h>
>> +
>> +#define =A0 =A0 =A0DRV_NAME =A0 =A0 =A0 =A0"pata_atp867x"
>> +#define =A0 =A0 =A0DRV_VERSION =A0 =A0 "0.7.5"
>> +
>> +/*
>> + * IO Registers
>> + * Note that all runtime hot priv ports are cached in ap private_da=
ta
>> + */
>> +
>> +enum {
>> + =A0 =A0 ATP867X_IO_CHANNEL_OFFSET =A0 =A0 =A0 =3D 0x10,
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* IO Register Bitfields
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 ATP867X_IO_PIOSPD_ACTIVE_SHIFT =A0=3D 4,
>> + =A0 =A0 ATP867X_IO_PIOSPD_RECOVER_SHIFT =3D 0,
>> +
>> + =A0 =A0 ATP867X_IO_DMAMODE_MSTR_SHIFT =A0 =3D 0,
>> + =A0 =A0 ATP867X_IO_DMAMODE_MSTR_MASK =A0 =A0=3D 0x07,
>> + =A0 =A0 ATP867X_IO_DMAMODE_SLAVE_SHIFT =A0=3D 4,
>> + =A0 =A0 ATP867X_IO_DMAMODE_SLAVE_MASK =A0 =3D 0x70,
>> +
>> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_6 =A0 =A0 =A0 =3D 0x07,
>> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_5 =A0 =A0 =A0 =3D 0x06,
>> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_4 =A0 =A0 =A0 =3D 0x05,
>> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_3 =A0 =A0 =A0 =3D 0x04,
>> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_2 =A0 =A0 =A0 =3D 0x03,
>> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_1 =A0 =A0 =A0 =3D 0x02,
>> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_0 =A0 =A0 =A0 =3D 0x01,
>> + =A0 =A0 ATP867X_IO_DMAMODE_DISABLE =A0 =A0 =A0=3D 0x00,
>> +
>> + =A0 =A0 ATP867X_IO_SYS_INFO_66MHZ =A0 =A0 =A0 =3D 0x04,
>> + =A0 =A0 ATP867X_IO_SYS_INFO_SLOW_UDMA5 =A0=3D 0x02,
>> + =A0 =A0 ATP867X_IO_SYS_MASK_RESERVED =A0 =A0=3D (~0xf1),
>> +
>> + =A0 =A0 ATP867X_IO_PORTSPD_VAL =A0 =A0 =A0 =A0 =A0=3D 0x1143,
>> + =A0 =A0 ATP867X_PREREAD_VAL =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0200,
>> +
>> + =A0 =A0 ATP867X_NUM_PORTS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 4,
>> + =A0 =A0 ATP867X_BAR_IOBASE =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0,
>> + =A0 =A0 ATP867X_BAR_ROMBASE =A0 =A0 =A0 =A0 =A0 =A0 =3D 6,
>> +};
>> +
>> +#define ATP867X_IOBASE(ap) =A0 =A0 =A0 =A0 =A0 ((ap)->host->iomap[0=
])
>> +#define ATP867X_SYS_INFO(ap) =A0 =A0 =A0 =A0 (0x3F + ATP867X_IOBASE=
(ap))
>> +
>> +#define ATP867X_IO_PORTBASE(ap, port) =A0 =A0 =A0 =A0(0x00 + ATP867=
X_IOBASE(ap) + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (port) * ATP867X_IO_CHANNEL_OFFSET)
>> +#define ATP867X_IO_DMABASE(ap, port) (0x40 + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> +
>> +#define ATP867X_IO_STATUS(ap, port) =A0(0x07 + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> +#define ATP867X_IO_ALTSTATUS(ap, port) =A0 =A0 =A0 (0x0E + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> +
>> +/*
>> + * hot priv ports
>> + */
>> +#define ATP867X_IO_MSTRPIOSPD(ap, port) =A0 =A0 =A0(0x08 + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ATP867X_IO_DMABASE((ap), (port)))
>> +#define ATP867X_IO_SLAVPIOSPD(ap, port) =A0 =A0 =A0(0x09 + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ATP867X_IO_DMABASE((ap), (port)))
>> +#define ATP867X_IO_8BPIOSPD(ap, port) =A0 =A0 =A0 =A0(0x0A + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ATP867X_IO_DMABASE((ap), (port)))
>> +#define ATP867X_IO_DMAMODE(ap, port) (0x0B + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ATP867X_IO_DMABASE((ap), (port)))
>> +
>> +#define ATP867X_IO_PORTSPD(ap, port) (0x4A + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> +#define ATP867X_IO_PREREAD(ap, port) (0x4C + \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> +
>> +struct atp867x_priv {
>> + =A0 =A0 void __iomem *dma_mode;
>> + =A0 =A0 void __iomem *mstr_piospd;
>> + =A0 =A0 void __iomem *slave_piospd;
>> + =A0 =A0 void __iomem *eightb_piospd;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 pci66mhz;
>> +};
>> +
>> +static inline u8 atp867x_speed_to_mode(u8 speed)
>> +{
>> + =A0 =A0 return speed - XFER_UDMA_0 + 1;
>> +}
>> +
>> +static void atp867x_set_dmamode(struct ata_port *ap, struct ata_dev=
ice *adev)
>> +{
>> + =A0 =A0 struct pci_dev *pdev =A0 =A0=3D to_pci_dev(ap->host->dev);
>> + =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>> + =A0 =A0 u8 speed =3D adev->dma_mode;
>> + =A0 =A0 u8 b;
>> + =A0 =A0 u8 mode;
>> +
>> + =A0 =A0 mode =3D atp867x_speed_to_mode(speed);
>
> The driver currently doesn't support MWDMA modes but claims otherwise
> (fixed in the attached patch).
>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Doc 6.6.9: decrease the udma mode value by 1 for safe=
r UDMA speed
>> + =A0 =A0 =A0* on 66MHz bus
>> + =A0 =A0 =A0* =A0 rev-A: UDMA_1~4 (5, 6 no change)
>> + =A0 =A0 =A0* =A0 rev-B: all UDMA modes
>> + =A0 =A0 =A0* =A0 UDMA_0 stays not to disable UDMA
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (dp->pci66mhz && mode > ATP867X_IO_DMAMODE_UDMA_0 =A0&&
>> + =A0 =A0 =A0 =A0(pdev->device =3D=3D PCI_DEVICE_ID_ARTOP_ATP867B ||
>> + =A0 =A0 =A0 =A0 mode < ATP867X_IO_DMAMODE_UDMA_5))
>> + =A0 =A0 =A0 =A0 =A0 =A0 mode--;
>> +
>> + =A0 =A0 b =3D ioread8(dp->dma_mode);
>> + =A0 =A0 if (adev->devno & 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b & ~ATP867X_IO_DMAMODE_SLAVE_MASK)=
 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mode << ATP867X_IO_DMAMOD=
E_SLAVE_SHIFT);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b & ~ATP867X_IO_DMAMODE_MSTR_MASK) =
|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mode << ATP867X_IO_DMAMOD=
E_MSTR_SHIFT);
>> + =A0 =A0 }
>> + =A0 =A0 iowrite8(b, dp->dma_mode);
>> +}
>> +
>> +static int atp867x_get_active_clocks_shifted(unsigned int clk)
>> +{
>> + =A0 =A0 unsigned char clocks =3D clk;
>> +
>> + =A0 =A0 switch (clocks) {
>> + =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 1 ... 7:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 8 ... 12:
>> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 7;
>
> Shouldn't "clocks =3D 0" (the default case) be used here?

The clocks value 0 sets it to 8 clocks, while value 7 sets to 12 clocks=
=2E
I cleaned up a bit on clocks_shift. See the patch below.

>
> Otherwise it seems to result in underclocked timings for dp->pci66mhz=
 =3D=3D 0.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: active %dclk=
 is invalid. "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using default 8clk.\n", c=
lk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0; =A0 =A0 /* 8 clk */
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 return clocks << ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
>> +}
>> +
>> +static int atp867x_get_recover_clocks_shifted(unsigned int clk)
>> +{
>> + =A0 =A0 unsigned char clocks =3D clk;
>> +
>> + =A0 =A0 switch (clocks) {
>> + =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 1 ... 11:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 12:
>> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 13: case 14:
>> + =A0 =A0 =A0 =A0 =A0 =A0 --clocks;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> Is "clocks =3D=3D 14" a reserved setting?

12 is reserved for the default (=3D=3D 0), and 13, 14 are set to value =
12,
13 respectively.

>
> If so a comment documenting it would be appreciated.

Sure. see the new patch below.

>
>> + =A0 =A0 case 15:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: recover %dcl=
k is invalid. "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using default 15clk.\n", =
clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0; =A0 =A0 /* 12 clk */
>
> Shouldn't it use "clocks =3D=3D 15" setting?
It was a typo. 12 is the right default.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 return clocks << ATP867X_IO_PIOSPD_RECOVER_SHIFT;
>> +}
>> +
>> +static void atp867x_set_piomode(struct ata_port *ap, struct ata_dev=
ice *adev)
>> +{
>> + =A0 =A0 struct ata_device *peer =3D ata_dev_pair(adev);
>> + =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>> + =A0 =A0 u8 speed =3D adev->pio_mode;
>> + =A0 =A0 struct ata_timing t, p;
>> + =A0 =A0 int T, UT;
>> + =A0 =A0 u8 b;
>> +
>> + =A0 =A0 T =3D 1000000000 / 33333;
>> + =A0 =A0 UT =3D T / 4;
>> +
>> + =A0 =A0 ata_timing_compute(adev, speed, &t, T, UT);
>> + =A0 =A0 if (peer && peer->pio_mode) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ata_timing_compute(peer, peer->pio_mode, &=
p, T, UT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ata_timing_merge(&p, &t, &t, ATA_TIMING_8B=
IT);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 b =3D ioread8(dp->dma_mode);
>> + =A0 =A0 if (adev->devno & 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b & ~ATP867X_IO_DMAMODE_SLAVE_MASK)=
;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b & ~ATP867X_IO_DMAMODE_MSTR_MASK);
>> + =A0 =A0 iowrite8(b, dp->dma_mode);
>> +
>> + =A0 =A0 b =3D atp867x_get_active_clocks_shifted(t.active) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 atp867x_get_recover_clocks_shifted(t.recov=
er);
>> + =A0 =A0 if (dp->pci66mhz)
>> + =A0 =A0 =A0 =A0 =A0 =A0 b +=3D 0x10;
>
> What is the purpose of the above hack?

=46or safe PIO mode according to spec.

>
> AFAICS (I don't have a datasheet) it may result in invalid active
> clocks being used for t.active > 12 and 0x80 bit being set incorrectl=
y
> for t.active values 7..12 (unless it was the purpose of the hack).

See the patch below..

>
>> + =A0 =A0 if (adev->devno & 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(b, dp->slave_piospd);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(b, dp->mstr_piospd);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* use the same value for comand timing as for PIO timim=
g
>> + =A0 =A0 =A0*/
>> + =A0 =A0 iowrite8(b, dp->eightb_piospd);
>
> This is incorrect if slave/master devices use different PIO modes
> or if PIO mode <=3D 2 is used by any device.
>
> Timing based on t.act8b and t.rec8b values should be used instead.

act8b and rec8b have the same values as active, recovery of the port.
If a:r=3D3:1 then they become 4:1 on 66mhz for safer transfer, and
a8:r8=3D3:1, which is identical but the a8 should be incremented by 1.
I can use a8:r8 with 66mhz fixup but it becomes the same as using a:r.
Take a look at the patch below.

>
> On the somehow related note:
>
> * I don't see how PIO0-2 command timings can be met with only 3 bits
> =A0used for active clocks. =A0Could it be that dp->eight_piospd shoul=
d be
> =A0programmed in a slightly different way than dp->{mstr,slave}_piosp=
d?
>

See new patch on clocks_shift below.

> * The controller allows higher clocks values for recovery timings but
> =A0ata_timing_compute() tries to fairly increase both recovery and ac=
tive
> =A0timings to meet the required cycle timing.
>
>> +}
>> +
>> +static int atp867x_cable_detect(struct ata_port *ap)
>> +{
>> + =A0 =A0 return ATA_CBL_PATA40_SHORT;
>> +}
>
> As noticed by Robert and Alan already:
>
> This should use ATA_CBL_PATA_UNK and rely on the driver-side cable de=
tection.

I modified cable_detect() to use override; on a certain
subsystem_vendor|device, its 40short, others, unknown.

>
>
> One last thing: Power Management support is missing from this driver
> (I tried addressing this in the separately posted patch but it needs
> testing by somebody with the hardware).
>
>
> MWDMA fix:
>
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_atp867x: fix it to not claim MWDMA support
>
> MWDMA modes are not supported by this driver currently.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> =A0drivers/ata/pata_atp867x.c | =A0 10 +---------
> =A01 file changed, 1 insertion(+), 9 deletions(-)
>
> Index: b/drivers/ata/pata_atp867x.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ata/pata_atp867x.c
> +++ b/drivers/ata/pata_atp867x.c
> @@ -118,20 +118,13 @@ struct atp867x_priv {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 pci66mhz;
> =A0};
>
> -static inline u8 atp867x_speed_to_mode(u8 speed)
> -{
> - =A0 =A0 =A0 return speed - XFER_UDMA_0 + 1;
> -}
> -
> =A0static void atp867x_set_dmamode(struct ata_port *ap, struct ata_de=
vice *adev)
> =A0{
> =A0 =A0 =A0 =A0struct pci_dev *pdev =A0 =A0=3D to_pci_dev(ap->host->d=
ev);
> =A0 =A0 =A0 =A0struct atp867x_priv *dp =3D ap->private_data;
> =A0 =A0 =A0 =A0u8 speed =3D adev->dma_mode;
> =A0 =A0 =A0 =A0u8 b;
> - =A0 =A0 =A0 u8 mode;
> -
> - =A0 =A0 =A0 mode =3D atp867x_speed_to_mode(speed);
> + =A0 =A0 =A0 u8 mode =3D speed - XFER_UDMA_0 + 1;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Doc 6.6.9: decrease the udma mode value by 1 for sa=
fer UDMA speed
> @@ -471,7 +464,6 @@ static int atp867x_init_one(struct pci_d
> =A0 =A0 =A0 =A0static const struct ata_port_info info_867x =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D ATA_FLAG=
_SLAVE_POSS,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pio_mask =A0 =A0 =A0 =3D ATA_PIO4,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =A0 =A0 =3D ATA_MWDMA2,

This looks good to me. thx.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.udma_mask =A0 =A0 =A0=3D ATA_UDMA6,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.port_ops =A0 =A0 =A0 =3D &atp867x_ops=
,
> =A0 =A0 =A0 =A0};
>


=46rom: John(Jung-Ik) Lee <jilee@google.com>

clarifications in timings calculations and cable detection

Signed-off-by: John(Jung-Ik) Lee <jilee@google.com>
---

 pata_atp867x.c |   50 +++++++++++++++++++++++++++++++++++++-----------=
--
 1 files changed, 37 insertions, 13 deletions

diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index e6c4706..c1c691f 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -156,8 +156,10 @@ static void atp867x_set_dmamode(struct ata_port
*ap, struct ata_device *adev)
 	iowrite8(b, dp->dma_mode);
 }

-static int atp867x_get_active_clocks_shifted(unsigned int clk)
+static int atp867x_get_active_clocks_shifted(struct ata_port *ap,
+	unsigned int clk)
 {
+	struct atp867x_priv *dp =3D ap->private_data;
 	unsigned char clocks =3D clk;

 	switch (clocks) {
@@ -166,15 +168,25 @@ static int
atp867x_get_active_clocks_shifted(unsigned int clk)
 		break;
 	case 1 ... 7:
 		break;
-	case 8 ... 12:
+	case 9 ... 12:
 		clocks =3D 7;
 		break;
 	default:
 		printk(KERN_WARNING "ATP867X: active %dclk is invalid. "
 			"Using default 8clk.\n", clk);
-		clocks =3D 0;	/* 8 clk */
-		break;
+	case 8:	/* default 8 clk */
+		clocks =3D 0;
+		goto active_clock_shift_done;
 	}
+
+	/*
+	 * Doc 6.6.9: increase the clock value by 1 for safer PIO speed
+	 * on 66MHz bus
+	 */
+	if (dp->pci66mhz && clocks < 7)
+		clocks++;
+
+active_clock_shift_done:
 	return clocks << ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
 }

@@ -188,20 +200,19 @@ static int
atp867x_get_recover_clocks_shifted(unsigned int clk)
 		break;
 	case 1 ... 11:
 		break;
-	case 12:
-		clocks =3D 0;
-		break;
 	case 13: case 14:
-		--clocks;
+		--clocks;	/* by the spec */
 		break;
 	case 15:
 		break;
 	default:
 		printk(KERN_WARNING "ATP867X: recover %dclk is invalid. "
 			"Using default 12clk.\n", clk);
-		clocks =3D 0;	/* 12 clk */
+	case 12:	/* default 12 clk */
+		clocks =3D 0;
 		break;
 	}
+
 	return clocks << ATP867X_IO_PIOSPD_RECOVER_SHIFT;
 }

@@ -230,10 +241,8 @@ static void atp867x_set_piomode(struct ata_port
*ap, struct ata_device *adev)
 		b =3D (b & ~ATP867X_IO_DMAMODE_MSTR_MASK);
 	iowrite8(b, dp->dma_mode);

-	b =3D atp867x_get_active_clocks_shifted(t.active) |
+	b =3D atp867x_get_active_clocks_shifted(ap, t.active) |
 		atp867x_get_recover_clocks_shifted(t.recover);
-	if (dp->pci66mhz)
-		b +=3D 0x10;

 	if (adev->devno & 1)
 		iowrite8(b, dp->slave_piospd);
@@ -246,9 +255,24 @@ static void atp867x_set_piomode(struct ata_port
*ap, struct ata_device *adev)
 	iowrite8(b, dp->eightb_piospd);
 }

+static int atp867x_cable_override(struct pci_dev *pdev)
+{
+	if (pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_ARTOP &&
+		(pdev->subsystem_device =3D=3D PCI_DEVICE_ID_ARTOP_ATP867A ||
+		 pdev->subsystem_device =3D=3D PCI_DEVICE_ID_ARTOP_ATP867B)) {
+		return 1;
+	}
+	return 0;
+}
+
 static int atp867x_cable_detect(struct ata_port *ap)
 {
-	return ATA_CBL_PATA40_SHORT;
+	struct pci_dev *pdev =3D to_pci_dev(ap->host->dev);
+
+	if (atp867x_cable_override(pdev))
+		return ATA_CBL_PATA40_SHORT;
+
+	return ATA_CBL_PATA_UNK;
 }

 static struct scsi_host_template atp867x_sht =3D {
