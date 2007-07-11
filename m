From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: REQUEST_SENSE and ide-cd.c
Date: Wed, 11 Jul 2007 18:09:16 -0400
Message-ID: <4695550C.7040501@redhat.com>
References: <46949541.4040206@itg.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56828 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764590AbXGKWJW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jul 2007 18:09:22 -0400
In-Reply-To: <46949541.4040206@itg.hitachi.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Piotr Muszynski <piotr@itg.hitachi.co.jp>
Cc: linux-kernel@vger.kernel.org, USB development list <linux-usb-devel@lists.sourceforge.net>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 07/11/2007 04:30 AM, Piotr Muszynski wrote:

[cc: linux-usb, linux-ide]

> I am adding transparent ATAPI capability to USB gadget Mass Storage
> driver. The idea is to pass USB traffic to block device queue as packet
> requests. At the end of the queue, the requests are handled by ide-cd.c
> driver.
> 
> It breaks when the ide-cd.c driver unconditionally generates
> REQUEST_SENSE for requests that ended in unit attention condition.
> 
> By clearing the drive's unit attention condition, this additional
> REQUEST_SENSE confuses the host, which fires it's own REQUEST_SENSE
> packet, to which the drive replies with NO SENSE.
> 
> I can see three solutions:
> 
> 1. Intercept the sense data returned by ide-cd.c and emulate unit
> attention condition in file_storage.c driver;
> 
> 2. Introduce a new request flag causing ide-cd.c to skip calling
> cdrom_queue_request_sense() for flagged requests, like below:
> 
>     cdrom_decode_status() 2.6.12:
>     -    if (stat & ERR_STAT) {
>     +    if (stat & ERR_STAT && !(rq->flags & REQ_NO_AUTOSENSE)) {
>              spin_lock_irqsave(&ide_lock, flags);
>              blkdev_dequeue_request(rq);
>              HWGROUP(drive)->rq = NULL;
>              spin_unlock_irqrestore(&ide_lock, flags);
>              cdrom_queue_request_sense(drive, rq->sense, rq);
>          } else
>              cdrom_end_request(drive, 0);
> 
> 3. Acknowledge that ide-cd.c was not meant to work as in (2) and search
> for another mechanism. Where?
> 
> (1) would unnecessarily duplicate the drive's state. I'd rather do (3).
> 
> So far, the (2) works well, but how bad is it?
> I'd greatly appreciate any critical feedback.
