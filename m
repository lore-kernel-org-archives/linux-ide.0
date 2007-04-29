From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-acpi: fix _GTF command protocol for ATAPI devices
Date: Sun, 29 Apr 2007 11:51:27 +0900
Message-ID: <4634082F.4030603@gmail.com>
References: <20070422170646.GM10619@htj.dyndns.org> <46339824.5000107@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:36285 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbXD2CwY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2007 22:52:24 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1593680nzf
        for <linux-ide@vger.kernel.org>; Sat, 28 Apr 2007 19:52:23 -0700 (PDT)
In-Reply-To: <46339824.5000107@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> _GTF command is never ATA_PROT_ATAPI_NODATA whether the device is
>> ATAPI or not.  It's always ATA_PROT_NODATA.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>  drivers/ata/libata-acpi.c |    3 +--
>>  1 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
>> index 03a0acf..cb3eab6 100644
>> --- a/drivers/ata/libata-acpi.c
>> +++ b/drivers/ata/libata-acpi.c
>> @@ -489,8 +489,7 @@ static void taskfile_load_raw(struct ata_port *ap,
>>  
>>      /* convert gtf to tf */
>>      tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE; /* TBD */
>> -    tf.protocol = atadev->class == ATA_DEV_ATAPI ?
>> -        ATA_PROT_ATAPI_NODATA : ATA_PROT_NODATA;
>> +    tf.protocol = ATA_PROT_NODATA;
> 
> Elaboration?
> 
> ATA_PROT_ATAPI_NODATA is the ATAPI version of the non-data protocol, so
> this change is unexpected.

ATA_PROT_ATAPI_NODATA is used for PACKET command without CDB.  ACPI _GTF
never contains PACKET command.  It's always ATA commands.  So, without
the change, it basically ends up issuing an ATA command than tries to
transmit non-existent CDB and gets a HSM violation.

-- 
tejun
