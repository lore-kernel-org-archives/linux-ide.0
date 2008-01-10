From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_qstor: use hardreset instead of
 softreset
Date: Thu, 10 Jan 2008 16:54:20 -0500
Message-ID: <4786940C.7050002@garzik.org>
References: <477CFDAB.3090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33671 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153AbYAJVyX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 16:54:23 -0500
In-Reply-To: <477CFDAB.3090705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> During conversion to new EH, sata_qstor was accidentaly changed to use
> softreset, which is buggy on this chip, instead of hardreset.  This
> patch updates sata_qstor such that it uses hardreset again.
> 
> This fixes bugzilla bug 9631.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mark Lord <mlord@pobox.com>
> ---
>  drivers/ata/sata_qstor.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied


