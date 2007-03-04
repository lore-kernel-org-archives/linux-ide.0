From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: (round 5) add support for ATA_16 on ATAPI
Date: Sun, 04 Mar 2007 15:31:39 -0500
Message-ID: <45EB2CAB.10308@rtr.ca>
References: <45C376F1.5060103@rtr.ca> <45E8C1C4.4050104@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1553 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbXCDUbl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Mar 2007 15:31:41 -0500
In-Reply-To: <45E8C1C4.4050104@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> Mark Lord wrote:
....
>> +    if (scsi_op == ATA_16 && dev->class == ATA_DEV_ATAPI && 
>> !ata16_passthru)
>> +        max_len = 16;
>> +    else
>> +        max_len = dev->cdb_len;
>> + +    if (unlikely(!scmd->cmd_len || scmd->cmd_len > max_len)) {
>> +         DPRINTK("bad CDB len=%u, max=%u\n",
>> +             scmd->cmd_len, max_len);
> 
> looks like a chompified patch (double '+')

Yup.  Chompified.  There used to be a blank line above that one.
I must have hit enter or something while editing the email.

Will resend.
...
>> +    xlat_func = ata_get_xlat_func(dev, scsi_op);
>> +    if (xlat_func)
>> +        rc = ata_scsi_translate(dev, scmd, done, xlat_func);
>> +    else
>> +        ata_scsi_simulate(dev, scmd, done);
>>     return rc;
> 
> 
> this looks like a bug?  ata_scsi_simulate() should not be called for 
> ATAPI devices.

Notabug.  ata_get_xlat_func will always return either atapi_xlat
or ata_scsi_pass_thru for ATAPI devices.

Cheers
