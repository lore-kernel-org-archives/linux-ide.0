From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fix SCSI/ATA device association during hotplug
Date: Wed, 29 Nov 2006 02:14:59 +0900
Message-ID: <456C6E93.9040203@gmail.com>
References: <20061120092534.GP2184@htj.dyndns.org> <456C43BF.4060807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:26478 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1758709AbWK1RPH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 12:15:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1536412uga
        for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 09:15:06 -0800 (PST)
In-Reply-To: <456C43BF.4060807@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
> ..
>> +        /* Try to attach new SCSI device.  SCSI midlayer
>> +         * doesn't supply separate interfaces for allocating
>> +         * and probing, so in this function, we can associate
>> +         * new SCSI device with its target ATA device only
>> +         * after probing is complete.
> ..
> 
> I'm not necessarily disagreeing with the code, but rather that comment.
> 
> Mmm.. isn't slave_alloc() for allocating?  It gets invoked before
> the INQUIRY, and then slave_configure() is invoked after a successful
> device INQUIRY (otherwise slave_destroy() is invoked to clean up).

Yeah, right.  That will be the perfect place to attach ATA device. 
Thanks for pointing out.  I'll redo this patch.

-- 
tejun
