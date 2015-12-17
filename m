From: Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Thu, 17 Dec 2015 13:57:19 -0400
Message-ID: <5672F77F.4010306@candw.ms>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
 <yw1x1tanffqg.fsf@unicorn.mansr.com>
 <1450364395.30729.136.camel@linux.intel.com>
 <yw1x60zxds5k.fsf@unicorn.mansr.com>
 <1450367702.30729.146.camel@linux.intel.com>
 <yw1xk2odcb87.fsf@unicorn.mansr.com>
 <1450371184.30729.175.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp618.redcondor.net ([208.80.206.18]:37240 "EHLO
	smtp618.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbbLQSHo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2015 13:07:44 -0500
In-Reply-To: <1450371184.30729.175.camel@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/17/2015 12:53 PM, Andy Shevchenko wrote:
> On Thu, 2015-12-17 at 16:04 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>
>>> On Thu, 2015-12-17 at 15:13 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>>>
>>>>> On Tue, 2015-12-15 at 23:34 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>> Mans Rullgard <mans@mansr.com> writes:
>>>>>>
>>>>>>> Currently this driver only works with a DesignWare DMA
>>>>>>> engine
>>>>>>> which it registers manually using the second "reg" address
>>>>>>> range and interrupt number from the DT node.
>>>>>>>
>>>>>>> This patch makes the driver instead use the "dmas" property
>>>>>>> if
>>>>>>> present, otherwise optionally falling back on the old way
>>>>>>> so
>>>>>>> existing device trees can continue to work.
>>>>>>>
>>>>>>> With this change, there is no longer any reason to depend
>>>>>>> on
>>>>>>> the 460EX machine type so drop that from Kconfig.
>>>>>>>
>>>>>>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>>>>>>> ---
>>>>>>>   drivers/ata/Kconfig          |  10 ++-
>>>>>>>   drivers/ata/sata_dwc_460ex.c | 192
>>>>>>> +++++++++++++++++++++++++++--
>>>>>>> --------------
>>>>>>>   2 files changed, 131 insertions(+), 71 deletions(-)
>>>>>> The corresponding patch for the canyonlands devicetree looks
>>>>>> something
>>>>>> like this.  I don't have any such hardware or even a manual,
>>>>>> so I
>>>>>> don't
>>>>>> know what values to use for the various required DT
>>>>>> properties of
>>>>>> the
>>>>>> DMA controller node, nor can I test it.  The SATA driver
>>>>>> works
>>>>>> with a
>>>>>> different DMA controller on a Sigma Designs chip.
>>>>>>
>>>>>> diff --git a/arch/powerpc/boot/dts/canyonlands.dts
>>>>>> b/arch/powerpc/boot/dts/canyonlands.dts
>>>>>> index 3dc75de..959f36e 100644
>>>>>> --- a/arch/powerpc/boot/dts/canyonlands.dts
>>>>>> +++ b/arch/powerpc/boot/dts/canyonlands.dts
>>>>>> @@ -190,12 +190,22 @@
>>>>>>   					 /* DMA */ 0x2 &UIC0
>>>>>> 0xc
>>>>>> 0x4>;
>>>>>>   		};
>>>>>>  =20
>>>>>> +		DMA0: dma@bffd0800 {
>>>>>> +			compatible =3D "snps,dma-spear1340";
>>>>>> +			reg =3D <4 0xbffd0800 0x400>;
>>>>>> +			interrupt-parent =3D <&UIC3>;
>>>>>> +			interrupts =3D <0x5 0x4>;
>>>>>> +			#dma-cells =3D <3>;
>>>>>> +			/* required properties here */
>>>>> You have to move the master assignments and other custom
>>>>> dw_dmac
>>>>> properties. Maybe at some point I will fix that in
>>>>> dw/platform.c.
>>>>>
>>>>>> +		};
>>>> The current sata_dwc driver calls dw_dma_probe() with null pdata
>>>> which causes the dw_dma driver to auto-detect most
>>>> parameters.  It
>>>> looks like simply omitting those properties here results in the
>>>> same
>>>> thing, although in this case dw_dma_parse_dt() leaves a
>>>> devm-allocated pdata struct adrift.  Deferring the allocation of
>>>> that
>>>> and changing the DT binding doc to make these properties optional
>>>> for
>>>> auto-detect-capable hardware should just work.
>>> Yeah, I would like to allow autoconfiguration in case of DT as well
>>> and
>>> translate it to use unified device property API.
>>>
>>>> Something like this:
>>> If it works for you, please, submit as a patch. Thanks.
>> I can't test it since I have no such hardware.
> It's currently broken, last person who seems to have it is
> (was?) Julian Margetson [1]
>
> [1] https://patchwork.ozlabs.org/patch/439850/
>
I have been running my machine mostly configured for pciex1  thus with=20
the sata_dwc disabled.
The changes to sata_dwc-460ex do cause an oops.
I will try to give more detailed info over this weekend .


