From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Thu, 07 Jan 2016 11:34:54 +0200
Message-ID: <1452159294.30729.405.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
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
	 <1450724880.30729.250.camel@linux.intel.com>
	 <yw1xr3if4n74.fsf@unicorn.mansr.com>
	 <1450731289.30729.282.camel@linux.intel.com>
	 <yw1x37uv4a6l.fsf@unicorn.mansr.com>
	 <1450781890.30729.298.camel@linux.intel.com>
	 <yw1x4meq1xnx.fsf@unicorn.mansr.com>
	 <CAHp75VfVo+y3rwQzBaLmi4-ZemzYt2nP3eHr-fhwGf0Lzg08UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39234 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846AbcAGJeb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Jan 2016 04:34:31 -0500
In-Reply-To: <CAHp75VfVo+y3rwQzBaLmi4-ZemzYt2nP3eHr-fhwGf0Lzg08UQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 2016-01-06 at 19:36 +0200, Andy Shevchenko wrote:
> On Wed, Jan 6, 2016 at 6:26 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.c=
om> wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >=20
> > > On Tue, 2015-12-22 at 00:08 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > > >=20
> > > > > Here's what I have: https://bitbucket.org/mansr/linux-dwc
> > > > Bitbucket because Github won't let me have more than one Linux
> > > > repo.
> > >=20
> > > Thanks, got it.
> > >=20
> > > Will base my stuff on what you had done already.
> >=20
> > I've revived my AVR32 board, and after patching up some unrelated
> > regressions, the MMC controller is working with the DMA driver as
> > of 4.4-rc8 as well as with my patches applied.
>=20
> I'm going to publish my branch tomorrow. It has been tested a bit on
> Intel hw, and works fine (yours patches are included with some slight
> changes)

So, M=C3=A5ns, Julian, I just have published my repository containing M=
=C3=A5ns'
and my patches regarding dw_dmac and sata_dwc_460ex drivers here

https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fnext

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

