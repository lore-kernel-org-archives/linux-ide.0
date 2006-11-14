From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4] libata: separate out rw ATA taskfile building into
 ata_build_tf()
Date: Wed, 15 Nov 2006 01:51:03 +0900
Message-ID: <4559F3F7.4080509@gmail.com>
References: <11635120302199-git-send-email-htejun@gmail.com> <4559EB3B.9050805@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:47394 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S966204AbWKNQvU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 11:51:20 -0500
Received: by nz-out-0102.google.com with SMTP id l1so1027945nzf
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 08:51:19 -0800 (PST)
In-Reply-To: <4559EB3B.9050805@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Mark Lord wrote:
> This logic sequence bothers me slightly:
> 
> Tejun Heo wrote:
>> Separate out rw ATA taskfile building from ata_scsi_rw_xlat() into
>> ata_build_tf().  This will be used to improve media error handling.
> ...
>> +    if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
>> +               ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
>> +        /* yay, NCQ */
>> +        if (!lba_48_ok(block, n_block))
>> +            return -ERANGE;
> ...
>> +    } else if (dev->flags & ATA_DFLAG_LBA) {
>> +        tf->flags |= ATA_TFLAG_LBA;
>> +
>> +        if (lba_28_ok(block, n_block)) {
>> +            /* use LBA28 */
>> +            tf->device |= (block >> 24) & 0xf;
>> +        } else if (lba_48_ok(block, n_block)) {
>> +            if (!(dev->flags & ATA_DFLAG_LBA48))
>> +                return -ERANGE;
> ...
> 
> In the first case, if !lba_48_ok(), then we should at least attempt
> to see if the request can be issued via non-NCQ.
> 
> Something like this:
> 
> if (lba_48_ok() && dev->flags & 
> (ATA_DFLAG_PIO|ATA_DFLAG_NCQ_OFF|ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
>   /* yay, NCQ */
>   ...
> } else if (dev->flags & ATA_DFLAG_LBA) {
>   ...
> 
> ..except prettier!  ;)
> 
> In theory, it looks like an impossible sequence anyway..
> if we have the NCQ flag set, then we probably already *know*
> that LBA48 is okay.  But since we're not making that assumption,
> let's give it the benefit of a doubt and try non-NCQ if LBA48 is a no-go.

First of all, that function is moved verbatim from ata_scsi_rw_xlat(), 
and I don't really understand your point.  lba_48_ok() checks whether 
the given block and n_block are inside LBA48 limit.  NCQ commands use 
LBA48 (well, nsect is in the different registers but the limits are the 
same) which is the largest addressing mode currently available.  So, if 
a command cannot be issued using NCQ, it cannot be issued w/ any command 
mode.  ie. if !lba_48_ok(), that command just cannot be issued.

Am I misunderstanding you?

-- 
tejun
