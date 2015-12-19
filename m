From: Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Sat, 19 Dec 2015 16:48:31 -0400
Message-ID: <5675C29F.5060004@candw.ms>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
 <yw1xegekarp9.fsf@unicorn.mansr.com>
 <1450441395.30729.203.camel@linux.intel.com>
 <yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
 <yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
 <yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
 <yw1xlh8r9wkm.fsf@unicorn.mansr.com>
 <CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
 <567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
 <CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
 <yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
 <yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
 <yw1xio3u8dgc.fsf@unicorn.mansr.com> <5675BB2F.6060107@candw.ms>
 <CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
 <yw1xegei893o.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp618.redcondor.net ([208.80.206.18]:40148 "EHLO
	smtp618.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724AbbLSUs5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2015 15:48:57 -0500
In-Reply-To: <yw1xegei893o.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/19/2015 4:41 PM, M=E5ns Rullg=E5rd wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
>> On Sat, Dec 19, 2015 at 10:16 PM, Julian Margetson <runaway@candw.ms=
> wrote:
>>> On 12/19/2015 3:07 PM, M=E5ns Rullg=E5rd wrote:
>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>> Total pages: 522752
>>>>> [    0.000000] Kernel command line: root=3D/dev/sda8 console=3Dtt=
yS0,115200
>>>>> console=3Dtty1 dw_dmac_core.dyndbg dw_dmac.dyndbg
>>>> Please add ignore_log_level.
>>>>
>>> Had to truncate the kernel command line to add it.
>> I guess M=E5ns meant 'ignore_loglevel'
> Obviously.  I can never remember where the underscores go.
>
:-)


