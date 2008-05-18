From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Sun, 18 May 2008 14:23:13 +0900
Message-ID: <482FBD41.7020604@gmail.com>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca> <482DBC5C.3020904@rtr.ca> <482DC41F.9080901@rtr.ca> <482DCD1F.4090503@rtr.ca> <482EE9E1.5000805@gmail.com> <482F16AB.1040003@rtr.ca> <482F1B5C.2000006@gmail.com> <482F2F1C.9030102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:6671 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbYERFXU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 01:23:20 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1153235waf.23
        for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 22:23:19 -0700 (PDT)
In-Reply-To: <482F2F1C.9030102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>>
>> * sil3124/32 and mv4140 combination for some reason can't do NCQ
>>   reliably.  I don't know why.  I'll blacklist it for the time being
>>   and contact both companies about this.
> ..
> 
> MMm... I wonder if it's the "don't mix NCQ with non-NCQ" issue there ?
> 
> I'll ping my Marvell folks about that one too.

Hmm... I don't think so.  It happens when all pending commands are NCQ.

-- 
tejun
