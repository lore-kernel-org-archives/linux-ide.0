From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata atapi work #5
Date: 14 May 2004 12:42:47 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084560167.8752.7.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:40399 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262060AbUENSnR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 14:43:17 -0400
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

> -				if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
> +				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
> ...
> -	ATA_QCFLAG_POLL		= (1 << 5), /* polling, no interrupts */

Back in PATA, when I set x02 ATA_NIEN, I mis/remember I saw INTRQ float,
rather than becoming reliably deasserted.

Is life better in SATA?

Pat LaVarre


