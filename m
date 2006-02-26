From: "kacer" <kacerxy@seznam.cz>
Subject: RE: Kernel driver for Sil 3112 (sata_sil.c) problems
Date: Sun, 26 Feb 2006 20:42:08 +0100
Message-ID: <20060226194220.D2D5937B93@relay.netbox.cz>
References: <44004CC7.8040207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.netbox.cz ([83.240.0.201]:7855 "EHLO relay.netbox.cz")
	by vger.kernel.org with ESMTP id S1751314AbWBZTm2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Feb 2006 14:42:28 -0500
In-Reply-To: <44004CC7.8040207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Tejun,

here is lspci:
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 04)
00:01.0 PCI bridge: Intel Corporation 82815 815 Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (rev 05)
00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #2) (rev 05)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev
3a)
02:0a.0 Mass storage controller: Triones Technologies, Inc.
HPT366/368/370/370A/372/372N (rev 04)
02:0c.0 Mass storage controller: Triones Technologies, Inc.
HPT366/368/370/370A/372/372N (rev 04)
02:0d.0 PCI bridge: Tiger Jet Network Inc. Unknown device 0600 (rev 01)
02:0e.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet
Controller
03:04.0 Mass storage controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 02)
03:05.0 Mass storage controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 02)

lspci -n:
00:00.0 0600: 8086:1130 (rev 04)
00:01.0 0604: 8086:1131 (rev 04)
00:1e.0 0604: 8086:244e (rev 05)
00:1f.0 0601: 8086:2440 (rev 05)
00:1f.1 0101: 8086:244b (rev 05)
00:1f.2 0c03: 8086:2442 (rev 05)
00:1f.3 0c05: 8086:2443 (rev 05)
00:1f.4 0c03: 8086:2444 (rev 05)
01:00.0 0300: 1002:475a (rev 3a)
02:0a.0 0180: 1103:0004 (rev 04)
02:0c.0 0180: 1103:0004 (rev 04)
02:0d.0 0604: e159:0600 (rev 01)
02:0e.0 0200: 8086:1076
03:04.0 0180: 1095:3112 (rev 02)
03:05.0 0180: 1095:3112 (rev 02)

According tests I have found that problems are while writing data, not while
reading.

Jiri Bartosik

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Saturday, February 25, 2006 1:26 PM
To: kacer
Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org
Subject: Re: Kernel driver for Sil 3112 (sata_sil.c) problems

Hello, Jiri.

'lspci -n' please.

-- 
tejun

