From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SII 3512 SATA Progress but help still needed
Date: Mon, 08 Dec 2003 15:33:42 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FD4E026.2020307@pobox.com>
References: <3FCF9B07.5020509@atl.lmco.com> <3FD4D88A.3050708@atl.lmco.com> <200312082126.32948.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29933 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261872AbTLHUd4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2003 15:33:56 -0500
In-Reply-To: <200312082126.32948.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Aron Rubin <arubin@atl.lmco.com>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> I don't know. ;-)
> 
> I have only one idea right now - look what drivers/scsi/libata.c
> does for SATA controllers during init and what drivers/ide/ doesn't.
> 
> I am talking about sata_phy_reset() in libata.c.

libata-core.c :)

Basically for Silicon Image:
* use SATA "SCR" (status and control register) to bring device out of 
any low-power state it may be in
* use SATA SCR to reset SATA bus
* do _not_ issue ATA software reset or E.D.D. (90h), as the desired 
signature is already in the ATA command block registers
* look at the signature, decide ATA or ATAPI
* issue IDENTIFY [PACKET] DEVICE
* issue SET FEATURES (XFER)

That's the ATA_FLAG_SATA_RESET code path.  If the driver has the flag 
ATA_FLAG_SRST, then the first few steps change to:
* issue ATA software reset, by flipping SRST bit in Device Control
* look at signature[...]

I'm pretty sure drivers/ide/pci/siimage.c already does the 
bring-it-out-of-low-power thing, twiddling the SCRs.

(the SCRs are documented in the public SATA spec on www.serialata.org)

In addition, drivers/ide/pci/siimage.c actually does initialize the 
hardware a bit more fully than my SII driver does, IIRC...

	Jeff




