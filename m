From: Felix Seeger <seeger@sitewaerts.de>
Subject: Problems with Asus P4P800-VM and compatibility-mode for IDE drives
Date: Fri, 1 Jul 2005 18:01:00 +0200
Message-ID: <200507011801.00261.seeger@sitewaerts.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trans145.ems-ag.de ([212.86.207.149]:5638 "EHLO
	samoa.sitewaerts") by vger.kernel.org with ESMTP id S263383AbVGAQAD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Jul 2005 12:00:03 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I just got an Asus P4P800-VM board. I am trying to get it working with one ide 
drive, and two sata drives.

If I enable "Enhanced Mode" in the bios, I am not able to boot linux because I 
get "irq11: nobody cared". IRQ 11 is the ide ide driver as far as I was able 
to see from the messages above.

I found this problem with google and there, the workaround is to enable 
"Compatibility Mode". 

In Compatibility mode, I am unable to enable DMA and/or UDMA3+ Modes for my 
IDE drive, even bios/hdparm -i says they are available. For dma I get  a 
"Operation not permitted" from hdparm without a message in my system logs.

Also, it doesn't help to compile the scsi sata ich5 driver as a module or if I 
remove the driver from the configuration and deaktivate the sata drives.


The only way I get DMA working is in enhanced mode, but there I get the IRQ 
Problems when I plug in my sata drives. Next I will try is a bios update, but 
the notes from asus don't look like they changes something there.


Is this a known problem, can I help to debug this ? At the moment I cannot use 
the machine anyway so I can test patches, no important data on the hd.


I am running a 2.6.12.1 Linus kernel.

Thanks !
Felix

P.S. Please CC me
