From: David Sims <dpsims@virtualdave.com>
Subject: Small help or advice please....
Date: Sat, 22 Jan 2005 14:49:08 -0600 (CST)
Message-ID: <Pine.LNX.4.21.0501221445030.16827-100000@ernie.virtualdave.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ernie.virtualdave.com ([198.216.116.246]:30987 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S262738AbVAVUtQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Jan 2005 15:49:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeremy@classic.engr.sgi.com
Cc: linux-ide@vger.kernel.org

Hi,

  I am struggling a bit to get a Dell Powervault 745N (i.e., Intel
31244/Vitesse 71714 (aka 7174) SATA controller) to run Linux.... I am
using Slackware with the 3.4.29 kernel.... the only module loaded is the
ethernet (e1000) and when I try to load sata_vsc it just hangs trying to
talk to disk 0.... If I unplug all the disks then the module will load and
all seems well, but without any disks, what's the point? ;)


  I have temporarly added a pci-ide controller in the expansion slot of
this box and have Linux running fine via that from a WD-800 pata
disk... So I have lots of tools, I just don't know how to troubleshoot
this SATA problem.....

  Any clues for me?? How can I troubleshoot this problem or get the intel
31244 to work??

TIA,

Dave Sims
Houston


