From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Pls help for LibATA caused kernel temporary hung.
Date: Mon, 28 Jun 2010 23:11:19 -0600
Message-ID: <4C298077.6070102@gmail.com>
References: <AANLkTinbQHdo40Drqc5Ydur5lCrAktHHDig45HDrC6s1@mail.gmail.com>	<4C2777D3.1050208@gmail.com>	<AANLkTim-sAoDmNDqlM4k8WKeQJ0mTcxcm1VyO968BQZC@mail.gmail.com>	<4C28653E.4080908@garzik.org> <AANLkTikwbBANkzepCW1XwbfSi3vvuq8iJNtG0WAZByDV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46704 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab0F2FLY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2010 01:11:24 -0400
Received: by iwn7 with SMTP id 7so805968iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 28 Jun 2010 22:11:21 -0700 (PDT)
In-Reply-To: <AANLkTikwbBANkzepCW1XwbfSi3vvuq8iJNtG0WAZByDV@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Li <simon.jiyou@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On 06/28/2010 03:09 AM, Simon Li wrote:
> We don't expect kernel goes to temporary hung, any ideas for the fix?

It depends what you mean by hanging. Usually if a drive is stuck trying 
to read a bad sector it will take quite a while before it gives up, and 
during that period all disk access is stalled. The kernel normally 
retries several times as well. If a bunch of applications are needing to 
access the disk, they'll appear to be hung up during this process.

>
>
> On Mon, Jun 28, 2010 at 5:02 PM, Jeff Garzik<jeff@garzik.org>  wrote:
>> On 06/28/2010 03:38 AM, Simon Li wrote:
>>>
>>> May 25 15:55:06 shctc-xq-ems22-me18 kernel: ata3: status=0x25 {
>>> DeviceFault CorrectedError Error }
>>
>>> May 25 15:59:59 shctc-xq-ems22-me18 kernel: ata3: status=0x25 {
>>> DeviceFault CorrectedError Error }
>>
>>> Jun  2 10:54:06 shctc-xm-ems21-me18 kernel: ata2: status=0x25 {
>>> DeviceFault CorrectedError Error }
>>
>>> Jun  2 10:54:08 shctc-xm-ems21-me18 kernel: ata2: status=0x25 {
>>> DeviceFault CorrectedError Error }
>>
>>> Jun  2 10:54:18 shctc-xm-ems21-me18 kernel: ata2: status=0x25 {
>>> DeviceFault CorrectedError Error }
>>
>> Your hardware is returning errors, which libata is dutifully reporting...
>>
>>         Jeff
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

