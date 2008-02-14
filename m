From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Thu, 14 Feb 2008 12:05:00 +0900
Message-ID: <47B3AFDC.5040605@gmail.com>
References: <20080212180254.GA28237@postdiluvian.org>	<20080212221257.12eeab13@core>	<20080213184702.GA13458@postdiluvian.org>	<20080213202151.34b7e5bc@core>	<20080213212549.GA14732@postdiluvian.org> <20080214002135.065dd322@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:55601 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbYBNDFH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 22:05:07 -0500
Received: by rn-out-0910.google.com with SMTP id i24so1131088rng.19
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 19:05:06 -0800 (PST)
In-Reply-To: <20080214002135.065dd322@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Mason <mason@postdiluvian.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com, James Bottomley <James.Bottomley@HansenPartnership.com>, Jens Axboe <jens.axboe@oracle.com>

Alan Cox wrote:
>> I hadn't considered that approach due to the way the ata_port is allocated:
>>
>>> libata-core.c:
>>>         host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
>>>
>>> hosts.c:
>>> struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>>> {
>>>         shost = kzalloc(sizeof(struct Scsi_Host) + privsize, gfp_mask);
>>> }
>> The ata_port allocation is tacked onto the end of the Scsi_Host
>> allocation, so the start of ata_port will only be cache aligned if the
>> end of the Scsi_Host struct is, although that would be easy enough to
>> fix since it's currently aligned to an unsigned long boundary.
> 
> You are right.

For recent kernels, ata_port is allocated separately so
____cacheline_aligned should be enough.

>> I like that approach better, since it's clearer what the intent is,

But, yeah, allocating separately is probably safer.

>> and it's easier.  Is there any other way that the ata_port struct
>> might be used that would invalidate this?  
> 
> I can't think of one. The object lifetime is right - the ata_port is
> created before the port buffer is used and destroyed after it is finished
> (obviously or embedding it in the struct wouldn't work either)

I'll prep a patch for the current kernel.  Hmmm... This means that any
DMA buffer should be aligned to cacheline.  Block layer DMA alignment
helpers should probably take this into consideration and we better add
warnings to dma map functions.  This only affects DMA-to-memory, right?

Thanks.

-- 
tejun
