From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Thu, 11 Oct 2007 03:22:19 -0400
Message-ID: <76366b180710110022s26d1e108vd86745605f8cf54e@mail.gmail.com>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net> <470C2A16.1040606@garzik.org>
	 <yq1641flhbc.fsf@sermon.lab.mkp.net>
	 <20071010152026.GA1616@cosmic.amd.com>
	 <76366b180710101039s344b588ap1e264ef893db87ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:42817 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbXJKHWU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Oct 2007 03:22:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so419981rvb
        for <linux-ide@vger.kernel.org>; Thu, 11 Oct 2007 00:22:19 -0700 (PDT)
In-Reply-To: <76366b180710101039s344b588ap1e264ef893db87ea@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jordan Crouse <jordan.crouse@amd.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Martin,

Just wanted to report that the 2.6.23 libata-dev with the MSR
pata_cs5536 applied to it is working fine with my LX board. I am using
the first PATA port as my boot/root drive right now.

Thanks,
-Andrew

scsi4 : pata_cs5536
scsi5 : pata_cs5536
ata5: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ff00 irq 14
ata6: DUMMY
ata5.00: ATA-0: , 060729DA, max MWDMA2
ata5.00: 256000 sectors, multi 1: LBA
ata5.00: configured for MWDMA2
scsi 4:0:0:0: Direct-Access     ATA                       0607 PQ: 0 ANSI: 5
sd 4:0:0:0: [sdc] 256000 512-byte hardware sectors (131 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
