From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE-TAPE NULL terminate strings.
Date: Tue, 23 Sep 2008 13:29:17 +0400
Message-ID: <48D8B6ED.6020407@ru.mvista.com>
References: <20080921185138.GA16310@localhost> <48D79ABD.8060805@ru.mvista.com> <9ea470500809220656j6dfcf4c9q7a5a4185481ec994@mail.gmail.com> <20080922204129.GA3495@localhost> <48D80949.4080901@ru.mvista.com> <20080923074845.GB5656@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:31269 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750732AbYIWJ30 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Sep 2008 05:29:26 -0400
In-Reply-To: <20080923074845.GB5656@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Mark de Wever <koraq@xs4all.nl>, Gadi Oxman <gadio@netvision.net.il>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>l

Hello.

Borislav Petkov wrote:

>>> Only not sure whether the static is the best solution, the following
>>> patch also works, by zeroing the memory as you suggested.
>>>
>>> Signed-off-by: Mark de Wever <koraq@xs4all.nl>
>>>
>>> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
>>> index 1bce84b..c41f5b1 100644
>>> --- a/drivers/ide/ide-tape.c
>>> +++ b/drivers/ide/ide-tape.c
>>> @@ -2338,7 +2338,7 @@ static void idetape_get_inquiry_results(ide_drive_t *drive)
>>>  {
>>>  	idetape_tape_t *tape = drive->driver_data;
>>>  	struct ide_atapi_pc pc;
>>> -	char fw_rev[6], vendor_id[10], product_id[18];
>>> +	char fw_rev[6] = {'\0'}, vendor_id[10] = {'\0'}, product_id[18] = {'\0'};
>>>   
>>>       
>>   Do you realize how much *absolutely unnecessary* code will this bring  
>> in? This is certainly worse than your initial patch (if it was correct).
>>     
>
> Yep, Sergei's right. Both of our patches are dumb.
>
>   
>> Ugh, looks like I'll have t submit the patch myself to stop this ugliness...
>>     
>
> Is this what you had in mind?
>   

   Sure.

WBR, Sergei


