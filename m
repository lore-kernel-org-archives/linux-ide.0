From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Thu, 07 Jan 2016 18:32:28 +0000
Message-ID: <yw1xr3htz1dv.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<5675A84F.2070208@candw.ms> <yw1xio3u8dgc.fsf@unicorn.mansr.com>
	<5675BB2F.6060107@candw.ms>
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
	<1452159294.30729.405.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452159294.30729.405.camel@linux.intel.com> (Andy Shevchenko's
	message of "Thu, 07 Jan 2016 11:34:54 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Wed, 2016-01-06 at 19:36 +0200, Andy Shevchenko wrote:
>> On Wed, Jan 6, 2016 at 6:26 PM, M=E5ns Rullg=E5rd <mans@mansr.com> w=
rote:
>> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >=20
>> > > On Tue, 2015-12-22 at 00:08 +0000, M=E5ns Rullg=E5rd wrote:
>> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > > >=20
>> > > > > Here's what I have: https://bitbucket.org/mansr/linux-dwc
>> > > > Bitbucket because Github won't let me have more than one Linux
>> > > > repo.
>> > >=20
>> > > Thanks, got it.
>> > >=20
>> > > Will base my stuff on what you had done already.
>> >=20
>> > I've revived my AVR32 board, and after patching up some unrelated
>> > regressions, the MMC controller is working with the DMA driver as
>> > of 4.4-rc8 as well as with my patches applied.
>>=20
>> I'm going to publish my branch tomorrow. It has been tested a bit on
>> Intel hw, and works fine (yours patches are included with some sligh=
t
>> changes)
>
> So, M=E5ns, Julian, I just have published my repository containing M=E5=
ns'
> and my patches regarding dw_dmac and sata_dwc_460ex drivers here
>
> https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fnext

I've picked out the relevant changes from your branch and made some
additional improvements.  A few notes:

- The __be32/__le32 typedefs for the DMA descriptor fields are necessar=
y
  to avoid a million sparse warnings (and sparse is correct to warn).
- Using #ifdef CONFIG_AVR32 is a step back, IMO, since this driver may
  well be used on another big endian system some day.  The Kconfig logi=
c
  for selecting this option could perhaps be improved though.

Tested on AVR32 (DMA driver) and Sigma SMP8642 (SATA driver).

Code here:
https://bitbucket.org/mansr/linux-dwc/branch/dwc-sata

--=20
M=E5ns Rullg=E5rd
