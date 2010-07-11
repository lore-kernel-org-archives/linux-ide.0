From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: timeout problems on onboard SATA 6.0 controller on Asus P7H57D-V
 EVO
Date: Sun, 11 Jul 2010 00:20:56 -0600
Message-ID: <4C3962C8.60000@gmail.com>
References: <alpine.DEB.1.10.1007101142440.23489@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51918 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab0GKGVA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jul 2010 02:21:00 -0400
Received: by iwn7 with SMTP id 7so3607769iwn.19
        for <linux-ide@vger.kernel.org>; Sat, 10 Jul 2010 23:20:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.1007101142440.23489@uplift.swm.pp.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Abrahamsson <swmike@swm.pp.se>
Cc: linux-ide@vger.kernel.org

On 07/10/2010 03:56 AM, Mikael Abrahamsson wrote:
 >
 > In the thread "mapping ataXX.YY to a /dev/sdX" I had some problems with
 > faultfinding timeout problems. When actually opening the computer up I
 > discovered that this channel actually was connected to the onboard Asus
 > P7H57D-V EVO motherboard 6.0Gb/s ports (one of two) (seems to be Marvell
 > based).
 >
 > I'm running ubuntu 10.04 with their 2.6.32 kernel. Is there a known
 > problem with this controller which is being rectified in later kernels?

Not as far as I know, they are just AHCI..

 >
 > Here is lspci (guess the 08.00.0 is the SATA3 controller, googling for
 > the Device ID yields SATA3 references anyway).
 >
 > 00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller
 > (rev 12)
 > 00:02.0 VGA compatible controller: Intel Corporation Core Processor
 > Integrated Graphics Controller (rev 12)
 > 00:16.0 Communication controller: Intel Corporation 5 Series/3400 Series
 > Chipset HECI Controller (rev 06)
 > 00:1a.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset
 > USB2 Enhanced Host Controller (rev 06)
 > 00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
 > High Definition Audio (rev 06)
 > 00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
 > Express Root Port 1 (rev 06)
 > 00:1c.4 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
 > Express Root Port 5 (rev 06)
 > 00:1c.5 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
 > Express Root Port 6 (rev 06)
 > 00:1c.6 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
 > Express Root Port 7 (rev 06)
 > 00:1c.7 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
 > Express Root Port 8 (rev 06)
 > 00:1d.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset
 > USB2 Enhanced Host Controller (rev 06)
 > 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a6)
 > 00:1f.0 ISA bridge: Intel Corporation 5 Series Chipset LPC Interface
 > Controller (rev 06)
 > 00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset
 > 6 port SATA AHCI Controller (rev 06)
 > 00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus
 > Controller (rev 06)
 > 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
 > RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 03)
 > 02:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6121 SATA II
 > Controller (rev b2)
 > 03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA
 > Raid II Controller (rev 01)
 > 04:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA
 > Raid II Controller (rev 01)
 > 05:00.0 PCI bridge: PLX Technology, Inc. Device 8608 (rev ba)
 > 06:01.0 PCI bridge: PLX Technology, Inc. Device 8608 (rev ba)
 > 06:05.0 PCI bridge: PLX Technology, Inc. Device 8608 (rev ba)
 > 06:07.0 PCI bridge: PLX Technology, Inc. Device 8608 (rev ba)
 > 06:09.0 PCI bridge: PLX Technology, Inc. Device 8608 (rev ba)
 > 07:00.0 USB Controller: NEC Corporation Device 0194 (rev 03)
 > 08:00.0 SATA controller: Device 1b4b:9123 (rev 10)
 >
 > The timeouts look like this:
 >
 > Jul 10 09:36:14 ub kernel: [734783.829968] ata14.00: exception Emask 0x0
 > SAct 0xffff SErr 0x0 action 0x6 frozen
 > Jul 10 09:36:14 ub kernel: [734783.829977] ata14.00: failed command:
 > READ FPDMA QUEUED
 > Jul 10 09:36:14 ub kernel: [734783.829987] ata14.00: cmd
 > 60/40:00:d0:fd:84/00:00:01:00:00/40 tag 0 ncq 32768 in
 > Jul 10 09:36:14 ub kernel: [734783.829989] res
 > 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
 > Jul 10 09:36:14 ub kernel: [734783.829993] ata14.00: status: { DRDY }
 >
 > I found a thread on lkml regarding similar issue
 > <http://kerneltrap.org/mailarchive/linux-kernel/2010/6/10/4581441>, and
 > I guess I can say I'm also hit by it, with different drives, and the
 > same drives work perfectly when I move them to a SiL based controller.
 >
 > <http://mogs.nl/node/35> seems to indicate NCQ based issues...

Unfortunately that's a pretty generic timeout error that could be caused 
by quite a few things, like a hardware issue, bad cable, etc. as well as 
possible driver problem..
