From: Jan Kasprzak <kas@fi.muni.cz>
Subject: Promise TX4 (PDC40718) hotplug support
Date: Wed, 6 Jun 2007 15:51:23 +0200
Message-ID: <20070606135123.GQ13668@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:43887 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbXFFNv0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jun 2007 09:51:26 -0400
Received: from anxur.fi.muni.cz (anxur.fi.muni.cz [147.251.48.3])
	by minas.ics.muni.cz (8.13.8/8.13.8/SuSE Linux 0.8) with ESMTP id l56DpNdq001379
	for <linux-ide@vger.kernel.org>; Wed, 6 Jun 2007 15:51:24 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

	Hello,

I have a Promise TX4 controller, and I have problems with hotplug. It seems
the controller does not recongnize the drive being hot-removed or hot-plugged.
I need either to reload the sata_promise module, or to do

	# echo 1 > /sys/block/sdN/device/delete

to remove the drive, and 

	# echo 0 0 0 > /sys/class/scs_host/hostN/scan

to scan for a new drive.

	Another box with nVidia CK08 (sata_nv) can recognize the removal and
insertion of the drive as hotplug events (so udev correctly remove and create
the /dev nodes, etc.), so I thought with Promise TX4 it would be the same,
especially as http://linux-ata.org/driver-status.html says about TX2/TX4
the following: "Full SATA control including hotplug and PM on all." 

	Is hotplug supported with this controller? Or could this be
a problem with the SATA backplane?

	The controller is (lspci):

06:00.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)

The userland is Fedora Core 6 and Fedora 7, x86_64 (intel CPU), and the
chassis and SATA backplane is Supermicro 743T-645
(http://www.supermicro.com/products/chassis/4U/743/SC743T-645.cfm).

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> I will never go to meetings again because I think  face to face meetings <
> are the biggest waste of time you can ever have.        --Linus Torvalds <
