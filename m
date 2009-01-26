From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/04] sata_mv: fix 8-port timeouts on 508x/6081 chips
Date: Mon, 26 Jan 2009 06:39:29 -0500
Message-ID: <497DA0F1.5010509@pobox.com>
References: <49750705.7010709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53474 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbZAZLje (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 06:39:34 -0500
In-Reply-To: <49750705.7010709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Mark Lord wrote:
> Fix a longstanding bug for the 8-port Marvell Sata controllers (508x/6081),
> where accesses to the upper 4 ports would cause lost-interrupts / timeouts
> for the lower 4-ports.  With this patch, the 6081 boards should finally be
> reliable enough for mainstream use with Linux.
> 
> This patch is for 2.6.29, but should also get reviewed/released
> for the -stable branches of 2.6.28, 2.6.27, and 2.6.26.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com> ---
> 
> Reposting, as I got no response/acknowledgement on the first attempt.

applied 1-3


