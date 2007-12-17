From: "jameshsu" <jameshsu@acard.com>
Subject: Re: Acard ATP8620 2SATA / 1 IDE  driver - AHCI.C Nov082007
Date: Mon, 17 Dec 2007 10:35:49 +0800
Message-ID: <000501c84055$939c7000$6200a8c0@acardjameshsu>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 219-80-62-20.static.tfn.net.tw ([219.80.62.20]:3979 "EHLO
	Thunder.acard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXLQCiG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Dec 2007 21:38:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, tytso@us.ibm.com, Matti Aarnio <postmaster@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>

Jeff,

Do you know who has SATA sample driver w/ AHCI support for reference (esp., 
for Acard SATA chip)??
If possible, please advise in your earlier convenience ! Appreciate for your 
help!
James
----- Original Message ----- 
From: jameshsu
To: Jeff Garzik
Cc: James Bottomley ; Matti Aarnio ; tytso@us.ibm.com ; IDE/ATA development 
list ; Andrew Morton
Sent: Tuesday, November 27, 2007 6:18 PM
Subject: Re: Acard ATP8620 2SATA / 1 IDE driver - AHCI.C Nov082007


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

