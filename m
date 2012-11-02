From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 00/14] ahci/libata: clean up platform device removal
Date: Fri, 2 Nov 2012 12:03:02 -0700
Message-ID: <CAN8TOE_dP4J02hm7m-e8PQpnpNaCiaeU6vq=0oQdzvn4jsEEgg@mail.gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
	<20121102170142.GA27320@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:35302 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab2KBTDD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 15:03:03 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2870812iag.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 12:03:02 -0700 (PDT)
In-Reply-To: <20121102170142.GA27320@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>

On Fri, Nov 2, 2012 at 10:01 AM, Tejun Heo <tj@kernel.org> wrote:
> On Fri, Nov 02, 2012 at 12:46:14AM -0700, Brian Norris wrote:
>> (1) Allows ahci_platform to unbind a device from the driver. This is useful for
>>     allowing total power-off of the device, for instance.
>> (2) Adds ahci_platform ata_port_operations.host_stop() hook, so that
>>     platform-device exit() can power down the device at the appropriate point
>>     in the removal sequence.
>> (3) Adds a common ata_platform_remove_one() function so that we don't
>>     re-implement a simple host detach across many platform drivers
>> (4) Switches many platform drivers to the new .remove function from (3)
>
> I personally would have converted all drivers in one patch but I think
> either way is fine.  Other than the indentation thing, for all patches
> in this series.
>
>   Acked-by: Tejun Heo <tj@kernel.org>

Thanks. I'll reply to the indentation patch with a v2.

>> P.S. A related but distinct issue: someting is still broken in the
>> ata_host_detach() function, for shutting down the host, spinning down disks,
>> etc. When I rmmod the driver or unbind the device, I get the following
>> failures, and the HDD doesn't spin down:
>
> That's because detaching the driver is handled basically as controller
> hot unplug.  By the time SCSI is noticing the SCSI devices are going
> away, the corresponding ATA devices are already away.  It's kinda
> natural to implement that way.  Is this an actual problem?

Yes. The HDD doesn't spin down. I'm removing the device because I want
some power savings, so I would expect to spin down the disk.

Brian
