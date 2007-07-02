From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc6] libata: remove reading alt_status from ata_hsm_qc_complete()
Date: Mon, 02 Jul 2007 10:14:29 -0400
Message-ID: <46890845.8070909@garzik.org>
References: <4683176B.3060605@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51862 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759755AbXGBOOa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 10:14:30 -0400
In-Reply-To: <4683176B.3060605@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> In ata_hsm_qc_complete():
> Calling ata_altstatus() after the qc is completed might race with next qc. Remove it.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> Jeff,
> 
> (Sorry for re-submitting this patch so late.)
> The unneeded reading of alt_status might cause trouble when another command doing activity like pio data xfer.
> After checking, the flush here is leftover/merge damage of ata_pio_block( ) in 2.6.17-rc5:
> http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commitdiff;h=bb31a8faa270beafcc51a65880c5564c6b718bd6
> We can safely remove it.

applied


