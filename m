From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Wed, 06 Jan 2016 16:26:58 +0000
Message-ID: <yw1x4meq1xnx.fsf@unicorn.mansr.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:38738 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbcAFQ1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jan 2016 11:27:07 -0500
In-Reply-To: <1450781890.30729.298.camel@linux.intel.com> (Andy Shevchenko's
	message of "Tue, 22 Dec 2015 12:58:10 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, 2015-12-22 at 00:08 +0000, M=E5ns Rullg=E5rd wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>=20
>> > On Mon, 2015-12-21 at 19:27 +0000, M=E5ns Rullg=E5rd wrote:
>> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > >=20
>> > > > I can share my working branch with a set of patches regarding
>> > > > to dw_dmac. We may do our work based on that code and after
>> > > > I'll submit everything to upstream. Does it sound okay for you=
,
>> > > > guys?
>> > >=20
>> > > I'm going away for the holidays, so I won't be able to do any
>> > > serious work on this until January, but I'll keep an eye on
>> > > emails and may even reply occasionally.=A0=A0Before I go, I'll
>> > > publish my patches so far whatever shape they're in.
>> >=20
>> > Okay, thanks! I will include them in my branch which I'm going to
>> > publish on GitHUB.
>>=20
>> Here's what I have: https://bitbucket.org/mansr/linux-dwc
>> Bitbucket because Github won't let me have more than one Linux
>> repo.
>
> Thanks, got it.
>
> Will base my stuff on what you had done already.

I've revived my AVR32 board, and after patching up some unrelated
regressions, the MMC controller is working with the DMA driver as
of 4.4-rc8 as well as with my patches applied.

--=20
M=E5ns Rullg=E5rd
