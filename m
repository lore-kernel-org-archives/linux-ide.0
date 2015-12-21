From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Mon, 21 Dec 2015 00:53:58 +0000
Message-ID: <yw1xbn9k7hax.fsf@unicorn.mansr.com>
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
	<yw1xlh8o7hle.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yw1xlh8o7hle.fsf@unicorn.mansr.com> (=?iso-8859-1?Q?=22M=E5n?=
 =?iso-8859-1?Q?s_Rullg=E5rd=22's?= message
	of "Mon, 21 Dec 2015 00:47:41 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

M=E5ns Rullg=E5rd <mans@mansr.com> writes:

> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
>> On Sun, Dec 20, 2015 at 8:49 PM, M=E5ns Rullg=E5rd <mans@mansr.com> =
wrote:
>>> Julian Margetson <runaway@candw.ms> writes:
>>>> On 12/20/2015 1:11 PM, M=E5ns Rullg=E5rd wrote:
>>>>> Julian Margetson <runaway@candw.ms> writes:
>>
>>>> [   48.769671] ata3.00: failed command: READ FPDMA QUEUED
>>>
>>> Well, that didn't help.  I still think it's part of the problem, bu=
t
>>> something else must be wrong as well.  The various Master Select fi=
elds
>>> look like a good place to start.
>>
>> Master number (which is here would be either 1 or 0) should not affe=
ct
>> as long as they are connected to the same AHB bus (I would be
>> surprised if they are not).
>
> I think they are not.  The relevant part of the block diagram for the
> 460EX looks something like this:

Oops, hit send by accident.  More soon.

--=20
M=E5ns Rullg=E5rd
