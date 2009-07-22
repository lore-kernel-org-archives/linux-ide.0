From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: Marvell 7042 has some problem on Marvell 6281(kirkwood) platform
	(Resent)
Date: Wed, 22 Jul 2009 15:09:56 +0300
Message-ID: <c70ff3ad0907220509j4c5be2a4r1d384c570b37a318@mail.gmail.com>
References: <788014650907211910j443d4d31y88001319acf8c1d4@mail.gmail.com>
	 <4A667F40.8060309@pobox.com>
	 <788014650907220004l7367c2cfwc42f88282bfa02f6@mail.gmail.com>
	 <c70ff3ad0907220127o3891b886k88e8bf43e22f9e38@mail.gmail.com>
	 <788014650907220456n149ea406s8dc1d1acf78c2650@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:7826 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbZGVMJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jul 2009 08:09:57 -0400
Received: by fg-out-1718.google.com with SMTP id e21so43411fga.17
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2009 05:09:56 -0700 (PDT)
In-Reply-To: <788014650907220456n149ea406s8dc1d1acf78c2650@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khchen@synology.com
Cc: Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, saeed@marvell.com, linux-ide@vger.kernel.org

>
> =C2=A0Sorry for we don't have other PCIe device to test. =C2=A0And th=
is issue
> would happens when using the Marvell BSP 4.2.2. The result is all the
> same as sata_mv.c (Dead in deactivateEdma, keep looping with the
> MV_SATA_UNRECOVERABLE_COMMUNICATION_ERROR event)
can you add stack_dump at this point?
>
> Thanks.
> ------------------
> Value at address 0x22000 (0x40000000): 0x28126
> Value at address 0x24000 (0x40000000): 0x41ED
> Value at address 0x26000 (0x40000000): 0xE1A00000
> Value at address 0x28000 (0x40000000): 0xE1A01008
> ------------------------
> Value at address 0x22030 (0x40000030): 0x280D7
> Value at address 0x24030 (0x40000030): 0x50803
> Value at address 0x26030 (0x40000030): 0xEB09FE5F
> Value at address 0x28030 (0x40000030): 0x12FFF10

I was looking for  register at 0x22000 of the device, the physical
address should be the base address of the device (check /proc/iomem) +
0x22000.
>
> ... cannot deactivate Edma .. keep looping.
>
> Best Regards,
> KueiHuan-Chen
>
>
>
> 2009/7/22 saeed bishara <saeed.bishara@gmail.com>:
>> Hi,
>> looks to me something wrong happened in PCIe link level, and any
>> register read ends up with 0xFFFFFFFF. can you please use devmem2 to=
ol
>> and read any register (e.g. 0x22000) of the device?
>>
>> also, can you test any other PCIe device?
>>
>> does this issue happens when using the Marvell BSP 4.2.2?
>> saeed
>>
>> On Wed, Jul 22, 2009 at 10:04 AM, KueiHuan Chen<kueihuan.chen@gmail.=
com> wrote:
>>> Dear Mark & Saeed,
>>>
>>> 2009/7/22 Mark Lord <mlord@pobox.com>:
>>>>
>>>> Are you using a discrete 7042 chip on a PCIe bus
>>>> along with a 6281 chip ??
>>>> Or are you simply using the built-in SATA controller inside the 62=
81 ?
>>>>
>>>
>>> =C2=A0 We use a standalone 7042 chip on a PCIe bus with 6281 platfo=
rm. And
>>> we choose four channels from 7042 to build a software raid 5. We ha=
d
>>> experimented that even though we disable the sata channels of 6281
>>> soc, the problem is still remain.
>>>
>>>> In either event, Marvell did not deem to share *any* technical inf=
o
>>>> about the 6281 with me, so I really cannot help you.
>>>>
>>>> Saeed Bishara from Marvell did everything to do with that chip.
>>>>
>>>>
>>>> ..
>>>>
>>>> I think the messages that happened before those above are the impo=
rtant
>>>> ones,
>>>> and you did not show those messages here.
>>>
>>> =C2=A0There is no any messages before the "unable to disable eDMA".=
 =C2=A0It
>>> just freeze for a while and then output these messages. I had tried=
 to
>>> use the sata driver from Marvell BSP driver 4.2.2. The problem is t=
he
>>> same. The BSP are also cannot disable eDMA. =C2=A0Then we unmount t=
his chip
>>> from that board and remount it into the other platform(powerpc). It
>>> works fine without any problem ... So we suspicion the problem may =
due
>>> to 7042 work on 6281 platform.
>>>
>>> =C2=A0If you have any ideas , please kindly tell us. We would try i=
t !
>>>
>>> Thanks!
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ide=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>>
>>
>
