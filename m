From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 06/30] libata: handle ata_pci_device_do_resume() failure
 while resuming
Date: Tue, 06 Mar 2007 06:57:12 -0500
Message-ID: <45ED5718.4030505@garzik.org>
References: <200703061037.l26Abtiq019469@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53692 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965872AbXCFL5O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 06:57:14 -0500
In-Reply-To: <200703061037.l26Abtiq019469@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, dmonakhov@sw.ru, dmonakhov@openvz.org

akpm@linux-foundation.org wrote:
> From: Dmitriy Monakhov <dmonakhov@sw.ru>
> 
> Since commit:553c4aa630af7bc885e056d0436e4eb7f238579b
> ata_pci_device_do_resume() can return error code, all callers was updated
> except this one.
> 
> Signed-off-by: Monakhov Dmitriy <dmonakhov@openvz.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/sata_inic162x.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

applied to #upstream


