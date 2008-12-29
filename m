From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI problem with hotplug
Date: Mon, 29 Dec 2008 17:17:08 +0900
Message-ID: <49588784.4020808@kernel.org>
References: <494178E3.6030305@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52737 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbYL2IR0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 03:17:26 -0500
In-Reply-To: <494178E3.6030305@cybernetics.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tony Battersby wrote:
> I am having a problem getting Linux to detect hot-plugged SATA disks on my
> ICH7 AHCI controller (SuperMicro PDSME motherboard).  On any SATA port that
> already had a disk plugged in during BIOS POST, Linux will see the disk and
> detect hot-plug and hot-unplug events just fine.  On any SATA port that did
> not have a disk plugged in during BIOS POST, Linux will not see a disk no
> matter what.  Here are the different sequences of events that I have tried:
> 
> 1) boot with SATA disk plugged in
>    modprobe ahci: disk detected
>    unplug disk:   disk deleted
>    plug in disk:  disk detected
> 
> 2) boot with SATA disk plugged in
>    unplug disk
>    modprobe ahci
>    plug in disk: disk detected
>    unplug disk:  disk deleted
>    plug in disk: disk detected
>    unplug disk:  disk deleted
>    plug in disk to any other SATA port    -> not detected
>    plug in disk to the original SATA port -> disk detected
> 
> 3) boot with SATA disk unplugged
>    plug in disk to any SATA port
>    modprobe ahci: not detected
>    grep ahci /proc/interrupts: 0 interrupts
> 
> 4) boot with SATA disk unplugged
>    modprobe ahci
>    plug in disk to any SATA port: not detected
>    grep ahci /proc/interrupts: 0 interrupts
> 
> 5) keep SATA disk plugged in during BIOS POST but unplug it before the
>    kernel boots
>    kernel hangs at "BIOS data check"
> 
> I have tried both 2.6.24.7 and 2.6.27.8 with the same result.
> 
> The BIOS is configured as follows:
> Parallel ATA:         [Enabled]
> Serial ATA:           [Enabled]
> SATA Controller Mode: [Enhanced]
> SATA RAID:            [Disabled]
> SATA AHCI:            [Enabled]
> 
> The root filesystem is on a parallel IDE disk using the legacy (non-libata)
> piix driver.

The BIOS could be tristating the ports.  Does it work if you issue
manual rescan (echo - - - > /sys/class/scsi_host/hostN/scan)?

-- 
tejun
