From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: libata: Implement disk shock protection support
Date: Thu, 18 Feb 2016 10:45:59 +0100
Message-ID: <8760xmic6g.fsf@denkblock.local>
References: <20160217192435.GA14960@mwanda>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.nebensachen.de ([5.45.99.250]:53235 "EHLO
	mail.nebensachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425940AbcBRJxs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Feb 2016 04:53:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Dan,

On 17 February 2016 at 20:24 CET, Dan Carpenter wrote:
> Hello Elias Oltmanns,
> The patch 45fabbb77bd9: "libata: Implement disk shock protection
> support" from Sep 21, 2008, leads to the following Smatch
> warning:
> 
>   drivers/ata/libata-scsi.c:206 ata_scsi_park_show()
>   warn: inconsistent returns 'irqsave:flags'.
> 	  Locked on:   line 206
> 	  Unlocked on: line 206
> 
> drivers/ata/libata-scsi.c
>    170  static ssize_t ata_scsi_park_show(struct device *device,
>    171                                    struct device_attribute *attr, char *buf)
>    172  {
[...]
>    183          spin_lock_irqsave(ap->lock, flags);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[...]
>    204          spin_unlock_irq(ap->lock);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This should almost certainly be spin_unlock_irqrestore().

since this is an accessor function for a sysfs attribute (see:
DEVICE_ATTR(unload_heads, S_IRUGO | S_IWUSR,
	    ata_scsi_park_show, ata_scsi_park_store);
at line 269), it will only ever be called from process context, in my
estimation. So, I suggest using spin_lock_irq() rather than the
_irqsave() variant. The same goes for the ata_scsi_park_store()
function.

Thanks for pointing out the inconsistency. Even though the patch itself
is quite straight forward, I won't have time to even compile test it
before the weekend.

Regards,

Elias
