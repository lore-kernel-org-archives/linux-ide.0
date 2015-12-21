From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 21:08:00 +0200
Message-ID: <1450724880.30729.250.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	 <56748D85.4060108@candw.ms> <yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	 <CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	 <567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
	 <CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
	 <yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
	 <yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
	 <yw1xio3u8dgc.fsf@unicorn.mansr.com> <5675BB2F.6060107@candw.ms>
	 <CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	 <yw1xegei893o.fsf@unicorn.mansr.com> <5675C452.2080206@candw.ms>
	 <yw1xy4cp6o4o.fsf@unicorn.mansr.com> <5676E906.1060603@candw.ms>
	 <yw1xpoy16jlt.fsf@unicorn.mansr.com>
	 <CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
	 <CAHp75VfaHvBHhTjQVMNdOYA2kEdus-XpH6E=9i1HPSKTa-2ffA@mail.gmail.com>
	 <yw1x60zs7g40.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11240 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbbLUTHo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2015 14:07:44 -0500
In-Reply-To: <yw1x60zs7g40.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2015-12-21 at 01:19 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>=C2=A0
> > P.S. I also noticed that original driver enables interrupt per each
> > block
>=20
> And then ignores all but the transfer complete interrupt.
>=20
> > and sets protection control bits.
>=20
> With no indication what the value it sets is supposed to mean.

Okay, let's summarize what we have:

0. AR: Get a working reference for PPC 460EX SATA driver
1. AR: Clear LLP_EN bits at the last block of LLP transfer
2. AR: Rename masters to 'memory' and 'peripheral' and change them per
DMA direction
3. AR: Set LMS (LLP master) to 'memory' when do LLP transfers
4. CHECK: PROTCTL bit (documentation says that recommended value is
0x01)
5. CHECK: Other bits in CFG register (FIFO_MODE, FCMODE)
6. CHECK: Block interrupts vs. one interrupt at the end of block chain
(M=C3=A5ns, I missed how any of them is ignored)
7. AR: Test everything on Intel SoCs such as Baytrail, CherryTrail, etc
(SPI, UART, dmatest), AVR32 (MMC, dmatest), PPC 460EX (Onboard SATA)


I can share my working branch with a set of patches regarding to
dw_dmac. We may do our work based on that code and after I'll submit
everything to upstream. Does it sound okay for you, guys?

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

