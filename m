From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2 v3] sata_mv: Support SoC controllers
Date: Fri, 01 Feb 2008 11:53:30 -0500
Message-ID: <47A34E8A.6020007@garzik.org>
References: <1201733446499-git-send-email-saeed.bishara@gmail.com> <12017334492566-git-send-email-saeed.bishara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60615 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335AbYBAQxe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 11:53:34 -0500
In-Reply-To: <12017334492566-git-send-email-saeed.bishara@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed.bishara@gmail.com
Cc: linux-ide@vger.kernel.org, saeed@marvell.com, htejun@gmail.com, liml@rtr.ca, Saeed Bishara <saeed@il.marvell.com>, Paul Mundt <lethal@linux-sh.org>

saeed.bishara@gmail.com wrote:
> --- /dev/null
> +++ b/include/linux/sata_mv.h
> @@ -0,0 +1,21 @@
> +/*
> + * Marvell integrated SATA platfrom device data definition file.
> + *
> + * Saeed Bishara <saeed@marvell.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __LINUX_SATA_MV_H__
> +#define __LINUX_SATA_MV_H__
> +
> +/*
> + * Sata private data
> + */
> +struct mv_sata_platform_data {
> +	int	n_ports; /* number of sata ports */
> +};
> +
> +#endif

Overall, the patch is OK, but I fear adding way too many of these tiny 
includes, for each platform.

Unless Paul M objects (pata_platform maintainer), I will rename 
linux/pata_platform.h to linux/ata_platform.h, and we can put your 
mv_sata_platform_data structure in there.

	Jeff


