From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH UPDATED] libata: use FLUSH_EXT only when driver is larger
 than LBA28 limit
Date: Tue, 14 Nov 2006 13:46:30 -0500
Message-ID: <455A0F06.4030502@pobox.com>
References: <20061110183304.GA22793@htj.dyndns.org> <20061111111045.GB22793@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45767 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S933470AbWKNSqd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 13:46:33 -0500
In-Reply-To: <20061111111045.GB22793@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Danny Kukawka <dkukawka@novell.com>, Stefan Seyfried <seife@novell.com>

Tejun Heo wrote:
> Many drives support LBA48 even when its capacity is smaller than
> 1<<28, as LBA48 is required for many functionalities.  FLUSH_EXT is
> mandatory for drives w/ LBA48 support.
> 
> Interestingly, at least one of such drives (ST960812A) has problems
> dealing with FLUSH_EXT.  It eventually completes the command but takes
> around 7 seconds to finish in many cases thus drastically slowing down
> IO transactions.  This seems to be a firmware bug which sneaked into
> production probably because no other ATA driver including linux IDE
> issues FLUSH_EXT to drives which report support for LBA48 & FLUSH_EXT
> but is smaller than 1<<28 blocks.
> 
> This patch adds ATA_DFLAG_FLUSH_EXT which is set iff the drive
> supports LBA48 & FLUSH_EXT and is larger than LBA28 limit.  Both cache
> flush paths are updated to issue FLUSH_EXT only when the flag is set.
> Note that the changed behavior is more inline with the rest of libata.
> libata prefers shorter commands whenever possible.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Danny Kukawka <dkukawka@novell.com>
> Cc: Stefan Seyfried <seife@novell.com>
> ---
> 
> * In ata_dev_configure(), use dev->n_sectors instead of reading it
> directly from id.

applied to #upstream -- I think this wants more testing than 2.6.19-rc5 
will allow


