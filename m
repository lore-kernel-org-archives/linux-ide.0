From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_jmicron: fix disabled port handling in	jmicron_pre_reset()
Date: Fri, 23 Nov 2007 19:24:29 -0500
Message-ID: <47476F3D.7030703@garzik.org>
References: <20071119090611.GE30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36780 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbXKXAYb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:24:31 -0500
In-Reply-To: <20071119090611.GE30919@htj.mynetwork.cxm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> There are two bugs in disabled port handling.
> 
> * test in PORT_PATA0 is reversed
> * ->prereset should return -ENOENT for disabled ports not 0
> 
> The first bug makes the PATA channel considered disabled but the
> second bug saves the day by returning 0.  The net result is that cable
> is always left at ATA_CBL_UNKNOWN.  This results in false 80c
> configuration and thus transfer errors.
> 
> This patch fixes both bugs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> applied to #tj-upstream-fixes.
> 
>  drivers/ata/pata_jmicron.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)

applied


