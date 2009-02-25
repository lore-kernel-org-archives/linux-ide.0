From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 01/06] sata_mv: cache frequently read registers
Date: Wed, 25 Feb 2009 12:52:35 -0500
Message-ID: <49A58563.50708@rtr.ca>
References: <4994FF3D.90904@rtr.ca> <499A029A.1060101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:36486 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbZBYRwj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 12:52:39 -0500
In-Reply-To: <499A029A.1060101@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Maintain a local (mv_port_priv) cache of frequently accessed registers,
>> to avoid having to re-read them (very slow) on every transistion
>> between EDMA and non-EDMA modes.  This speeds up things like
>> flushing the drive write cache, and anything using basic DMA transfers.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>> -- 
>>
>> Resending without any changes from original.
> 
> ACK patches 1-6
> 
> however, they do not seem to apply to libata-dev.git#upstream, which 
> already has several sata_mv changes in it.
> 
> Can you regenerate please?  No need to copy the list on resend, unless 
> the patch content changes....
..

I sent you the patches via email a week ago now,
and no word back .. and no updates visible in libata-dev.

Did you get them?

Thanks

Mark
