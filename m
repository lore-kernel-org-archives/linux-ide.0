From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Why is only one command issue per time in AHCI driver?
Date: Thu, 13 Jan 2011 23:47:48 -0600
Message-ID: <4D2FE384.4090405@gmail.com>
References: <AANLkTin5=NiZn6ZWZ=r-XS0v_Utrf6dpTb_YzCay-PJM@mail.gmail.com>	<4D2F3A86.3010503@garzik.org> <AANLkTikV-VWpy0XKpMUvurp86dRAOWUUNEQP5OkvfCso@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47338 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab1ANFru (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2011 00:47:50 -0500
Received: by iyj18 with SMTP id 18so2216228iyj.19
        for <linux-ide@vger.kernel.org>; Thu, 13 Jan 2011 21:47:50 -0800 (PST)
In-Reply-To: <AANLkTikV-VWpy0XKpMUvurp86dRAOWUUNEQP5OkvfCso@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?576F56eJ6Yie?= <luobingjiun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On 01/13/2011 07:06 PM, =E7=BE=85=E7=A7=89=E9=88=9E wrote:
> Hi,
>
> Yes, what I see is every time scsi_request_fn is called, we can only =
pop
> up one request to be dispatched. So, How can we make block layer to
> pass more than one commands to us? So that we can fill up more
> commands into the Command List before write Px.CI. I think it might
> shorten the command interval time.
>
> Even I enable the NCQ, I observed that there is only one command to b=
e
> executed per time and tag 0 is used.

That sounds like the I/O pattern doesn't result in any concurrent=20
transfers being executed. What kind of workload is this running?

>
> Is there any possible to change the libata and ahci.c to be able to f=
ire up
> more than one commands at one time and report complete multiple to
> upper layer(SCSI and block layer).
>
> Another question, at scsi_adjust_queue_depth() function, why sdev->or=
dered_tags
> and sdev->simple_tags value is only 0 or 1 regardless of queue_depth?=
 What
> does it mean?
>
> Thank you in advance for your explanation.
>
>
>
> On Fri, Jan 14, 2011 at 1:46 AM, Jeff Garzik<jeff@garzik.org>  wrote:
>> On 01/13/2011 05:52 AM, =E7=BE=85=E7=A7=89=E9=88=9E wrote:
>>>
>>> Hello,
>>>
>>> Inside ahci_qc_issue() function, I see that driver always write one=
 bit
>>> to Px.CI register even enable the NCQ.
>>>
>>> AHCI allows to fire 32 commands at one time and AHCI driver also
>>> claims itself able to queue up to 31 commands.
>>>
>>> Inside ahci.c :
>>> static struct scsi_host_template ahci_sht =3D {
>>>         ATA_NCQ_SHT(DRV_NAME),
>>>         .can_queue              =3D AHCI_MAX_CMDS - 1,
>>> ............
>>>
>>> Why upper layer(Block or SCSI layer) does not fill up as many as po=
ssible
>>> commands into Command List before sending the commands out
>>> (Write to Px.CI register)?
>>
>> The driver successfully executes up to 31 commands at a time, in par=
alle.
>>
>> We submit one command at a time to hardware because the block layer =
passes
>> commands to us one at a time.
>>
>>         Jeff
>>
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

