From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Request to 2.6.24/patch-sata_promise-limit-sataii-to-1.5Gbps-2.6.24 because it doesn't work
Date: Fri, 23 Oct 2009 15:19:26 +0200
Message-ID: <19169.44382.793296.116944@pilspetsen.it.uu.se>
References: <200910231231.n9NCVbIV011530@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:37998 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbZJWNTa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Oct 2009 09:19:30 -0400
In-Reply-To: <200910231231.n9NCVbIV011530@post.webmailer.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Milan Burgdorf <milan@wwwburgdorf.de>
Cc: linux-ide@vger.kernel.org

Milan Burgdorf writes:
 > Dear Mr. Pettersson and the whole LINUX-IDE-team,
 > 
 > 
 > I'm working with Xubuntu 8.04 by using Kernel 2.6.24-24-generic. My two
 > 2,5-Zoll SATA-II-Harddisks are connected with a Promise SATA 300 TX2
 > Plus-Controller.
 > 
 > When the disks work with high I/O, than I become the similar problems
 > like they are described in
 > 
 > "http://marc.info/?l=linux-ide&m=121475606225101&w=2" and
 > "http://marc.info/?l=linux-ide&m=120134441006713&w=2":
 > 
 > Oct 15 20:20:46 alexandria-epia kernel: [ 5731.478618] res
 > 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
 > Oct 15 20:20:51 alexandria-epia kernel: [ 5736.825857] ata1: port is
 > slow to respond, please be patient (Status 0xff)
 > Oct 15 20:20:56 alexandria-epia kernel: [ 5741.526446] ata1: device not
 > ready (errno=-16), forcing hardreset
 > Oct 15 20:20:56 alexandria-epia kernel: [ 5741.526472] ata1: hard
 > resetting link
 > Oct 15 20:21:02 alexandria-epia kernel: [ 5747.713897] ata1: port is
 > slow to respond, please be patient (Status 0xff)
 > Oct 15 20:21:06 alexandria-epia kernel: [ 5751.575082] ata1: hard
 > resetting link
 > Oct 15 20:21:12 alexandria-epia kernel: [ 5757.762534] ata1: port is
 > slow to respond, please be patient (Status 0xff)
 > Oct 15 20:21:16 alexandria-epia kernel: [ 5761.623715] ata1: hard
 > resetting link
 > Oct 15 20:21:22 alexandria-epia kernel: [ 5767.811162] ata1: port is
 > slow to respond, please be patient (Status 0xff)
 > Oct 15 20:21:51 alexandria-epia kernel: [ 5796.650099] ata1: limiting
 > SATA link speed to 1.5 Gbps
 > Oct 15 20:21:51 alexandria-epia kernel: [ 5796.650114] ata1: hard
 > resetting link
 > Oct 15 20:21:56 alexandria-epia kernel: [ 5801.658417] ata1.00: disabled

Incomplete messages. Please post the full kernel log.

FWIW, the 2.6.32-rc kernel has updates for the controller reset operations
which may help get stubborn disks back on line. That patch is available
for 2.6.28 to 2.6.31 kernels in the patch repository you mention below.

 > To solve my problem I patched the sata_promise-Module with your three
 > patches from "http://user.it.uu.se/~mikpe/linux/patches/2.6/OLD/2.6.24/"
 > and installed the new module.
 > 
 > After this I checked hopefully my /var/log/messages, but the disk run
 > anymore in 3.0GB/s-Mode, and again I become the I/O-problems:

Incomplete messages. In particular, the limit-sataii-to-1.5Gbps
patch has a printk() which is missing here.

 > Is there another possibility to force the Promise-Controller down to 1.5
 > GB/s?

Libata has a generic libata.force= parameter which can be used to tweak
various settings, including 1.5Gbps vs 3Gbps. I haven't used it myself,
but see Documentation/kernel-parameters.txt for details.

/Mikael
