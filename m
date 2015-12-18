From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 18 Dec 2015 12:08:30 +0200
Message-ID: <1450433310.30729.184.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	 <yw1x1tanffqg.fsf@unicorn.mansr.com>
	 <1450364395.30729.136.camel@linux.intel.com>
	 <yw1x60zxds5k.fsf@unicorn.mansr.com>
	 <1450367702.30729.146.camel@linux.intel.com>
	 <yw1xk2odcb87.fsf@unicorn.mansr.com>
	 <1450371184.30729.175.camel@linux.intel.com> <5672F77F.4010306@candw.ms>
	 <yw1xfuz1c5xy.fsf@unicorn.mansr.com> <567302E8.5050303@candw.ms>
	 <yw1x7fkcdi2a.fsf@unicorn.mansr.com> <5673061A.4070700@candw.ms>
	 <yw1x37v0df86.fsf@unicorn.mansr.com> <56732C04.9040100@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36869 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbbLRKIP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Dec 2015 05:08:15 -0500
In-Reply-To: <56732C04.9040100@candw.ms>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2015-12-17 at 17:41 -0400, Julian Margetson wrote:
> On 12/17/2015 3:53 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > Julian Margetson <runaway@candw.ms> writes:
> >=20
> > > On 12/17/2015 2:51 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > > Julian Margetson <runaway@candw.ms> writes:
> > > >=20
> > > > > On 12/17/2015 1:59 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > > > > Julian Margetson <runaway@candw.ms> writes:
> > > > > >=20
> > > > > > > I have been running my machine mostly configured for
> > > > > > > pciex1=C2=A0=C2=A0thus with
> > > > > > > the sata_dwc disabled.
> > > > > > > The changes to sata_dwc-460ex do cause an oops.
> > > > > > > I will try to give more detailed info over this weekend .
> > > > > > The driver as is upstream would do that since it
> > > > > > unconditionally
> > > > > > dereferences a null pointer in the probe function.=C2=A0=C2=
=A0My
> > > > > > patch fixes that
> > > > > > as a side-effect.
> > > > > >=20
> > > > > patching file drivers/ata/Kconfig
> > > > >=20
> > > > > Hunk #1 FAILED at 296.
> > > > [...]
> > > >=20
> > > > > root@julian-VirtualBox:/usr/src/linux-3.18.25#
> > > > The patch is against 4.4-rc5.
> > > >=20
> > > =C2=A0CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/ata/sata_dwc_=
460ex.o
> > >=20
> > > drivers/ata/sata_dwc_460ex.c:198:15: error: variable
> > > =C3=A2=E2=82=AC=CB=9Csata_dwc_dma_dws=C3=A2=E2=82=AC=E2=84=A2 has=
 initializer but incomplete type
> > >=20
> > > =C2=A0static struct dw_dma_slave sata_dwc_dma_dws =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0^
> > It builds, albeit with an unrelated warning, using the attached
> > config.
> > Maybe there's a missing config dependency somewhere.
> >=20
> I am attempting to cross compile under Ubuntu 14.04 X86 in Virtualbox
> with your .config.
> 4.4.0-rc5 builds ok with no patches applied .
> Once your patch is applied it fails to build .
> CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/ata/sata_dwc_460ex.o
> drivers/ata/sata_dwc_460ex.c:198:15: error: variable
> =E2=80=98sata_dwc_dma_dws=E2=80=99 has initializer but incomplete typ=
e
> =C2=A0static struct dw_dma_slave sata_dwc_dma_dws =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0^
> drivers/ata/sata_dwc_460ex.c:199:2: error: unknown field =E2=80=98src=
_id=E2=80=99
> specified in initializer
> =C2=A0 .src_id =3D 0,

This clearly means that header file that defines the struct
dw_dma_slave is not included.

After the patch it seems you have to explicitly enable DW_DMAC, so,
either via make nconfig, or by adding
CONFIG_DW_DMAC=3Dy


> =C2=A0 ^
> drivers/ata/sata_dwc_460ex.c:199:2: warning: excess elements in
> struct initializer [enabled by default]
> drivers/ata/sata_dwc_460ex.c:199:2: warning: (near initialization for
> =E2=80=98sata_dwc_dma_dws=E2=80=99) [enabled by default]
> drivers/ata/sata_dwc_460ex.c:200:2: error: unknown field =E2=80=98dst=
_id=E2=80=99
> specified in initializer
> =C2=A0 .dst_id =3D 0,
> =C2=A0 ^
> drivers/ata/sata_dwc_460ex.c:200:2: warning: excess elements in
> struct initializer [enabled by default]
> drivers/ata/sata_dwc_460ex.c:200:2: warning: (near initialization for
> =E2=80=98sata_dwc_dma_dws=E2=80=99) [enabled by default]
> drivers/ata/sata_dwc_460ex.c:201:2: error: unknown field =E2=80=98src=
_master=E2=80=99
> specified in initializer
> =C2=A0 .src_master =3D 0,
> =C2=A0 ^
> drivers/ata/sata_dwc_460ex.c:201:2: warning: excess elements in
> struct initializer [enabled by default]
> drivers/ata/sata_dwc_460ex.c:201:2: warning: (near initialization for
> =E2=80=98sata_dwc_dma_dws=E2=80=99) [enabled by default]
> drivers/ata/sata_dwc_460ex.c:202:2: error: unknown field =E2=80=98dst=
_master=E2=80=99
> specified in initializer
> =C2=A0 .dst_master =3D 1,
> =C2=A0 ^
> drivers/ata/sata_dwc_460ex.c:202:2: warning: excess elements in
> struct initializer [enabled by default]
> drivers/ata/sata_dwc_460ex.c:202:2: warning: (near initialization for
> =E2=80=98sata_dwc_dma_dws=E2=80=99) [enabled by default]
> drivers/ata/sata_dwc_460ex.c: In function =E2=80=98dma_dwc_xfer_setup=
=E2=80=99:
> drivers/ata/sata_dwc_460ex.c:389:20: warning: cast from pointer to
> integer of different size [-Wpointer-to-int-cast]
> =C2=A0 dma_addr_t addr =3D (dma_addr_t)&hsdev->sata_dwc_regs->dmadr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> drivers/ata/sata_dwc_460ex.c: In function =E2=80=98sata_dwc_dma_filte=
r=E2=80=99:
> drivers/ata/sata_dwc_460ex.c:872:9: error: dereferencing pointer to
> incomplete type
> =C2=A0 if (dws->dma_dev !=3D chan->device->dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> drivers/ata/sata_dwc_460ex.c: In function =E2=80=98sata_dwc_port_star=
t=E2=80=99:
> drivers/ata/sata_dwc_460ex.c:958:13: error: dereferencing pointer to
> incomplete type
> =C2=A0 hsdevp->dws->dma_dev =3D hsdev->dev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0^
> drivers/ata/sata_dwc_460ex.c: In function =E2=80=98sata_dwc_probe=E2=80=
=99:
> drivers/ata/sata_dwc_460ex.c:1330:12: error: dereferencing pointer to
> incomplete type
> =C2=A0 hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0^
> drivers/ata/sata_dwc_460ex.c:1331:16: error: dereferencing pointer to
> incomplete type
> =C2=A0 if (hsdev->dma->irq =3D=3D NO_IRQ) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> drivers/ata/sata_dwc_460ex.c:1338:12: error: dereferencing pointer to
> incomplete type
> =C2=A0 hsdev->dma->regs =3D of_iomap(np, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0^
> drivers/ata/sata_dwc_460ex.c:1339:17: error: dereferencing pointer to
> incomplete type
> =C2=A0 if (!hsdev->dma->regs) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> drivers/ata/sata_dwc_460ex.c:1349:12: error: dereferencing pointer to
> incomplete type
> =C2=A0 hsdev->dma->dev =3D &ofdev->dev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0^
> drivers/ata/sata_dwc_460ex.c:1352:2: error: implicit declaration of
> function =E2=80=98dw_dma_probe=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
> =C2=A0 err =3D dw_dma_probe(hsdev->dma, NULL);
> =C2=A0 ^
> drivers/ata/sata_dwc_460ex.c:1381:2: error: implicit declaration of
> function =E2=80=98dw_dma_remove=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
> =C2=A0 dw_dma_remove(hsdev->dma);
> =C2=A0 ^
> drivers/ata/sata_dwc_460ex.c:1383:20: error: dereferencing pointer to
> incomplete type
> =C2=A0 iounmap(hsdev->dma->regs);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> drivers/ata/sata_dwc_460ex.c: In function =E2=80=98sata_dwc_remove=E2=
=80=99:
> drivers/ata/sata_dwc_460ex.c:1400:20: error: dereferencing pointer to
> incomplete type
> =C2=A0 iounmap(hsdev->dma->regs);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> drivers/ata/sata_dwc_460ex.c: At top level:
> drivers/ata/sata_dwc_460ex.c:901:12: warning:
> =E2=80=98sata_dwc_dma_get_channel=E2=80=99 defined but not used [-Wun=
used-function]
> =C2=A0static int sata_dwc_dma_get_channel(struct sata_dwc_device_port
> *hsdevp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0^
> cc1: some warnings being treated as errors
> make[2]: *** [drivers/ata/sata_dwc_460ex.o] Error 1
> make[1]: *** [drivers/ata] Error 2
> make: *** [drivers] Error 2
> root@julian-VirtualBox:/usr/src/linux-4.4-rc5#=20
>=20
>=20
>=20
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

