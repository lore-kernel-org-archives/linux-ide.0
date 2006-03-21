From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC] libata-dev: handle ERR=1 DRQ=1
Date: Tue, 21 Mar 2006 12:35:15 -0500
Message-ID: <44203953.3080803@pobox.com>
References: <441FE605.8010202@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8595 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932328AbWCURfU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 12:35:20 -0500
In-Reply-To: <441FE605.8010202@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, edmudama@gmail.com

Albert Lee wrote:
> handle ERR=1 DRQ=1 for PIO protocol
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> 
> Some PIO read commands might set DRQ=1 alone with ERR=1.
> Under such situation, the data block should be transferred even if err=1.
> 
> This patch adds extra logic to HSM_ST_ERR to handle the required
> data transfer.
> 
> BTW, also found the following work in progress:
> "Disable Data Transfer after Error Detection"
> http://t13.org/docs2006/dt1825Lr3-DDT_TR.pdf
> If this feature is turned on, then DRQ will be guaranteed 0 when ERR=1
> which would simplify the PIO error handling.
> 
> Patch against the irq-pio branch.
> Need your review and advice, thanks.

If DRQ==1 then the error register and ATA_ERR should be considered 
irrelevant.  I agree with Eric, that's more of a "don't touch it, other 
than to SRST it" situation.

	Jeff


