From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Sat, 19 Dec 2015 22:39:40 +0200
Message-ID: <CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<56732C04.9040100@candw.ms>
	<yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<5673F277.2050607@candw.ms>
	<yw1xegekarp9.fsf@unicorn.mansr.com>
	<1450441395.30729.203.camel@linux.intel.com>
	<yw1x37uzc45t.fsf@unicorn.mansr.com>
	<5674271B.9090308@candw.ms>
	<yw1xtwnfad4y.fsf@unicorn.mansr.com>
	<56745BA4.1090607@candw.ms>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com>
	<56748D85.4060108@candw.ms>
	<yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	<CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	<567541EE.9010308@candw.ms>
	<yw1x60zua1ld.fsf@unicorn.mansr.com>
	<CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
	<yw1xwpsa8j2x.fsf@unicorn.mansr.com>
	<56758F33.20804@candw.ms>
	<yw1xsi2y8ifa.fsf@unicorn.mansr.com>
	<5675A84F.2070208@candw.ms>
	<yw1xio3u8dgc.fsf@unicorn.mansr.com>
	<5675BB2F.6060107@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34610 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbbLSUjl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2015 15:39:41 -0500
In-Reply-To: <5675BB2F.6060107@candw.ms>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Dec 19, 2015 at 10:16 PM, Julian Margetson <runaway@candw.ms> w=
rote:
> On 12/19/2015 3:07 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>> Julian Margetson <runaway@candw.ms> writes:

>>> Total pages: 522752
>>> [    0.000000] Kernel command line: root=3D/dev/sda8 console=3DttyS=
0,115200
>>> console=3Dtty1 dw_dmac_core.dyndbg dw_dmac.dyndbg
>>
>> Please add ignore_log_level.
>>
> Had to truncate the kernel command line to add it.

I guess M=C3=A5ns meant 'ignore_loglevel'

--=20
With Best Regards,
Andy Shevchenko
