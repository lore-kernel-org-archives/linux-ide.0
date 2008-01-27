From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.6.24 sata_promise SATA300TX4 problems
Date: Sun, 27 Jan 2008 01:24:11 +0100
Message-ID: <18331.53035.493189.308501@harpo.it.uu.se>
References: <479B0A39.2050700@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:55928 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbYA0AYR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 19:24:17 -0500
In-Reply-To: <479B0A39.2050700@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Peter Favrholdt writes:
 > Hi Mikael & list,
 > 
 > I have previously reported problems with my setup:
 > 
 > SATA300TX4 + 4 Seagate Barracuda ES 500GB
 > 
 > I just tested with 2.6.24. After copying approx 25GB of each drive using
 >   dd if=/dev/sd[abcd] of=/dev/null bs=1M
 > sda failed with the following message:
 > 
 > [ 1060.069489] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
 > [ 1060.069498] ata1.00: cmd 25/00:00:90:2c:e6/00:02:01:00:00/e0 tag 0 
 > dma 262144 in
 > [ 1060.069501]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
 > 0x4 (timeout)
 > 
 > I have included lspci and dmesg output below.
 > 
 > My system is rock solid using 2.6.21-rc2 with Mikael Pettersons 1.5Gbps 
 > patch.
...
 > [ 1060.069478] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
 > action 0x2 frozen
 > [ 1060.069489] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
 > [ 1060.069498] ata1.00: cmd 25/00:00:90:2c:e6/00:02:01:00:00/e0 tag 0 
 > dma 262144 in
 > [ 1060.069501]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
 > 0x4 (timeout)
 > [ 1060.069505] ata1.00: status: { DRDY }
 > [ 1065.437567] ata1: port is slow to respond, please be patient (Status 
 > 0xff)
 > [ 1070.114210] ata1: device not ready (errno=-16), forcing hardreset
 > [ 1070.114219] ata1: hard resetting link
 > [ 1076.320932] ata1: port is slow to respond, please be patient (Status 
 > 0xff)
 > [ 1080.158924] ata1: COMRESET failed (errno=-16)

Mysterious. What you have there is a transmission error between the
controller and the disk, which is bad in and by itself, but then there's
a sequence of COMRESETs that fail to bring the port or disk back to life.

The original error is not a driver error but something caused by your
system, be it a dodgy cable, a poorly seated cable, or electrical
interference. But the failed COMRESETs is a concern as I've seen them
in other reports as well.

Me worried ...

So going back to 2.6.21-rc2 makes the system stable again? Can you do some
more testing to see at what point the system becomes less stable? I.e.,
2.6.21-rcI, 2.6.22, 2.6.22-rcJ, 2.6.23, or 2.6.24-rcJ?

FWIW, I just completed some testing of a 300 TX4 card with kernel 2.6.24,
including dd:s, fscks, mkfs:s, and copying about 400GB of data from one drive
(Samsung) to another (Seagate 7200.10) on that card, and I cannot seem to break it.
