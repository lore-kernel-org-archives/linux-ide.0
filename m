From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 03/30] pata: expose set_mode method so it can be wrapped
Date: Fri, 09 Mar 2007 09:19:48 -0500
Message-ID: <45F16D04.8030002@garzik.org>
References: <200703061037.l26Abq2S019460@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56567 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767315AbXCIOTu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 09:19:50 -0500
In-Reply-To: <200703061037.l26Abq2S019460@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Alan <alan@lxorguk.ukuu.org.uk>
> 
> This splits set_mode into do_set_mode and the wrapper so that a driver can
> call the standard method inside its own.  This in theory also obsoletes
> ->post_set_mode().
> 
> Needed for ACPI driver.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/libata-core.c |   37 +++++++++++++++++++++++++++++-------
>  include/linux/libata.h    |    1 
>  2 files changed, 31 insertions(+), 7 deletions(-)

applied


