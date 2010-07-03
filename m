From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH v2]ata:ahci.c Fix warning: comparison between 'enum <anonymous>'
 and 'enum <anonymous>'
Date: Sat, 03 Jul 2010 07:32:10 -0700
Message-ID: <4C2F49EA.8070201@gmail.com>
References: <1277879827-18233-1-git-send-email-justinmattock@gmail.com> <4C2AE8FE.3020409@kernel.org> <4C2AED03.7070103@gmail.com> <4C2AEE2A.8060405@kernel.org> <4C2AF088.2080609@gmail.com> <4C2F099D.1080806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62369 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0GCObm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jul 2010 10:31:42 -0400
Received: by pwi5 with SMTP id 5so977469pwi.19
        for <linux-ide@vger.kernel.org>; Sat, 03 Jul 2010 07:31:42 -0700 (PDT)
In-Reply-To: <4C2F099D.1080806@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On 07/03/2010 02:57 AM, Tejun Heo wrote:
> Hello,
>
> On 06/30/2010 09:21 AM, Justin P. Mattock wrote:
>>> What does the extra warning buy us?  There are several places which
>>> use anonymous enums for constants and I can't see what the benefit of
>>> this warning would be.
>>
>> I don't think it buys us anything..think it's just saying "hey
>> you have two #defines with the same value" or something in that
>> area(if Im reading the warning correctly) funny thing is, is
>> gcc should of done the same with the original patch that I
>> sent, as well as the second..  (but could be wrong).
>
> Okay, just tested and it's warning that the code is comparing two
> enums which are from two different enum blocks.  I'm kind of
> doubtful about its usefulness but then again I don't think there
> will be many occassions of this to be problematic either.  For
> now, can you please submit a patch to cast just ATA_MAX_QUEUE
> to (int) before comparing and short comment explanining why it's
> necessary?
>
> Thanks.
>

o.k., just sent a patch subject is:
Fix warning: comparison between 'enum <anonymous>' and 'enum <anonymous>'
hopefully it's doing what you had asked it to do i.g. send
ATA_MAX_QUEUE to int.

let me know if it needs to be resent or anything.

Justin P. Mattock
