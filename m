From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata-acpi: improve dock
	event handling
Date: Thu, 13 Mar 2008 19:19:46 +0100
Message-ID: <20080313181946.GD26183@homac.suse.de>
References: <47D7691B.3080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56109 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421AbYCMSSN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Mar 2008 14:18:13 -0400
Content-Disposition: inline
In-Reply-To: <47D7691B.3080107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed 12. Mar - 14:24:43, Tejun Heo wrote:
> Improve ACPI hotplug handling such that dock event is handled properly.
> 
> * Register handlers for dock events.
> 
> * Directly detach device on EJECT_REQUEST instead of signaling hotplug
>   event.  This prevents libata from accessing severed controller
>   and/or device.
> 
> * While at it, use named constants for ACPI events and move uevent
>   signaling inside host lock.
> 
> Original patch and testing by Holger Macht.

Grrrr, unfortunately, the patch still seems to be not perfect:
  http://marc.info/?l=linux-acpi&m=120543202908662&w=2

Are you sure access to the device (/dev/srX) is locked before
ata_acpi_dev_notify() returns?

Regards,
	Holger
