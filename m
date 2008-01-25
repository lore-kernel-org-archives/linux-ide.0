From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/9] enable FSL SATA driver config for Freescale SoCs
Date: Fri, 25 Jan 2008 15:23:04 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801251522160.20972@blarg.am.freescale.net>
References: <20080124204621.2c09359e.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43631 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbYAYVZp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 16:25:45 -0500
In-Reply-To: <20080124204621.2c09359e.kim.phillips@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, 24 Jan 2008, Kim Phillips wrote:

> The mpc8315 shares the same SATA controller as the mpc837x,
> and likelihood is that future SoCs from Freescale will also.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> Kumar, let me know if you want me to post this to the ata list (I'm
> assuming it's not necessary).
>
>  drivers/ata/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>

applied.

- k
