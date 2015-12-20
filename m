From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Sun, 20 Dec 2015 19:41:51 +0200
Message-ID: <CAHp75Vf1+pFqe9PLvsowmTiWcc1_e1awqmaEy+esHeOnPOpNGQ@mail.gmail.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
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
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com>
	<5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33752 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbLTRlw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 12:41:52 -0500
In-Reply-To: <yw1xy4cp6o4o.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Dec 20, 2015 at 7:11 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
> Julian Margetson <runaway@candw.ms> writes:
>
>> On 12/19/2015 4:41 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>>
>>>> On Sat, Dec 19, 2015 at 10:16 PM, Julian Margetson <runaway@candw.=
ms> wrote:
>>>>> On 12/19/2015 3:07 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>> Julian Margetson <runaway@candw.ms> writes:

>> [   18.606292] dma dma0chan0: dwc_tx_submit: queued 2
>> [   18.611091] dma dma0chan0: dwc_dostart_first_queued: started 2
>> [   48.748614] ata3: lost interrupt (Status 0x40)
>
> Now we're getting somewhere.  The dma transfer is set up and initiate=
d,
> but then nothing happens.  Comparing the old sata_dwc driver, from
> before the switch to dmaengine, with the dw_dma driver, I noticed an
> obvious problem: the descriptors are filled in using the wrong byte
> order.

So, it means we have IO in little endian, but DMA reads data from
memory in big endian?

>  This patch might fix that.

In case it works I have to test it on AVR32.

--=20
With Best Regards,
Andy Shevchenko
