From: starlight@binnacle.cx
Subject: unexpected downspeed of AHCI controller on Intel
  Seaburg 5400
Date: Tue, 18 Nov 2008 15:44:23 -0500
Message-ID: <6.2.5.6.2.20081118154009.01c8a2d0@binnacle.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.binnacle.cx ([74.95.187.105]:48602 "EHLO mx.binnacle.cx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbYKRUwq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Nov 2008 15:52:46 -0500
Received: from geileis.binnacle.cx (geileis [172.29.87.12])
	by mx.binnacle.cx (envelope-from <starlight@binnacle.cx>)
	(8.14.1/8.14.1) with ESMTP id mAIKqiKW028282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 15:52:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[prior incomplete message was sent accidently]

Have a relatively recent HP DL160 G5 incorporating the 
Seaburg 5400 chipset.  Appears the 5400 is a MCM including
a 631xESB/632xESB I/O controller.

Running kernel 2.6.27.1.  Latest HP BIOS.

Strangely the SATA controller seems to be reporting that
it can only run at 1.5 Gbps instead of 3 Gbps.

ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part
ahci 0000:00:1f.2: setting latency timer to 64

Looked at the AHCI specification and Intel datasheets for both 
the 5400 and the 631xESB/632xESB.  The latter shows the register 
but does not include 3 Gpbs in the enumeration.  SATA-II support 
is stated in general for the device however.  The SATA links all 
are reported as running at 1.5 Gbps.

Definitely did pull the rate-limit jumpers off the Seagate
ES.2 drives.

details:

http://binnacle.cx/file/ahci_seaburg_downspeed_dmesg.txt
http://binnacle.cx/file/ahci_seaburg_downspeed_dmidecode.txt
http://binnacle.cx/file/ahci_seaburg_downspeed_hdparm-I.txt
http://binnacle.cx/file/ahci_seaburg_downspeed_lspci-vv.txt

