From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 22:25:47 +0200
Message-ID: <1450729547.30729.273.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	 <yw1x60zua1ld.fsf@unicorn.mansr.com>
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
	 <1450716497.30729.232.camel@linux.intel.com> <56783636.80901@candw.ms>
	 <CAHp75VfQ6jWm+W1kHh-4zqV28wF4OCCrBfSX8jXxsEcEYSsw5Q@mail.gmail.com>
	 <567843B8.1000801@candw.ms> <yw1xzix34py1.fsf@unicorn.mansr.com>
	 <567850D0.90803@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14645 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbbLUUZm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2015 15:25:42 -0500
In-Reply-To: <567850D0.90803@candw.ms>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2015-12-21 at 15:19 -0400, Julian Margetson wrote:
> On 12/21/2015 2:27 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
> > The hard drive is recognized .
> > > These system gets unresponsive with USB devices like the mouse
> > > and
> > > keyboard not responding=C2=A0=C2=A0when I start Gparted.
> > Did you disable the SATA and DMA debug messages?
> >=20
> It is working.

Indeed, thanks, Julian!

I might ask you to test my branch with set of patches when it will be
ready (apparently after Xmas) if you are okay with that.

M=C3=A5ns, also I would ask you to test on your hardware (AVR32) as wel=
l if
you have no objections.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

