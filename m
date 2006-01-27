From: Tejun <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: fix MAP VALUE interpretation for for ICH6/7
Date: Fri, 27 Jan 2006 16:35:21 +0900
Message-ID: <43D9CD39.7000209@gmail.com>
References: <20051218081707.GA4129@htj.dyndns.org> <43D98C23.4040004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:51739 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932423AbWA0Hf2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2006 02:35:28 -0500
Received: by zproxy.gmail.com with SMTP id 34so546968nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 23:35:27 -0800 (PST)
In-Reply-To: <43D98C23.4040004@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Unlike their older siblings, ICH6 and 7 use different scheme for MAP
>> VALUE.  This patch makes ata_piix interpret MV properly on ICH6/7.
>>
>> Pre-ICH6/7
>>
>>  The value of these bits indicate the address range the SATA port
>>  responds to, and whether or not the SATA and IDE functions are
>>  combined.
>>
>>  000 = Non-combined. P0 is primary master. P1 is secondary master.
>>  001 = Non-combined. P0 is secondary master. P1 is primary master.
>>  100 = Combined. P0 is primary master. P1 is primary slave. P-ATA is
>>        2:0 Map Value secondary.
>>  101 = Combined. P0 is primary slave. P1 is primary master. P-ATA is
>>        secondary.
>>  110 = Combined. P-ATA is primary. P0 is secondary master. P1 is
>>        secondary slave.
>>  111 = Combined. P-ATA is primary. P0 is secondary slave. P1 is
>>        secondary master.
>>
>> ICH6/7
>>
>>  Map Value - R/W. Map Value (MV): The value in the bits below indicate
>> the address range the SATA ports responds to, and whether or not the
>> PATA and SATA functions are combined. When in combined mode, the AHCI
>> memory space is not available and AHCI may not be used.
>>
>>  00 = Non-combined. P0 is primary master, P2 is the primary slave. P1
>>       is secondary master, P3 is the 1:0 secondary slave (desktop
>>       only). P0 is primary master, P2 is the primary slave (mobile
>>       only).
>>  01 = Combined. IDE is primary. P1 is secondary master, P3 is the
>>       secondary slave. (desktop only)
>>  10 = Combined. P0 is primary master. P2 is primary slave. IDE is 
>> secondary
>>  11 = Reserved
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> applied to upstream-2.6.17.  patch looks OK, but only testing on 
> ICH5+6+7 will really convince me.  Documentation has often been confused 
> before, and the only data I've received from you is "it works for me." 
> So, proceeding with caution :)
> 

I'll follow up with test results next week.

-- 
tejun
