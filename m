From: Simon Li <simon.jiyou@gmail.com>
Subject: Re: Pls help for LibATA caused kernel temporary hung.
Date: Tue, 29 Jun 2010 15:10:16 +0800
Message-ID: <AANLkTimnoyjEVTmorcPD_Ph9TDjNo33jz7qcwEE0z6-2@mail.gmail.com>
References: <AANLkTinbQHdo40Drqc5Ydur5lCrAktHHDig45HDrC6s1@mail.gmail.com>
	<4C2777D3.1050208@gmail.com>
	<AANLkTim-sAoDmNDqlM4k8WKeQJ0mTcxcm1VyO968BQZC@mail.gmail.com>
	<4C28653E.4080908@garzik.org>
	<AANLkTikwbBANkzepCW1XwbfSi3vvuq8iJNtG0WAZByDV@mail.gmail.com>
	<4C298077.6070102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42497 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab0F2HKQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2010 03:10:16 -0400
Received: by pwj8 with SMTP id 8so3679658pwj.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Jun 2010 00:10:16 -0700 (PDT)
In-Reply-To: <4C298077.6070102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

We observed that all the processes on the blade are totally stuck,
though only one process is actually accessing the disks, other
processes are mostly CPU-consuming applications.


On Tue, Jun 29, 2010 at 1:11 PM, Robert Hancock <hancockrwd@gmail.com> =
wrote:
> On 06/28/2010 03:09 AM, Simon Li wrote:
>>
>> We don't expect kernel goes to temporary hung, any ideas for the fix=
?
>
> It depends what you mean by hanging. Usually if a drive is stuck tryi=
ng to
> read a bad sector it will take quite a while before it gives up, and =
during
> that period all disk access is stalled. The kernel normally retries s=
everal
> times as well. If a bunch of applications are needing to access the d=
isk,
> they'll appear to be hung up during this process.
>
>>
>>
>> On Mon, Jun 28, 2010 at 5:02 PM, Jeff Garzik<jeff@garzik.org> =A0wro=
te:
>>>
>>> On 06/28/2010 03:38 AM, Simon Li wrote:
>>>>
>>>> May 25 15:55:06 shctc-xq-ems22-me18 kernel: ata3: status=3D0x25 {
>>>> DeviceFault CorrectedError Error }
>>>
>>>> May 25 15:59:59 shctc-xq-ems22-me18 kernel: ata3: status=3D0x25 {
>>>> DeviceFault CorrectedError Error }
>>>
>>>> Jun =A02 10:54:06 shctc-xm-ems21-me18 kernel: ata2: status=3D0x25 =
{
>>>> DeviceFault CorrectedError Error }
>>>
>>>> Jun =A02 10:54:08 shctc-xm-ems21-me18 kernel: ata2: status=3D0x25 =
{
>>>> DeviceFault CorrectedError Error }
>>>
>>>> Jun =A02 10:54:18 shctc-xm-ems21-me18 kernel: ata2: status=3D0x25 =
{
>>>> DeviceFault CorrectedError Error }
>>>
>>> Your hardware is returning errors, which libata is dutifully report=
ing...
>>>
>>> =A0 =A0 =A0 =A0Jeff
>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
