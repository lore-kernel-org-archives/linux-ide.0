From: Mark Lord <liml@rtr.ca>
Subject: Re: libata EH appears to be NFG up to 2.6.17 (at least).
Date: Thu, 06 Jul 2006 16:51:33 -0400
Message-ID: <44AD77D5.90905@rtr.ca>
References: <44AD749C.1070208@rtr.ca> <44AD76CA.40100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2491 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750835AbWGFUvg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jul 2006 16:51:36 -0400
In-Reply-To: <44AD76CA.40100@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Ric Wheeler <ric@emc.com>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Got your attention now?  Good!
>>
>> I am doing some testing with known-bad drives on 2.6.16 (and 2.6.17).
>>
>> Libata EH is wretched there, because it does not seem to be careful
>> about reading/saving the bad ata_status value when an error occurs.
>>
>> The ata_status from a failed/aborted command is first read in
>> the interrupt handler, either by the LLD or by ata_host_intr().
>>
>> This value is not saved for reuse anywhere, and the next time it is read,
>> the reader will see ATA_ERR==0, and then not do the Right Thing (tm).
>>
>> Who reads it next, you ask?  Well, it gets read *again* from libata-scsi
>> when it is trying to generate meaningful sense data.  But at that point,
>> all that is seen is 0x50 -- "success".
>>
>> So libata-scsi returns incorrect (or no) sense data to the SCSI 
>> mid-layer,
>> and the error is mishandled or ignored.
>>
>> Ugh.  The distro folks will probably want to fix this in their 2.6.1[56]
>> based distro kernels.  I don't yet see a way to do this without modifying
>> core data structures (eg. adding an ata_status field to the qc).
> 
> What driver?
> What architecture?
> What kernel config?
> How does 2.6.18-rc1, with vastly different EH, behave?

All drivers, all architectures.  Dunno about 2.6.18-rc1 yet.

This patch (below) appears to fix it, but I really need your opinion
on its correctness.  My apologies in advance for the likely bad whitespace,
as I don't currently have access to my usual patch-mailer at present.

Enable libata-scsi to report correct sense data on errors.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---
--- linux/drivers/scsi/libata-scsi.c.orig       2006-06-19 10:37:03.000000000 -0400
+++ linux/drivers/scsi/libata-scsi.c    2006-07-06 16:46:42.000000000 -0400
@@ -554,6 +554,12 @@
        qc->ap->ops->tf_read(qc->ap, tf);

        /*
+        * Restore the error bit (which got cleared when the
+        * interrupt handler first read the ata_status
+        */
+       if (qc->err_mask)
+               tf->command |= ATA_ERR;
+       /*
         * Use ata_to_sense_error() to map status register bits
         * onto sense key, asc & ascq.
         */

