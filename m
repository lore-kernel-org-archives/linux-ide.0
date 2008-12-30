From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.27.10: ata1.00: HPA detected: current 293044655, native
  293046768
Date: Tue, 30 Dec 2008 11:30:07 -0600
Message-ID: <495A5A9F.9020406@shaw.ca>
References: <alpine.DEB.1.10.0812300657050.11356@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55669 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbYL3RfF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2008 12:35:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LHiUg-0003SM-82
	for linux-ide@vger.kernel.org; Tue, 30 Dec 2008 17:35:02 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 17:35:02 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 17:35:02 +0000
In-Reply-To: <alpine.DEB.1.10.0812300657050.11356@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org

Justin Piszcz wrote:
> On one system, two Raptor 150s:
> 
> [    0.739402] ata1.00: HPA detected: current 293044655, native 293046768
> [    0.739491] ata1.00: ATA-7: WDC WD1500ADFD-00NLR5, 21.07QR5, max 
> UDMA/133
> [    0.739577] ata1.00: 293044655 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    0.742454] ata1.00: configured for UDMA/133
> 
> [    1.059146] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.061406] ata2.00: ATA-7: WDC WD1500ADFD-00NLR5, 21.07QR5, max 
> UDMA/133
> [    1.061494] ata2.00: 293046768 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.064360] ata2.00: configured for UDMA/133
> 
> Two disks in a RAID-1 (mdadm) configuration, how come the first one
> has an issue w/HPA as the firmware of both disks is the same..?
> 
> l1:~# smartctl -a /dev/sda | grep -i bytes
> User Capacity:    150,038,863,360 bytes
> l1:~# smartctl -a /dev/sdb | grep -i bytes
> User Capacity:    150,039,945,216 bytes
> l1:~#
> 
> Why does this occur?

Presumably somebody or something set up a host protected area on one 
drive and not the other.. I believe there are some utilities out there 
that can be used to disable the HPA and allow the full capacity to be used.

