From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Playing with SATA NCQ
Date: Fri, 27 May 2005 03:51:11 -0400
Message-ID: <4296D16F.9030805@pobox.com>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050527072046.GN1435@suse.de> <4296CC5C.5000807@pobox.com> <20050527073307.GP1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:53469 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261964AbVE0HvQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2005 03:51:16 -0400
In-Reply-To: <20050527073307.GP1435@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, May 27 2005, Jeff Garzik wrote:
> 
>>Jens Axboe wrote:
>>
>>>I double checked this. If you agree to move the setting of QCFLAG_ACTIVE
>>>_after_ successful ap->ops->qc_issue(qc) and clear it _after_
>>>__ata_qc_complete(qc) then I can just use that bit and kill
>>>ATA_QCFLAG_ACCOUNT.
>>>
>>>What do you think?
>>
>>Fine with me.
>>
>>Keep in mind that the attached patch was applied recently...
> 
> 
> Yeah, the two hunks from the ncq patch would look like this then. Ok?

ACK (modulo my distaste for 'depth' and 'ncq_depth', of course... :))


