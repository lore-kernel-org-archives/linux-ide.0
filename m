From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 18 Dec 2015 14:23:15 +0200
Message-ID: <1450441395.30729.203.camel@linux.intel.com>
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
	 <yw1xvb7wbowu.fsf@unicorn.mansr.com> <5673F277.2050607@candw.ms>
	 <yw1xegekarp9.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60999 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbbLRMXN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Dec 2015 07:23:13 -0500
In-Reply-To: <yw1xegekarp9.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2015-12-18 at 12:04 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Julian Margetson <runaway@candw.ms> writes:
>=20
> > On 12/17/2015 8:06 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > Julian Margetson <runaway@candw.ms> writes:
> > >=20
> > > > On 12/17/2015 3:53 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > > > Julian Margetson <runaway@candw.ms> writes:
> > > > >=20
> > > > > > On 12/17/2015 2:51 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > > > > > Julian Margetson <runaway@candw.ms> writes:
> > > > > > >=20
> > > > > > > > On 12/17/2015 1:59 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > > > > > > > Julian Margetson <runaway@candw.ms> writes:
> > > > > > > > >=20
> > > > > > > > > > I have been running my machine mostly configured
> > > > > > > > > > for pciex1=C2=A0=C2=A0thus with
> > > > > > > > > > the sata_dwc disabled.
> > > > > > > > > > The changes to sata_dwc-460ex do cause an oops.
> > > > > > > > > > I will try to give more detailed info over this
> > > > > > > > > > weekend .
> > > > > > > > > The driver as is upstream would do that since it
> > > > > > > > > unconditionally
> > > > > > > > > dereferences a null pointer in the probe
> > > > > > > > > function.=C2=A0=C2=A0My patch fixes that
> > > > > > > > > as a side-effect.
> > > > > > > > >=20
> > > > > > > > patching file drivers/ata/Kconfig
> > > > > > > >=20
> > > > > > > > Hunk #1 FAILED at 296.
> > > > > > > [...]
> > > > > > >=20
> > > > > > > > root@julian-VirtualBox:/usr/src/linux-3.18.25#
> > > > > > > The patch is against 4.4-rc5.
> > > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dri=
vers/ata/sata_dwc_460ex.o
> > > > > >=20
> > > > > > drivers/ata/sata_dwc_460ex.c:198:15: error: variable
> > > > > > =C3=A2=E2=82=AC=CB=9Csata_dwc_dma_dws=C3=A2=E2=82=AC=E2=84=A2=
 has initializer but incomplete type
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0static struct dw_dma_slave sata_dwc_dma_d=
ws =3D {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> > > > > It builds, albeit with an unrelated warning, using the
> > > > > attached config.
> > > > > Maybe there's a missing config dependency somewhere.
> > > > >=20
> > > > I am attempting to cross compile under Ubuntu 14.04 X86 in
> > > > Virtualbox
> > > > with your .config.
> > > > 4.4.0-rc5 builds ok with no patches applied .
> > > > Once your patch is applied it fails to build .
> > > >=20
> > > > CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/ata/sata_dwc_460e=
x.o
> > > > drivers/ata/sata_dwc_460ex.c:198:15: error: variable
> > > > =E2=80=98sata_dwc_dma_dws=E2=80=99 has initializer but incomple=
te type
> > > > =C2=A0 static struct dw_dma_slave sata_dwc_dma_dws =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> > > Bizarre.=C2=A0=C2=A0This is what it looks like here:
> > >=20
> > > mru@unicorn:/tmp/linux-sata$ git status
> > > On branch sata-dwc
> > > nothing to commit, working directory clean
> > > mru@unicorn:/tmp/linux-sata$ git describe
> > > v4.4-rc5
> > > mru@unicorn:/tmp/linux-sata$ sha1sum /tmp/0001-ata-
> > > sata_dwc_460ex-use-dmas-DT-property-to-find-dma-.patch
> > > e300971aa483390f82de2e9120dc16e460e74feb=C2=A0=C2=A0/tmp/0001-ata=
-
> > > sata_dwc_460ex-use-dmas-DT-property-to-find-dma-.patch
> > > mru@unicorn:/tmp/linux-sata$ git am /tmp/0001-ata-sata_dwc_460ex-
> > > use-dmas-DT-property-to-find-dma-.patch
> > > Applying: ata: sata_dwc_460ex: use "dmas" DT property to find dma
> > > channel
> > > mru@unicorn:/tmp/linux-sata$ sha1sum .config
> > > 4e7615b8d2fa9a1c4b4ae9ffc363aefcaf3789ca=C2=A0=C2=A0.config
> > > mru@unicorn:/tmp/linux-sata$ make ARCH=3Dpowerpc
> > > CROSS_COMPILE=3Dpowerpc64-none-linux-gnu- oldconfig
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/basic/fixdep
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/kconfig/conf.o
> > > =C2=A0=C2=A0=C2=A0SHIPPED scripts/kconfig/zconf.tab.c
> > > =C2=A0=C2=A0=C2=A0SHIPPED scripts/kconfig/zconf.lex.c
> > > =C2=A0=C2=A0=C2=A0SHIPPED scripts/kconfig/zconf.hash.c
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/kconfig/zconf.tab.o
> > > =C2=A0=C2=A0=C2=A0HOSTLD=C2=A0=C2=A0scripts/kconfig/conf
> > > scripts/kconfig/conf=C2=A0=C2=A0--oldconfig Kconfig
> > > #
> > > # configuration written to .config
> > > #
> > > mru@unicorn:/tmp/linux-sata$ make ARCH=3Dpowerpc
> > > CROSS_COMPILE=3Dpowerpc64-none-linux-gnu-
> > > drivers/ata/sata_dwc_460ex.o
> > > scripts/kconfig/conf=C2=A0=C2=A0--silentoldconfig Kconfig
> > > =C2=A0=C2=A0=C2=A0CHK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/config=
/kernel.release
> > > =C2=A0=C2=A0=C2=A0UPD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/config=
/kernel.release
> > > =C2=A0=C2=A0=C2=A0WRAP=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/includ=
e/generated/asm/clkdev.h
> > > =C2=A0=C2=A0=C2=A0WRAP=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/includ=
e/generated/asm/div64.h
> > > =C2=A0=C2=A0=C2=A0WRAP=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/includ=
e/generated/asm/irq_regs.h
> > > =C2=A0=C2=A0=C2=A0WRAP=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/includ=
e/generated/asm/irq_work.h
> > > =C2=A0=C2=A0=C2=A0WRAP=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/includ=
e/generated/asm/local64.h
> > > =C2=A0=C2=A0=C2=A0WRAP=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/includ=
e/generated/asm/mcs_spinlock.h
> > > =C2=A0=C2=A0=C2=A0WRAP=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/includ=
e/generated/asm/preempt.h
> > > =C2=A0=C2=A0=C2=A0WRAP=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/includ=
e/generated/asm/rwsem.h
> > > =C2=A0=C2=A0=C2=A0WRAP=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/includ=
e/generated/asm/vtime.h
> > > =C2=A0=C2=A0=C2=A0CHK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/uapi/linux/version.h
> > > =C2=A0=C2=A0=C2=A0UPD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/uapi/linux/version.h
> > > =C2=A0=C2=A0=C2=A0CHK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/utsrelease.h
> > > =C2=A0=C2=A0=C2=A0UPD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/utsrelease.h
> > > =C2=A0=C2=A0=C2=A0CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kernel/bo=
unds.s
> > > =C2=A0=C2=A0=C2=A0CHK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/bounds.h
> > > =C2=A0=C2=A0=C2=A0UPD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/bounds.h
> > > =C2=A0=C2=A0=C2=A0CHK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/timeconst.h
> > > =C2=A0=C2=A0=C2=A0UPD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/timeconst.h
> > > =C2=A0=C2=A0=C2=A0CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/powe=
rpc/kernel/asm-offsets.s
> > > =C2=A0=C2=A0=C2=A0CHK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/asm-offsets.h
> > > =C2=A0=C2=A0=C2=A0UPD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/genera=
ted/asm-offsets.h
> > > =C2=A0=C2=A0=C2=A0CALL=C2=A0=C2=A0=C2=A0=C2=A0scripts/checksyscal=
ls.sh
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/dtc.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/flattree.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/fstree.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/data.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/livetree.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/treesource.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/srcpos.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/checks.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/util.o
> > > =C2=A0=C2=A0=C2=A0SHIPPED scripts/dtc/dtc-lexer.lex.c
> > > =C2=A0=C2=A0=C2=A0SHIPPED scripts/dtc/dtc-parser.tab.h
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/dtc-lexer.lex.o
> > > =C2=A0=C2=A0=C2=A0SHIPPED scripts/dtc/dtc-parser.tab.c
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/dtc/dtc-parser.tab.o
> > > =C2=A0=C2=A0=C2=A0HOSTLD=C2=A0=C2=A0scripts/dtc/dtc
> > > =C2=A0=C2=A0=C2=A0CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/m=
od/empty.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/mod/mk_elfconfig
> > > =C2=A0=C2=A0=C2=A0MKELF=C2=A0=C2=A0=C2=A0scripts/mod/elfconfig.h
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/mod/modpost.o
> > > =C2=A0=C2=A0=C2=A0CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/m=
od/devicetable-offsets.s
> > > =C2=A0=C2=A0=C2=A0GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/mod/de=
vicetable-offsets.h
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/mod/file2alias.o
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/mod/sumversion.o
> > > =C2=A0=C2=A0=C2=A0HOSTLD=C2=A0=C2=A0scripts/mod/modpost
> > > =C2=A0=C2=A0=C2=A0HOSTCC=C2=A0=C2=A0scripts/kallsyms
> > > =C2=A0=C2=A0=C2=A0CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/a=
ta/sata_dwc_460ex.o
> > > drivers/ata/sata_dwc_460ex.c: In function 'dma_dwc_xfer_setup':
> > > drivers/ata/sata_dwc_460ex.c:383:20: warning: cast from pointer
> > > to integer of different size [-Wpointer-to-int-cast]
> > > =C2=A0=C2=A0=C2=A0dma_addr_t addr =3D (dma_addr_t)&hsdev->sata_dw=
c_regs->dmadr;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> > > mru@unicorn:/tmp/linux-sata$
> > >=20
> > > Patch file and .config attached.
> > >=20
> > > Looking into that warning, I doubt it works as is, but that's not
> > > caused
> > > by my patch.=C2=A0=C2=A0I can try to come up with a fix, but agai=
n, I can't
> > > test it.
> > >=20
> > Builds now. Using my own .config.
>=20
> What changed?

(Just in case a hint: diffconfig helps to do the job)

>=20
> > [=C2=A0=C2=A0=C2=A0=C2=A04.784199] sata-dwc 4bffd1000.sata: id 0, c=
ontroller version
> > 1.82
> > [=C2=A0=C2=A0=C2=A0=C2=A04.791186] scsi host0: sata-dwc
> > [=C2=A0=C2=A0=C2=A0=C2=A04.794830] ata1: SATA max UDMA/133 irq 36
> > [=C2=A0=C2=A0=C2=A0=C2=A04.799463] sata_sil 0001:00:04.0: Applying =
R_ERR on DMA
> > activate FIS errata fix
> > [=C2=A0=C2=A0=C2=A0=C2=A04.807959] scsi host1: sata_sil
> > [=C2=A0=C2=A0=C2=A0=C2=A04.811662] scsi host2: sata_sil
> > [=C2=A0=C2=A0=C2=A0=C2=A04.815242] ata2: SATA max UDMA/100 mmio m51=
2@0xd84280000 tf
> > 0xd84280080 irq 21
> > [=C2=A0=C2=A0=C2=A0=C2=A04.822990] ata3: SATA max UDMA/100 mmio m51=
2@0xd84280000 tf
> > 0xd842800c0 irq 21
> >=20
> > [=C2=A0=C2=A0=C2=A0=C2=A05.143502] ata1: SATA link up 3.0 Gbps (SSt=
atus 123 SControl
> > 300)
> > [=C2=A0=C2=A0=C2=A0=C2=A05.164367] ata2: SATA link up 1.5 Gbps (SSt=
atus 113 SControl
> > 310)
> > [=C2=A0=C2=A0=C2=A0=C2=A05.185174] ppc-of-ohci 4bffd0000.usb: irq 3=
2, io mem
> > 0x4bffd0000
> > [=C2=A0=C2=A0=C2=A0=C2=A05.206125] Unable to handle kernel paging r=
equest for data at
> > address 0x00000000
> > [=C2=A0=C2=A0=C2=A0=C2=A05.228546] Faulting instruction address: 0x=
c043a2c8
> > [=C2=A0=C2=A0=C2=A0=C2=A05.248577] Vector: 300 (Data Access) at [ed=
dafae0]
> > [=C2=A0=C2=A0=C2=A0=C2=A05.268658]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pc:=
 c043a2c8: sata_dwc_qc_issue+0xb8/0x204
>=20
> Well, that's not good.=C2=A0=C2=A0Can you translate that address to a=
 line of
> code?

Besides that, can you enable DYNAMIC_DEBUG in the config and append
'dw_dmac_core.dyndbg dw_dmac.dyndbg' to the kernel cmdline?

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

