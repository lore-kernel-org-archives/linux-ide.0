From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_mv: remove iounmap in mv_platform_remove and use
 devm_iomap
Date: Wed, 20 Feb 2008 12:21:01 -0500
Message-ID: <47BC617D.3030303@garzik.org>
References: <12033601481951-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44508 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755095AbYBTRVG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 12:21:06 -0500
In-Reply-To: <12033601481951-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: mlord@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org, saeed.bishara@gmail.com, byron.bbradley@gmail.com, tbm@cyrius.com

Saeed Bishara wrote:
> this will fix crash bug when doing rmmod to the driver, this is because the
> port_stop function get called later and it could access the device's registers.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)

applied


