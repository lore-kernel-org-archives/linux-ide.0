From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: fix ata_qc_issue failure path
Date: Sat, 01 Apr 2006 03:41:14 +0900
Message-ID: <442D77CA.5060805@gmail.com>
References: <20060331113647.GD13172@htj.dyndns.org> <442D47C8.8030609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:42164 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750881AbWCaSlW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 13:41:22 -0500
Received: by zproxy.gmail.com with SMTP id o37so999692nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 10:41:21 -0800 (PST)
In-Reply-To: <442D47C8.8030609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello, Jeff.

Jeff Garzik wrote:
> Tejun Heo wrote:
>> On sg_err failure path, ata_qc_issue() doesn't mark the qc active
>> before returning.  This triggers WARN_ON() in __ata_qc_complete() when
>> the qc gets completed.  This patch moves ap->active_tag and
>> QCFLAG_ACTIVE setting to the top of the function.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> applied 1-2, but two comments:
> 
> * this patch widens the race window for the remaining unlocked uses of 
> ATA_QCFLAG_ACTIVE

Hmmm.. the only unloked use of ATA_QCFLAG_ACTIVE I could find was in 
pio_task and later patches will tighten that up. Any other places?

> * in the current code, its questionable whether ATA_QCFLAG_ACTIVE has 
> much value.  The flag may have more value after your EH work, but its 
> not terribly important in the current #upstream.

Yeap, ap->active_tag always coincides with ATA_QCFLAG_ACTIVE. And, yeah, 
it gets more important especially with NCQ as then we have two different 
mechanism to indicate active commands from the port (ap->active_tag and 
ap->sactive), so ATA_QCFLAG_ACTIVE is quite handy as aggregate test 
condition.

Thanks.

-- 
tejun
