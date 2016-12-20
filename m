From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH 1/1] libata: Fix ATA request sense
Date: Tue, 20 Dec 2016 11:25:16 +0900
Message-ID: <400289c7-67df-6286-25a7-5b4bc0a39494@wdc.com>
References: <1482110260-14551-1-git-send-email-damien.lemoal@wdc.com>
 <ebce119d-032f-8580-ba62-a389a121858c@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1861 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbcLTCZY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2016 21:25:24 -0500
In-Reply-To: <ebce119d-032f-8580-ba62-a389a121858c@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>



On 12/19/16 21:19, Sergei Shtylyov wrote:
> Hello!
> 
> On 12/19/2016 4:17 AM, Damien Le Moal wrote:
> 
>> For an ATA device supporting the sense data reporting feature set,
>> a failed command will trigger the execution of ata_eh_request_sense if
>> the result task file of the failed command has the ATA_SENSE bit set
>> (sense data available bit). ata_eh_request_sense executes the
>> REQUEST SENSE DATA EXT command to retrieve the sense data of the failed
>> command. On success of REQUEST SENSE DATA EXT, the ATA_SENSE bit will
>> NOT be set (the command succeeded) but ata_eh_request_sense
>> nevertheless tests the availability of sense data by testing that bit
>> presence in the result tf of the REQUEST SENSE DATA EXT command.
>> This leads to a falsy assume that request sense data failed and to the
> 
>     False assumption?

"This leads to falsely assume that..."

My apologies for the typo.

> 
>> warning message:
>>
>> atax.xx: request sense failed stat 50 emask 0
>>
>> Upon success of REQUEST SENSE DATA EXT, set the ATA_SENSE bit in the
>> result task file command so that sense data can be returned by
>> ata_eh_request_sense.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> [...]
> 
> MBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
