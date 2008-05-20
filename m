From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream-fixes] git tree available
Date: Tue, 20 May 2008 13:28:11 +0900
Message-ID: <4832535B.1080505@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com> <006501c8ba19$c1f53340$6917a8c0@parents> <48323E4F.3050806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:42662 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbYETE2S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2008 00:28:18 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1815012rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 21:28:18 -0700 (PDT)
In-Reply-To: <48323E4F.3050806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Brian & Chamaigne Scamman <scammanbc@earthlink.net>, jeff@garzik.org, linux-ide@vger.kernel.org

Mark Lord wrote:
> Brian & Chamaigne Scamman wrote:
>> Tejun-
>>
>> The hotplug fixes didn't solve the problem. After adding some "logic
>> monitoring" statements, I found that the successful discovery of the 
>> drives
>> depends on the response from sil24_exec_polled_cmd.
>>
>> If the call from ata_wait_register is 327680, the drives are 
>> recognized; if
>> the response is 262144 the drives have timed out.
>>
>> I've also noticed that the drives respond to the EH entering with DevExch
>> vs. PHY RDY changed.
>>
>> Bottom line, the drives seem to be recognized almost every time I attach
>> them to the PMP after the EH has completed processing the empty PMP.  
>> If the
>> drives are attached to the PMP before the PMP is attached to the 
>> controller,
>> the drives are almost never recognized (EH times out).

Can you please describe what you did exactly?  sil3726/4726 has some 
problems when its first fan out port goes online and offline while it's 
powered up.  You want to keep it occupied at all times.

Also, does putting sslep(5) right before followup-SRST help?

> hp-polling is beginning to look better and better..  again.  :)

hp-polling wouldn't really help here.  What's failing is not hotplug 
event detection, the reset protocol is failing.

-- 
tejun
