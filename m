From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add another Maxtor drive with broken NCQ to the
 list
Date: Thu, 12 Jul 2007 16:10:23 -0400
Message-ID: <46968AAF.6020903@garzik.org>
References: <469674DF.9000804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55552 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755656AbXGLUKZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 16:10:25 -0400
In-Reply-To: <469674DF.9000804@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Chuck Ebbert wrote:
> Add another Maxtor 6B200M0 drive with broken NCQ to the list.
> 
> Signed-off-by: Chuck Ebbert <cebbert@redhat.com>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)

applied


