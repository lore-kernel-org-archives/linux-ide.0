From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 22 Jan 2016 14:15:37 +0200
Message-ID: <CAHp75VdWj+03bS8q0n1bNGkP7iWvUTxb8QtA_7BXq=Ro0hxzDQ@mail.gmail.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<1450724880.30729.250.camel@linux.intel.com>
	<yw1xr3if4n74.fsf@unicorn.mansr.com>
	<1450731289.30729.282.camel@linux.intel.com>
	<yw1x37uv4a6l.fsf@unicorn.mansr.com>
	<1450781890.30729.298.camel@linux.intel.com>
	<yw1x4meq1xnx.fsf@unicorn.mansr.com>
	<CAHp75VfVo+y3rwQzBaLmi4-ZemzYt2nP3eHr-fhwGf0Lzg08UQ@mail.gmail.com>
	<1452159294.30729.405.camel@linux.intel.com>
	<yw1xr3htz1dv.fsf@unicorn.mansr.com>
	<1452243464.30729.430.camel@linux.intel.com>
	<yw1xwpr4ozjq.fsf@unicorn.mansr.com>
	<1453317808.2521.135.camel@linux.intel.com>
	<yw1xpowwoy08.fsf@unicorn.mansr.com>
	<CAHp75Vc__QXa=HE1Zw5yJut_sVEUs88tYTdeNxFnOVvBmB24rw@mail.gmail.com>
	<yw1xlh7kowyo.fsf@unicorn.mansr.com>
	<CAHp75Vftz_dAEDdG8yar==BB2spBpGozqf6UNpEDr-196J9xhg@mail.gmail.com>
	<yw1xh9i8ow0r.fsf@unicorn.mansr.com>
	<1453457080.2521.179.camel@linux.intel.com>
	<yw1xsi1pn9yr.fsf@unicorn.mansr.com>
	<1453463800.2521.189.camel@linux.intel.com>
	<yw1xk2n1n7jf.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:32858 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbcAVMPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jan 2016 07:15:38 -0500
In-Reply-To: <yw1xk2n1n7jf.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jan 22, 2016 at 2:05 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> On Fri, 2016-01-22 at 11:13 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>> > On Wed, 2016-01-20 at 20:07 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
>>> > > Andy Shevchenko <andy.shevchenko@gmail.com> writes:

>> +               u8 _dms =3D (_is_slave && _dwc->direction =3D=3D DMA=
_MEM_TO_DEV) ?    \
>> +                          _dwc->p_master : _dwc->m_master;         =
            \
>> +               u8 _sms =3D (_is_slave && _dwc->direction =3D=3D DMA=
_DEV_TO_MEM) ?    \
>> +                          _dwc->p_master : _dwc->m_master;         =
            \

> Oh, I see it now.  Two lines have a space rather than a tab since a t=
ab
> would push them over 80 columns.  Now those lines could be shortened =
by
> simply dropping the "_is_slave" since this is necessarily true if the
> other half of the && is.

Yes, direction is precisely from the _is_slave space.

--=20
With Best Regards,
Andy Shevchenko
