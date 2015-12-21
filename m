From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Mon, 21 Dec 2015 19:50:55 +0000
Message-ID: <yw1xio3r4m3k.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
	<yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
	<yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
	<yw1xio3u8dgc.fsf@unicorn.mansr.com> <5675BB2F.6060107@candw.ms>
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com> <5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com> <5676E906.1060603@candw.ms>
	<yw1xpoy16jlt.fsf@unicorn.mansr.com>
	<CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
	<yw1xa8p47h3w.fsf@unicorn.mansr.com>
	<CAHp75VeT6ZssxiD-c3SqZgAcL5vFuvv4H5AVPz8sypuGkuvqRg@mail.gmail.com>
	<yw1xwps8577f.fsf@unicorn.mansr.com>
	<CAHp75Vcin1GXpYm-air5fV5B+jiMnB9hoByCqOvbDgd5pHRRJA@mail.gmail.com>
	<yw1xd1tz650x.fsf@unicorn.mansr.com>
	<1450725813.30729.256.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450725813.30729.256.camel@linux.intel.com> (Andy Shevchenko's
	message of "Mon, 21 Dec 2015 21:23:33 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Mon, 2015-12-21 at 18:16 +0000, M=E5ns Rullg=E5rd wrote:
>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>=20
>> > On Mon, Dec 21, 2015 at 2:15 PM, M=E5ns Rullg=E5rd <mans@mansr.com=
>
>> > wrote:
>> > > Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>> > >=A0
>> > I used to have a patch to implement this in dw_dmac driver.
>> > However, I
>> > dropped it at some point. Seems we need it back and now I possible
>> > have a good explanation why.
>>=20
>> Are you still able to find that patch?=A0=A0Shouldn't be too hard to=
 do
>> from scratch if not.
>
> Yes, I found a version of it, let me mock up tomorrow something
> working.
>
>>=20
>> > > If those values didn't matter, why would the fields exist in the
>> > > first place?
>> >=20
>> > Because someone can have more than one AHB bus on the system and
>> > connect DMA to all of them (up to 4).
>>=20
>> Which apparently these guys did.=A0=A0Well, not a full-blown AHB bus=
, but
>> they seem to be using two master interfaces.
>
> To different buses? Intel HW uses two masters and they are quite equa=
l
> (at least from OS point of view, it might be HW adjusts it).

Judging by the block diagram in the 460EX datasheet [1], and by the fac=
t
that the old SATA driver works despite using an invalid address, the DM=
A
=46IFO of the controller isn't connected to the AHB bus at all but
directly to master 0 on the DW DMA controller.  Master 1 of the DMA
controller is connected to the AHB bus, which is bridged to the main
system bus.

I haven't managed to find a full manual for the 460EX.

[1] http://datasheet.octopart.com/PPC460EX-NUB800T-AMCC-datasheet-11553=
412.pdf

--=20
M=E5ns Rullg=E5rd
