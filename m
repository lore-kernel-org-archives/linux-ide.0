From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/2] [libata] sata_mv: Support integrated controllers
Date: Sun, 02 Dec 2007 17:51:22 -0500
Message-ID: <475336EA.2050206@rtr.ca>
References: <11966092121262-git-send-email-saeed.bishara@gmail.com> <11966092143056-git-send-email-saeed.bishara@gmail.com> <11966092162669-git-send-email-saeed.bishara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3426 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXLBWvY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 17:51:24 -0500
In-Reply-To: <11966092162669-git-send-email-saeed.bishara@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed.bishara@gmail.com
Cc: linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org, Saeed Bishara <saeed@marvell.com>

saeed.bishara@gmail.com wrote:
> From: Saeed Bishara <saeed@marvell.com>
> 
> Marvell's Orion SoC includes SATA controllers based on Marvell's
> PCI-to-SATA 88SX controllers. The integrated SATA unit is connected
> directly to the internal bus of the Orion SoC, and not via PCI.
> This patch extends the libATA sata_mv driver to support those
> controllers.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c   |  392 ++++++++++++++++++++++++++++++++++++++++-------
>  include/linux/sata_mv.h |   21 +++
>  2 files changed, 358 insertions(+), 55 deletions(-)
>  create mode 100644 include/linux/sata_mv.h
...

This patch won't apply, because sata_mv.c was just recently updated
to fix 7042 PCIe support.  You'll have to rebase this patch against that.

Also, I'm not sure I understand why there's a need for the new sata_mv.h file ?

> new file mode 100644
> index 0000000..b0fa7cd
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

