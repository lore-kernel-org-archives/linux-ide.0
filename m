From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use it
 in pata_via, take #2
Date: Tue, 28 Nov 2006 04:00:45 -0500
Message-ID: <456BFABD.6030600@pobox.com>
References: <20061116015050.GB2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49794 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935721AbWK1JAt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:00:49 -0500
In-Reply-To: <20061116015050.GB2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, castet.matthieu@free.fr

Tejun Heo wrote:
> This patch implements ATA_FLAG_SETXFER_POLLING and use in pata_via.
> If this flag is set, transfer mode setting performed by polling not by
> interrupt.  This should help those controllers which raise interrupt
> before the command is actually complete on SETXFER.
> 
> Rationale for this approach.
> 
> * uses existing facility and relatively simple
> * no busy sleep in the interrupt handler
> * updating drivers is easy
> 
> While at it, kill now unused flag ATA_FLAG_SRST in pata_via.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


