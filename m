From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix kernel-doc parameters
Date: Wed, 09 May 2007 20:17:58 -0400
Message-ID: <464264B6.60900@pobox.com>
References: <20070501173555.6e95c3bb.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50646 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760083AbXEJASB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 20:18:01 -0400
In-Reply-To: <20070501173555.6e95c3bb.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Warning(linux-2.6.21-git4//drivers/ata/libata-core.c:904): No description found for parameter 'new_sectors'
> Warning(linux-2.6.21-git4//drivers/ata/libata-core.c:941): No description found for parameter 'new_sectors'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/libata-core.c |    2 ++
>  1 file changed, 2 insertions(+)

applied


