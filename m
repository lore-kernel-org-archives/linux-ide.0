From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/1] libata: Fix ATA request sense
Date: Tue, 20 Dec 2016 13:22:58 +0300
Message-ID: <2325edac-26c8-ac0e-20d3-80d26f4bb642@cogentembedded.com>
References: <1482110260-14551-1-git-send-email-damien.lemoal@wdc.com>
 <ebce119d-032f-8580-ba62-a389a121858c@cogentembedded.com>
 <400289c7-67df-6286-25a7-5b4bc0a39494@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36585 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934708AbcLTKXB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Dec 2016 05:23:01 -0500
Received: by mail-lf0-f51.google.com with SMTP id t196so72909838lff.3
        for <linux-ide@vger.kernel.org>; Tue, 20 Dec 2016 02:23:00 -0800 (PST)
In-Reply-To: <400289c7-67df-6286-25a7-5b4bc0a39494@wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <damien.lemoal@wdc.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

On 12/20/2016 5:25 AM, Damien Le Moal wrote:

>>> For an ATA device supporting the sense data reporting feature set,
>>> a failed command will trigger the execution of ata_eh_request_sense if
>>> the result task file of the failed command has the ATA_SENSE bit set
>>> (sense data available bit). ata_eh_request_sense executes the
>>> REQUEST SENSE DATA EXT command to retrieve the sense data of the failed
>>> command. On success of REQUEST SENSE DATA EXT, the ATA_SENSE bit will
>>> NOT be set (the command succeeded) but ata_eh_request_sense
>>> nevertheless tests the availability of sense data by testing that bit
>>> presence in the result tf of the REQUEST SENSE DATA EXT command.
>>> This leads to a falsy assume that request sense data failed and to the
>>
>>     False assumption?
>
> "This leads to falsely assume that..."

    "Leads us to falsely assume" then, maybe?

> My apologies for the typo.

MBR, Sergei

