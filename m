From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: convert several bmdma-style controllers to new
 EH, take #2
Date: Tue, 13 Jun 2006 20:44:02 -0400
Message-ID: <448F5BD2.6060905@pobox.com>
References: <20060613115131.GA17964@htj.dyndns.org> <20060613214313.GA10142@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29096 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932372AbWFNAoF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2006 20:44:05 -0400
In-Reply-To: <20060613214313.GA10142@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert sata_sis, svw, uli and vsc drivers to new EH.  All the drivers
> used to specify ATA_FLAG_SATA_RESET to tell libata to use SATA
> hardreset instead of SRST.
> 
> This patch preserves the behavior by defining private error handler
> for each driver which only supports SATA hardreset.  It is likely that
> all these controllers support SRST and can simply use the stock bmdma
> EH.  The private EH methods will be removed after each driver is
> tested w/ the stock bmdma EH.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Too cautious :)  I don't want to add the duplicate code, and then just 
remove it later when things are they are supposed to work.

Just make sure your changes will either (a) work or (b) fail in an 
obvious way :)

Then call for testers...

	Jeff



