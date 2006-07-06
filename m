From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata EH appears to be NFG up to 2.6.17 (at least).
Date: Thu, 06 Jul 2006 16:47:06 -0400
Message-ID: <44AD76CA.40100@pobox.com>
References: <44AD749C.1070208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61633 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750842AbWGFUrJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jul 2006 16:47:09 -0400
In-Reply-To: <44AD749C.1070208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Got your attention now?  Good!
> 
> I am doing some testing with known-bad drives on 2.6.16 (and 2.6.17).
> 
> Libata EH is wretched there, because it does not seem to be careful
> about reading/saving the bad ata_status value when an error occurs.
> 
> The ata_status from a failed/aborted command is first read in
> the interrupt handler, either by the LLD or by ata_host_intr().
> 
> This value is not saved for reuse anywhere, and the next time it is read,
> the reader will see ATA_ERR==0, and then not do the Right Thing (tm).
> 
> Who reads it next, you ask?  Well, it gets read *again* from libata-scsi
> when it is trying to generate meaningful sense data.  But at that point,
> all that is seen is 0x50 -- "success".
> 
> So libata-scsi returns incorrect (or no) sense data to the SCSI mid-layer,
> and the error is mishandled or ignored.
> 
> Ugh.  The distro folks will probably want to fix this in their 2.6.1[56]
> based distro kernels.  I don't yet see a way to do this without modifying
> core data structures (eg. adding an ata_status field to the qc).

What driver?
What architecture?
What kernel config?
How does 2.6.18-rc1, with vastly different EH, behave?

	Jeff



