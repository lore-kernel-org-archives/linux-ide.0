From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/5] libata: consistently use msecs for time durations
Date: Tue, 20 May 2008 13:03:23 +0900
Message-ID: <48324D8B.7060709@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>	<12112174751988-git-send-email-htejun@gmail.com> <873aodx6qc.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:29656 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYETED3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2008 00:03:29 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1605150wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 21:03:28 -0700 (PDT)
In-Reply-To: <873aodx6qc.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca

Elias Oltmanns wrote:
> Tejun Heo <htejun@gmail.com> wrote:
>> libata has been using mix of jiffies and msecs for time druations.
>> This is getting confusing.  As writing sub HZ values in jiffies is
>> PITA and msecs_to_jiffies() can't be used as initializer, unify unit
>> for all time durations to msecs.  So, durations are in msecs and
>> deadlines are in jiffies.  ata_deadline() is added to compute deadline
>> from a start time and duration in msecs.
>>
>> While at it, drop now superflous _msec suffix from arguments and
>> rename @timeout to @deadline if it represents a fixed point in time
>> rather than duration.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> [...]
>> +static inline unsigned long ata_deadline(unsigned long from_jiffies,
>> +					 unsigned long timeout_msecs)
> 							      ^^^^^^
> Wouldn't that be against the newly adopted convention? Just a thought.

Yeah, but as the function takes both jiffies and msecs, I thought it 
would be better to make it explicit.  Hmmm... I can't really decide 
which way would be better.

-- 
tejun
