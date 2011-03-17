From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V1 1/3] ahci_platform: add two clk pointer member into
 ahci_platform_data struct
Date: Thu, 17 Mar 2011 09:37:24 +0100
Message-ID: <20110317083724.GV29521@pengutronix.de>
References: <1300345860-16574-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38178 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab1CQIhl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Mar 2011 04:37:41 -0400
Content-Disposition: inline
In-Reply-To: <1300345860-16574-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

On Thu, Mar 17, 2011 at 03:10:58PM +0800, Richard Zhu wrote:
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  include/linux/ahci_platform.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index be3d9a7..86b5e24 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -26,6 +26,8 @@ struct ahci_platform_data {
>  	const struct ata_port_info *ata_port_info;
>  	unsigned int force_port_map;
>  	unsigned int mask_port_map;
> +	struct clk *sata_clk;
> +	struct clk *sata_ref_clk;

No, ahci_platform_data shouldn't be the dump place for arbitrary board
data. Keep this to your board.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
