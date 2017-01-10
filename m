From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH 1/1] libata: Fix ATA request sense
Date: Tue, 10 Jan 2017 09:54:44 +0900
Message-ID: <4ecc1395-3ac9-3381-3a90-b8fb58b46923@wdc.com>
References: <1482110260-14551-1-git-send-email-damien.lemoal@wdc.com>
 <20170106204416.GC29909@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21297 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032762AbdAJAyz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2017 19:54:55 -0500
In-Reply-To: <20170106204416.GC29909@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>


Tejun,

On 1/7/17 05:44, Tejun Heo wrote:
> On Mon, Dec 19, 2016 at 10:17:40AM +0900, Damien Le Moal wrote:
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
>> warning message:
>>
>> atax.xx: request sense failed stat 50 emask 0
>>
>> Upon success of REQUEST SENSE DATA EXT, set the ATA_SENSE bit in the
>> result task file command so that sense data can be returned by
>> ata_eh_request_sense.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Applied to libata/for-4.10-fixes with patch description updated as
> suggested by Sergei.

Thank you.

Should we send this patch to stable too ?
This bug does break applications on kernels 4.7 to 4.9 (e.g. libzbc test
suite and many tools we have using SGIO to directly send ATA commands to
SATA disks). I suspect sg-utils and hdparm may be affected in some way too.

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
