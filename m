From: Christoph Hellwig <hch@infradead.org>
Subject: Re: ZBC_IN command translation
Date: Wed, 7 Jun 2017 02:07:51 -0700
Message-ID: <20170607090751.GA29487@infradead.org>
References: <4b12630e-1add-6a4e-51ab-52417e60d4b2@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34425 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdFGJHz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jun 2017 05:07:55 -0400
Content-Disposition: inline
In-Reply-To: <4b12630e-1add-6a4e-51ab-52417e60d4b2@wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>

On Wed, Jun 07, 2017 at 06:03:52PM +0900, Damien Le Moal wrote:
> Tejun, Hannes,
> 
> Currently, in libata-scsi.c, the function ata_scsi_zbc_in_xlat
> translating ZBC REPORT ZONES into the ZAC version returns an error if
> the scsi command buffer length is not aligned on 512. This is possible
> since the ZBC version allows report zones buffer as a multiple of 64B,
> while the ZAC version of the same command requires 512B size alignment
> of the command buffer.
> 
> However, SAT-4, in section 9.13.3 says:
> 
> "The SATL shall send the ATA REPORT ZONES EXT command with the ATA
> RETURN PAGE COUNT field set to INT((ALLOCATION LENGTH + 511)/512)."
> 
> So clearly, instead of returning an error, we need to bounce the scsi
> command buffer to a bigger 512B size aligned temporary buffer for the
> ZAC report zones. I do not see any code ready to use to do so easily,
> but I may be missing it. Is there something that can be used to do so or
> do I need to cook something ?

Just like for TRIM we should reject any ZBC_IN/OUT command that doesn't
come from the block layer, and then we can tightly control what input
we get.
