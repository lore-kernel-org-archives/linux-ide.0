From: "Owen B. Mehegan" <owen@nerdnetworks.org>
Subject: SATA hotplug in 2.6.17-2?
Date: Tue, 13 May 2008 12:08:01 -0700 (PDT)
Message-ID: <49841.71.5.1.212.1210705681.squirrel@www.nerdnetworks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nerdnetworks.org ([216.93.177.252]:56694 "EHLO nerdnetworks.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756245AbYEMT21 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 May 2008 15:28:27 -0400
Received: from www.nerdnetworks.org (localhost [127.0.0.1])
	by nerdnetworks.org (Postfix) with ESMTP id 353B75D794
	for <linux-ide@vger.kernel.org>; Tue, 13 May 2008 12:08:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm running Debian Etch on a SuperMicro 6024H 2U server. Specs on it can
be viewed here:
http://www.supermicro.com/products/system/2U/6024/SYS-6024H-T.cfm

The system has a Marvell 88SX6081 8-port SATA controller attached to a
6-port backplane. I currently have two drives in it, using _software_ RAID
1 and LVM in Linux. I'm no longer sure why I didn't just use the onboard
hardware RAID system; I think I assumed it would be easier to
monitor/manage the RAID using the existing Linux software tools. Maybe I
was wrong about that...

Earlier this year one of the drives in the system failed. No big deal - I
got a replacement, went down to the datacenter, yanked the old one and put
in a new one. The system didn't seem to mind this at all, but with the new
drive in place I couldn't make the system recognize it. dmesg seemed to
show that a drive was present, but no amount of fiddling would allow me to
add the drive to the array and get the rebuild started. After awhile I
read the FAQ here: http://linux-ata.org/software-status.html  This seemed
to indicate that full hotplug support wasn't in the Linux kernel until
2.6.19. Of course, I happen to be running 2.6.17.

I ended up rebooting the box, and as soon as it came up it noticed the new
drive, and I was able to add it into the RAID and get the rebuild started.
I would have preferred not to have to do this though.

My question is this:  Can anyone confirm that my mistake was trying to do
hotplug on a 2.6.17 kernel? Or is it possible I did something else wrong?
My procedure was to use mdadm -f to mark the drive failed, then mdadm -r
to remove it from the array. Then physically unplug it, and insert the new
drive. After that I tried using the rescan-scsi-bus.sh script, which
basically just does the echo "- - -" > /sys/class/scsi_host/host1/scan 
stuff, and tried other things as well, but the system never saw the drive
until I rebooted.

Bonus question:  Can you point me to a set of instructions for what
exactly I need to do on the software side to swap a drive?

-- 
Owen B. Mehegan (owen@nerdnetworks.org)


-- 
Owen B. Mehegan (owen@nerdnetworks.org)



