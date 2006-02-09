From: "JaniD++" <djani22@dynamicweb.hu>
Subject: promise driver stability question (bugreport?)
Date: Thu, 9 Feb 2006 12:11:34 +0100
Message-ID: <005801c62d69$99298950$9d00a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.enternet.hu ([62.112.192.21]:50183 "EHLO smtp.enternet.hu")
	by vger.kernel.org with ESMTP id S1422743AbWBILFI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 06:05:08 -0500
Received: from [62.68.179.10] (helo=dcccs)
	by smtp.enternet.hu with esmtpa (Exim 4)
	id 1F79bX-0001Ca-IM
	for linux-ide@vger.kernel.org; Thu, 09 Feb 2006 12:04:51 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello, Jeff, list,

10 days ago i have upgrade my system from 8TB to 13.2TB (the system info is
the bottom of mail), and now i have seriously problem with my 2 disk node.

(first i try the sil3112 based cards, but this looks like wery unstable,
makes data lost, very worst write speed with multiple cards and i have
replaced these cards with promise controllers.)

Currently i use the ICH5 , promise sata 300 TX4 and promise sata 300 TX2
cards/chips only.

I use 2.6.16-rc2-git5, because only this kernel knows what i need.

The problem is, one of my disk nodes seriously reboots. (about 4-8 hourly)
I try to catch the error message with remote syslogd, but i cannot see any
valuable info.

At this time i can see the reboot only happens, when  the concentrator is
writing to nodes.

The reboot is newer happens, when  the node is resyncing, doing  recovery
for a long time (~6 hours) and have no other work.
The reboot makes no data lost, except the dirty buffer. (looks like reset)

First i try to track down the problem to hardware, but this looks like good.
(after the system upgrade on the prevously stable nodes, the new hardware is
only the HDD, and the promise cards, plus the kernel.)

Today i try to replace the e1000 nic driver in the kernel with the old, and
known to be stable version, but the reboot happened again. :-(

Is there any info or known bug about promise driver? (or 2.6.16-rc kernels)
What do you recommend to do or try?

Thanks,
Janos

The system info:

4x 3.3TB disk nodes, and one concentrator, without disks.
The nodes:
Abit IS7 motherboard (i865), P4 3G, 1G ram, Intel Gigabit Pro NIC.
4x IDE maxtor 300GB in ICH5
2x SATA maxtor 300GB in ICH5-sata
4x SATA maxtor 300GB in Promise sata 300 TX4
2x SATA maxtor 300GB in Promise sata 300 TX2

