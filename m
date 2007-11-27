From: "jameshsu" <jameshsu@acard.com>
Subject: Re: Acard ATP8620 2SATA / 1 IDE  driver - AHCI.C Nov082007
Date: Tue, 27 Nov 2007 18:18:02 +0800
Message-ID: <015401c830de$da8b62e0$6200a8c0@jameshsu>
References: <00b501c81ace$ece895f0$6200a8c0@jameshsu> <47270656.7080205@garzik.org> <003701c81c63$cee89c30$6200a8c0@jameshsu> <025c01c82016$fbcf3810$d400a8c0@laurence> <025001c82067$d76c04c0$6200a8c0@jameshsu> <20071107221355.GB15784@havoc.gtf.org> <001f01c821b0$20b6c9f0$6200a8c0@jameshsu> <02d301c821e2$25dc01c0$d400a8c0@laurence> <005e01c821fb$502be120$6200a8c0@jameshsu> <20071108162229.GB31492@havoc.gtf.org>
Reply-To: "jameshsu" <jameshsu@acard.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 219-80-62-20.static.tfn.net.tw ([219.80.62.20]:2607 "EHLO
	Thunder.acard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbXK0KU1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:20:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Matti Aarnio <postmaster@vger.kernel.org>, tytso@us.ibm.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Jeff,

First, appreciate for taking few minutes to answer my short question:

1) How is the status of ACARD Linux SATA driver after spec studying??.
Any progress and any qustion/help needed from Acard, esp., AHCI support??
If you have draft open source(driver) now, do you mind to share with us!
Please advise! Thanks!

Best regards & happy holiday season!

James
----- Original Message -----
From: Jeff Garzik
To: jameshsu
Cc: Jason Wu ; LaurenceWu ; Andrew Morton ; IDE/ATA development list ;
tytso@us.ibm.com ; Matti Aarnio ; James Bottomley ; Daniel Weng
Sent: Friday, November 09, 2007 12:22 AM
Subject: Re: Acard ATP8620 2SATA / 1 IDE driver - AHCI.C Nov082007


On Thu, Nov 08, 2007 at 07:34:22PM +0800, jameshsu wrote:
> From: LaurenceWu

> We didn't study about ata/ahci.c, but it should be based on AHCI1.0 or 1.1
> spec. That is, NO P.M. FIS base switching, but supports both non-NCQ and
NCQ
> protocols.
>
> For NCQ or nonNCQ, 8620 is very AHCI-like, although not fully compatible,
> programmer can easily modify standard ahci.c
> for 8620. The main differences between 8620 and AHCI are :
>
> 1. PRD table format changed, (please compare AHCI 1.x section 4.2.3.3 and
> 8620 datasheet section 7.3), 'I' bit in 8620 is defined as 'EOT' and NO
> PRDTL value are available in the
>     Command List Structure.
>
> 2. For NCQ transfer, PxIS bit 3(SDBS) is changed. ATP8620 add the Reg_144h
> to accumulate 32 Sactive bits in each SDB FIS.
>     The Reg_144h is RWC and all its 32 bits are 'ORed'  to form the PxIS
> bit3 and interrupt, if PxIE bit 3 enabled.
>
> Yes.  Modifying the ata/ahci.c is OK to support atp8620.

This is good information, thanks.

After studying the datasheet I also noted a couple differences:

1) Port Multiplier support appears different from standard AHCI.

2) This chip includes target mode support.  Very nice, well done!
I hope that standard AHCI eventually supports this nice feature!

Jeff

