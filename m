From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v3)
Date: Fri, 23 Nov 2007 10:22:21 -0500
Message-ID: <4746F02D.2060204@rtr.ca>
References: <47463534.9010100@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1640 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755125AbXKWPWX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 10:22:23 -0500
In-Reply-To: <47463534.9010100@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Robert Hancock wrote:
> This fixes some problems with ATAPI devices on nForce4 controllers in ADMA mode
> on systems with memory located above 4GB. We need to delay setting the 64-bit
> DMA mask until the PRD table and padding buffer are allocated so that they don't
> get allocated above 4GB and break legacy mode (which is needed for ATAPI
> devices).
...

Mmm.. I wonder how many other libata drivers have this exact same bug,
whether noticed yet or not ?

Cheers
