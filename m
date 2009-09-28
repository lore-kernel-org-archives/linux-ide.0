From: "Jung-Ik (John) Lee" <jilee@google.com>
Subject: Re: [git patches] libata updates
Date: Mon, 28 Sep 2009 13:49:10 -0700
Message-ID: <8b5805ff0909281349neebb86fnd6e2d78817608ea3@mail.gmail.com>
References: <20090917204935.GA7432@havoc.gtf.org> <200909202305.06199.bzolnier@gmail.com>
	<8b5805ff0909211936s4968d11fnd3e6604d38e31c79@mail.gmail.com>
	<200909281734.11090.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753274AbZI1Utk@vger.kernel.org>
In-Reply-To: <200909281734.11090.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@google.com>, Gwendal Gringo <gwendal@google.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Sep 28, 2009 at 8:34 AM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Tuesday 22 September 2009 04:36:13 Jung-Ik (John) Lee wrote:
>> On Sun, Sep 20, 2009 at 2:05 PM, Bartlomiej Zolnierkiewicz
>> <bzolnier@gmail.com> wrote:
>> > On Thursday 17 September 2009 22:49:35 Jeff Garzik wrote:
>> >>
>> >> Bug fixes, and a new driver.
>> >>
>> >>
>> >>
>> >> Please pull from 'upstream-linus' branch of
>> >> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.gi=
t upstream-linus
>> >>
>> >> to receive the following updates:
>> >>
>> >> =A0drivers/ata/Kconfig =A0 =A0 =A0 =A0| =A0 =A09 +
>> >> =A0drivers/ata/Makefile =A0 =A0 =A0 | =A0 =A01 +
>> >> =A0drivers/ata/ahci.c =A0 =A0 =A0 =A0 | =A0 =A04 +-
>> >> =A0drivers/ata/libata-core.c =A0| =A0 =A04 +-
>> >> =A0drivers/ata/pata_amd.c =A0 =A0 | =A0 =A03 +
>> >> =A0drivers/ata/pata_atp867x.c | =A0548 ++++++++++++++++++++++++++=
++++++++++++++++++
>> >> =A0drivers/ata/sata_promise.c | =A0155 +++++++++++--
>> >> =A0include/linux/pci_ids.h =A0 =A0| =A0 =A02 +
>> >> =A08 files changed, 704 insertions(+), 22 deletions(-)
>> >> =A0create mode 100644 drivers/ata/pata_atp867x.c
>> >>
>> >> John(Jung-Ik) Lee (1):
>> >> =A0 =A0 =A0 libata: Add pata_atp867x driver for Artop/Acard ATP86=
7X controllers
>> >
>> > That was really fast.. =A0Not necessarily a bad thing but this dri=
ver would
>> > benefit from few polishing touches..
>> >
>> >> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867=
x.c
>> >> new file mode 100644
>> >> index 0000000..7990de9
>> >> --- /dev/null
>> >> +++ b/drivers/ata/pata_atp867x.c
>> >> @@ -0,0 +1,548 @@
>> >> +/*
>> >> + * pata_atp867x.c - ARTOP 867X 64bit 4-channel UDMA133 ATA contr=
oller driver
>> >> + *
>> >> + * =A0 (C) 2009 Google Inc. John(Jung-Ik) Lee <jilee@google.com>
>> >> + *
>> >> + * Per Atp867 data sheet rev 1.2, Acard.
>> >> + * Based in part on early ide code from
>> >> + * =A0 2003-2004 by Eric Uhrhane, Google, Inc.
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or=
 modify
>> >> + * it under the terms of the GNU General Public License as publi=
shed by
>> >> + * the Free Software Foundation; either version 2 of the License=
, or
>> >> + * (at your option) any later version.
>> >> + *
>> >> + * This program is distributed in the hope that it will be usefu=
l,
>> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty o=
f
>> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he
>> >> + * GNU General Public License for more details.
>> >> + *
>> >> + * You should have received a copy of the GNU General Public Lic=
ense
>> >> + * along with this program; if not, write to the Free Software
>> >> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 0211=
1-1307 USA
>> >> + *
>> >> + *
>> >> + * TODO:
>> >> + * =A0 1. RAID features [comparison, XOR, striping, mirroring, e=
tc.]
>> >> + */
>> >> +
>> >> +#include <linux/kernel.h>
>> >> +#include <linux/module.h>
>> >> +#include <linux/pci.h>
>> >> +#include <linux/init.h>
>> >> +#include <linux/blkdev.h>
>> >> +#include <linux/delay.h>
>> >> +#include <linux/device.h>
>> >> +#include <scsi/scsi_host.h>
>> >> +#include <linux/libata.h>
>> >> +
>> >> +#define =A0 =A0 =A0DRV_NAME =A0 =A0 =A0 =A0"pata_atp867x"
>> >> +#define =A0 =A0 =A0DRV_VERSION =A0 =A0 "0.7.5"
>> >> +
>> >> +/*
>> >> + * IO Registers
>> >> + * Note that all runtime hot priv ports are cached in ap private=
_data
>> >> + */
>> >> +
>> >> +enum {
>> >> + =A0 =A0 ATP867X_IO_CHANNEL_OFFSET =A0 =A0 =A0 =3D 0x10,
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* IO Register Bitfields
>> >> + =A0 =A0 =A0*/
>> >> +
>> >> + =A0 =A0 ATP867X_IO_PIOSPD_ACTIVE_SHIFT =A0=3D 4,
>> >> + =A0 =A0 ATP867X_IO_PIOSPD_RECOVER_SHIFT =3D 0,
>> >> +
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_MSTR_SHIFT =A0 =3D 0,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_MSTR_MASK =A0 =A0=3D 0x07,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_SLAVE_SHIFT =A0=3D 4,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_SLAVE_MASK =A0 =3D 0x70,
>> >> +
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_6 =A0 =A0 =A0 =3D 0x07,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_5 =A0 =A0 =A0 =3D 0x06,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_4 =A0 =A0 =A0 =3D 0x05,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_3 =A0 =A0 =A0 =3D 0x04,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_2 =A0 =A0 =A0 =3D 0x03,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_1 =A0 =A0 =A0 =3D 0x02,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_UDMA_0 =A0 =A0 =A0 =3D 0x01,
>> >> + =A0 =A0 ATP867X_IO_DMAMODE_DISABLE =A0 =A0 =A0=3D 0x00,
>> >> +
>> >> + =A0 =A0 ATP867X_IO_SYS_INFO_66MHZ =A0 =A0 =A0 =3D 0x04,
>> >> + =A0 =A0 ATP867X_IO_SYS_INFO_SLOW_UDMA5 =A0=3D 0x02,
>> >> + =A0 =A0 ATP867X_IO_SYS_MASK_RESERVED =A0 =A0=3D (~0xf1),
>> >> +
>> >> + =A0 =A0 ATP867X_IO_PORTSPD_VAL =A0 =A0 =A0 =A0 =A0=3D 0x1143,
>> >> + =A0 =A0 ATP867X_PREREAD_VAL =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x0200,
>> >> +
>> >> + =A0 =A0 ATP867X_NUM_PORTS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 4,
>> >> + =A0 =A0 ATP867X_BAR_IOBASE =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0,
>> >> + =A0 =A0 ATP867X_BAR_ROMBASE =A0 =A0 =A0 =A0 =A0 =A0 =3D 6,
>> >> +};
>> >> +
>> >> +#define ATP867X_IOBASE(ap) =A0 =A0 =A0 =A0 =A0 ((ap)->host->ioma=
p[0])
>> >> +#define ATP867X_SYS_INFO(ap) =A0 =A0 =A0 =A0 (0x3F + ATP867X_IOB=
ASE(ap))
>> >> +
>> >> +#define ATP867X_IO_PORTBASE(ap, port) =A0 =A0 =A0 =A0(0x00 + ATP=
867X_IOBASE(ap) + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (port) * ATP867X_IO_CHANNEL_OFFSET)
>> >> +#define ATP867X_IO_DMABASE(ap, port) (0x40 + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> >> +
>> >> +#define ATP867X_IO_STATUS(ap, port) =A0(0x07 + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> >> +#define ATP867X_IO_ALTSTATUS(ap, port) =A0 =A0 =A0 (0x0E + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> >> +
>> >> +/*
>> >> + * hot priv ports
>> >> + */
>> >> +#define ATP867X_IO_MSTRPIOSPD(ap, port) =A0 =A0 =A0(0x08 + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_DMABASE((ap), (port)))
>> >> +#define ATP867X_IO_SLAVPIOSPD(ap, port) =A0 =A0 =A0(0x09 + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_DMABASE((ap), (port)))
>> >> +#define ATP867X_IO_8BPIOSPD(ap, port) =A0 =A0 =A0 =A0(0x0A + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_DMABASE((ap), (port)))
>> >> +#define ATP867X_IO_DMAMODE(ap, port) (0x0B + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_DMABASE((ap), (port)))
>> >> +
>> >> +#define ATP867X_IO_PORTSPD(ap, port) (0x4A + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> >> +#define ATP867X_IO_PREREAD(ap, port) (0x4C + \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATP867X_IO_PORTBASE((ap), (port)))
>> >> +
>> >> +struct atp867x_priv {
>> >> + =A0 =A0 void __iomem *dma_mode;
>> >> + =A0 =A0 void __iomem *mstr_piospd;
>> >> + =A0 =A0 void __iomem *slave_piospd;
>> >> + =A0 =A0 void __iomem *eightb_piospd;
>> >> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 pci66mhz;
>> >> +};
>> >> +
>> >> +static inline u8 atp867x_speed_to_mode(u8 speed)
>> >> +{
>> >> + =A0 =A0 return speed - XFER_UDMA_0 + 1;
>> >> +}
>> >> +
>> >> +static void atp867x_set_dmamode(struct ata_port *ap, struct ata_=
device *adev)
>> >> +{
>> >> + =A0 =A0 struct pci_dev *pdev =A0 =A0=3D to_pci_dev(ap->host->de=
v);
>> >> + =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>> >> + =A0 =A0 u8 speed =3D adev->dma_mode;
>> >> + =A0 =A0 u8 b;
>> >> + =A0 =A0 u8 mode;
>> >> +
>> >> + =A0 =A0 mode =3D atp867x_speed_to_mode(speed);
>> >
>> > The driver currently doesn't support MWDMA modes but claims otherw=
ise
>> > (fixed in the attached patch).
>> >
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Doc 6.6.9: decrease the udma mode value by 1 for s=
afer UDMA speed
>> >> + =A0 =A0 =A0* on 66MHz bus
>> >> + =A0 =A0 =A0* =A0 rev-A: UDMA_1~4 (5, 6 no change)
>> >> + =A0 =A0 =A0* =A0 rev-B: all UDMA modes
>> >> + =A0 =A0 =A0* =A0 UDMA_0 stays not to disable UDMA
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 if (dp->pci66mhz && mode > ATP867X_IO_DMAMODE_UDMA_0 =A0=
&&
>> >> + =A0 =A0 =A0 =A0(pdev->device =3D=3D PCI_DEVICE_ID_ARTOP_ATP867B=
 ||
>> >> + =A0 =A0 =A0 =A0 mode < ATP867X_IO_DMAMODE_UDMA_5))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 mode--;
>> >> +
>> >> + =A0 =A0 b =3D ioread8(dp->dma_mode);
>> >> + =A0 =A0 if (adev->devno & 1) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b & ~ATP867X_IO_DMAMODE_SLAVE_MA=
SK) |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mode << ATP867X_IO_DMA=
MODE_SLAVE_SHIFT);
>> >> + =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b & ~ATP867X_IO_DMAMODE_MSTR_MAS=
K) |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mode << ATP867X_IO_DMA=
MODE_MSTR_SHIFT);
>> >> + =A0 =A0 }
>> >> + =A0 =A0 iowrite8(b, dp->dma_mode);
>> >> +}
>> >> +
>> >> +static int atp867x_get_active_clocks_shifted(unsigned int clk)
>> >> +{
>> >> + =A0 =A0 unsigned char clocks =3D clk;
>> >> +
>> >> + =A0 =A0 switch (clocks) {
>> >> + =A0 =A0 case 0:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 case 1 ... 7:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 case 8 ... 12:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 7;
>> >
>> > Shouldn't "clocks =3D 0" (the default case) be used here?
>>
>> The clocks value 0 sets it to 8 clocks, while value 7 sets to 12 clo=
cks.
>
> This would explain it but then there is no need to use "clocks =3D 7"
> for the _input_ "clocks =3D=3D 7".
>
>> I cleaned up a bit on clocks_shift. See the patch below.
>>
>> > Otherwise it seems to result in underclocked timings for dp->pci66=
mhz =3D=3D 0.
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 default:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: active %d=
clk is invalid. "
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using default 8clk.\n"=
, clk);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0; =A0 =A0 /* 8 clk */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 }
>> >> + =A0 =A0 return clocks << ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
>> >> +}
>> >> +
>> >> +static int atp867x_get_recover_clocks_shifted(unsigned int clk)
>> >> +{
>> >> + =A0 =A0 unsigned char clocks =3D clk;
>> >> +
>> >> + =A0 =A0 switch (clocks) {
>> >> + =A0 =A0 case 0:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 case 1 ... 11:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 case 12:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 case 13: case 14:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 --clocks;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >
>> > Is "clocks =3D=3D 14" a reserved setting?
>>
>> 12 is reserved for the default (=3D=3D 0), and 13, 14 are set to val=
ue 12,
>> 13 respectively.
>
> I meant the _output_ "clocks =3D=3D 14" here.
>
>> >
>> > If so a comment documenting it would be appreciated.
>>
>> Sure. see the new patch below.
>>
>> >
>> >> + =A0 =A0 case 15:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 default:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: recover %=
dclk is invalid. "
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using default 15clk.\n=
", clk);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0; =A0 =A0 /* 12 clk */
>> >
>> > Shouldn't it use "clocks =3D=3D 15" setting?
>> It was a typo. 12 is the right default.
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> + =A0 =A0 }
>> >> + =A0 =A0 return clocks << ATP867X_IO_PIOSPD_RECOVER_SHIFT;
>> >> +}
>> >> +
>> >> +static void atp867x_set_piomode(struct ata_port *ap, struct ata_=
device *adev)
>> >> +{
>> >> + =A0 =A0 struct ata_device *peer =3D ata_dev_pair(adev);
>> >> + =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>> >> + =A0 =A0 u8 speed =3D adev->pio_mode;
>> >> + =A0 =A0 struct ata_timing t, p;
>> >> + =A0 =A0 int T, UT;
>> >> + =A0 =A0 u8 b;
>> >> +
>> >> + =A0 =A0 T =3D 1000000000 / 33333;
>> >> + =A0 =A0 UT =3D T / 4;
>> >> +
>> >> + =A0 =A0 ata_timing_compute(adev, speed, &t, T, UT);
>> >> + =A0 =A0 if (peer && peer->pio_mode) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ata_timing_compute(peer, peer->pio_mode=
, &p, T, UT);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ata_timing_merge(&p, &t, &t, ATA_TIMING=
_8BIT);
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 b =3D ioread8(dp->dma_mode);
>> >> + =A0 =A0 if (adev->devno & 1)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b & ~ATP867X_IO_DMAMODE_SLAVE_MA=
SK);
>> >> + =A0 =A0 else
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b & ~ATP867X_IO_DMAMODE_MSTR_MAS=
K);
>> >> + =A0 =A0 iowrite8(b, dp->dma_mode);
>> >> +
>> >> + =A0 =A0 b =3D atp867x_get_active_clocks_shifted(t.active) |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 atp867x_get_recover_clocks_shifted(t.re=
cover);
>> >> + =A0 =A0 if (dp->pci66mhz)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 b +=3D 0x10;
>> >
>> > What is the purpose of the above hack?
>>
>> For safe PIO mode according to spec.
>>
>> >
>> > AFAICS (I don't have a datasheet) it may result in invalid active
>> > clocks being used for t.active > 12 and 0x80 bit being set incorre=
ctly
>> > for t.active values 7..12 (unless it was the purpose of the hack).
>>
>> See the patch below..
>>
>> >
>> >> + =A0 =A0 if (adev->devno & 1)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(b, dp->slave_piospd);
>> >> + =A0 =A0 else
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(b, dp->mstr_piospd);
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* use the same value for comand timing as for PIO ti=
mimg
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 iowrite8(b, dp->eightb_piospd);
>> >
>> > This is incorrect if slave/master devices use different PIO modes
>> > or if PIO mode <=3D 2 is used by any device.
>> >
>> > Timing based on t.act8b and t.rec8b values should be used instead.
>>
>> act8b and rec8b have the same values as active, recovery of the port=
=2E
>
> Please take a look at drivers/ata/libata-core.c::ata_timing[] table:
>
> ...
> =A0 =A0 =A0 =A0{ XFER_PIO_0, =A0 =A0 70, 290, 240, 600, 165, 150, 0, =
=A0600, =A0 0 },
> =A0 =A0 =A0 =A0{ XFER_PIO_1, =A0 =A0 50, 290, =A093, 383, 125, 100, 0=
, =A0383, =A0 0 },
> =A0 =A0 =A0 =A0{ XFER_PIO_2, =A0 =A0 30, 290, =A040, 330, 100, =A090,=
 0, =A0240, =A0 0 },
> =A0 =A0 =A0 =A0{ XFER_PIO_3, =A0 =A0 30, =A080, =A070, 180, =A080, =A0=
70, 0, =A0180, =A0 0 },
> =A0 =A0 =A0 =A0{ XFER_PIO_4, =A0 =A0 25, =A070, =A025, 120, =A070, =A0=
25, 0, =A0120, =A0 0 },
> =A0 =A0 =A0 =A0{ XFER_PIO_5, =A0 =A0 15, =A065, =A025, 100, =A065, =A0=
25, 0, =A0100, =A0 0 },
> =A0 =A0 =A0 =A0{ XFER_PIO_6, =A0 =A0 10, =A055, =A020, =A080, =A055, =
=A020, 0, =A0 80, =A0 0 },
> ...
>
> For PIO modes <=3D 2 (or if master/slave devices use different PIO mo=
des)
> we'll have different values, i.e. for PIO2 in case of a single device=
 on
> the port using standard timings we'll have:
>
> t.active =A0 =3D =A04
> t.recovery =3D =A04
> t.act8b =A0 =A0=3D 10
> t.rec8b =A0 =A0=3D =A02
>
> Most likely we won't see much use of this driver with older devices,
> however this should not stop us from supporting them and at the same
> time making the driver easier to maintain.
>
>> If a:r=3D3:1 then they become 4:1 on 66mhz for safer transfer, and
>> a8:r8=3D3:1, which is identical but the a8 should be incremented by =
1.
>> I can use a8:r8 with 66mhz fixup but it becomes the same as using a:=
r.
>> Take a look at the patch below.
>>
>> >
>> > On the somehow related note:
>> >
>> > * I don't see how PIO0-2 command timings can be met with only 3 bi=
ts
>> > =A0used for active clocks. =A0Could it be that dp->eight_piospd sh=
ould be
>> > =A0programmed in a slightly different way than dp->{mstr,slave}_pi=
ospd?
>> >
>>
>> See new patch on clocks_shift below.
>>
>> > * The controller allows higher clocks values for recovery timings =
but
>> > =A0ata_timing_compute() tries to fairly increase both recovery and=
 active
>> > =A0timings to meet the required cycle timing.
>> >
>> >> +}
>> >> +
>> >> +static int atp867x_cable_detect(struct ata_port *ap)
>> >> +{
>> >> + =A0 =A0 return ATA_CBL_PATA40_SHORT;
>> >> +}
>> >
>> > As noticed by Robert and Alan already:
>> >
>> > This should use ATA_CBL_PATA_UNK and rely on the driver-side cable=
 detection.
>>
>> I modified cable_detect() to use override; on a certain
>> subsystem_vendor|device, its 40short, others, unknown.
>>
>> >
>> >
>> > One last thing: Power Management support is missing from this driv=
er
>> > (I tried addressing this in the separately posted patch but it nee=
ds
>> > testing by somebody with the hardware).
>> >
>> >
>> > MWDMA fix:
>> >
>> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> > Subject: [PATCH] pata_atp867x: fix it to not claim MWDMA support
>> >
>> > MWDMA modes are not supported by this driver currently.
>> >
>> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> > ---
>> > =A0drivers/ata/pata_atp867x.c | =A0 10 +---------
>> > =A01 file changed, 1 insertion(+), 9 deletions(-)
>> >
>> > Index: b/drivers/ata/pata_atp867x.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- a/drivers/ata/pata_atp867x.c
>> > +++ b/drivers/ata/pata_atp867x.c
>> > @@ -118,20 +118,13 @@ struct atp867x_priv {
>> > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 pci66mhz;
>> > =A0};
>> >
>> > -static inline u8 atp867x_speed_to_mode(u8 speed)
>> > -{
>> > - =A0 =A0 =A0 return speed - XFER_UDMA_0 + 1;
>> > -}
>> > -
>> > =A0static void atp867x_set_dmamode(struct ata_port *ap, struct ata=
_device *adev)
>> > =A0{
>> > =A0 =A0 =A0 =A0struct pci_dev *pdev =A0 =A0=3D to_pci_dev(ap->host=
->dev);
>> > =A0 =A0 =A0 =A0struct atp867x_priv *dp =3D ap->private_data;
>> > =A0 =A0 =A0 =A0u8 speed =3D adev->dma_mode;
>> > =A0 =A0 =A0 =A0u8 b;
>> > - =A0 =A0 =A0 u8 mode;
>> > -
>> > - =A0 =A0 =A0 mode =3D atp867x_speed_to_mode(speed);
>> > + =A0 =A0 =A0 u8 mode =3D speed - XFER_UDMA_0 + 1;
>> >
>> > =A0 =A0 =A0 =A0/*
>> > =A0 =A0 =A0 =A0 * Doc 6.6.9: decrease the udma mode value by 1 for=
 safer UDMA speed
>> > @@ -471,7 +464,6 @@ static int atp867x_init_one(struct pci_d
>> > =A0 =A0 =A0 =A0static const struct ata_port_info info_867x =3D {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D ATA_F=
LAG_SLAVE_POSS,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pio_mask =A0 =A0 =A0 =3D ATA_PIO4,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mwdma_mask =A0 =A0 =3D ATA_MWDMA2,
>>
>> This looks good to me. thx.
>>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.udma_mask =A0 =A0 =A0=3D ATA_UDMA6=
,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.port_ops =A0 =A0 =A0 =3D &atp867x_=
ops,
>> > =A0 =A0 =A0 =A0};
>> >
>>
>>
>> From: John(Jung-Ik) Lee <jilee@google.com>
>>
>> clarifications in timings calculations and cable detection
>>
>> Signed-off-by: John(Jung-Ik) Lee <jilee@google.com>
>> ---
>>
>> =A0pata_atp867x.c | =A0 50 +++++++++++++++++++++++++++++++++++++----=
---------
>> =A01 files changed, 37 insertions, 13 deletions
>>
>> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
>> index e6c4706..c1c691f 100644
>> --- a/drivers/ata/pata_atp867x.c
>> +++ b/drivers/ata/pata_atp867x.c
>> @@ -156,8 +156,10 @@ static void atp867x_set_dmamode(struct ata_port
>> *ap, struct ata_device *adev)
>> =A0 =A0 =A0 iowrite8(b, dp->dma_mode);
>> =A0}
>>
>> -static int atp867x_get_active_clocks_shifted(unsigned int clk)
>> +static int atp867x_get_active_clocks_shifted(struct ata_port *ap,
>> + =A0 =A0 unsigned int clk)
>> =A0{
>> + =A0 =A0 struct atp867x_priv *dp =3D ap->private_data;
>> =A0 =A0 =A0 unsigned char clocks =3D clk;
>>
>> =A0 =A0 =A0 switch (clocks) {
>> @@ -166,15 +168,25 @@ static int
>> atp867x_get_active_clocks_shifted(unsigned int clk)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 1 ... 7:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 case 8 ... 12:
>> + =A0 =A0 case 9 ... 12:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 7;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: active %dc=
lk is invalid. "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using default 8clk.\n",=
 clk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0; =A0 =A0 /* 8 clk */
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 8: /* default 8 clk */
>> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto active_clock_shift_done;
>> =A0 =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Doc 6.6.9: increase the clock value by 1 for safer PI=
O speed
>> + =A0 =A0 =A0* on 66MHz bus
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (dp->pci66mhz && clocks < 7)
>> + =A0 =A0 =A0 =A0 =A0 =A0 clocks++;
>> +
>> +active_clock_shift_done:
>> =A0 =A0 =A0 return clocks << ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
>> =A0}
>>
>> @@ -188,20 +200,19 @@ static int
>> atp867x_get_recover_clocks_shifted(unsigned int clk)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 1 ... 11:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 case 12:
>> - =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 13: case 14:
>> - =A0 =A0 =A0 =A0 =A0 =A0 --clocks;
>> + =A0 =A0 =A0 =A0 =A0 =A0 --clocks; =A0 =A0 =A0 /* by the spec */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 15:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ATP867X: recover %d=
clk is invalid. "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using default 12clk.\n"=
, clk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0; =A0 =A0 /* 12 clk */
>> + =A0 =A0 case 12: =A0 =A0 =A0 =A0/* default 12 clk */
>> + =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 return clocks << ATP867X_IO_PIOSPD_RECOVER_SHIFT;
>> =A0}
>>
>> @@ -230,10 +241,8 @@ static void atp867x_set_piomode(struct ata_port
>> *ap, struct ata_device *adev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 b =3D (b & ~ATP867X_IO_DMAMODE_MSTR_MASK=
);
>> =A0 =A0 =A0 iowrite8(b, dp->dma_mode);
>>
>> - =A0 =A0 b =3D atp867x_get_active_clocks_shifted(t.active) |
>> + =A0 =A0 b =3D atp867x_get_active_clocks_shifted(ap, t.active) |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 atp867x_get_recover_clocks_shifted(t.rec=
over);
>> - =A0 =A0 if (dp->pci66mhz)
>> - =A0 =A0 =A0 =A0 =A0 =A0 b +=3D 0x10;
>>
>> =A0 =A0 =A0 if (adev->devno & 1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(b, dp->slave_piospd);
>> @@ -246,9 +255,24 @@ static void atp867x_set_piomode(struct ata_port
>> *ap, struct ata_device *adev)
>> =A0 =A0 =A0 iowrite8(b, dp->eightb_piospd);
>> =A0}
>>
>> +static int atp867x_cable_override(struct pci_dev *pdev)
>> +{
>> + =A0 =A0 if (pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_ARTOP &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (pdev->subsystem_device =3D=3D PCI_DEVICE_=
ID_ARTOP_ATP867A ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0pdev->subsystem_device =3D=3D PCI_DEVIC=
E_ID_ARTOP_ATP867B)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static int atp867x_cable_detect(struct ata_port *ap)
>> =A0{
>> - =A0 =A0 return ATA_CBL_PATA40_SHORT;
>> + =A0 =A0 struct pci_dev *pdev =3D to_pci_dev(ap->host->dev);
>> +
>> + =A0 =A0 if (atp867x_cable_override(pdev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ATA_CBL_PATA40_SHORT;
>> +
>> + =A0 =A0 return ATA_CBL_PATA_UNK;
>> =A0}
>>
>> =A0static struct scsi_host_template atp867x_sht =3D {
>
> Thanks, your patch looks good to me but since there are still some
> leftover issues left we would also need something like the incrementa=
l
> patch below:
>
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_atp867x: PIO support fixes
>
> * use =A08 clk setting for active clocks =3D=3D 7 (was 12 clk)
> * use 12 clk setting for active clocks > 12 (was =A08 clk)
> * do 66MHz bus fixup before mapping active clocks
> * fix setup of PIO command timings
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> =A0drivers/ata/pata_atp867x.c | =A0 36 +++++++++++++++++++-----------=
------
> =A01 file changed, 19 insertions(+), 17 deletions(-)
>
> Index: b/drivers/ata/pata_atp867x.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ata/pata_atp867x.c
> +++ b/drivers/ata/pata_atp867x.c
> @@ -155,30 +155,31 @@ static int atp867x_get_active_clocks_shi
> =A0 =A0 =A0 =A0struct atp867x_priv *dp =3D ap->private_data;
> =A0 =A0 =A0 =A0unsigned char clocks =3D clk;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Doc 6.6.9: increase the clock value by 1 for safer=
 PIO speed
> + =A0 =A0 =A0 =A0* on 66MHz bus
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (dp->pci66mhz)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks++;
> +
> =A0 =A0 =A0 =A0switch (clocks) {
> =A0 =A0 =A0 =A0case 0:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clocks =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> - =A0 =A0 =A0 case 1 ... 7:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case 9 ... 12:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 7;
> + =A0 =A0 =A0 case 1 ... 6:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING "ATP867X: active %=
dclk is invalid. "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using default 8clk.\n"=
, clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using 12clk.\n", clk);
> + =A0 =A0 =A0 case 9 ... 12:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks =3D 7; =A0 =A0 /* 12 clk */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 7:
> =A0 =A0 =A0 =A0case 8: /* default 8 clk */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clocks =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto active_clock_shift_done;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Doc 6.6.9: increase the clock value by 1 for safer=
 PIO speed
> - =A0 =A0 =A0 =A0* on 66MHz bus
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (dp->pci66mhz && clocks < 7)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocks++;
> -
> =A0active_clock_shift_done:
> =A0 =A0 =A0 =A0return clocks << ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
> =A0}
> @@ -193,7 +194,8 @@ static int atp867x_get_recover_clocks_sh
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 1 ... 11:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> - =A0 =A0 =A0 case 13: case 14:
> + =A0 =A0 =A0 case 13:
> + =A0 =A0 =A0 case 14:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--clocks; =A0 =A0 =A0 /* by the spec *=
/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 15:
> @@ -235,16 +237,16 @@ static void atp867x_set_piomode(struct a
> =A0 =A0 =A0 =A0iowrite8(b, dp->dma_mode);
>
> =A0 =A0 =A0 =A0b =3D atp867x_get_active_clocks_shifted(ap, t.active) =
|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 atp867x_get_recover_clocks_shifted(t.re=
cover);
> + =A0 =A0 =A0 =A0 =A0 atp867x_get_recover_clocks_shifted(t.recover);
>
> =A0 =A0 =A0 =A0if (adev->devno & 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iowrite8(b, dp->slave_piospd);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iowrite8(b, dp->mstr_piospd);
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* use the same value for comand timing as for PIO ti=
mimg
> - =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 b =3D atp867x_get_active_clocks_shifted(ap, t.act8b) |
> + =A0 =A0 =A0 =A0 =A0 atp867x_get_recover_clocks_shifted(t.rec8b);
> +
> =A0 =A0 =A0 =A0iowrite8(b, dp->eightb_piospd);
> =A0}
>
>

Looks good. Thanks Bart.

Acked-by: Jung-Ik (John) Lee <jilee@google.com>
