From: Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Sat, 19 Dec 2015 13:09:07 -0400
Message-ID: <56758F33.20804@candw.ms>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
 <567302E8.5050303@candw.ms> <yw1x7fkcdi2a.fsf@unicorn.mansr.com>
 <5673061A.4070700@candw.ms> <yw1x37v0df86.fsf@unicorn.mansr.com>
 <56732C04.9040100@candw.ms> <yw1xvb7wbowu.fsf@unicorn.mansr.com>
 <5673F277.2050607@candw.ms> <yw1xegekarp9.fsf@unicorn.mansr.com>
 <1450441395.30729.203.camel@linux.intel.com>
 <yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
 <yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
 <yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
 <yw1xlh8r9wkm.fsf@unicorn.mansr.com>
 <CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
 <567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
 <CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
 <yw1xwpsa8j2x.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp687.redcondor.net ([208.80.206.87]:36390 "EHLO
	smtp687.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbbLSRJe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2015 12:09:34 -0500
In-Reply-To: <yw1xwpsa8j2x.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/19/2015 1:05 PM, M=E5ns Rullg=E5rd wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
>> On Sat, Dec 19, 2015 at 5:40 PM, M=E5ns Rullg=E5rd <mans@mansr.com> =
wrote:
>>
>>> OK, I've found something.  The dma setup errors are benign, caused =
by
>>> the driver calling dmaengine_prep_slave_sg() even for non-dma
>>> operations.
>> I suppose the following is a quick fix to avoid preparing descriptor
>> for non-DMA operations (not tested anyhow)
>>
>> a/drivers/ata/sata_dwc_460ex.c
>> +++ b/drivers/ata/sata_dwc_460ex.c
>> @@ -1041,6 +1041,9 @@ static void sata_dwc_qc_prep_by_tag(struct
>> ata_queued_cmd *qc, u8 tag)
>>                  __func__, ap->port_no, get_dma_dir_descript(qc->dma=
_dir),
>>                   qc->n_elem);
>>
>> +       if (!is_slave_direction(qc->dma_dir))
>> +               return;
>> +
>>          desc =3D dma_dwc_xfer_setup(qc);
>>          if (!desc) {
>>                  dev_err(ap->dev, "%s: dma_dwc_xfer_setup returns NU=
LL\n",
> I already have a better patch sitting here.
>
>>> The real error is the lock recursion that's reported
>>> later.  I wasn't seeing it since I was running a UP non-preempt ker=
nel.
>>> With lock debugging enabled, I get the same error.  This patch shou=
ld
>>> fix it.
>>> -       spin_lock_irqsave(&ap->host->lock, flags);
>>>          hsdevp->cmd_issued[tag] =3D cmd_issued;
>>> -       spin_unlock_irqrestore(&ap->host->lock, flags);
>>> +
>> This will create a second empty line, though I don't care it is so m=
inor.
> The patch leaves one blank line before the following block comment.  =
I
> think it looks better that way.
>

Still can't get the patch applied .

