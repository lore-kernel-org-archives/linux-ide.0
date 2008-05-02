From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/12] sata_mv pci features
Date: Fri, 02 May 2008 13:41:42 -0400
Message-ID: <481B5256.9040003@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca>	 <481AAFE0.9090101@rtr.ca> <da824cf30805020906k276e6574p93dfe7b696eeda8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2549 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758135AbYEBRlo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 13:41:44 -0400
In-Reply-To: <da824cf30805020906k276e6574p93dfe7b696eeda8b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Grant Grundler wrote:
..
> In order to enable cut-thru, the docs say "MRdTrig" bit in PCI
> Command Register ()xC00) must also be clear on 6042.
> This _might_ also apply to  7042. I didn't see any code in
> this patch (Perhaps a different one?) to make sure
> "MRdTrig" bit is clear.
..

Were you looking for this, from the same patch #02:

..
>>  +               reg = readl(mmio + PCI_COMMAND_OFS);
>>  +               if (reg & PCI_COMMAND_MRDTRIG)
>>  +                       return 0; /* not okay */
..

And, no, this does not apply to the 7042 (PCI Express version).

Cheers
