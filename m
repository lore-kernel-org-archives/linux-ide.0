From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] sata_via: Apply WD workaround only when needed
Date: Tue, 16 Feb 2016 16:42:53 -0500
Message-ID: <20160216214253.GR3741@mtj.duckdns.org>
References: <1455570107-11520-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35344 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcBPVmz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Feb 2016 16:42:55 -0500
Content-Disposition: inline
In-Reply-To: <1455570107-11520-1-git-send-email-linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-ide@vger.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Kernel development list <linux-kernel@vger.kernel.org>

Hello, Ondrej.

On Mon, Feb 15, 2016 at 10:01:47PM +0100, Ondrej Zary wrote:
> The first hdparm is slower because of the error:
> [   80.964060] ata5.00: exception Emask 0x12 SAct 0x0 SErr 0x1000500 action 0x6
> [   80.964095] ata5.00: BMDMA stat 0x5
> [   80.964108] ata5: SError: { UnrecovData Proto TrStaTrns }
> [   80.964125] ata5.00: failed command: READ DMA EXT
> [   80.964143] ata5.00: cmd 25/00:90:00:00:00/00:04:00:00:00/e0 tag 0 dma 598016 in
>          res 51/84:af:df:00:00/84:03:00:00:00/e0 Emask 0x12 (ATA bus error)
> [   80.964173] ata5.00: status: { DRDY ERR }
> [   80.964185] ata5.00: error: { ICRC ABRT }
> [   80.964209] ata5: hard resetting link
> [   81.284056] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   81.300531] ata5.00: configured for UDMA/133
> [   81.300569] ata5: Incompatible drive (WD?): enabling workaround
> [   81.300598] ata5: EH complete

Hmm... I like the workaround but wish the kernel weren't generating
the above output.  How about doing something like the following?

svia_error_handler()
{
	if (workaround hasn't been applied yet &&
	    the conditions match for the workaround) {
		apply the workaround;
		mark as such;
		print informational message;
		set ATA_EHI_QUIET;
	}

	ata_sff_error_handler(ap);
}

-- 
tejun
