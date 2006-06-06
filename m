From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: hotplugging ide devices on a dock station
Date: Tue, 06 Jun 2006 16:11:31 -0700
Message-ID: <1149635492.13089.67.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8321 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751297AbWFFXA2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jun 2006 19:00:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
I've been working on getting docking/undocking to work and have written
an acpi driver which handles dock/undock events and successfully
hotplugs devices which either a) have another acpi driver or b) are on
the PCI bus or c) are usb devices.  I would like to be able to allow IDE
devices that are on dock stations to be discovered after a dock, and
gracefully removed after undock.  IDE controllers that are PCI devices
are hotadded without issues, but right now devices do not seem to be.  I
know from reading the archives of this list that there has been some
effort in enabling hotplug for SATA?  Is there some method that I should
be using to tell the ide subsystem to rescan for new devices?  I have
built in a method that other drivers can use to be notified of dock
events, and have also built in a way for other drivers to register
hotplug routines that can be called after a dock event.  Right now the
pci hotplug driver acpiphp utilizes these functions to do the hotplug
activities for pci based devices that are on the dock station, and I'd
like to either figure out a way to do something similar for the ide
devices, or else use a way that you have designed to indicate that a new
device should be scanned for.  

Thanks for any advice you can give, 
Kristen
