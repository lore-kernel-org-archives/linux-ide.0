From: Mark Lord <liml@rtr.ca>
Subject: Re: libata total system lockup fix
Date: Wed, 10 Aug 2005 10:16:23 -0400
Message-ID: <42FA0C37.6070605@rtr.ca>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <42F8C8D0.2010603@pobox.com> <42F94242.6090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:26376 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S965124AbVHJOQ0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Aug 2005 10:16:26 -0400
In-Reply-To: <42F94242.6090402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

>> I'm back from holiday now, and will try your one-liner
>> in place of the more complex patch I had been using.

Okay, the one-liner eh fix for libata appears to prevent
the lockups here, so I will continue using it from now on
in place of the earlier more complex patch.

And it looks "obviously correct" too, a Good Thing (tm).

Jeff:   This one should go out ASAP.

Tejun:  I'm short on time to soak the other larger patch,
as the problem occurs only on my primary notebook PC,
and I really need it for "real (paid) work" now.

Cheers
--
Mark Lord


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
