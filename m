From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 18 Dec 2015 16:24:59 +0200
Message-ID: <1450448699.30729.220.camel@linux.intel.com>
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
	 <yw1xegekarp9.fsf@unicorn.mansr.com> <5673FD36.4050502@candw.ms>
	 <yw1xa8p8apsw.fsf@unicorn.mansr.com> <56740F9F.5020500@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:50308 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbbLROYo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Dec 2015 09:24:44 -0500
In-Reply-To: <56740F9F.5020500@candw.ms>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2015-12-18 at 09:52 -0400, Julian Margetson wrote:
> On 12/18/2015 8:45 AM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > Julian Margetson <runaway@candw.ms> writes:

> > > > > [=C2=A0=C2=A0=C2=A0=C2=A04.784199] sata-dwc 4bffd1000.sata: i=
d 0, controller
> > > > > version 1.82
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A04.791186] scsi host0: sata-dwc
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A04.794830] ata1: SATA max UDMA/133 ir=
q 36
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A04.799463] sata_sil 0001:00:04.0: App=
lying R_ERR on DMA
> > > > > activate FIS errata fix
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A04.807959] scsi host1: sata_sil
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A04.811662] scsi host2: sata_sil
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A04.815242] ata2: SATA max UDMA/100 mm=
io m512@0xd84280000
> > > > > tf 0xd84280080 irq 21
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A04.822990] ata3: SATA max UDMA/100 mm=
io m512@0xd84280000
> > > > > tf 0xd842800c0 irq 21
> > > > >=20
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.143502] ata1: SATA link up 3.0 Gbp=
s (SStatus 123
> > > > > SControl 300)
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.164367] ata2: SATA link up 1.5 Gbp=
s (SStatus 113
> > > > > SControl 310)
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.185174] ppc-of-ohci 4bffd0000.usb:=
 irq 32, io mem
> > > > > 0x4bffd0000
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.206125] Unable to handle kernel pa=
ging request for
> > > > > data at address 0x00000000
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.228546] Faulting instruction addre=
ss: 0xc043a2c8
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.248577] Vector: 300 (Data Access) =
at [eddafae0]
> > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.268658]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0pc: c043a2c8: sata_dwc_qc_issue+0xb8/0x204
> > > > Well, that's not good.=C2=A0=C2=A0Can you translate that addres=
s to a
> > > > line of code?
> > > >=20
> > > need some guidance on method .
> > Enable CONFIG_DEBUG_INFO, then use this command:
> >=20
> > $ addr2line -e vmlinux 0xc043a2c8
> >=20
> > Obviously substitute the actual crashing address if it changes.
> >=20
> addr2line -e vmlinux 0xc044b41c
> arch/powerpc/lib/copy_32.S:?

memcpy I suppose. Might be copy to unmapped memory.

Anyway, can you enable debug options as I suggested including debug for
sata driver ('dw_dmac_core.dyndbg dw_dmac.dyndbg sata_dwc_460ex.dydbg'
to the cmdline and CONFIG_DYNAMIC_DEBUG=3Dy)?


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

