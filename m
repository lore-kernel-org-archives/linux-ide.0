From: Grant Grundler <grundler@google.com>
Subject: Re: NCQ high speed data integrity issues
Date: Thu, 17 Dec 2009 10:16:24 -0800
Message-ID: <da824cf30912171016w3e8c64a3vd604aa8103fd9068@mail.gmail.com>
References: <93b143da0912151129obdf3613q558295b320e4db65@mail.gmail.com>
	 <da824cf30912151247r14c4e29cp6c97421683d82eb2@mail.gmail.com>
	 <93b143da0912162249q2b439537hb9d18dae00359d38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:39742 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934027AbZLQSQ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 13:16:29 -0500
Received: from spaceape24.eur.corp.google.com (spaceape24.eur.corp.google.com [172.28.16.76])
	by smtp-out.google.com with ESMTP id nBHIGR14013513
	for <linux-ide@vger.kernel.org>; Thu, 17 Dec 2009 10:16:28 -0800
Received: from fg-out-1718.google.com (fgg16.prod.google.com [10.86.7.16])
	by spaceape24.eur.corp.google.com with ESMTP id nBHIGON9017783
	for <linux-ide@vger.kernel.org>; Thu, 17 Dec 2009 10:16:25 -0800
Received: by fg-out-1718.google.com with SMTP id 16so1334069fgg.5
        for <linux-ide@vger.kernel.org>; Thu, 17 Dec 2009 10:16:24 -0800 (PST)
In-Reply-To: <93b143da0912162249q2b439537hb9d18dae00359d38@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Porat <dan.porat@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Dec 16, 2009 at 10:49 PM, Dan Porat <dan.porat@gmail.com> wrote:
> Variyng the speed - using usleep.
>
> bpt is a parameter but when used over sd , it seems to be ignored somehow , and
> transfers have variating sizes.
>
> regarding the data - since the problem is a timing issues or
> synchronization issue , it does not always appear.
> The disk is written with the same character and when read , using
> sgp_dd , sometimes , some data is just different.

To track this down, "good" vs "bad" data needs to be presented such
that one can compare alignment and size of "bad" data.

> We know for sure that the data is written correctly as it sometimes
> does succeed to read all successfully.

Does the data appear correctly if it is re-read from the disk?
ie read once and see bad data. Then read again. Still bad?

> No errors are to be seen in kernel level , and definitely not in the
> application side.

Good. Rules out a large amount of code.

hth,
grant

>
> We have seen that the more threads there are , the more likely this
> problem to occur.
> Same as the amount of data.
> The bigger the data , the more likely for us to see the problem.
>
> Any suggestion how to investigate ?
>
>
> Dan Porat
>
> On Tue, Dec 15, 2009 at 10:47 PM, Grant Grundler <grundler@google.com> wrote:
>>
>> On Tue, Dec 15, 2009 at 11:29 AM, Dan Porat <dan.porat@gmail.com> wrote:
>> > I am running into data integrity issues while running sgp_dd ver 1.20
>> > against any sg device while running 31 threads.
>> > kernel 2.6.28 Ubuntu.
>> > When running it in slow speed (20 MB/s) all runs well.
>> > When pushing it towards the 50MB/s , Data integrity issues appear.
>>
>> How are you varying the speed?
>>
>> > When running it against sd devices - no integrity issues , but bpt is
>> > not determined and changes .
>>
>> Hrm? bpt is a parameter. What do you mean?
>>
>> I don't know offhand why sg vs sd would make a difference but it's
>> obviously of interest.
>>
>> > Any idea how to fix the sg data integrity issues?
>>
>> Can you post Good vs Bad data?
>> Knowing the offset, size, and type of corruption will help narrow down
>> possible sources of corruption.
>>
>> Any errors reported by the device driver, memory controller, sg device?
>>
>> cheers,
>> grant
>
