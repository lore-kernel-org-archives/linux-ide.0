From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] libata: add MODE_SENSE(6) emulation?
Date: Sun, 15 May 2005 22:29:38 -0400
Message-ID: <42880592.40402@pobox.com>
References: <425393DB.3010702@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:46233 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261246AbVEPC3m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2005 22:29:42 -0400
In-Reply-To: <425393DB.3010702@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Hi Jeff,
> 
>   Even though libata sets  sdev->use_10_for_ms = 1;
> libata still receives MODE_SENSE(6) and MODE_SELECT(6) commands during 
> the test.
> (These commands seems to be coming from the user space, not from the 
> SCSI mid-layer.)
> 
> Most ATAPI devices don't like it, and either return error or time out.
> (Ex.
> Attached scsi CD-ROM sr0 at scsi7, channel 0, id 0, lun 0
> ata7: command 0xa0 timeout, stat 0x50 host_stat 0x1)
> 
> Should MODE_SENSE(6) / MODE_SELECT(6) emulation be added to libata
> to fix this? This can also make the ATAPI devices look more like real 
> SCSI devices.

I would prefer not to add this emulation.

This has been standard behavior for ATAPI devices, and was the reason 
that use_10_for_{ms,rw} was created inside the kernel.

Userland applications should be fixed instead:  the current SCSI MMC 
specification does not list MODE SENSE(6) either, and ATAPI devices are 
most like MMC devices.

The applications should be updated with more knowledge of the MMC 
specification.

	Jeff


