From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata bugfix: preserve LBA bit for HDIO_DRIVE_TASK
Date: Sun, 01 Apr 2007 02:05:13 +0900
Message-ID: <460E94C9.1040509@gmail.com>
References: <20070330205938.984247529@mini.kroah.org> <20070330210659.GK29450@kroah.com> <460D8510.1050102@pobox.com> <460DD725.1040607@gmail.com> <460E9294.3020005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753500AbXCaRFW@vger.kernel.org>
In-Reply-To: <460E9294.3020005@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
>>> Ideally, this would go into linux-2.6.21.
>>>
>>> Preserve the LBA bit in the DevSel/Head register for HDIO_DRIVE_TASK.
>>>
>>> Signed-off-by:  Mark Lord <mlord@pobox.com>
>>> ---
>>> --- linux/drivers/ata/libata-scsi.c.orig    2007-03-21
>>> 13:35:02.000000000 -0400
>>> +++ linux/drivers/ata/libata-scsi.c    2007-03-30 17:40:58.000000000 
>>> -0400
>>> @@ -333,7 +333,7 @@
>>>     scsi_cmd[8]  = args[3];
>>>     scsi_cmd[10] = args[4];
>>>     scsi_cmd[12] = args[5];
>>> -    scsi_cmd[13] = args[6] & 0x0f;
>>> +    scsi_cmd[13] = args[6] & 0x4f;
>>>     scsi_cmd[14] = args[0];
>>>
>>>     /* Good values for timeout and retries?  Values below
>>
>> IDE seems to be just overriding devsel (0x10) and leaving the rest
>> alone.  Maybe we should do (args[6] & ~0x10) here?  Or is it safer 
>> this way?
> 
> Same thoughts here.  I went "conservative" on this one,
> because the entire field has been all zeros until this patch,
> and I didn't want to trigger any possible latent bugs in libata.
> 
> Whatever.

Yeah, I agree 'whatever' should work here.  :-)

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
