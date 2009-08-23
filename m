From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.31-rc6: ACPI handle has no context apparenty from libata during suspend to RAM
Date: Sun, 23 Aug 2009 20:58:32 +0200
Message-ID: <200908232058.32917.rjw@sisk.pl>
References: <200908231424.07900.arvidjaar@mail.ru> <200908231407.38543.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48271 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933689AbZHWS5q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Aug 2009 14:57:46 -0400
In-Reply-To: <200908231407.38543.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 23 August 2009, Frans Pop wrote:
> Andrey Borzenkov wrote:
> > sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > sd 0:0:0:0: [sda] Stopping disk
> > ACPI handle has no context!
> > sdhci-pci 0000:03:01.1: PME# disabled
> > sdhci-pci 0000:03:01.1: PCI INT B disabled
> > ACPI handle has no context!
> > ata5: port disabled. ignoring.
> 
> I have a few of those too. I've been intending to try to investigate them, 
> but haven't gotten around to it yet. One problem is that there is no 
> context information in the error message itself (what 
> driver/function/whatever).
> 
> Are they new for you in .31 or have they always been there? I suspect the 
> latter, in which case I wouldn't worry about them too much. I at least 
> have never noticed any actual negative impact from them.

Most likely, the messages are from acpi_pm_device_sleep_state(), which on some
buses (PCI for one example) is called for all devices regardless of whether or
not they have the corresponding ACPI devices.  If they don't, this message is
printed and it's a KERN_DEBUG message.  It's totally harmless.

Thanks,
Rafael
