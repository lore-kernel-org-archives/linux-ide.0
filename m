From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Fri, 18 Dec 2015 11:24:32 +0000
Message-ID: <yw1xio3watjj.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1x1tanffqg.fsf@unicorn.mansr.com>
	<1450364395.30729.136.camel@linux.intel.com>
	<yw1x60zxds5k.fsf@unicorn.mansr.com>
	<1450367702.30729.146.camel@linux.intel.com>
	<yw1xk2odcb87.fsf@unicorn.mansr.com>
	<1450371184.30729.175.camel@linux.intel.com>
	<5672F77F.4010306@candw.ms> <yw1xfuz1c5xy.fsf@unicorn.mansr.com>
	<567302E8.5050303@candw.ms> <yw1x7fkcdi2a.fsf@unicorn.mansr.com>
	<5673061A.4070700@candw.ms> <yw1x37v0df86.fsf@unicorn.mansr.com>
	<56732C04.9040100@candw.ms>
	<1450433310.30729.184.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450433310.30729.184.camel@linux.intel.com> (Andy Shevchenko's
	message of "Fri, 18 Dec 2015 12:08:30 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Thu, 2015-12-17 at 17:41 -0400, Julian Margetson wrote:
>> On 12/17/2015 3:53 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>> > Julian Margetson <runaway@candw.ms> writes:
>> >=20
>> > > On 12/17/2015 2:51 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>> > > > Julian Margetson <runaway@candw.ms> writes:
>> > > >=20
>> > > > > On 12/17/2015 1:59 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>> > > > > > Julian Margetson <runaway@candw.ms> writes:
>> > > > > >=20
>> > > > > > > I have been running my machine mostly configured for
>> > > > > > > pciex1=C2=A0=C2=A0thus with
>> > > > > > > the sata_dwc disabled.
>> > > > > > > The changes to sata_dwc-460ex do cause an oops.
>> > > > > > > I will try to give more detailed info over this weekend =
=2E
>> > > > > > The driver as is upstream would do that since it
>> > > > > > unconditionally
>> > > > > > dereferences a null pointer in the probe function.=C2=A0=C2=
=A0My
>> > > > > > patch fixes that
>> > > > > > as a side-effect.
>> > > > > >=20
>> > > > > patching file drivers/ata/Kconfig
>> > > > >=20
>> > > > > Hunk #1 FAILED at 296.
>> > > > [...]
>> > > >=20
>> > > > > root@julian-VirtualBox:/usr/src/linux-3.18.25#
>> > > > The patch is against 4.4-rc5.
>> > > >=20
>> > > =C2=A0CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/ata/sata_dwc=
_460ex.o
>> > >=20
>> > > drivers/ata/sata_dwc_460ex.c:198:15: error: variable
>> > > =C3=A2=E2=82=AC=CB=9Csata_dwc_dma_dws=C3=A2=E2=82=AC=E2=84=A2 ha=
s initializer but incomplete type
>> > >=20
>> > > =C2=A0static struct dw_dma_slave sata_dwc_dma_dws =3D {
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0^
>> > It builds, albeit with an unrelated warning, using the attached
>> > config.
>> > Maybe there's a missing config dependency somewhere.
>> >=20
>> I am attempting to cross compile under Ubuntu 14.04 X86 in Virtualbo=
x
>> with your .config.
>> 4.4.0-rc5 builds ok with no patches applied .
>> Once your patch is applied it fails to build .
>> CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/ata/sata_dwc_460ex.o
>> drivers/ata/sata_dwc_460ex.c:198:15: error: variable
>> =E2=80=98sata_dwc_dma_dws=E2=80=99 has initializer but incomplete ty=
pe
>> =C2=A0static struct dw_dma_slave sata_dwc_dma_dws =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0^
>> drivers/ata/sata_dwc_460ex.c:199:2: error: unknown field =E2=80=98sr=
c_id=E2=80=99
>> specified in initializer
>> =C2=A0 .src_id =3D 0,
>
> This clearly means that header file that defines the struct
> dw_dma_slave is not included.

And yet two lines above there's this:

#include <linux/platform_data/dma-dw.h>

This unconditionally defines struct dw_dma_slave.

Moreover, the line number in the error message above does not match any
version of the file with my patches applied.  I suspect something went
wrong when Julian patched his tree.

> After the patch it seems you have to explicitly enable DW_DMAC, so,
> either via make nconfig, or by adding
> CONFIG_DW_DMAC=3Dy

The option for enabling the compatibility code selects DW_DMAC.  There
is a missing select DMA_ENGINE, but that won't make any difference here=
,
and my .config has it enabled anyhow.

--=20
M=C3=A5ns Rullg=C3=A5rd
