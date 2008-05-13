From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv on Orion: CONFIG_SATA_PMP=y needed even when no multiplier
Date: Tue, 13 May 2008 17:45:39 +0900
Message-ID: <48295533.4080800@gmail.com>
References: <20080512132840.GA15711@deprecation.cyrius.com> <482866F2.5040901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:54679 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758720AbYEMIpr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 May 2008 04:45:47 -0400
Received: by wa-out-1112.google.com with SMTP id j37so4001675waf.23
        for <linux-ide@vger.kernel.org>; Tue, 13 May 2008 01:45:46 -0700 (PDT)
In-Reply-To: <482866F2.5040901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org

Mark Lord wrote:
> Martin Michlmayr wrote:
>> With 2.6.26-rc1 I have to enable CONFIG_SATA_PMP=y otherwise sata_mv
>> doesn't find a disk on my Orion based device (QNAP TS-209).  Without
>> CONFIG_SATA_PMP I get:
>>
>> [42949381.790000] sata_mv sata_mv.0: version 1.20
>> [42949381.790000] sata_mv sata_mv.0: slots 32 ports 2
>> [42949381.800000] scsi0 : sata_mv
>> [42949381.800000] scsi1 : sata_mv
>> [42949381.810000] ata1: SATA max UDMA/133 irq 29
>> [42949381.810000] ata2: SATA max UDMA/133 irq 29
>> [42949382.170000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [42949382.520000] ata2: SATA link down (SStatus 0 SControl 300)
>> [and nothing else]
>>
>> So obviously it sees that something is connected to ata1, but it
>> doesn't actually print anything about the disk or create the device
>> node.
>>
>> This works correctly with 2.6.25 or when I set CONFIG_SATA_PMP=y.
>> However, my device doesn't have a multiplier.
> ..
> 
> Okay, so the "SStatus 123" means that sata_mv::mv_hardreset must
> have succeeded in finding good link status.  Great.
> 
> After that, libata-core and pals do the actual device IDENTIFY/probing.
> 
> With CONFIG_SATA_PMP=y, there's an added soft-reset done first,
> and without it, there is no soft-reset.
> 
> Looks like your device either needs the extra soft-reset regardless,
> or maybe just needs a little more time in the probing sequence.
> 
> Tejun?
> 
> I suppose we could just always ask for the extra soft-reset here (?)

Hmm... sata_mv doesn't do device classification, right?  If so, it 
should return -EAGAIN on success to tell EH to perform follow-up SRST.

Thanks.

-- 
tejun
