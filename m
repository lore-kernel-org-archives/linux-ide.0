From: Marc MERLIN <marc@merlins.org>
Subject: Re: [PATCH 1/2] libata: Expose trim capability in sysfs
Date: Sat, 5 Apr 2014 23:19:58 -0700
Message-ID: <20140406061958.GC5006@merlins.org>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
 <20140406040312.GA5006@merlins.org>
 <1403024.0HLhjfholh@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:60279 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbaDFGUL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Apr 2014 02:20:11 -0400
Content-Disposition: inline
In-Reply-To: <1403024.0HLhjfholh@quad>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org, linux-ide@vger.kernel.org, Chris Samuel <chris@csamuel.org>

On Sun, Apr 06, 2014 at 03:05:51PM +1000, Chris Samuel wrote:
> On Sat, 5 Apr 2014 09:03:12 PM you wrote:
> 
> > Ok, I'm going to sound stupid, but which sysfs property is this in?
> > Or more simply what file do I have to cat see this?
> 
> I found them with a simple:
> 
> find /sys -name trim
> 
> I looked at my dmesg info from boot to correlate with devices.

Ah, that helps, thanks.

So here's another
Tested-By: Chris Samuel <marc@merlins.org>

legolas [mc]# cat /sys/devices/pci0000:00/0000:00:1f.2/ata1/link1/dev1.0/ata_device/dev1.0/trim
unqueued

:(

So much for the Samsung 840 EVO then.
Then again, it does confirm why deleting a kernel tree takes 1.5
seconds.

legolas [mc]# smartctl -i /dev/sda
smartctl 6.2 2013-07-26 r3841 [x86_64-linux-3.14.0-amd64-i915-preempt-20140216] (local build)
Copyright (C) 2002-13, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     Samsung SSD 840 EVO 1TB
Serial Number:    S1D9NEAD934600N
LU WWN Device Id: 5 002538 85009a8ff
Firmware Version: EXT0BB0Q
User Capacity:    1,000,204,886,016 bytes [1.00 TB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    Solid State Device
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4c
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sat Apr  5 23:18:08 2014 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

Thanks for the new code.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                         | PGP 1024R/763BE901
