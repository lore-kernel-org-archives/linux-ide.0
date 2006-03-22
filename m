From: Ed Sweetman <safemode@comcast.net>
Subject: libata ignores non-dma disks?
Date: Tue, 21 Mar 2006 21:19:37 -0500
Message-ID: <4420B439.6000608@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([63.240.77.81]:54510 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751880AbWCVCTi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 21:19:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I'm using 2.6.16-rc6-ide1 (alan's patchset) and using the sata_nv and 
pata_amd drivers.  I have all UDMA drives except a CF disk -> IDE 
interface, which should be running in PIO mode4.   Libata detects the 
device, but spits out a message about "no dma" and then says it's not 
supported and is ignoring it.   Is this device not supported because 
it's not using dma or for some other reason?  
It's the only device on it's channel (secondary pata)

ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
ata6: dev 0 cfg 49:0e00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0000
ata6: no dma
ata6: dev 0 not supported, ignoring
scsi5 : pata_amd


I'd really like to get this up and running so if anyone has any 
suggestions, I'm all ears.

