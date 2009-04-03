From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: LibATA SCSI WRITE_BUFFER to ATA DOWNLOAD_MICROCODE patch
Date: Fri, 03 Apr 2009 15:24:15 -0500
Message-ID: <1238790255.3359.85.camel@mulgrave.int.hansenpartnership.com>
References: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
	 <49D4F4F4.6040406@rtr.ca>  <49D66C75.9050005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46488 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762534AbZDCUYS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Apr 2009 16:24:18 -0400
In-Reply-To: <49D66C75.9050005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, salimmu@beardog.cca.cpqcorp.net, linux-ide@vger.kernel.org, scameron@beardog.cca.cpqcorp.net, mike.miller@hp.com, steve.cameron@hp.com

On Fri, 2009-04-03 at 16:07 -0400, Jeff Garzik wrote:
> Mark Lord wrote:
> > salimmu@beardog.cca.cpqcorp.net wrote:
> >> Attach is a patch that adds translation of scsi WRITE_BUFFER to 
> >> ATA_DOWNLOAD_MICROCODE command.\
> > ..
> > 
> > Do we really need or want this extra code in-kernel?
> > 
> > This type of thing is already doable from user-space with SG_IO + ATA_16.
> > Eg.  hdparm --fwdownload
> 
> If it can be done in userspace, I don't see much reason to add emulation 
> in libata-scsi.c...

The only reason I might be able to see it isn't for firmware download,
agreed, since nothing in the kernel would ever use it.

If were were going to add some type of domain validation to the lines in
SAS/SATA using write buffer echo tests, it might be more plausible, but
that isn't the purpose of the patch.

James


