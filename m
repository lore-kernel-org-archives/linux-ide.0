From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA Bus Error with ICH7R and WDC WD7500AAKS-0
Date: Sun, 13 Apr 2008 11:29:12 +0900
Message-ID: <48016FF8.2050908@gmail.com>
References: <47F38841.9080300@tidaldata.com> <20080402145628.c1eab7cb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:46434 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbYDMC3U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 22:29:20 -0400
Received: by wa-out-1112.google.com with SMTP id m16so1393848waf.23
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 19:29:20 -0700 (PDT)
In-Reply-To: <20080402145628.c1eab7cb.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chaitanya Huilgol <chaitanya@tidaldata.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> (cc linux-ide)
> 
> On Wed, 02 Apr 2008 18:51:05 +0530
> Chaitanya Huilgol <chaitanya@tidaldata.com> wrote:
> 
>> Hi,
>>
>> I am getting frequent 'ATA bus error' with ICH7R & WD7500AAKS-0.
>> I have tried the following combinations of NCQ and Write Cache disabled,
>> Write I/O is done with dd:
>> dd if=/dev/zero of=/dev/sdc bs=1048576
>>
>> (1) With Write Cache is Disabled and NCQ is enabled then the
>> errors are seen immediately on starting I/O
>> (2) With Write Cache enabled and NCQ enabled the errors are less frequent
>> (3) With NCQ disabled using "echo 1 >/sys/block/sdc/device/queue_depth"
>> the errors are rare but do occur.
>>
>> I have tried with different SATA Cables & Sata port combinations to
>> rule out cable/bad port issues.
>>
>> I am wondering if the WDC WD7500AAKS-0 is another candidate for NCQ blacklist?

PHY RDY changed is likely to indicate hardware problems.  Especially so 
on ICH ahci's which is one of the best supported and tested.  Can you 
please re-seat cable and move the harddrive to different power connector?

-- 
tejun
