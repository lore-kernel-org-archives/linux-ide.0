From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci fails with SATA DVD drive, IDE mode works
Date: Thu, 19 Feb 2009 18:10:26 +0900
Message-ID: <499D2202.7070503@kernel.org>
References: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51787 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955AbZBSJK0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 04:10:26 -0500
In-Reply-To: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-ide@vger.kernel.org

Hello,

Chuck Ebbert wrote:
> Using kernel 2.6.29-rc3...
> 
> lspci says this device in IDE mode is ID 8086:292d Intel (ICH9M/M-E)
> In that mode it works with the ata_piix driver.
> 
> But with ahci mode I get:
>
> ata2: Sata link up 1.5Gbps (SStatus 113 SControl 300)
> ata2.00 ATAPI: TSSTcorp CDDVDW TS-L633A, UO00, max MWDMA2, ATAPI AN
> ata2.00 applying bridge limits
> ata2.00 configured for PIO4
> ata2.00 qc timeout (cmd 0xa0)
> ata2.00 failed to clear UNIT ATTENTION (err_mask=0x5)
> ata2: Sata link up 1.5Gbps (SStatus 113 SControl 300)
> ata2.00 configured for PIO4
> ata2.00 qc timeout (cmd 0xa0)
> ata2.00 failed to clear UNIT ATTENTION (err_mask=0x5)
> ata2: limiting SATA link speed to 1.5Gbps
> ata2.00 limiting speed to PIO3
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: COMRESET failed (errno=-16)
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: COMRESET failed (errno=-16)
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: COMRESET failed (errno=-16)
> ata2: COMRESET failed (errno=-16)
> ata2: reset failed, giving up
> ata2.00: disabled
> ata2: hard resetting link
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: COMRESET failed (errno=-16)

Can you please attach log of successful boot using ata_piix and the
output of "hdparm -I" on the drive?  Also, if you put a different
harddisk and more preferably a different ATAPI device there, does it
work in ahci mode?

Thanks.

-- 
tejun
