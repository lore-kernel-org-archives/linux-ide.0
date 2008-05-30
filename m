From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix libata-scsi kernel-doc notation
Date: Fri, 30 May 2008 18:11:29 -0400
Message-ID: <48407B91.9060906@pobox.com>
References: <20080430125700.6d1d24b1.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44936 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbYE3WLb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 18:11:31 -0400
In-Reply-To: <20080430125700.6d1d24b1.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix libata-scsi kernel-doc notation:
> 
> Warning(linux-2.6.25-git15//drivers/ata/libata-scsi.c:1659): No description found for parameter 'cmd'
> Warning(linux-2.6.25-git15//drivers/ata/libata-scsi.c:1971): No description found for parameter 'buf'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/libata-scsi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied


