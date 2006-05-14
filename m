From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Sun, 14 May 2006 10:20:17 +0900
Message-ID: <446685D1.4030607@gmail.com>
References: <11473536871340-git-send-email-htejun@gmail.com> <44665AAB.7000806@pobox.com> <44666D98.1000503@gmail.com> <44668249.9000004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.197]:45250 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932448AbWENBU0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 21:20:26 -0400
Received: by wx-out-0102.google.com with SMTP id i29so351125wxd
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 18:20:25 -0700 (PDT)
In-Reply-To: <44668249.9000004@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> +struct ata_ering {
>>>> +    int            cursor;
>>>> +    int            size;
>>>> +    struct ata_ering_entry    ring[];
>>>> +};
>>>> +
>>>> +#define DEFINE_ATA_ERING(name, size)    \
>>>> +    struct ata_ering    name;    \
>>>> +    struct ata_ering_entry    name_entries[size];
>>>
>>> ACK, but this is creeping dangerously close to C abuse :)
>>>
>>> This sort of code will confuse debuggers and source checkers.
>>>
>>
>> Well, as ering is currently used in only one place and it will stay in 
>> libata in the future, it might be better to remove the macro and shove 
>> the allocation into where it's used; however, I prefer the macro 
>> because it's safer and I don't use any debuggers or source checkers.
>>
>> Linux source has lots of cpp macros like above and IMHO the above 
>> doesn't even rank among C abuses.  lxr and sparse would be fine.
> 
> I doubt you'll find another example of this at all.  The reason why its 
> abuse is that the declaration and use are subtlely different.  In the 
> above, the C compiler is free to insert padding between 'name' and 
> 'name_entries'.
> 
> Other counterpoints:
> 
> * Its important to support other people's use of debuggers and source 
> checkers.

Agreed.

> * I disagree that the macro is safer, simply because we are having this 
> conversation :)  An allocation is easier to understand and less prone to 
> subtle breakage.
>
> This is the trap of the 0-element array:  its handy for avoiding an 
> additional allocation, but if you look all over the kernel at its real 
> world uses (including SCSI and libata), you'll see a hodgepodge of ugly 
> casting, varied approaches, and yet similar bug patterns.

With your comment about padding above, I'm a bit confused.  No matter 
whether we put the name_entries in the macro or in struct ata_device, 
the compiler is free to insert padding inbetween.  That's how 
zero/flexible-length array is supposed to be used.  The only thing 
guaranteed is that there will be enough space to store the array 
members.  Accessing the storage area directly will result in disaster. 
I consider it one another convention to learn about the great C.

The alternatives here are...

* leave it as it is
* shove ering_entry allocation into ering (fixed size is ATM)
* shove ering_entry allocation into ata_device

I'll take any of above.  It's your call.

-- 
tejun
