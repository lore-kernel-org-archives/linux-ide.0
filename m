From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 27/30] pata_cmd640: CMD640 PCI support
Date: Tue, 06 Mar 2007 07:01:50 -0500
Message-ID: <45ED582E.1050407@garzik.org>
References: <200703061038.l26AcBSc019545@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53755 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933239AbXCFMBv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 07:01:51 -0500
In-Reply-To: <200703061038.l26AcBSc019545@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Support for the PCI CMD640 (not VLB)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/Kconfig       |   10 +
>  drivers/ata/Makefile      |    1 
>  drivers/ata/pata_cmd640.c |  298 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 309 insertions(+)

applied


