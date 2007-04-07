From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SB600 SATA errors with MSI enabled
Date: Sat, 07 Apr 2007 06:04:18 -0400
Message-ID: <46176CA2.4010705@garzik.org>
References: <46175D6E.7090600@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41878 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965336AbXDGKEX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Apr 2007 06:04:23 -0400
In-Reply-To: <46175D6E.7090600@yahoo.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rathskunk@yahoo.ca
Cc: linux-ide@vger.kernel.org

Christopher Jones wrote:
> Hello,
> 
> I have some testing to report.  Using debian 4.0 and kernel 2.6.20.6 The 
> computer is a Dell inspiron 1501 laptop.  I get errors and the hard disc 
> is not detected.
> 
> ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA 
> mode
> ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pmp pio slum part
> ata3: SATA max UDMA/133 cmd 0xFFFFC20000022100 ctl 0x0 bmdma 0x0 irq 317
> ata4: SATA max UDMA/133 cmd 0xFFFFC20000022180 ctl 0x0 bmdma 0x0 irq 317
> ata5: SATA max UDMA/133 cmd 0xFFFFC20000022200 ctl 0x0 bmdma 0x0 irq 317
> ata6: SATA max UDMA/133 cmd 0xFFFFC20000022280 ctl 0x0 bmdma 0x0 irq 317
> scsi2 : ahci
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: qc timeout (cmd 0xec)
> ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> 
> Using pci=nomsi causes the hard disc to be detected and it works correctly.
> 
> The same errors occurred with the 2.6.18 kernel.  Again pci=nomsi fixes it.

Yep, broken interrupt delivery will definitely look like that.  MSI is 
definitely a problem here, at least on SB600.


> I can also report that the pata_atiixp driver which was new between 
> 2.6.18 and 2.6.20.6 works correctly for my CD drive.

That driver does not use MSI, so no worries there.

	Jeff



