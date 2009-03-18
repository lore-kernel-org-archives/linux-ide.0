From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-core Use more robust parsing for multi_count
Date: Wed, 18 Mar 2009 11:58:04 -0400
Message-ID: <49C11A0C.3070502@rtr.ca>
References: <49C1047D.4000008@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:52270 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515AbZCRP6M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 11:58:12 -0400
In-Reply-To: <49C1047D.4000008@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Gents,
> 
> I am debugging a drive hang issue for a client,
> which involves "multiple sector" read/write commands (PIO).
> 
> Libata does not appear (as of current #upstream at least)
> to correctly implement this functionality.
> 
> Specifically, libata doesn't reset dev->multi_count to zero
> on drive resets (whereas the drive firmware often *does*),
> and libata does not deal well with dubious IDENTIFY data.
> 
> So, on resets, we should either clear dev->multi_count,
> or re-probe it from the drive, or issue a SET_MULTIPLE command
> to restore the old value.
> 
> When probing:
> 
> If (dev->id[59] == 0xffff), ignore it.
> If (dev->id[59] & 0x00ff) is not an even power of two, ignore it.
> it should also be ignored (this catches the 0xffff case too).
> 
> The powers of two is from the ATA8 standard, which strongly suggests
> that only powers of two are valid for use with SET_MULTIPLE.
> 
> The probe stuff is trivial to fix (below), but I'm not really
> up to speed on figuring out how to get this code re-invoked
> after drive resets, and on how to ensure that a SET_MULTIPLE
> gets issued to restore the previous working value (with eventual
> fallback to not using it after repeated errors).   Tejun?
..

Mmm.. we also have to re-check and/or re-set dev->multi_count
after any ata_acpi_on_devcfg() call, because some machines use
ACPI taskfiles to issue a "set multi_count" command to the drive.

This appears to be taken care of already though,
as as ata_dev_configure() is where we now invoke ata_acpi_on_devcfg(),
and this all gets called from ata_dev_revalidate().

So with the patch I provided, newer kernels should then be fine.
But I suppose the patch itself could also be even more finicky
about things, and not bother with R/W multi commands if multi_count==1,
and also validate multi_count against the drive's reported maximum 
from ID word 47.

Alan:  do you reckon we'll be fine enough by just checking
that word on its own, or would its interpretation depend upon
the supported ATA revisions of the device?  If so, then so would
the rest of the mult_count support in libata, right?

I'll re-spin a v3 of the patch to check against word 47.

Cheers
