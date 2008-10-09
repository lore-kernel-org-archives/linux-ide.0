From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: VIA SATA/PATA problem
Date: Thu, 9 Oct 2008 16:26:17 +0200
Message-ID: <18670.5257.616698.563401@harpo.it.uu.se>
References: <1223559916.13924.13.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:55632 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758875AbYJIO1s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Oct 2008 10:27:48 -0400
In-Reply-To: <1223559916.13924.13.camel@jetpack.demon.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Alan Hourihane writes:
 > Hi,
 > 
 > I've got a VIA SATA/PATA PCI RAID card installed in a MIPS box, which
 > obviously doesn't run the BIOS on the card.
 > 
 > When booting these messages appear....
 > 
 > PCI: Enabling device 0000:00:0a.3 (0000 ->
 > 0003)                                
 > sata_via 0000:00:0a.3: routed to hard irq line
 > 9                                
 > scsi0 :
 > sata_via                                                                
 > scsi1 :
 > sata_via                                                                
 > scsi2 :
 > sata_via                                                                
 > ata1: SATA max UDMA/133 port i16@0x1890 bmdma 0x1860 irq
 > 9                      
 > ata2: SATA max UDMA/133 port i16@0x18a0 bmdma 0x1868 irq
 > 9                      
 > ata3: PATA max UDMA/133 port i16@0x18b0 bmdma 0x1870 irq
 > 9                      
 > ata1: SATA link down (SStatus 8C8C8C8C SControl
 > 8C8C8C8C)                       
 > ata2: SATA link down (SStatus 8C8C8C8C SControl
 > 8C8C8C8C)                       
 > ata3: port is slow to respond, please be patient (Status
 > 0x8c)                  
 > ata3: device not ready (errno=-16), forcing hardreset                 
 > 
 > Now, the 8C8C8C8C is suspicious because the card hasn't had the BIOS
 > executed, so something isn't getting initialized. As it's the same for
 > even the PATA port with 0x8c.
 > 
 > Any ideas ?

None for VIA specifically, but I long ago had a similar (but
less severe) problem with a sata_promise card in a sparc64 box.
What I ended up doing was to
1. put the card in an x86 box, boot, and dump its PCI config
   space with lspci
2. put the card in the non-x86 box, boot, and dump its PCI config
   space with lspci
3. compare the PCI config spaces from steps 1 and 2, note any
   differences, and study manual/datasheet/driver to see what
   the diffs might mean
4. add missing initialisations to the Linux driver

/Mikael
