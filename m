From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] libata: Fix ATA request sense
Date: Fri, 6 Jan 2017 15:44:16 -0500
Message-ID: <20170106204416.GC29909@mtj.duckdns.org>
References: <1482110260-14551-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35977 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbdAFUoY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jan 2017 15:44:24 -0500
Received: by mail-qk0-f195.google.com with SMTP id a20so11225140qkc.3
        for <linux-ide@vger.kernel.org>; Fri, 06 Jan 2017 12:44:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1482110260-14551-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

On Mon, Dec 19, 2016 at 10:17:40AM +0900, Damien Le Moal wrote:
> For an ATA device supporting the sense data reporting feature set,
> a failed command will trigger the execution of ata_eh_request_sense if
> the result task file of the failed command has the ATA_SENSE bit set
> (sense data available bit). ata_eh_request_sense executes the
> REQUEST SENSE DATA EXT command to retrieve the sense data of the failed
> command. On success of REQUEST SENSE DATA EXT, the ATA_SENSE bit will
> NOT be set (the command succeeded) but ata_eh_request_sense
> nevertheless tests the availability of sense data by testing that bit
> presence in the result tf of the REQUEST SENSE DATA EXT command.
> This leads to a falsy assume that request sense data failed and to the
> warning message:
> 
> atax.xx: request sense failed stat 50 emask 0
> 
> Upon success of REQUEST SENSE DATA EXT, set the ATA_SENSE bit in the
> result task file command so that sense data can be returned by
> ata_eh_request_sense.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Applied to libata/for-4.10-fixes with patch description updated as
suggested by Sergei.

Thanks.

-- 
tejun
