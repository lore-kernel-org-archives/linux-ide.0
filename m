From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port-Multiplier hotplug support: ATA_FLAG_AN
Date: Wed, 14 May 2008 12:10:34 +0900
Message-ID: <482A582A.7090108@gmail.com>
References: <482A1B41.50507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:63611 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbYENDKl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 May 2008 23:10:41 -0400
Received: by wa-out-1112.google.com with SMTP id j37so4518623waf.23
        for <linux-ide@vger.kernel.org>; Tue, 13 May 2008 20:10:40 -0700 (PDT)
In-Reply-To: <482A1B41.50507@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun,
> 
> Apparently the newer (GenIIe) sata_mv chips *can* support asynchronous
> notification without problems.  Some/all of the older ones cannot (errata).
> 
> So, I've done the one-liner change in sata_mv, to add ATA_FLAG_AN to
> the 7042 and 6042 chips, and it all seems to work rather nicely.
> 
> Am I missing something?  Is there any other local code to sata_mv
> that should be provided before setting ATA_FLAG_AN ?
> 
> Like I said, it works, but I just want to check whether any other
> pieces are expected to be present?

You need to call sata_async_notification() from interrupt handler after 
AN FIS is received.  sata_async_notification() is responsible for 
discerning between ATAPI and PMP ANs using SNotification and schedule 
appropriate actions.  If SNotification is not available && PMP is 
attached, it just calls ata_port_schedule_eh().  That's probably why it 
just worked by setting ATA_FLAG_AN.

Thanks.

-- 
tejun
