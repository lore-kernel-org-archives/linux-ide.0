From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Thu, 11 Jun 2009 11:10:57 +0900
Message-ID: <4A3067B1.3010907@gmail.com>
References: <20090520065942.GD11363@kernel.dk> <20090520070038.GE11363@kernel.dk> <4A2FCD2D.3040205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f178.google.com ([209.85.216.178]:44467 "EHLO
	mail-px0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbZFKCTI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2009 22:19:08 -0400
Received: by pxi8 with SMTP id 8so104820pxi.33
        for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2009 19:19:10 -0700 (PDT)
In-Reply-To: <4A2FCD2D.3040205@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Jens Axboe wrote:
>> libata currently has a pretty dumb ATA_MAX_QUEUE loop for finding
>> a free tag to use. Instead of fixing that up, convert libata to
>> using block layer tagging - gets rid of code in libata, and is also
>> much faster.
>>
>> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
>> ---
>>  drivers/ata/libata-core.c |   65
>> ++++----------------------------------------
>>  drivers/ata/libata-scsi.c |   23 ++++++++++++++-
>>  drivers/ata/libata.h      |   19 ++++++++++++-
>>  include/linux/libata.h    |    1 -
>>  4 files changed, 44 insertions(+), 64 deletions(-)
> 
> Patch looks good to me, with regards (a) simplex, (b) master/slave, (c)
> non-queued and (d) NCQ.  I'm not confident about the PMP case, but if
> Tejun is happy, I guess I can go ahead and queue these...

Unfortunately, I'm not quite happy yet. :-) Jens, any progress on
this?

Thanks.

-- 
tejun
