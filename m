From: BingJiun Luo <luobingjiun@gmail.com>
Subject: Re: Why is only one command issue per time in AHCI driver?
Date: Mon, 17 Jan 2011 09:19:25 +0800
Message-ID: <AANLkTi=XTAor01G0V+uH=-JJBGsK=N8=S9_eOh_ae-di@mail.gmail.com>
References: <AANLkTin5=NiZn6ZWZ=r-XS0v_Utrf6dpTb_YzCay-PJM@mail.gmail.com>
	<4D2F3A86.3010503@garzik.org>
	<AANLkTikV-VWpy0XKpMUvurp86dRAOWUUNEQP5OkvfCso@mail.gmail.com>
	<4D2FE384.4090405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43392 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab1AQBT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Jan 2011 20:19:27 -0500
Received: by wwa36 with SMTP id 36so4929627wwa.1
        for <linux-ide@vger.kernel.org>; Sun, 16 Jan 2011 17:19:26 -0800 (PST)
In-Reply-To: <4D2FE384.4090405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

I am just thinking how to make commands interval time shorter to have b=
etter
performance.

Meanwhile, there is an NCQ feature in SATA specification and block laye=
r also
support tagging, but why we can not utilize this functionality because =
always
only one command is sent out per time and the tag number is zero even e=
nable
NCQ.

Regards,
BingJiun

On Fri, Jan 14, 2011 at 1:47 PM, Robert Hancock <hancockrwd@gmail.com> =
wrote:
> On 01/13/2011 07:06 PM, =C3=B9=AA=C3=B6v wrote:
>>
>> Hi,
>>
>> Yes, what I see is every time scsi_request_fn is called, we can only=
 pop
>> up one request to be dispatched. So, How can we make block layer to
>> pass more than one commands to us? So that we can fill up more
>> commands into the Command List before write Px.CI. I think it might
>> shorten the command interval time.
>>
>> Even I enable the NCQ, I observed that there is only one command to =
be
>> executed per time and tag 0 is used.
>
> That sounds like the I/O pattern doesn't result in any concurrent tra=
nsfers
> being executed. What kind of workload is this running?
>
>>
>> Is there any possible to change the libata and ahci.c to be able to =
fire
>> up
>> more than one commands at one time and report complete multiple to
>> upper layer(SCSI and block layer).
>>
>> Another question, at scsi_adjust_queue_depth() function, why
>> sdev->ordered_tags
>> and sdev->simple_tags value is only 0 or 1 regardless of queue_depth=
? What
>> does it mean?
>>
>> Thank you in advance for your explanation.
>>
>>
>>
>> On Fri, Jan 14, 2011 at 1:46 AM, Jeff Garzik<jeff@garzik.org>  wrote=
:
>>>
>>> On 01/13/2011 05:52 AM, =C3=B9=AA=C3=B6v wrote:
>>>>
>>>> Hello,
>>>>
>>>> Inside ahci_qc_issue() function, I see that driver always write on=
e bit
>>>> to Px.CI register even enable the NCQ.
>>>>
>>>> AHCI allows to fire 32 commands at one time and AHCI driver also
>>>> claims itself able to queue up to 31 commands.
>>>>
>>>> Inside ahci.c :
>>>> static struct scsi_host_template ahci_sht =3D {
>>>>        ATA_NCQ_SHT(DRV_NAME),
>>>>        .can_queue              =3D AHCI_MAX_CMDS - 1,
>>>> ............
>>>>
>>>> Why upper layer(Block or SCSI layer) does not fill up as many as
>>>> possible
>>>> commands into Command List before sending the commands out
>>>> (Write to Px.CI register)?
>>>
>>> The driver successfully executes up to 31 commands at a time, in pa=
ralle.
>>>
>>> We submit one command at a time to hardware because the block layer
>>> passes
>>> commands to us one at a time.
>>>
>>>        Jeff
>>>
>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
