From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/06] sata_mv: cache frequently read registers
Date: Mon, 16 Feb 2009 19:19:38 -0500
Message-ID: <499A029A.1060101@pobox.com>
References: <4994FF3D.90904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54937 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbZBQATl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2009 19:19:41 -0500
In-Reply-To: <4994FF3D.90904@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Maintain a local (mv_port_priv) cache of frequently accessed registers,
> to avoid having to re-read them (very slow) on every transistion
> between EDMA and non-EDMA modes.  This speeds up things like
> flushing the drive write cache, and anything using basic DMA transfers.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> -- 
> 
> Resending without any changes from original.

ACK patches 1-6

however, they do not seem to apply to libata-dev.git#upstream, which 
already has several sata_mv changes in it.

Can you regenerate please?  No need to copy the list on resend, unless 
the patch content changes....

	Jeff




