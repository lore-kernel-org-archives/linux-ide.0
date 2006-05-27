From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata resume improvements
Date: Sat, 27 May 2006 16:10:30 -0400
Message-ID: <4478B236.7000007@rtr.ca>
References: <20060527055533.GA5159@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:39830 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964935AbWE0UK3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:10:29 -0400
In-Reply-To: <20060527055533.GA5159@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> This is an example of how one might make sure the ATA bus reaches
> bus-idle, before attempting to talk to it.
> 
> It compiles, but is completely untested...
> 
> Other resume improvements should work at the pci_driver::resume level as
> this does, _not_ the SCSI->ATA->resume device level.
> 
> 
> diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
...

Sorry to say, but no user-visible difference from previous attempts.
Still fails the same way, after a 30-ish second timeout on resume.

Cheers
