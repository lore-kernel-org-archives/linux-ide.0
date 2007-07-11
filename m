From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_mpc52xx: suspend/resume support
Date: Tue, 10 Jul 2007 21:14:50 -0400
Message-ID: <46942F0A.1010707@garzik.org>
References: <20070703082738.GM23294@moe.telargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37448 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756784AbXGKBOx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:14:53 -0400
In-Reply-To: <20070703082738.GM23294@moe.telargo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Domen Puncer <domen.puncer@telargo.com>
Cc: linuxppc-embedded@ozlabs.org, linux-ide@vger.kernel.org

Domen Puncer wrote:
> Implement suspend and resume routines for mpc52xx ata driver.
> Tested on Lite5200b with deep-sleep and low-power (not yet in-tree)
> modes.
> 
> 
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
> 
> ---
> If anyone cares, I attached ATA_DEBUG messages at the end of patch.
> Should it take almost 5 seconds?
> 
> 
>  drivers/ata/pata_mpc52xx.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

applied


