From: "Roger Heflin" <rheflin@atipa.com>
Subject: RE: sata_mv and MV88SX6041 don't work
Date: Wed, 1 Feb 2006 09:15:52 -0600
Message-ID: <EXCHG2003qSOc7wo95E00001106@EXCHG2003.microtech-ks.com>
References: <200602011543.00647.sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:34716 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932387AbWBAPF2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Feb 2006 10:05:28 -0500
In-Reply-To: <200602011543.00647.sojkam1@fel.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sojkam1@fel.cvut.cz, linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, kelbelj@fel.cvut.cz

 

> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org 
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Michal Sojka
> Sent: Wednesday, February 01, 2006 8:43 AM
> To: linux-ide@vger.kernel.org
> Cc: jgarzik@pobox.com; kelbelj@fel.cvut.cz
> Subject: sata_mv and MV88SX6041 don't work
> 
> Hello,
> 
> we have problems with this SATA controller:
> 
> 0000:03:03.0 RAID bus controller: Marvell Technology Group 
> Ltd. MV88SX6041 4-port SATA II PCI-X Controller (rev 03)
> 
> Is there any chance that this hardware will be supported by 
> sata_mv in near future? Can we help somehow with debugging? 
> Here is the excerpt from
> 2.6.16-rc1 boot messages (the full boot log is attached):
> 
> sata_mv 0000:03:03.0: version 0.5
> ...
> sata_mv 0000:03:03.0: Applying B2 workarounds to unknown rev 
> sata_mv 0000:03:03.0: 32 slots 4 ports unknown mode IRQ via MSI
> ata1: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A2120 bmdma 
> 0x0 irq 185 ...
> ata1: dev 0 ATA-6, max UDMA/133, 72303840 sectors: LBA48
> ata1: qc timeout (cmd 0xef)
> ata1: failed to set xfermode, disabled
> ata1: dev 0 configured for UDMA/133
> 
> 
> We are currently using GPL driver from Marvell
> (http://www.keffective.com/mvsata/FC3/mvSata_Linux_3.6.1.tgz) 
> but we are able to compile it only under 2.6.11. This driver 
> had to be patched to support our revision 3. The original 
> driver supports only revisions greater than 9. Does anybody 
> know whether this is a bug of the driver or there is some 
> reason why lower revisions are not supported?
> 
> We tried it also under 2.6.14 but we did not succeed. It 
> would be nice if we can have this hardware working under 
> newer kernels since we have another problems which are 
> hopefully solved there.
> 
> Please CC me when replying to this e-mail.

Michael,

We have reported highpoints Marvell GPL derivative not working
on 2.6.14+, it does work on 2.6.13 kernels.

I suspect that it will be a while before it works, Highpoint
(and I assume Marvell) are supposed to be working on 
correcting the issues.

I also suspect that it will be a while before the sata_mv is 
fully operational.

                         Roger

