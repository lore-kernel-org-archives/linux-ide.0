From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Sun, 20 Dec 2015 22:17:31 +0200
Message-ID: <CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
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
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com>
	<5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com>
	<5676E906.1060603@candw.ms>
	<yw1xpoy16jlt.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36686 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbLTURc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 15:17:32 -0500
In-Reply-To: <yw1xpoy16jlt.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Dec 20, 2015 at 8:49 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
> Julian Margetson <runaway@candw.ms> writes:
>> On 12/20/2015 1:11 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>> Julian Margetson <runaway@candw.ms> writes:

>> [   48.769671] ata3.00: failed command: READ FPDMA QUEUED
>
> Well, that didn't help.  I still think it's part of the problem, but
> something else must be wrong as well.  The various Master Select fiel=
ds
> look like a good place to start.

Master number (which is here would be either 1 or 0) should not affect
as long as they are connected to the same AHB bus (I would be
surprised if they are not).

>  Also, the manual says the LLP_SRC_EN
> and LLP_DST_EN flags should be cleared on the last in a chain of bloc=
ks.
> The old sata_dwc driver does this whereas dw_dma does not.

Easy to fix, however I can't get how it might affect.

> It might be worthwhile to try reverting drivers/ata/sata_dwc_460ex.c =
to
> v4.0 (leaving the rest at 4.4-rc5) just to make sure that's a good
> reference.  I've verified that this builds.

It would be nice.

I noticed thanks to DWC_PARAMS that burst size is hardcoded to 32
items on this board, however registers for SATA program it to 64. I
remember that I got no interrupt when I programmed transfer width
wrongly (64 bits against 32 bits) when I ported dw_dmac to be used on
Intel SoCs.


--=20
With Best Regards,
Andy Shevchenko
