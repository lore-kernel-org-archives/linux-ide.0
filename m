From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/07] sata_mv: restructure mv_qc_issue
Date: Mon, 02 Feb 2009 23:14:34 -0500
Message-ID: <4987C4AA.9040902@pobox.com>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca> <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56067 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbZBCEOi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 23:14:38 -0500
In-Reply-To: <498391D9.2000403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Rearrange logic in mv_qc_issue() to handle protocols
> other than ATA_PROT_DMA, ATA_PROT_NCQ, and ATA_PROT_PIO.
> This is in preparation for later enabling ATAPI support.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied 3-4


