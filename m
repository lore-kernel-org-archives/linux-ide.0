From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Tue, 20 Dec 2005 21:44:17 -0700
Message-ID: <E1Eovpp-0000XC-S5@highlab.com>
References: <43A86AF2.2080508@physics.ucsd.edu> <E1EooUH-0008VA-Vj@highlab.com> <43A87273.2060403@physics.ucsd.edu> <43A88218.1040205@physics.ucsd.edu> <E1Eoq94-00009u-SS@highlab.com> <43A8BF6B.1090006@physics.ucsd.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ecae158-153-dhcp.colorado.edu ([128.138.158.153]:43138 "EHLO
	highlab.com") by vger.kernel.org with ESMTP id S932285AbVLUEnw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Dec 2005 23:43:52 -0500
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1Eovpp-0000XC-S5
	for linux-ide@vger.kernel.org; Tue, 20 Dec 2005 21:44:17 -0700
In-reply-to: <43A8BF6B.1090006@physics.ucsd.edu> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Terrence Martin <tmartin@physics.ucsd.edu> wrote:
> ata8: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
> ata8: slow completion (cmd ef)
> ata8: dev 0 configured for UDMA/133
...
> SCSI device sdc: drive cache: write back
>  sdc:<3>ata8: Entering mv_eng_timeout
> mmio_base f8880000 ap f6b91314 qc f6b917f0 scsi_cmnd f6393e00 &cmnd f6393e44
> ata8: status=0x50 { DriveReady SeekComplete }
> ata8: error=0x01 { AddrMarkNotFound }
> sdc: Current: sense key: No Sense
>     Additional sense: No additional sense information
>  unknown partition table

I've seen this error on my system.  It went away and things work well now.
I did two things at the same time and I'm not sure which one fixed things.

My system has two PCI 32/33 slots and three PCI-X 64/66 slots.


Non-working configuration:

      PCI slot 1: Promise TX2 
      PCI slot 2: Adaptec 2930 (5V card)
    PCI-X slot 1: Promise TX2
    PCI-X slot 2: Marvell 6081
    PCI-X slot 3: empty


Working configuration:

      PCI slot 1: Promise TX2
      PCI slot 2: Promise TX2
    PCI-X slot 1: empty
    PCI-X slot 2: empty
    PCI-X slot 3: Marvell 6081


Could be getting rid of the 5V Adaptec card, could be taking all the
non-PCI-X cards out of the PCI-X slots.  Could be something else.
I'm not sure.  Good luck!


-- 
Sebastian Kuzminsky
