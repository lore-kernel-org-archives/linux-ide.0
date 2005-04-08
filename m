From: Gerald Hopf <linux-ide@nv-systems.net>
Subject: 'hdparm -C' problems with libata-dev
Date: Fri, 08 Apr 2005 16:03:21 +0200
Message-ID: <42568F29.6020800@nv-systems.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nv-systems.net ([62.75.252.178]:48904 "EHLO mail.nv-systems.net")
	by vger.kernel.org with ESMTP id S262819AbVDHODW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2005 10:03:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi everyone,

I've been trying to get the hdparm and hddtemp tools to work with my 
Seagate SATA Drives.

I have 4 Drives connected to an nVidia nForce 3 SATA Controller, and 1 
Drive connected to a Promise SATA 150 TX2.

After some reading, i found out that SMART support for reading the 
harddrive's temperature is not yet in the kernel, so i got the 
libata-dev patch from here: 
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-libata-dev1.patch.bz2

and patched the 2.6.11.7 kernel with it. (Worked fine, but i'm not sure 
if that was the right patch file? The BK patches are newer, are those 
the "right" ones, or are they only for such a specific BK version of a 
kernel?)

Everything worked fine, and after updating hddtemp to the latest 
v0.3_beta13, i even am able to get temperature readings from the drives.

What's not fully working as expected, however, is hdparm. If I (for 
example) want to check the drive's power status, i get the following:

root # hdparm -C /dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde
/dev/sda: \ drive state is:  standby
/dev/sdb: \ drive state is:  standby
/dev/sdc: \ drive state is:  standby
/dev/sdd: \ drive state is:  standby
/dev/sde: \ drive state is:  standby

The drives are of course, NOT in standby, but are in the state 
"active/idle".

When setting the standby parameter for a drive, everything seems to work 
normally.

root # hdparm -S 241 /dev/sda
/dev/sda:  setting standby to 241 (30 minutes)

I wasn't able to check that this really works (because of missing hdparm 
-C) but i think it acually does. At least hdparm -y is able to standby a 
drive.

I'm using hdparm v5.9, which is IMHO the most recent version.
Is there anything i can do to make this ('hdparm -C') work? Is this a 
libata bug or missing feature? A Seagate Firmware bug? A hdparm problem? 
Or just not possible with SATA Drives?

I'd gratefully appreciate any help/comments ;-)

Gerald

