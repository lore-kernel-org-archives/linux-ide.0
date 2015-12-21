From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Mon, 21 Dec 2015 20:33:19 +0000
Message-ID: <yw1xegef4k4w.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<56758F33.20804@candw.ms> <yw1xsi2y8ifa.fsf@unicorn.mansr.com>
	<5675A84F.2070208@candw.ms> <yw1xio3u8dgc.fsf@unicorn.mansr.com>
	<5675BB2F.6060107@candw.ms>
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com> <5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com> <5676E906.1060603@candw.ms>
	<yw1xpoy16jlt.fsf@unicorn.mansr.com>
	<CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
	<CAHp75VfaHvBHhTjQVMNdOYA2kEdus-XpH6E=9i1HPSKTa-2ffA@mail.gmail.com>
	<1450716497.30729.232.camel@linux.intel.com> <56783636.80901@candw.ms>
	<CAHp75VfQ6jWm+W1kHh-4zqV28wF4OCCrBfSX8jXxsEcEYSsw5Q@mail.gmail.com>
	<567843B8.1000801@candw.ms> <yw1xzix34py1.fsf@unicorn.mansr.com>
	<567850D0.90803@candw.ms> <1450729547.30729.273.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:54727 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbbLUUd1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 15:33:27 -0500
In-Reply-To: <1450729547.30729.273.camel@linux.intel.com> (Andy Shevchenko's
	message of "Mon, 21 Dec 2015 22:25:47 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andy.shevchenko@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Mon, 2015-12-21 at 15:19 -0400, Julian Margetson wrote:
>> On 12/21/2015 2:27 PM, M=E5ns Rullg=E5rd wrote:
>> > The hard drive is recognized .
>> > > These system gets unresponsive with USB devices like the mouse
>> > > and
>> > > keyboard not responding=A0=A0when I start Gparted.
>> > Did you disable the SATA and DMA debug messages?
>> >=20
>> It is working.
>
> Indeed, thanks, Julian!
>
> I might ask you to test my branch with set of patches when it will be
> ready (apparently after Xmas) if you are okay with that.
>
> M=E5ns, also I would ask you to test on your hardware (AVR32) as well=
 if
> you have no objections.

Sure, but it will have to wait until January.

--=20
M=E5ns Rullg=E5rd
