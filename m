From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Add port multiplier (PMP) support in sata_fsl driver
Date: Fri, 30 May 2008 18:11:46 -0400
Message-ID: <48407BA2.5050103@pobox.com>
References: <Pine.LNX.4.64.0805200015010.5318@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44953 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbYE3WLw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 18:11:52 -0400
In-Reply-To: <Pine.LNX.4.64.0805200015010.5318@blarg.am.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, ashish.kalra@freescale.com, htejun@gmail.com

Kumar Gala wrote:
> From: Ashish Kalra <ashish.kalra@freescale.com>
> 
> PMP support for sata_fsl driver.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@freescale.com>
> ---
> Jeff,
> 
> The following commit (4c9bf4e799ce06a7378f1196587084802a414c03):
> libata: replace tf_read with qc_fill_rtf for non-SFF drivers
> 
> Broke the sata_fsl.c driver in 2.6.26.  I know the following patch fixes
> the issue, it clearly also adds port multipler support.  I'm not sure if
> you are willing to take that as part of 2.6.26 or not, but the current
> 2.6.26 driver is broken.
> 
> On boot with debug enabled we get something like (w/o this patch):
> 
> spurious interrupt!!, CC = 0x1
> interrupt status 0x1
> xx_scr_read, reg_in = 1
> spurious interrupt!!, CC = 0x1
> interrupt status 0x1
> xx_scr_read, reg_in = 1
> spurious interrupt!!, CC = 0x1
> interrupt status 0x1
> xx_scr_read, reg_in = 1
> 
> .. continues for ever.
> 
> - k
> 
>  drivers/ata/sata_fsl.c |  224 +++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 163 insertions(+), 61 deletions(-)
> 

applied


