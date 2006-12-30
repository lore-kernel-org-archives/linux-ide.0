From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: bug: AHCI: Serial ATA to CompactFlash adapter loops endlessly
Date: Sat, 30 Dec 2006 12:48:44 -0500
Message-ID: <20061230174844.GY18867@kvack.org>
References: <20061117211135.GO7299@kvack.org> <45842390.1000102@pobox.com> <20061220021309.GY1104@kvack.org> <4596984F.4020604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kanga.kvack.org ([66.96.29.28]:36080 "EHLO kanga.kvack.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbWL3RtD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Dec 2006 12:49:03 -0500
Content-Disposition: inline
In-Reply-To: <4596984F.4020604@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Sat, Dec 30, 2006 at 11:48:15AM -0500, Mark Lord wrote:
> >Got any ideas for things to try?
> 
> Just for extra info, try redoing your tests *without* smartd running.
> (possible theory is that S.M.A.R.T. commands may be interfering
> or triggering some kind of buggy behaviour somewhere).

With smartd killed, it still seems to be triggering with the following 
message:

Dec 30 12:38:49 tower kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Dec 30 12:38:49 tower kernel: ata4.00: (BMDMA stat 0x26)
Dec 30 12:38:49 tower kernel: ata4.00: cmd c8/00:08:70:e9:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
Dec 30 12:38:49 tower kernel:          res 50/00:00:70:e9:02/00:00:00:00:00/e0 Emask 0x20 (host bus error)
Dec 30 12:38:49 tower kernel: ata4.00: configured for UDMA/33
Dec 30 12:38:49 tower kernel: ata4: EH complete
Dec 30 12:38:49 tower kernel: SCSI device sdc: 4030464 512-byte hdwr sectors (2064 MB)
Dec 30 12:38:49 tower kernel: sdc: Write Protect is off
Dec 30 12:38:49 tower kernel: SCSI device sdc: write cache: disabled, read cache: enabled, doesn't support DPO or FUA

>From what I've found experimenting, the problem seems to occur much more 
frequently with larger IOs often around the same offset (~181000 blocks).  
Is there any way to force libata to drop back to a slower UDMA mode (but not 
PIO) to see if it may be a timing issue with the card and adapter itself?

The other problem I'm finding is that this new motherboard doesn't want to 
use AHCI, regardless of the settings of the BIOS.  The old IDE drivers will 
only work in PIO mode on this chipset (an ICH7, I think), making it difficult 
to compare things.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
