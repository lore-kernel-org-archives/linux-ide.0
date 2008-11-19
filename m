From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: unexpected downspeed of AHCI controller on Intel    Seaburg 5400
Date: Tue, 18 Nov 2008 20:04:42 -0600
Message-ID: <4923743A.2050903@shaw.ca>
References: <6.2.5.6.2.20081118154009.01c8a2d0@binnacle.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:35818 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbYKSCE7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Nov 2008 21:04:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L2cR5-000175-Ql
	for linux-ide@vger.kernel.org; Wed, 19 Nov 2008 02:04:55 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 19 Nov 2008 02:04:55 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 19 Nov 2008 02:04:55 +0000
In-Reply-To: <6.2.5.6.2.20081118154009.01c8a2d0@binnacle.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

starlight@binnacle.cx wrote:
> [prior incomplete message was sent accidently]
> 
> Have a relatively recent HP DL160 G5 incorporating the 
> Seaburg 5400 chipset.  Appears the 5400 is a MCM including
> a 631xESB/632xESB I/O controller.
> 
> Running kernel 2.6.27.1.  Latest HP BIOS.
> 
> Strangely the SATA controller seems to be reporting that
> it can only run at 1.5 Gbps instead of 3 Gbps.
> 
> ahci 0000:00:1f.2: version 3.0
> ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode

That comes right out of the controller's registers, so presumably it is 
telling the truth. That particular value is only used for display, 
though - the actual negotiated speed is determined from other registers. 
So if the controller says it can only do 1.5 and the drives all 
negotiated at 1.5, well, that's likely all it can do..

> ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part
> ahci 0000:00:1f.2: setting latency timer to 64
> 
> Looked at the AHCI specification and Intel datasheets for both 
> the 5400 and the 631xESB/632xESB.  The latter shows the register 
> but does not include 3 Gpbs in the enumeration.  SATA-II support 
> is stated in general for the device however.  The SATA links all 
> are reported as running at 1.5 Gbps.

It doesn't necessarily mean anything that it supports SATA II, that's 
just a revision of the spec and it defines support for 3 Gbps, but 
doesn't require it.

> 
> Definitely did pull the rate-limit jumpers off the Seagate
> ES.2 drives.
> 
> details:
> 
> http://binnacle.cx/file/ahci_seaburg_downspeed_dmesg.txt
> http://binnacle.cx/file/ahci_seaburg_downspeed_dmidecode.txt
> http://binnacle.cx/file/ahci_seaburg_downspeed_hdparm-I.txt
> http://binnacle.cx/file/ahci_seaburg_downspeed_lspci-vv.txt
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

