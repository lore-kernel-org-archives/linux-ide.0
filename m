From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv: fix SoC interrupt breakage
Date: Wed, 25 Feb 2009 15:28:54 -0500
Message-ID: <49A5AA06.7020201@pobox.com>
References: <499D7CDC.9000202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52626 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbZBYU3A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 15:29:00 -0500
In-Reply-To: <499D7CDC.9000202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Lennert Buytenhek <buytenh@marvell.com>, Martin Michlmayr <tbm@cyrius.com>

Mark Lord wrote:
> For some reason, sata_mv doesn't clear interrupt status during init
> when it's running on an SoC host adapter.  If the bootloader has
> touched the SATA controller before starting Linux, Linux can end up
> enabling the SATA interrupt with events pending, which will cause the
> interrupt to be marked as spurious and then be disabled, which then
> breaks all further accesses to the controller.
> 
> This patch makes the SoC path clear interrupt status on init like in
> the non-SoC case.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> 
> This is for 2.6.29 (upstream-fixes).
> Despite appearances, this patch simply removes a single unnecessary
> if-stmt from the code.  It looks larger due to the resulting change
> in indentation level.

applied manually...  not even patch(1) liked this one, and patch(1) is 
far less strict than git-am patch import tool.  Other peoples' patches 
are processing just fine.

	Jeff




