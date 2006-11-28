From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix SCSI/ATA device association during hotplug
Date: Tue, 28 Nov 2006 04:07:39 -0500
Message-ID: <456BFC5B.5020609@pobox.com>
References: <20061120092534.GP2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:15235 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935735AbWK1JHl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:07:41 -0500
In-Reply-To: <20061120092534.GP2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Two subtle hotplug related bugs are found.
> 
> * SCSI didn't use to issue commands to devices in SDEV_CANCEL state
>   but now it does.  For ATA devices, it means that SYNCHRONIZE_CACHE
>   is issued even after libata tells SCSI midlayer that the SCSI device
>   is offline now.  When devices are swapped, SYNCHRONIZE_CACHE for the
>   previous device can be issued to the later device.
> 
> * Devices can be swapped while SCSI probing is in progress.  SCSI
>   device used to get associated with ATA device only after probing is
>   complete, which means that SCSI device detaching is not performed
>   while probing.  This can result in mismatch between SCSI device and
>   ATA device (e.g. sd attached to ATAPI device) if devices are
>   swapped after INQUIRY but before probing is complete.
> 
> This patch makes libata associate new SCSI device with ATA device
> before INQUIRY is issued and check whether SCSI device issuing a
> command matches dev->sdev on each command.  Both bugs are fixed by
> this tighter coupling between SCSI device and ATA device.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


