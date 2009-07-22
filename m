From: KueiHuan Chen <kueihuan.chen@gmail.com>
Subject: Re: Marvell 7042 has some problem on Marvell 6281(kirkwood) platform
	(Resent)
Date: Wed, 22 Jul 2009 19:56:12 +0800
Message-ID: <788014650907220456n149ea406s8dc1d1acf78c2650@mail.gmail.com>
References: <788014650907211910j443d4d31y88001319acf8c1d4@mail.gmail.com>
	 <4A667F40.8060309@pobox.com>
	 <788014650907220004l7367c2cfwc42f88282bfa02f6@mail.gmail.com>
	 <c70ff3ad0907220127o3891b886k88e8bf43e22f9e38@mail.gmail.com>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:48585 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbZGVL4N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jul 2009 07:56:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so177434and.1
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2009 04:56:12 -0700 (PDT)
In-Reply-To: <c70ff3ad0907220127o3891b886k88e8bf43e22f9e38@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, saeed@marvell.com, linux-ide@vger.kernel.org

Hi Saeed,

  There is no any chance to read the PCIe register from user space.
Because when it happens, system is just like hang without any
response. The only chance is to modify it in the drivers. If you want
to see some special register, you can tell me, i would modify the
driver to print it out. Below is the last register information from
devmem2.

  Sorry for we don't have other PCIe device to test.  And this issue
would happens when using the Marvell BSP 4.2.2. The result is all the
same as sata_mv.c (Dead in deactivateEdma, keep looping with the
MV_SATA_UNRECOVERABLE_COMMUNICATION_ERROR event)

Thanks.
------------------
Value at address 0x22000 (0x40000000): 0x28126
Value at address 0x24000 (0x40000000): 0x41ED
Value at address 0x26000 (0x40000000): 0xE1A00000
Value at address 0x28000 (0x40000000): 0xE1A01008
------------------------
Value at address 0x22030 (0x40000030): 0x280D7
Value at address 0x24030 (0x40000030): 0x50803
Value at address 0x26030 (0x40000030): 0xEB09FE5F
Value at address 0x28030 (0x40000030): 0x12FFF10

=2E.. cannot deactivate Edma .. keep looping.

Best Regards,
KueiHuan-Chen



2009/7/22 saeed bishara <saeed.bishara@gmail.com>:
> Hi,
> looks to me something wrong happened in PCIe link level, and any
> register read ends up with 0xFFFFFFFF. can you please use devmem2 too=
l
> and read any register (e.g. 0x22000) of the device?
>
> also, can you test any other PCIe device?
>
> does this issue happens when using the Marvell BSP 4.2.2?
> saeed
>
> On Wed, Jul 22, 2009 at 10:04 AM, KueiHuan Chen<kueihuan.chen@gmail.c=
om> wrote:
>> Dear Mark & Saeed,
>>
>> 2009/7/22 Mark Lord <mlord@pobox.com>:
>>>
>>> Are you using a discrete 7042 chip on a PCIe bus
>>> along with a 6281 chip ??
>>> Or are you simply using the built-in SATA controller inside the 628=
1 ?
>>>
>>
>> =C2=A0 We use a standalone 7042 chip on a PCIe bus with 6281 platfor=
m. And
>> we choose four channels from 7042 to build a software raid 5. We had
>> experimented that even though we disable the sata channels of 6281
>> soc, the problem is still remain.
>>
>>> In either event, Marvell did not deem to share *any* technical info
>>> about the 6281 with me, so I really cannot help you.
>>>
>>> Saeed Bishara from Marvell did everything to do with that chip.
>>>
>>>
>>> ..
>>>
>>> I think the messages that happened before those above are the impor=
tant
>>> ones,
>>> and you did not show those messages here.
>>
>> =C2=A0There is no any messages before the "unable to disable eDMA". =
=C2=A0It
>> just freeze for a while and then output these messages. I had tried =
to
>> use the sata driver from Marvell BSP driver 4.2.2. The problem is th=
e
>> same. The BSP are also cannot disable eDMA. =C2=A0Then we unmount th=
is chip
>> from that board and remount it into the other platform(powerpc). It
>> works fine without any problem ... So we suspicion the problem may d=
ue
>> to 7042 work on 6281 platform.
>>
>> =C2=A0If you have any ideas , please kindly tell us. We would try it=
 !
>>
>> Thanks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
