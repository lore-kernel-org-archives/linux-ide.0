From: Mark Lord <lkml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Fri, 17 Mar 2006 10:20:14 -0500
Message-ID: <441AD3AE.1030301@rtr.ca>
References: <1142344212.4416ca14a26b4@webmail.aon.at> <44182CD7.9070401@rtr.ca> <20060316100838.GF3595@suse.de> <441A4873.3030102@rtr.ca> <441A80CA.6080407@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:13547 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750803AbWCQPUQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Mar 2006 10:20:16 -0500
In-Reply-To: <441A80CA.6080407@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>, me_trash1@aon.at, linux-ide@vger.kernel.org

Albert Lee wrote:
> Mark Lord wrote:
..
>> We're both correct, in that 0x35 is ATA_CMD_WRITE_EXT as I said.
>> But the naming had me fooled -- they really are DMA commands,
>> even if the linux/ata.h names are incomplete.
>>
>  
> How about the attached renaming patch?
> It could make the command names more consistent to what's in the ATA/ATAPI spec.
..

Hey, that's a great idea.  And the patch is quite small, too.

Stick a Signed-Off-By line on it, and we'll see what our
benevolent overJeff says for it.  ;)

Cheers
