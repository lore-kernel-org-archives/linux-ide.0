From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Laptop shock detection and harddisk protection
Date: Wed, 17 Sep 2008 17:21:01 +0200
Message-ID: <87d4j2ol2a.fsf@denkblock.local>
References: <48C7FCEE.8060404@kernel.org>
	<41840b750809110908o54a61f55w7b1b9793abf55634@mail.gmail.com>
	<48C948A6.3080404@kernel.org> <877i9ipi56.fsf@denkblock.local>
	<20080817195103.GD4043@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:59298 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbYIQPVL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Sep 2008 11:21:11 -0400
In-Reply-To: <20080817195103.GD4043@ucw.cz> (Pavel Machek's message of "Sun,
	17 Aug 2008 21:51:03 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, Shem Multinymous <multinymous@gmail.com>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
>> Short of a satisfying proposition regarding the questions raised, I just
>> want to add two things that would be nice to solve in the future one way
>> or another and should perhaps be taken into consideration from the
>> beginning:
>> 
>> 1. Disable polling completely when it isn't required: once the hd has
>>    spun down, there is no need to keep polling the sensors at all. Only
>>    when the first request requiring the hd to spin up arrives, the
>>    kernel needs to hold back for a short while to gather enough data
>>    from the sensors, so shock protection is up and running again.
>
> hdparm can already tell if disk is spinning or not. As userland is
> polling, already, that may be enough?

Yes, I know it *is* possible, I just think it may not be completely
trivial to get it right. The only way I can think of, right now, is some
sort of polling in the hdparm way, i.e. issuing a ATA_CMD_CHK_POWER from
time to time. The question is how we are to decide when and how often we
should poll for the current power state of the HD.

>
>> 2. Make shock protection interact nicely with suspend operations:
>>    currently, we are out of luck if anything should happen after
>>    processes have been frozen. This is particularly unfortunatel in the
>>    case of s2disk.
>
> I'd say that s2disk is similar to early boot... no protection there. 

Well, this is true for resume. However, I can't help thinking that we
may do better than that until the disk spins down, particularly while
writing the image to disk.

Regards,

Elias
