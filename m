From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/02] sata_mv: workaround for multi_count errata sata24
Date: Mon, 13 Apr 2009 13:36:33 -0400
Message-ID: <49E37821.4020004@rtr.ca>
References: <49E359D6.1090309@rtr.ca> <49E35A5E.4020204@rtr.ca> <49E35BF8.1070402@rtr.ca> <49E37588.10506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33256 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbZDMRgf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 13:36:35 -0400
In-Reply-To: <49E37588.10506@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Someday I'll fix that, if you guys don't beat me to it.
>> I suppose we just need to issue the SET_MULTIPLE command from
>> the drive revalidation code. 
> 
> IMO this would be a good idea to do, across many ATA devices.
> 
> IIRC there is at least one other chip that snoops the set-multiple 
> command, and sets internal chip parameters.
> 
> Thus, like SET FEATURES - XFER MODE, it seems wise to unconditionally 
> issue SET MULTIPLE for ATA devices, under the logic that it 
> more-thoroughly initializes the controller and device, ensuring we are 
> at a known state at all times.
> 
> Wanna do a patch?  :)  Although not the greatest code location, I'm 
> guessing ata_dev_read_id() would probably be the place...  Ideally we 
> would have a post-IDENTIFY reset sequence function.
..

I agree with all of the above.

Except I have a certain other, eagerly anticipated,
patch to work on right now.  :)

Perhaps afterwards, though I'm due to disappear into the embedded
world again for a while, a couple of weeks from now.

If anyone else feels the urge, please don't wait for me!

Cheers
