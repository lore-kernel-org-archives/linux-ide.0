From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Wed, 06 Oct 2004 23:34:51 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4164B95B.7020401@pobox.com>
References: <20040928001633.A8363@florence.linkmargin.com> <415AFF27.7080906@tteng.com.br> <415AFFBB.8090503@pobox.com> <4162EDA3.1030202@tteng.com.br> <20041005140653.A13393@florence.linkmargin.com> <41631DEC.9090404@pobox.com> <20041005173703.D13871@florence.linkmargin.com> <20041005224146.GA16514@havoc.gtf.org> <20041006060411.GC13631@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17289 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269669AbUJGDgA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 23:36:00 -0400
In-Reply-To: <20041006060411.GC13631@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Andy Warner <andyw@pobox.com>, "Luciano A. Stertz" <luciano@tteng.com.br>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Tue, Oct 05 2004, Jeff Garzik wrote:
> 
>>On Tue, Oct 05, 2004 at 05:37:03PM -0500, Andy Warner wrote:
>>
>>>Jeff Garzik wrote:
>>>
>>>>[...]
>>>>Probably you were running as root, and Luciano was not (guessing)
>>>
>>>Yup - but I was only doing it to get around the device
>>>permissions (or so I thought.) Do people think I should
>>>add ATA_16/ATA_12 to the approved list of scsi commands ?
>>
>>If you do, it's not that simple -- you would need to check the ATA
>>command to see if it was permissible for an unpriveleged user to issue
>>that specific ATA command.
>>
>>Otherwise, unpriveleged users could fry the hardware, or whatnot.
> 
> 
> This is getting more and more horrible...
> 
> ATA_16/ATA_12 should be allowed for read, and there should be a filter
> for tha ta opcode below that. We need the per-genhd loadable command
> filter lists for that.

I'm happy with requiring privelege for now...

	Jeff



