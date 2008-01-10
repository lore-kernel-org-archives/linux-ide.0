From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: don't normalize UNKNOWN to NONE
 after reset
Date: Thu, 10 Jan 2008 16:55:48 -0500
Message-ID: <47869464.3030301@garzik.org>
References: <47835DD4.4000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33722 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822AbYAJVzv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 16:55:51 -0500
In-Reply-To: <47835DD4.4000609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Robert Hancock <hancockr@shaw.ca>

Tejun Heo wrote:
> After non-classifying reset, ehc->classes[] could contain
> ATA_DEV_UNKNOWN which used to be normalized to ATA_DEV_NONE for
> consistency.  However, this causes unfortunate side effect for drivers
> which have non-classifying hardresets (e.g. sata_nv) by making
> hardreset report ATA_DEV_NONE for non-classifying resets and thus
> makes EH believe that the port is unoccupied and recovery can be
> skipped.  The end result is that after a device is swapped with
> another one, the new device isn't attached after the old one is
> detached.
> 
> This patch makes ata_eh_reset() not normalize UNKNOWN to NONE after
> non-classifying resets.  This fixes the above problem.  As UNKNOWN and
> NONE are handled differently by only EH hotplug logic, this doesn't
> cause other behavior changes.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Robert Hancock <hancockr@shaw.ca>
> ---
> Robert, missing new device was a bug in core EH logic not sata_nv.
> BTW, I did quite a few hotplug tests with adma=0 and it works just
> fine.  No lock up.
> 
>  drivers/ata/libata-eh.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

applied


