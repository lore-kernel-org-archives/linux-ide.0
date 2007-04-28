From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 08/10] drivers/ata/pata_cmd640.c: fix build with CONFIG_PM=n
Date: Sat, 28 Apr 2007 15:17:10 -0400
Message-ID: <46339DB6.2030505@garzik.org>
References: <200704260719.l3Q7JQ8B023700@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53693 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754118AbXD1TRM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 15:17:12 -0400
In-Reply-To: <200704260719.l3Q7JQ8B023700@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> This is grubby, but all the ata drivers do it this way.
> 
> Would it not be better to do
> 
> #define ata_scsi_device_resume NULL
> 
> in libata.h, remove all those ifdefs?
> 
> (updated version, ug, ug)
> 
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_cmd640.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

applied 8-9


