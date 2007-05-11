From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 10/20] add the ATI  SB700 SATA controller device id  to
 AHCI pci table
Date: Fri, 11 May 2007 18:16:32 -0400
Message-ID: <4644EB40.3070201@garzik.org>
References: <200705110548.l4B5mpwH007642@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43694 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239AbXEKWQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 18:16:34 -0400
In-Reply-To: <200705110548.l4B5mpwH007642@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, henry.su@amd.com, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: "Henry Su" <henry.su@amd.com>
> 
> Add the device ID to AHCI pci table for ATI SB700 SATA controller, the
> subsequent chipset of SB600.
> 
> Signed-off-by: henry su<henry.su@amd.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/ahci.c |    1 +
>  1 file changed, 1 insertion(+)

applied


