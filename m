From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH -mm] libata: add human-readable error value decoding v3
Date: Tue, 02 Oct 2007 11:20:41 -0400
Message-ID: <470261C9.3000700@garzik.org>
References: <46B36D59.7060803@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50723 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbXJBPUn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 11:20:43 -0400
In-Reply-To: <46B36D59.7060803@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Robert Hancock wrote:
> This adds human-readable decoding of the ATA status and error registers
> (similar to what drivers/ide does) as well as the SATA Serror register to
> libata error handling output.  This prevents the need to pore through
> standards documents to figure out the meaning of the bits in these
> registers when looking at error reports.  Some bits that drivers/ide
> decoded are not decoded here, since the bits are either command-dependent
> or obsolete, and properly parsing them would add too much complexity.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> 
> ---
> 
> Rebased to apply to 2.6.23-rc1-mm2.

I'm applying this manually....   sorry it took so long, the asymmetry of 
"{DRDY }" bugged me, so I did a few cleanups.


