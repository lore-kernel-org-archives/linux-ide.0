From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Issues with SIS 964 chipset on SATA
Date: Mon, 07 Feb 2005 16:44:33 -0500
Message-ID: <4207E141.3090808@pobox.com>
References: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27586 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261336AbVBGVot (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Feb 2005 16:44:49 -0500
In-Reply-To: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-ide@vger.kernel.org

Gary Poppitz wrote:
> We tracked down a problem with the 964 chipset with a 0x180 ID code that 
> may save someone on the list some time.
> 
> The chip will only transfer multiples of 4 bytes. Anything else will 
> cause it to hang.

Interesting, either ULi or SiS set me a needs-to-be-cleaned-up-a-lot fix 
for this.

SATA transport is dword-based, so this is not surprising.

For the SIS (or ULi, I forget) controller, and perhaps others, a 
workaround needs to be applied.  Suggestions/patches welcome.

We may want to guarantee _DMA_ of 4-byte-aligned chunks, but still only 
reflect the true amount in ATAPI CDB.

	Jeff


