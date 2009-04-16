From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH UPDATED #upstream-fixes] libata: handle SEMB signature
 better
Date: Thu, 16 Apr 2009 15:22:43 -0400
Message-ID: <49E78583.5030401@garzik.org>
References: <49E466DE.7020701@kernel.org> <49E47DBF.9060502@garzik.org> <49E4FA13.1090400@kernel.org> <49E4FB42.7010609@garzik.org> <49E4FE46.1010006@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37860 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989AbZDPTWs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Apr 2009 15:22:48 -0400
In-Reply-To: <49E4FE46.1010006@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, David Haun <drhaun88@gmail.com>, liw@liw.fi, jmcarranza@gmail.com

Tejun Heo wrote:
> WDC WD1600JS-62MHB5 successfully hits the window between ATA/ATAPI-7
> and Serial ATA II standards and reports 3c/c3 signature which now is
> assigned to SEMB.  Make ata_dev_classify() report ATA_DEV_SEMB on the
> sig and let ata_dev_read_id() work around it by trying IDENTIFY once.
> 
> This fixes bko#11579.
> 
> UPDATED: Jeff spotted stupid bug caused by lingering debug code.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: David Haun <drhaun88@gmail.com>
> Reported-by: Lars Wirzenius <liw@liw.fi>
> Reported-by: Juan Manuel <jmcarranza@gmail.com>
> ---
>  drivers/ata/libata-core.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

applied


