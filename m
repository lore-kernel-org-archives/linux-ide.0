From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata transfer mode & FUA & mode sense page
Date: Wed, 16 Nov 2005 12:15:52 -0500
Message-ID: <437B6948.8060902@pobox.com>
References: <437B649C.5080708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:26805 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751474AbVKPRP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 12:15:59 -0500
In-Reply-To: <437B649C.5080708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Douglas Gilbert <dougg@torque.net>, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> ATA FUA is interesting in that it's supported only for multisector PIO 
> and DMA protocols.  There is no ATA_CMD_PIO_WRITE_FUA_EXT.  So, when 

That's ok, that's 99% of all users anyway.

(pio-mult is merged in Albert's irq-pio branch)


> generating mode sense page, the status of FUA supported bit is dependent 
> on the configured transfer mode.

Yep.


> transfer mode configuration yet, I'm thinking of simply passing ap or 
> device down to mode sense functions and use it to report FUA status. How 
> does that sound?

That's fine.


> If dynamic transport configuration is implemented in the future (from EH 
> or explicit user input), this FUA bit will go on and off depending on 
> transfer mode.  Ugh... It seems that we'll need a way to raise UA for 
> configuration change and trigger revalidation of SCSI disk device.

Just one more thing to think about, before allowing userspace to change 
the transfer mode at will, during runtime :)

	Jeff


