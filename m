From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream] sata_sil24: always set protocol override for
 non-ATAPI data commands
Date: Sat, 22 Aug 2009 11:25:26 -0400
Message-ID: <4A900DE6.2020802@rtr.ca>
References: <4A71FE71.7040002@gmail.com> <4A8F88CC.1000406@gmail.com> <4A8FFA9A.2020904@rtr.ca> <4A8FFC8A.1000500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:53753 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451AbZHVPZW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Aug 2009 11:25:22 -0400
In-Reply-To: <4A8FFC8A.1000500@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

Jeff Garzik wrote:
> On 08/22/2009 10:03 AM, Mark Lord wrote:
>> Robert Hancock wrote:
>>> On 07/30/2009 02:11 PM, Robert Hancock wrote:
>>>> The sil24 hardware has a built-in list of commands and associated
>>>> protocols
>>>> that gets used by default to decide how to handle a given command.
>>>> However,
>>>> if the command is not known to the controller then it presumably
>>>> assumes it to
>>>> be a non-data command which then causes protocol mismatch errors if
>>>> the device
>>>> ends up requesting data transfer. The new DATA SET MANAGEMENT - Trim
>>>> command
>>>> causes this issue since it's a DMA data-out command.
>>>>
>>>> Since we should always know best what protocol the command should be
>>>> using,
>>>> let's just set the override flag to inform the controller what
>>>> protocol to use
>>>> for all non-ATAPI commands with data transfer.
>>>>
>>>> Signed-off-by: Robert Hancock<hancockrwd@gmail.com>
>>>> Tested-by: Mark Lord<liml@rtr.ca>
>>>
>>> Any more comments on this one? Thought I heard an ack from Tejun on it..
>>>
>>>>
>>>> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
>>>> index 77aa8d7..e6946fc 100644
>>>> --- a/drivers/ata/sata_sil24.c
>>>> +++ b/drivers/ata/sata_sil24.c
>>>> @@ -846,6 +846,17 @@ static void sil24_qc_prep(struct ata_queued_cmd
>>>> *qc)
>>>> if (!ata_is_atapi(qc->tf.protocol)) {
>>>> prb =&cb->ata.prb;
>>>> sge = cb->ata.sge;
>>>> + if (ata_is_data(qc->tf.protocol)) {
>>>> + u16 prot = 0;
>>>> + ctrl = PRB_CTRL_PROTOCOL;
>>>> + if (ata_is_ncq(qc->tf.protocol))
>>>> + prot |= PRB_PROT_NCQ;
>>>> + if (qc->tf.flags& ATA_TFLAG_WRITE)
>>>> + prot |= PRB_PROT_WRITE;
>>>> + else
>>>> + prot |= PRB_PROT_READ;
>>>> + prb->prot = cpu_to_le16(prot);
>>>> + }
>>>> } else {
>>>> prb =&cb->atapi.prb;
>>>> sge = cb->atapi.sge;
>>>
>> ..
>>
>> Hasn't this gone upstream yet??
>> Heck, it should even go out for -stable, too.
> 
> It's queued for 2.6.32...  I'd rather be more conservative and get wider 
> testing before pushing such a fundamental change to sata_sil24 data xfer 
> path upon everyone.
..

Whatever.  It's very well tested (and in continuous use) here on two systems
with siI-3132 controllers.  So we'll want to hear from users of the 3124
and 3131/3531 chips for completeness, then.

Cheers
