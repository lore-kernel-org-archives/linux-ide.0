From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata DMADIR support
Date: Sun, 16 May 2004 19:16:17 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A7F641.3070809@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33259 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264843AbUEPXQb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 19:16:31 -0400
In-Reply-To: <1084717146.3576.3.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> + #undef ATA_FORCE_DMADIR /* give Si DMADIR to all SATA ATAPI DMA */

> I'll save time in the end if I volunteer to write such a patch, after
> you reply to say you would consider such a patch, if in fact you would.


Should be atapi patch #2.2, which I just commited and pushed upstream.

	Jeff



