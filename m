From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH RESEND] pata_mpc52xx: driver needs BMDMA
Date: Fri, 24 Dec 2010 13:38:43 -0500
Message-ID: <4D14E8B3.8070605@pobox.com>
References: <1293033011-19265-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41605 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab0LXSis (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 13:38:48 -0500
In-Reply-To: <1293033011-19265-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/22/2010 10:50 AM, Wolfram Sang wrote:
> Found by this build-error if BMDMA is disabled:
>
> drivers/ata/pata_mpc52xx.c: In function 'mpc52xx_ata_init_one':
> drivers/ata/pata_mpc52xx.c:662: error: 'ata_bmdma_interrupt' undeclared (first use in this function)
> ...
>
> Move the Kconfig entry to the proper location as needed since
> 9a7780c9acb821fe1c2b6fc53f74cc2556ff5364 (libata-sff: make BMDMA optional)
>
> Signed-off-by: Wolfram Sang<w.sang@pengutronix.de>
> ---
>
> This is a build-failure, so fixing it before 2.6.37 would be great.
>
>   drivers/ata/Kconfig  |   20 ++++++++++----------
>   drivers/ata/Makefile |    2 +-
>   2 files changed, 11 insertions(+), 11 deletions(-)

applied


