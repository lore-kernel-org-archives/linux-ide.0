From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata dev_config call order wrong.
Date: Sun, 29 Aug 2004 13:29:44 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41321288.4090403@pobox.com>
References: <41320DAF.2060306@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50384 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268237AbUH2R35
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Aug 2004 13:29:57 -0400
In-Reply-To: <41320DAF.2060306@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Well, well, well - Three holes in the ground.
> 
> My bridge boards *are* choking on > 200 sector transfers.
> 
> I patched sata_via in the same way sata_sil was patched to tell the 
> controller to use 200 as max_sectors the same way sata_sil uses 15 as 
> max_sectors on the seagates.
> 
> The problem is that ata_scsi_slave_config in libata-scsi.c is getting 
> called *after* .dev_config in sata_via and resetting my value of 200 to 
> 2048.

Take a look at what ATA_DFLAG_LOCK_SECTORS does ;-)  Here's hoping 
that's the last piece of the puzzle...

BTW I just sent email to SiI to see if there is a way to detect a 
PATA->SATA bridge.

	Jeff


