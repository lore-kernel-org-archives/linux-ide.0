Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4952C433F5
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 07:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiBGHQ3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352032AbiBGHCw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2022 02:02:52 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB8C043181
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 23:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644217372; x=1675753372;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=O4CjwtBpGd+oA/jr6KuHKZREJV0m4CNghltVzWL1VcU=;
  b=Mruk3AYyKOKzsRK6w4kJ5NFKt9h7s4s7dIlJwbaCNwrhYK+oicFvU/RJ
   bTvDWRMWEcvjS1qgAuGc+UAdZSHBUvd6y+UBjZ3teGes0S46m/Ad2NjZa
   7dyCl8Ze4yAqt4rjmJ00MHIpPL3NycEPC8cVsjnfBdj/Dny6nhw1aHLrH
   4O1skzrjNMXv2DsdSDQ28EwFxlxuEundyQHMRK7VtQzjBIGYmkOHFbEoh
   Z+VJYticAzFlXALh+EqgOrW87E3K/h105PrUFCI2JtTW5Ac675vzcxXvW
   uxscpiPWdxWWaNl8h14X2F7D7oFMQdCbHeSeaTdhP9gtsD+Hn7TxWOh0V
   w==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="193289943"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 15:02:51 +0800
IronPort-SDR: 1VwCLZN/Mss431LO+ye6v+80m1Uvmb1YrWa+sqQAGDqymgjv7fzGVN3nnRWdGpuXxZl0NV+pH5
 eSnLoEMWvqyoU3Biq3DzVD88SvFc9DSQUI/tpxewvMkVYPDINdl1eGDdhvr695BU+X/Us4cNcG
 Oh2yeEt+Ryb9yZgz1x2P2btic9QNi00qo2q+1sC+LzqZ53oSETzYMz9l5WDFjKl89ki4eUmm7P
 a1d4u5TWXieyOv5bu1R6eDAyH/WVmORExSsgOLqqMJ5v1Qe1uehC7rtKEjf7tGoJuw/vNSZnXc
 y3gSyE2UGINzJGAqCjgkaxY0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:35:52 -0800
IronPort-SDR: SJeGbWAeVEd8Ixs+Sw8QnX/JoncJGq0lmwAKo2IddANCmOs6R0CbBe3zlGTrPVcetBC23k1C23
 xCo7geOvyTGD9q6KvXxiSMZ+pwZLfeT2xQIT0rXHj9vlZubuJ58jYKaBdGVnlRe82X1Upa+kqR
 vFP6hhdI4J7CNTKSvTVt7qEtMW9S5Pm8bodMz7CB+/yZXYyq3LUneIR1+/nIaVBUXJ4itY6ldZ
 OVQai5esVL+u3Y53eVNJURbAzrvXdaG9lwfGvysqDLY+TatFkGU0lJ3AfLnWJ2lNvGHET0iNwt
 wSM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 23:02:50 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JscXp3hncz1SHwl
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 23:02:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644217370; x=1646809371; bh=O4CjwtBpGd+oA/jr6KuHKZREJV0m4CNghlt
        VzWL1VcU=; b=GR0/36pdsbT0204QGKClv0uE6iYqU/i9XcOWZ8rQD6lpg5X+D4+
        bt6gGozU3jzxHtTRk4obV0WNUiAV2ZnTUSSKX2s6GHgJH2Nm8uNQCykegTazCrsd
        OH/ytQgRAPF//q5tHawy/huJkdRg1syhcKfIbYeVd+m7cGpmfhZ6JYO9f2fUWPHJ
        dSzwe68FUFt1gZ03OcHa5dG9KQKhJl6k3TdBJ0WiB7+gmSLXqahzIRRf3k57MTe8
        aFRl49wuRlFhYlbYP0naPlgMxcRQMd3j0qMIhWb4lkbH62plI90MhedyKkfAna7j
        EKUHkfadf5K2dzDcETqKH772PLv9BkhbUjw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2NYBCoSLaJgt for <linux-ide@vger.kernel.org>;
        Sun,  6 Feb 2022 23:02:50 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JscXn4pZsz1Rwrw;
        Sun,  6 Feb 2022 23:02:49 -0800 (PST)
Message-ID: <28712d9a-f2d7-7c75-5a85-0e243cfb1f5d@opensource.wdc.com>
Date:   Mon, 7 Feb 2022 16:02:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: libata-core: Fix ata_dev_config_cpr()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20220207031616.944994-1-damien.lemoal@opensource.wdc.com>
 <e07372be-3bb5-ad24-1014-2f4d9f59dc62@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e07372be-3bb5-ad24-1014-2f4d9f59dc62@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/7/22 15:50, Hannes Reinecke wrote:
> On 2/7/22 04:16, Damien Le Moal wrote:
>> The concurrent positioning ranges log page 47h is a general purpose log
>> page and not a subpage of the indentify device log. Using
>> ata_identify_page_supported() to test for concurrent positioning ranges
>> support is thus wrong. ata_log_supported() must be used.
>> This invalid test created boot problems for several users in the field.
>>
>> While at it, strengthen the detection for concurrent positioning ranges
>> support by limiting the detection to drives implementing a recent ATA
>> standard, that is, ACS-4 (major version 11) or later ACS versions. This
>> additional condition effectively turns ata_dev_config_cpr() into a nop,
>> avoiding problems in the field with older drives.
>>
>> Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215519
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>   drivers/ata/libata-core.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Thanks, but I sent a v3 with an update to include/linux/ata.h. Review OK
on that one ?

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
