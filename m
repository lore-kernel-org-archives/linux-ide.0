From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: LibATA SCSI WRITE_BUFFER to ATA DOWNLOAD_MICROCODE patch
Date: Fri, 03 Apr 2009 16:07:17 -0400
Message-ID: <49D66C75.9050005@pobox.com>
References: <20090401205115.GA32307@beardog.cca.cpqcorp.net> <49D4F4F4.6040406@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41175 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbZDCUHY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Apr 2009 16:07:24 -0400
In-Reply-To: <49D4F4F4.6040406@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, salimmu@beardog.cca.cpqcorp.net
Cc: linux-ide@vger.kernel.org, scameron@beardog.cca.cpqcorp.net, mike.miller@hp.com, steve.cameron@hp.com

Mark Lord wrote:
> salimmu@beardog.cca.cpqcorp.net wrote:
>> Attach is a patch that adds translation of scsi WRITE_BUFFER to 
>> ATA_DOWNLOAD_MICROCODE command.\
> ..
> 
> Do we really need or want this extra code in-kernel?
> 
> This type of thing is already doable from user-space with SG_IO + ATA_16.
> Eg.  hdparm --fwdownload

If it can be done in userspace, I don't see much reason to add emulation 
in libata-scsi.c...

	Jeff




