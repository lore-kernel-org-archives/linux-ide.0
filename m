From: Hein-Pieter van Braam <hp@syntomax.com>
Subject: sata_mv PCI ERROR; PCI IRQ reason=0x00000000 highpoint rocketraid
	2300 pci-e
Date: Wed, 14 Nov 2007 23:58:19 +0100
Message-ID: <1195081099.21755.18.camel@liza>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a80-126-0-120.adsl.xs4all.nl ([80.126.0.120]:34940 "EHLO
	ifolder.erca.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbXKNXEi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 18:04:38 -0500
Received: from [192.168.2.10] (krimson.erca.nl [192.168.4.1])
	by ifolder.erca.nl (8.13.8/8.13.8/Debian-3) with ESMTP id lAEMwJh1013057
	for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 23:58:19 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi list,

I have a couple of Highpoint Rocket(Fake)Raid 2300 PCI-e X1 adapters in
my system, I bought those because the box said ('Open Source' next to
'linux driver' btw, talk about false advertising). Here's the lspci
output:

02:00.0 SCSI storage controller: HighPoint Technologies, Inc. RocketRAID
230x 4 Port SATA-II Controller (rev 02)
03:00.0 SCSI storage controller: HighPoint Technologies, Inc. RocketRAID
230x 4 Port SATA-II Controller (rev 02)
04:00.0 SCSI storage controller: HighPoint Technologies, Inc. RocketRAID
230x 4 Port SATA-II Controller (rev 02)

and lspci -n

02:00.0 0100: 1103:2300 (rev 02)
03:00.0 0100: 1103:2300 (rev 02)
04:00.0 0100: 1103:2300 (rev 02)

Now, because the chip on the thing is a Marvell 7042 I figured I just
add the PCI ID to the driver. I tried this, and, if I do not boot from
the device it does seem to work. I did however get the following errors
(a lot):

02:00.0 sata_mv PCI ERROR; PCI IRQ reason=0x00000000

I write this from memory, but the numbers are correct, sorry if they do
not EXACTLY match.

The disk drives do work, but they are dog slow, and when I try to boot
my ubuntu 7.10 system with this driver, it hangs during boot, right
after it tried to enable my software raid volumes. 

I have tried both the 'stock' ubuntu kernel 2.6.22-14-generic (I guess
that won't mean much) but I also tried vanilla kernel.org 2.6.23.1

I realize that this is probably too little information, and I'm very
willing to provide any other information that you might want. 
I'd love to provide a complete boot log, but my @#$@#%@#$ motherboard
does not have a serial interface. Any suggestion is highly
appreciated :)

Thank you so much for your help in advance, I feel all dirty using the
proprietary driver from highpoint :)

- Hein-Pieter van Braam


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

