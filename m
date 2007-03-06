From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 02/30] libata: warn if speed limited due to 40-wire cable
Date: Tue, 06 Mar 2007 06:57:03 -0500
Message-ID: <45ED570F.1080501@garzik.org>
References: <200703061037.l26AbpOo019457@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53681 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965870AbXCFL5F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 06:57:05 -0500
In-Reply-To: <200703061037.l26AbpOo019457@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, hancockr@shaw.ca, alan@lxorguk.ukuu.org.uk

akpm@linux-foundation.org wrote:
> From: Robert Hancock <hancockr@shaw.ca>
> 
> Warn the user if a drive's transfer rate is limited because of a 40-wire
> cable detection.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/libata-core.c |   33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)

applied to #upstream


