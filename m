From: Mark Lord <lkml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Fri, 17 Mar 2006 00:26:11 -0500
Message-ID: <441A4873.3030102@rtr.ca>
References: <1142344212.4416ca14a26b4@webmail.aon.at> <44182CD7.9070401@rtr.ca> <20060316100838.GF3595@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:42190 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751272AbWCQF0O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Mar 2006 00:26:14 -0500
In-Reply-To: <20060316100838.GF3595@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: me_trash1@aon.at, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Jens Axboe wrote:
> On Wed, Mar 15 2006, Mark Lord wrote:
..
>> ATA cmd=0x35 is ATA_CMD_WRITE_EXT, and 0x25 (lower down in the logs)
>> is ATA_CMD_READ_EXT.
>>
>> Those are the bog-standard (and slow!) PIO R/W commands,
>> which generate one interrupt per 512-bytes transferred.
> 
> Eh no they are not, 0x35 is WRITEDMA_EXT and 0x25 is READMA_EXT.

We're both correct, in that 0x35 is ATA_CMD_WRITE_EXT as I said.
But the naming had me fooled -- they really are DMA commands,
even if the linux/ata.h names are incomplete.

Cheers

