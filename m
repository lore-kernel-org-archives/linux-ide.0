From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata DMADIR support
Date: Mon, 17 May 2004 15:08:06 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A90D96.2040002@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com> <1084819720.4328.86.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40598 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262205AbUEQTIY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 15:08:24 -0400
In-Reply-To: <1084819720.4328.86.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> I remember I promised cross-references into the t13.org theories.  Over
> time I hope to walk back thru ATA/PI 7, 6, 5, and 4.  Here first is most
> of a DMADIR grep in ATA/PI 7, quoted below.

Under the "documents 2003" link on http://www.t13.org/ there is also the 
original Silicon Image proposal:

ATAPI DMA Direction issues Proposal 12/21/03 Hartney
http://www.t13.org/docs2003/e03132r3.pdf

Though the latest rev of ATA/ATAPI7 docs are probably a more up-to-date 
guide.

> If bit 15 of word 62 is cleared to 0, DMADIR bit in the PACKET command
> is not required. If bit 15 of word 62  is cleared to zero, then all bits
> of word 62 shall be cleared to zero.

I bet your bridge doesn't _require_ DMADIR, therefore it doesn't bother 
with word 62?  </wild guess>

	Jeff



