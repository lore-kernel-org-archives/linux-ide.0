From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix SCSI/ATA device association during hotplug,
 take 2
Date: Fri, 02 Mar 2007 18:44:05 -0500
Message-ID: <45E8B6C5.9010103@garzik.org>
References: <20061120092534.GP2184@htj.dyndns.org> <456C43BF.4060807@rtr.ca> <456C6E93.9040203@gmail.com> <20061212042431.GD18947@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54842 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992764AbXCBXoK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 18:44:10 -0500
In-Reply-To: <20061212042431.GD18947@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

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
> Cc: Mark Lord <liml@rtr.ca>
> ---
> 
> scsi_dev <-> ata_dev association is moved to ->slave_alloc as Mark
> suggested.
[...]
> +		/* Try to attach new SCSI device.  SCSI midlayer
> +		 * doesn't supply separate interfaces for allocating
> +		 * and probing, so in this function, we can associate
> +		 * new SCSI device with its target ATA device only
> +		 * after probing is complete.
> +		 *
> +		 * However, hotplug event may occur during probing and
> +		 * we might have to detach a SCSI device which is in
> +		 * the middle of probing.  So, we need to associate
> +		 * new SCSI device with its target ATA device before
> +		 * the first INQUIRY is complete.
> +		 *
> +		 * This is achieved by attaching the device in
> +		 * ->slave_alloc().
> +		 */
> +		scsi_add_device(ap->scsi_host, 0, i, 0);

ACK

The above quoted comment serves to reinforce that libata eventually 
needs to have an ATA transport class


