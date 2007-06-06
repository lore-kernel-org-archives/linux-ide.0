From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Promise TX4 (PDC40718) hotplug support
Date: Wed, 6 Jun 2007 16:25:12 +0200 (MEST)
Message-ID: <200706061425.l56EPCx5004324@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:60167 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbXFFOZS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jun 2007 10:25:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kas@fi.muni.cz, linux-ide@vger.kernel.org

On Wed, 6 Jun 2007 15:51:23 +0200, Jan Kasprzak wrote:
> I have a Promise TX4 controller, and I have problems with hotplug. It seems
> the controller does not recongnize the drive being hot-removed or hot-plugged.
> I need either to reload the sata_promise module, or to do
> 
> 	# echo 1 > /sys/block/sdN/device/delete
> 
> to remove the drive, and 
> 
> 	# echo 0 0 0 > /sys/class/scs_host/hostN/scan
> 
> to scan for a new drive.
> 
> 	Another box with nVidia CK08 (sata_nv) can recognize the removal and
> insertion of the drive as hotplug events (so udev correctly remove and create
> the /dev nodes, etc.), so I thought with Promise TX4 it would be the same,
> especially as http://linux-ata.org/driver-status.html says about TX2/TX4
> the following: "Full SATA control including hotplug and PM on all." 
> 
> 	Is hotplug supported with this controller?

The Promise SATA hardware supports hotplug, but the driver
doesn't yet handle it.

It's on my TODO list. (When I get some spare time, sigh.)

/Mikael
