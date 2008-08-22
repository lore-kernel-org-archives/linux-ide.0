From: "xerces8" <xerces8@butn.net>
Subject: (unknown)
Date: Fri, 22 Aug 2008 17:21:14 +0200
Message-ID: <WorldClient-F200808221721.AA21140170@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ikar.perftech.si ([195.246.0.20]:65230 "EHLO ikar.perftech.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbYHVPci (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 11:32:38 -0400
Received: from dedal.perftech.si (unknown [10.12.0.44])
	by ikar.perftech.si (Spam Firewall) with ESMTP id B051131A7A1
	for <linux-ide@vger.kernel.org>; Fri, 22 Aug 2008 17:21:18 +0200 (CEST)
Received: from dedal.perftech.si ([10.12.0.44]) by ikar.perftech.si with ESMTP id V38KV5cjDqTv6yzb for <linux-ide@vger.kernel.org>; Fri, 22 Aug 2008 17:21:18 +0200 (CEST)
Received: from WorldClient by butn.net (MDaemon PRO v9.6.4)
	with ESMTP id 37-md50000233854.msg
	for <linux-ide@vger.kernel.org>; Fri, 22 Aug 2008 17:21:17 +0200
Subject: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hi!

I noticed that recent kernels do not detect my SATA devices (two
SATA hard drives and one DVD unit).

HW: Asus P5K-E WiFi mainboard, BIOS version 1013 (latest as of now)
BIOS setup: SATA adapter mode : AHCI
CPU: Intel Core2 Q6600 (not overclocked)
RAM: 4x2GB DDR2-800

Kernel: 2.6.26.3 (vanilla unpatched)
arch: i386

kernel config : http://pastebin.com/f7640ead2
dmesg output : http://pastebin.com/f3b3fac14
lspci: http://pastebin.com/f2a3edebf
lspci -v -n : http://pastebin.com/f724cf3
/proc/cpuinfo: http://pastebin.com/f11930c44

uname -a :
Linux RIPLinuX 2.6.26.3 #1 Fri Aug 22 16:24:23 CEST 2008 i686 GNU/Linux

/proc/version:
Linux version 2.6.26.3 (stein@udba) (gcc version 4.2.3 (Ubuntu 4.2.3-2u=
buntu7)) #1 Fri Aug 22
16:24:23 CEST 2008

=46unny thing, in 64 bit mode it all works fine (tested and first
discovered with RIPLinux 6.3; the above config should match the 32 bit
config from riplinux)

Please advise.

Regards,
David Bala=C5=BEic


