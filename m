From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/4] libata: add R-Car SATA driver
Date: Sun, 26 May 2013 03:34:54 +0400
Message-ID: <51A14A9E.5060605@cogentembedded.com>
References: <201302202310.30443.sergei.shtylyov@cogentembedded.com> <519FF3D6.2090202@cogentembedded.com> <51A14665.3070508@cogentembedded.com> <20130525232024.GA11304@mtj.dyndns.org> <20130525232301.GB11304@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:61761 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758177Ab3EYXe5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 May 2013 19:34:57 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so5550617lab.15
        for <linux-ide@vger.kernel.org>; Sat, 25 May 2013 16:34:55 -0700 (PDT)
In-Reply-To: <20130525232301.GB11304@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

On 05/26/2013 03:23 AM, Tejun Heo wrote:
> On Sun, May 26, 2013 at 08:20:24AM +0900, Tejun Heo wrote:
>> Hey,
>>
>> On Sun, May 26, 2013 at 03:16:53AM +0400, Sergei Shtylyov wrote:
>>>>    This value should have been put into the 'dma_boundary' field of the
>>>> 'struct scsi_host_template', IIUC. Tejun, if I do it, do I need
>>>> this check at all?
>>>     You haven't replied, so I went and searched an answer myself. Indeed,
>>> it's enough to specify the right 'dma_boundary' and stop bothering about it.
>>> Expect two patches to the driver. I think the correct branch for
>>> them will be
>>> 'for-3.11'.
>> I was just about to reply.  Yes, it should be enough.  Both block
>> layer and the dma machniery honors the DMA boundary and segment size,
>> which are configured from __scsi_alloc_queue().
> But I'm a bit confused about ata_bmdma_fill_sg().  ATA_BMDMA_SHT sets
> the DMA boundary to 0xffff, so I have no idea why it's explicitly
> checking the DMA boundary in the function again.  What am I missing?

    Because with SFF-8038i  (BMIDE) controllers transfer can't cross
64KiB address boundaries. This function has to break up those S/G
entries that do cross them. I.e. the PRD length is actually additionally
limited by an offset of its start within 64KiB memory segment.
Does this make sense? Or does the block layer already care about this?
Hm, I'm not confident now, should revisit this after some sleep.

WBR, Sergei

