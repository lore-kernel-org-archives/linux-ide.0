From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Fri, 24 Sep 2010 17:26:56 -0600
Message-ID: <4C9D33C0.8050900@gmail.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com> <4C9C44D0.1030409@teksavvy.com> <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com> <4C9CA385.5090709@teksavvy.com> <4C9CA673.4090104@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33563 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0IXX07 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2010 19:26:59 -0400
Received: by iwn5 with SMTP id 5so2763419iwn.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Sep 2010 16:26:58 -0700 (PDT)
In-Reply-To: <4C9CA673.4090104@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Seed <seedrubbish@gmail.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 09/24/2010 07:24 AM, Mark Lord wrote:
> On 10-09-24 09:11 AM, Mark Lord wrote:
>> On 10-09-24 03:01 AM, Seed wrote:
>>> On Fri, Sep 24, 2010 at 4:27 PM, Mark Lord<kernel@teksavvy.com> wrote:
>>>> The bug seems to be in the libahci code somewhere.
>>>
>>> ahci_qc_fill_rtf seems to be the function converting FIS to result_tf.
>> ..
>>
>> Yeah, that's as far as I got with it last night.
>> If you apply this patch (below), it makes the problem more "obvious",
>> though I still don't see exactly how that struct gets updated.
>>
>> --- a/drivers/ata/libahci.c 2010-09-24 02:40:24.722887047 -0400
>> +++ b/drivers/ata/libahci.c 2010-09-24 09:10:21.761520099 -0400
>> @@ -1838,6 +1838,7 @@
>> d2h_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
>>
>> ata_tf_from_fis(d2h_fis, &qc->result_tf);
>> + memset(d2h_fis, 0xfd, AHCI_RX_FIS_SZ);
>> return true;
>> }
>>
> ..
>
> And here's an example of the bug, which should work (as a demo)
> for most folks out there with the same controller ahci / JMB360:
>
> Here, I'll use hdparm to do a "set acoustic" command
> on a drive which does NOT have the "Acoustic Management" feature set.
> Just look for the fd fd fd strings in the returned data,
> and notice how the final IDENTIFY at the end works, but returns
> bad ATA status 0x51 from the stale result_tf:

The d2h_fis area is supposed to be updated by the controller with the 
last FIS received from the device. Maybe this controller just isn't 
doing that for some reason?
