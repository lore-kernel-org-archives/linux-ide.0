From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/12] libata: allocate ap separately from shost
Date: Tue, 17 Apr 2007 11:04:06 -0400
Message-ID: <4624E1E6.7050501@garzik.org>
References: <1176821046841-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39976 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932274AbXDQPEI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 11:04:08 -0400
In-Reply-To: <1176821046841-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> Don't embed ap inside shost.  Allocate it separately and point it back
> from shosts's hostdata.  This makes port allocation more flexible and
> allows regular ATA and SAS share host alloc/init paths.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   19 ++++++++++++++-----
>  include/linux/libata.h    |    2 +-
>  2 files changed, 15 insertions(+), 6 deletions(-)

applied patches 1-12 to #upstream.

Yay, libata init model is finally clean!

Thanks,

	Jeff


