From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 18 Dec 2015 20:48:29 +0200
Message-ID: <1450464509.30729.222.camel@linux.intel.com>
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
	 <1450441395.30729.203.camel@linux.intel.com>
	 <yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
	 <yw1xtwnfad4y.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41897 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbbLRSsO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Dec 2015 13:48:14 -0500
In-Reply-To: <yw1xtwnfad4y.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2015-12-18 at 17:18 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Julian Margetson <runaway@candw.ms> writes:
>=20
> > On 12/18/2015 8:49 AM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > >=20
> > > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.206125] Unable to handle kernel =
paging request for
> > > > > > data at
> > > > > > address 0x00000000
> > > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.228546] Faulting instruction add=
ress: 0xc043a2c8
> > > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.248577] Vector: 300 (Data Access=
) at [eddafae0]
> > > > > > [=C2=A0=C2=A0=C2=A0=C2=A05.268658]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0pc: c043a2c8:
> > > > > > sata_dwc_qc_issue+0xb8/0x204
> > > > > Well, that's not good.=C2=A0=C2=A0Can you translate that addr=
ess to a
> > > > > line of
> > > > > code?
> > > > Besides that, can you enable DYNAMIC_DEBUG in the config and
> > > > append
> > > > 'dw_dmac_core.dyndbg dw_dmac.dyndbg' to the kernel cmdline?
> > > Enabling debug messages in the sata_dwc driver might also be
> > > informative.
> > >=20
> > Changed the sata-dwc to a module .
> >=20
> > [=C2=A0=C2=A0=C2=A018.475140] sata-dwc 4bffd1000.sata: sata_dwc_qc_=
prep_by_tag:
> > dma_dwc_xfer_setup returns NULL
> > [=C2=A0=C2=A0=C2=A018.535698] sata-dwc 4bffd1000.sata: sata_dwc_qc_=
prep_by_tag:
> > dma_dwc_xfer_setup returns NULL
>=20
> That's strange.=C2=A0=C2=A0The only way that can happen is if
> dmaengine_prep_slave_sg() return NULL, and that really shouldn't be
> happening.=C2=A0=C2=A0Did you turn on debug messages in dw_dma?=C2=A0=
=C2=A0You can enable
> some extra debug messages by adding "#define VERBOSE_DEBUG" at the
> top
> of drivers/dma/dw/core.c

There are options also for DMA Engine such as CONFIG_DMADEVICES_DEBUG

>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

