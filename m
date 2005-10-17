From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Intel SATA combined mode quirk broken for SCSI_SATA=m
Date: Sun, 16 Oct 2005 22:33:11 -0400
Message-ID: <43530D67.6020209@pobox.com>
References: <200510161913.59622.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:4488 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932132AbVJQCdW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2005 22:33:22 -0400
In-Reply-To: <200510161913.59622.jbarnes@virtuousgeek.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jesse Barnes wrote:
> Back in July, Adrian Bunk sent in a patch to make SCSI_SATA tristate.  This 
> prevents the intel_ide_combined quirk in drivers/pci/quirks.c from working if 
> SCSI_SATA=m, which is the case for Fedora kernels (my motivation for tracking 
> this down).
> 
> In my configuration, not running the quirk causes the ata_piix driver (the 
> libata driver for my IDE controller) to fail to attach to the device, since 
> the legacy IDE driver has already claimed the ports.  Unfortunately, the AHCI 
> driver also tries to mess with the device, and ends up disabling its 
> interrupts before aborting its load, causing the IDE layer to complain loudly 
> that hda is losing interrupts.

Thanks a ton for figuring this out!


> So what should be done?  Ideally, libata would fully support ATAPI and then I 
> wouldn't need the legacy IDE drivers at all on this box, making the quirk 
> moot, but that won't happen for 2.6.14, so we'll need something else.  
> Unconditionally enabling the quirk will cause at least one of the ports to be 
> reserved for the SATA driver, which may never load.  And obviously not 
> running the quirk leads to the situation described above.
> 
> A hack that might be suitable for 2.6.14 is to make the quirk depend on either 
> CONFIG_SCSI_SATA or CONFIG_SCSI_SATA_MODULE.  Then the quirk could be removed 
> entirely when ATAPI support for libata is merged.

Overall the quirk is a hack until ATAPI is supported -- but even after 
ATAPI is supported, we need to figure out some way to keep IDE driver 
from stealing the legacy IDE ports before libata can touch them :(

However, when ATAPI is supported, that at least means that both PATA and 
SATA can run at full speed.

Your patch is correct, and should go into 2.6.14-rc post-haste.

I continue to grumble at the Kconfig annoyance:  CONFIG_SCSI_SATA is 
fundamentally a yes/no question.  CONFIG_SCSI_SATA=m makes no sense at 
all -- and causes problems, as we see -- but is required in order to do 
Kconfig dependencies correctly AFAIK.

Maybe 'if SCSI_SATA' is needed instead?  A lame way to implement 
dependencies, but if there is no other way...

	Jeff


