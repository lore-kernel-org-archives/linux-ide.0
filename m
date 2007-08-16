From: Tejun Heo <htejun@gmail.com>
Subject: Re: Enabling AHCI on ICH7 without BIOS support
Date: Thu, 16 Aug 2007 21:23:39 +0900
Message-ID: <46C441CB.8020805@gmail.com>
References: <46C1A999.5070109@dastyle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:15826 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbXHPMXy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 08:23:54 -0400
Received: by rv-out-0910.google.com with SMTP id k20so192865rvb
        for <linux-ide@vger.kernel.org>; Thu, 16 Aug 2007 05:23:53 -0700 (PDT)
In-Reply-To: <46C1A999.5070109@dastyle.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Bastien-Filiatrault <joe@dastyle.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Jonathan Bastien-Filiatrault wrote:
> Hello,
> 
> I am the owner of a Dell Latitude D620 notebook with an ICH7 SATA
> controller, unfortunately, the BIOS does not offer the option of using
> "native mode" instead of "compatibility mode" when it comes to SATA. For
> now, the ata_piix runs happily in compatibility mode. Looking at the
> ICH7 docs, I found that poking register 0x90 in PCI configuration space
> with value 0x40 should enable AHCI. However, there are some issues with
> poking that register with setpci in an early initramfs:
> 
> 
> - The kernel does not seem to update the device id from PCI config
> space, which changes with the controller mode (it would seem the PCI
> subsystem keeps a copy)
> 
> - Poking PCI registers from userspace is far from ideal
> 
> 
> It would be great if the AHCI driver (or otherwise) had a
> "force_ich7_ahci" to properly setup and initialize this device in full
> "native" AHCI mode. This option would be greatly welcome from users like
> me who have a stupid bios (eh, who doesn't).

Sorry but most BIOSen don't map ABAR unless it supports AHCI and there
usually isn't a hole to fit in ABAR afterwards unless the kernel
completely reallocates IO resources, which, again unfortunately, can't
be done reliably cuz machines can be quirky and might puke if addresses
aren't laid out as their BIOSen would do.

So, you'll have to live with ata_piix.

-- 
tejun
