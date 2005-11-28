From: Matt Darcy <kernel-lists@projecthugo.co.uk>
Subject: sata_mv 2.6.15 development/debugging
Date: Mon, 28 Nov 2005 10:05:03 +0000
Message-ID: <438AD64F.90203@projecthugo.co.uk>
Reply-To: kernel-lists@projecthugo.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from beng-03.stn.ab2.ifl.net ([194.238.49.3]:35598 "EHLO [127.0.0.1]")
	by vger.kernel.org with ESMTP id S1751239AbVK1KFF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Nov 2005 05:05:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I've been using the propritary sata_mv driver for some time with good 
stability and reasonable performance. It has been a pain though due to 
using it for software raid configuration, and the fact that it is a 
module that has to be loaded at boot time, plus I cannot use it in a 
kernel after 2.6.12.6

I was delighted to see the inclusion and development of this driver in 
the 2.6.15 kernel. I decided to give this a try.

I was pleased to note it worked straight out of the box - with regard to 
detecting the disks attatched and making them available for raid startup 
at boot.

However I had problems using lvm2 with the meta devices, the driver 
actually hangs the system, and for some reason includes cdrom devices 
when trying to create a volume group (note the cdrom drives are IDE 
based, on a VIA chip - so I don't know why the sata driver probes them - 
or at least thats how it appears)

I noted that the driver is maked as very experimental, and I would like 
to feed into this drivers testing and debugging, as to be honest the 
sooner this driver becomes stable and usable, the easier my life will be.

the note at the header of the driver says to use this mailing list for 
development/bugs, however it does seem a little strange mailing 
linux-ide when sata is classed as SCSI in the kernel.

Is this the correct mailing list to discuss/report bugs on ?

If so, what information is needed to report bugs effectivly - each list 
normally has a set of pre-requs, distro/version/config/certain libs etc etc.

Many thanks,

Matt

