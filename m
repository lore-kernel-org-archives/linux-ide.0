From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Sata_promise.c queries
Date: Fri, 11 Feb 2005 18:03:27 -0500
Message-ID: <420D39BF.6090602@pobox.com>
References: <8142CBF3-7AB2-11D9-A80A-000A95D2AC6A@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27088 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261387AbVBKXDo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Feb 2005 18:03:44 -0500
In-Reply-To: <8142CBF3-7AB2-11D9-A80A-000A95D2AC6A@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-ide@vger.kernel.org

Gary Poppitz wrote:
> First off, I have the libdata-2.6 pull.
> 
> The version of sata_promise.c is 1.58 .
> 
> Is this the latest one available?
> 
> 
> Next question, in function pdc_qc_issue_prot, there is a BUG() call in 
> the case of
> ATA_PROT_ATAPI_DMA.
> 
> Is this one of those "fixme"s that will be addressed Real Soon Now, or 
> is this an actual error that I am hitting. Naturally, the device I am 
> using wants to do ATAPI DMA.

That's the "ATAPI is not implemented yet for this driver" warning.

	Jeff



