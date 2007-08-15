From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 04/25] libata-add-irq_flags-to-struct-pata_platform_info-fix
Date: Wed, 15 Aug 2007 04:28:04 -0400
Message-ID: <46C2B914.2000904@garzik.org>
References: <200708102059.l7AKxXkS008578@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59364 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbXHOI2G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 04:28:06 -0400
In-Reply-To: <200708102059.l7AKxXkS008578@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, htejun@gmail.com, sonic.adi@gmail.com

akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> Remove unneeded, undesirable cast of void*.
> 
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Sonic Zhang <sonic.adi@gmail.com>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_platform.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)

applied


