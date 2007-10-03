From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 3 Oct 2007 19:22:32 +0100
Message-ID: <20071003192232.558ec72b@the-village.bc.nu>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49915 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757699AbXJCSR5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 14:17:57 -0400
In-Reply-To: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <mkp@mkp.net>
Cc: linux-ide@vger.kernel.org, info-linux@geode.amd.com

> pata_cs5536.c relies on Geode Machine Specific Registers to configure
> the ATA function and uses the correct PIO timings for the chip.
> 
> Signed-off-by: Martin K. Petersen <mkp@mkp.net>

I'm basically happy with this but would appreciate some feedback from AMD
on the subject.

(cc added therefore : info-linux@geode.amd.com)

> +	.qc_issue	= ata_qc_issue_prot,

The older AMD ex NS ex Cyrix chipsets mishandle 64K DMA blocks - is that
the case for the CS5536 or not - does it consider a PRD entry with zero
length as 64K or 0 bytes

> +	if ((cfg & IDE_CFG_CHANEN) == 0) {
> +		printk(KERN_ERR "CS5536: disabled by BIOS\n");

To save Jeff whining - he'll want that to be DRV_NAME or similar and to
call it pata_cs5536

