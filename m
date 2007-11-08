From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Acard ATP8620 2SATA / 1 IDE  driver - AHCI.C Nov082007
Date: Thu, 8 Nov 2007 11:22:29 -0500
Message-ID: <20071108162229.GB31492@havoc.gtf.org>
References: <00b501c81ace$ece895f0$6200a8c0@jameshsu> <47270656.7080205@garzik.org> <003701c81c63$cee89c30$6200a8c0@jameshsu> <025c01c82016$fbcf3810$d400a8c0@laurence> <025001c82067$d76c04c0$6200a8c0@jameshsu> <20071107221355.GB15784@havoc.gtf.org> <001f01c821b0$20b6c9f0$6200a8c0@jameshsu> <02d301c821e2$25dc01c0$d400a8c0@laurence> <005e01c821fb$502be120$6200a8c0@jameshsu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:40007 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759187AbXKHQWa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 11:22:30 -0500
Content-Disposition: inline
In-Reply-To: <005e01c821fb$502be120$6200a8c0@jameshsu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jameshsu <jameshsu@acard.com>
Cc: Jason Wu <jason_wu@acard.com>, DerweiChen =?utf-8?B?KOmZs+W+t+WogSk=?= <derwei@acard.com>, LaurenceWu <laurence@acard.com>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, tytso@us.ibm.com, Matti Aarnio <postmaster@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Daniel Weng <dweng@acard.com>

On Thu, Nov 08, 2007 at 07:34:22PM +0800, jameshsu wrote:
> From: LaurenceWu

> We didn't study about ata/ahci.c, but it should be based on AHCI1.0 or 1.1
> spec. That is, NO P.M. FIS base switching, but supports both non-NCQ and NCQ
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



