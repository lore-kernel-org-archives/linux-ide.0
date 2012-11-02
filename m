From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/14] ahci/libata: clean up platform device removal
Date: Fri, 2 Nov 2012 10:01:42 -0700
Message-ID: <20121102170142.GA27320@mtj.dyndns.org>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42677 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759255Ab2KBRBr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 13:01:47 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2582362pad.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 10:01:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Kevin Cernekee <cernekee@broadcom.com>

Hello,

On Fri, Nov 02, 2012 at 12:46:14AM -0700, Brian Norris wrote:
> (1) Allows ahci_platform to unbind a device from the driver. This is useful for
>     allowing total power-off of the device, for instance.
> (2) Adds ahci_platform ata_port_operations.host_stop() hook, so that
>     platform-device exit() can power down the device at the appropriate point
>     in the removal sequence.
> (3) Adds a common ata_platform_remove_one() function so that we don't
>     re-implement a simple host detach across many platform drivers
> (4) Switches many platform drivers to the new .remove function from (3)

I personally would have converted all drivers in one patch but I think
either way is fine.  Other than the indentation thing, for all patches
in this series.

  Acked-by: Tejun Heo <tj@kernel.org>

> P.S. A related but distinct issue: someting is still broken in the
> ata_host_detach() function, for shutting down the host, spinning down disks,
> etc. When I rmmod the driver or unbind the device, I get the following
> failures, and the HDD doesn't spin down:

That's because detaching the driver is handled basically as controller
hot unplug.  By the time SCSI is noticing the SCSI devices are going
away, the corresponding ATA devices are already away.  It's kinda
natural to implement that way.  Is this an actual problem?

Thanks.

-- 
tejun
