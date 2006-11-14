From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/4] libata: separate out rw ATA taskfile building into
 ata_build_tf()
Date: Tue, 14 Nov 2006 11:13:47 -0500
Message-ID: <4559EB3B.9050805@rtr.ca>
References: <11635120302199-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1032 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S966141AbWKNQNt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 11:13:49 -0500
In-Reply-To: <11635120302199-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

This logic sequence bothers me slightly:

Tejun Heo wrote:
> Separate out rw ATA taskfile building from ata_scsi_rw_xlat() into
> ata_build_tf().  This will be used to improve media error handling.
...
> +	if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
> +			   ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
> +		/* yay, NCQ */
> +		if (!lba_48_ok(block, n_block))
> +			return -ERANGE;
...
> +	} else if (dev->flags & ATA_DFLAG_LBA) {
> +		tf->flags |= ATA_TFLAG_LBA;
> +
> +		if (lba_28_ok(block, n_block)) {
> +			/* use LBA28 */
> +			tf->device |= (block >> 24) & 0xf;
> +		} else if (lba_48_ok(block, n_block)) {
> +			if (!(dev->flags & ATA_DFLAG_LBA48))
> +				return -ERANGE;
...

In the first case, if !lba_48_ok(), then we should at least attempt
to see if the request can be issued via non-NCQ.

Something like this:

if (lba_48_ok() && dev->flags & (ATA_DFLAG_PIO|ATA_DFLAG_NCQ_OFF|ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
   /* yay, NCQ */
   ...
} else if (dev->flags & ATA_DFLAG_LBA) {
   ...

..except prettier!  ;)

In theory, it looks like an impossible sequence anyway..
if we have the NCQ flag set, then we probably already *know*
that LBA48 is okay.  But since we're not making that assumption,
let's give it the benefit of a doubt and try non-NCQ if LBA48 is a no-go.

Cheers

