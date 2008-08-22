From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] pata_via: clean up recent tf_load changes
Date: Fri, 22 Aug 2008 02:20:27 -0400
Message-ID: <48AE5AAB.5080507@garzik.org>
References: <48917FAB.3000703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37292 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbYHVGUc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:20:32 -0400
In-Reply-To: <48917FAB.3000703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, JosephChan@via.com.tw

Tejun Heo wrote:
> Commit bfce5e0179ad059035df28558724ff60af708e09 implemented custom
> tf_load for pata_via.  This patch cleans it up a bit.
> 
> * Instead of duplicating whole body, copy tf and set ATA_TFLAG_DEVICE
>   when necessary.
> 
> * Rename via_ata_tf_load() to via_tf_load().
> 
> * No need to set .tf_load in via_port_ops_noirq as it inherits from
>   via_port_ops.
> 
> * Clean up indentation.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Joseph Chan <JosephChan@via.com.tw>
> ---
>  drivers/ata/pata_via.c |   59 +++++++++----------------------------------------
>  1 file changed, 11 insertions(+), 48 deletions(-)

applied


