From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: give devices one last chance even if recovery
 failed with -EINVAL
Date: Fri, 11 May 2007 18:10:58 -0400
Message-ID: <4644E9F2.3000706@garzik.org>
References: <464465BB.5070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43614 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933947AbXEKWLA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 18:11:00 -0400
In-Reply-To: <464465BB.5070203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> After certain errors, some devices report complete garbage on
> IDENTIFY.  This can cause ata_dev_read_id() to fail with -EINVAL
> resulting in immediate disabling of the device.  Give the device one
> last chance after -EINVAL to allow recovery from such situations.  As
> -EINVAL is triggered very rarely, this shouldn't cause any noticeable
> affect on more common error paths.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Harald Dunkel <harald.dunkel@t-online.de>

applied


