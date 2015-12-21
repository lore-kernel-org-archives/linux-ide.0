From: Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 13:20:27 -0400
Message-ID: <567834DB.4050103@candw.ms>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
 <yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
 <yw1xlh8r9wkm.fsf@unicorn.mansr.com>
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
 <CAHp75VfaHvBHhTjQVMNdOYA2kEdus-XpH6E=9i1HPSKTa-2ffA@mail.gmail.com>
 <1450716497.30729.232.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp618.redcondor.net ([208.80.206.18]:42288 "EHLO
	smtp618.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbbLURUt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 12:20:49 -0500
In-Reply-To: <1450716497.30729.232.camel@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/21/2015 12:48 PM, Andy Shevchenko wrote:
> On Sun, 2015-12-20 at 22:55 +0200, Andy Shevchenko wrote:
>> On Sun, Dec 20, 2015 at 10:17 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Sun, Dec 20, 2015 at 8:49 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mans=
r.com>
>>> wrote:
>>> I noticed thanks to DWC_PARAMS that burst size is hardcoded to 32
>>> items on this board, however registers for SATA program it to 64. I
>>> remember that I got no interrupt when I programmed transfer width
>>> wrongly (64 bits against 32 bits) when I ported dw_dmac to be used
>>> on
>>> Intel SoCs.
>> One more thing, I have a patch to monitor DMA IO, we may check what
>> exactly the values are written / read  in DMA. I can share it
>> tomorrow.
> As promised the patch I have to debug IO of DW DMA. Didn't check thou=
gh
> if it applies cleanly on top of recent vanilla kernel.
>
patch -p1 -R <../0001-dw_dmac-debug-dma-controller-IO.patch
patching file drivers/dma/dw/core.c
Hunk #1 succeeded at 543 (offset -27 lines).
Hunk #2 FAILED at 1571.
Hunk #3 FAILED at 1717.
2 out of 3 hunks FAILED -- saving rejects to file drivers/dma/dw/core.c=
=2Erej
patching file drivers/dma/dw/regs.h
Hunk #1 succeeded at 114 (offset -16 lines).
Hunk #2 succeeded at 262 (offset -39 lines).
Hunk #3 succeeded at 293 (offset -40 lines).
root@julian-VirtualBox:/usr/src/linux-test# patch -p1=20
<../0001-dw_dmac-debug-dma-controller-IO.patch
patching file drivers/dma/dw/core.c
Hunk #1 succeeded at 543 (offset -27 lines).
Hunk #2 FAILED at 1572.
Hunk #3 FAILED at 1716.
2 out of 3 hunks FAILED -- saving rejects to file drivers/dma/dw/core.c=
=2Erej
patching file drivers/dma/dw/regs.h
Hunk #1 succeeded at 114 (offset -16 lines).
Hunk #2 succeeded at 264 (offset -39 lines).
Hunk #3 succeeded at 307 (offset -40 lines).


