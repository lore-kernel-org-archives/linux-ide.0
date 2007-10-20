From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix kernel-doc param name
Date: Fri, 19 Oct 2007 22:57:30 -0400
Message-ID: <47196E9A.2050705@pobox.com>
References: <20071018141226.9923ff99.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58431 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966917AbXJTC5e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Oct 2007 22:57:34 -0400
In-Reply-To: <20071018141226.9923ff99.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>, torvalds <torvalds@linux-foundation.org>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix libata kernel-doc parameter name.
> 
> Warning(linux-2.6.23-git13//drivers/ata/libata-core.c:1415): No description found for parameter 'sgl'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/libata-core.c |    2 +-

applied


