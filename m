From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Mon, 21 Dec 2015 18:19:19 +0000
Message-ID: <yw1x8u4n64wo.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
	<yw1xio3u8dgc.fsf@unicorn.mansr.com> <5675BB2F.6060107@candw.ms>
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com> <5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com> <5676E906.1060603@candw.ms>
	<yw1xpoy16jlt.fsf@unicorn.mansr.com>
	<CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
	<yw1xa8p47h3w.fsf@unicorn.mansr.com>
	<CAHp75VeT6ZssxiD-c3SqZgAcL5vFuvv4H5AVPz8sypuGkuvqRg@mail.gmail.com>
	<5677D447.40906@candw.ms> <yw1xsi2w574t.fsf@unicorn.mansr.com>
	<5677FC31.1030305@candw.ms> <yw1xlh8o53zh.fsf@unicorn.mansr.com>
	<56780F42.2020907@candw.ms> <yw1xh9jb6d08.fsf@unicorn.mansr.com>
	<1450716262.30729.230.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450716262.30729.230.camel@linux.intel.com> (Andy Shevchenko's
	message of "Mon, 21 Dec 2015 18:44:22 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andy.shevchenko@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Mon, 2015-12-21 at 15:24 +0000, M=E5ns Rullg=E5rd wrote:
>> Julian Margetson <runaway@candw.ms> writes:
>>=20
>>=20
>> Oh, that one again.=A0=A0My patch still applies.=A0=A0Here it is as =
applied
>> to
>> that revision of the file.
>>=20
>> From what I can tell, that bug has always been there.=A0=A0Probably
>> nobody
>> ever tested the driver in a PREEMPT or SMP build, nor with lock
>> debugging enabled.
>
> I guess it's a time to submit this one to upstream with proper Fixes:
> tag (which I suppose the initial commit of the driver).

Done.

--=20
M=E5ns Rullg=E5rd
