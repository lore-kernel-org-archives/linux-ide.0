From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix kernel-doc parameter warning
Date: Wed, 20 Feb 2008 12:21:10 -0500
Message-ID: <47BC6186.3040805@pobox.com>
References: <20080219134321.68047fa6.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44513 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756166AbYBTRVM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 12:21:12 -0500
In-Reply-To: <20080219134321.68047fa6.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix libata kernel-doc parameter:
> 
> Warning(linux-2.6.25-rc2-git3//drivers/ata/libata-scsi.c:845): No description found for parameter 'rq'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/libata-scsi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied


