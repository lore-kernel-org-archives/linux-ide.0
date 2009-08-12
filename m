From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] ahci: add workaround for on-board 5723s
 on some gigabyte boards
Date: Wed, 12 Aug 2009 06:26:29 -0400
Message-ID: <4A8298D5.9070100@pobox.com>
References: <4A77C760.1010300@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52561 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbZHLK0b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Aug 2009 06:26:31 -0400
In-Reply-To: <4A77C760.1010300@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: ide <linux-ide@vger.kernel.org>, Nicolas.Mailhot@LaPoste.net, marcbowes@gmail.com, Andrew Morton <akpm@linux-foundation.org>

Tejun Heo wrote:
> Some gigabytes have on-board SIMG5723s connected to JMB ahcis.  These
> are used to implement hardware raid.  Unfortunately some firmware
> revisions on these 5723s don't bring the link down when all the
> downstream ports are unoccupied while not responding to reset protocol
> which makes libata think that there's device attached to the port but
> is not responding and retry.  This results in painfully wrong boot
> detection time for these ports when they're empty.
> 
> This patch quirks those boards such that ahci gives up after the
> initial timeout.  Combined with parallel probing, this gives quick
> enough probing and also is safe because SIMG5723 will respond to the
> first try if any of the downstream ports is occupied.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Marc Bowes <marcbowes@gmail.com>
> Reported-by: Nicolas Mailhot <Nicolas.Mailhot@LaPoste.net>
> ---
>  drivers/ata/ahci.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 72 insertions(+), 4 deletions(-)

applied


