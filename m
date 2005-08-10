From: Mark Lord <liml@rtr.ca>
Subject: Re: libata for SATA HDs.
Date: Tue, 09 Aug 2005 22:28:04 -0400
Message-ID: <42F96634.6040308@rtr.ca>
References: <42EEA9D5.5080304@superbug.demon.co.uk> <42F8B264.5010706@rtr.ca> <42F8EE0B.7000706@superbug.demon.co.uk> <20050809180411.GD10315@havoc.gtf.org> <42F92DE7.9070301@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:57351 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964884AbVHJC2E
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 22:28:04 -0400
In-Reply-To: <42F92DE7.9070301@superbug.demon.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

>>>> Yes, but only if you manually apply the "libata-passthru" patch.
>>>
>>> So, why hasn't that patch got into the kernel?
>>
>> Because there are several reports of it causing problems, when used on a
>> loaded system.

Please post more information about these "problems".

I wonder if it might be another occurance of the libata eh lockups.
Those are NOT unique to ATAPI -- the lockups can happen anytime
the libata eh code is run, like on a busy RAID, or "loaded system"
suffering failed "passthru" commands.

Perhaps kill a couple of birds with one stone, if we're lucky.

So far, the one-liner from Tejun Heo (below) is holding steady here,
but it needs to soak for another day before I pronounce it "cured".

Cheers!


diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -385,6 +385,7 @@ int ata_scsi_error(struct Scsi_Host *hos
          * appropriate place
          */
         host->host_failed--;
+       INIT_LIST_HEAD(&host->eh_cmd_q);

         DPRINTK("EXIT\n");
         return 0;
